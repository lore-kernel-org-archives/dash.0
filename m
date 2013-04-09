From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Crash on valid input
Date: Tue, 09 Apr 2013 23:20:52 +0200
Message-ID: <51648634.4090708@gigawatt.nl>
References: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com> <51638620.4030603@redhat.com> <CAPF-yOZmkcKSpU+jVMsSi6Q8harUYZ-hS5Ugn7SsbBwm-GzhiQ@mail.gmail.com> <51638AA0.4080701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:56284 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943Ab3DIWZj (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 9 Apr 2013 18:25:39 -0400
In-Reply-To: <51638AA0.4080701@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Dan Kegel <dank@kegel.com>, Eric Blake <eblake@redhat.com>

On 09/04/13 05:27, Eric Blake wrote:
> On 04/08/2013 09:12 PM, Dan Kegel wrote:
>> Yes, my script was crap, I've fixed it.
>>
>> Here's the reproducer.  Called with foo unset.  I think it doesn't
>> crash without -x.
>>
>> #!/bin/dash
>> set -x
>> test ! $foo
> The 'set -x' was indeed the key to reproducing the problem.  In fact,
> this is the shortest I could make it:
>
> dash -cx 'test !'
>
It is not limited to 'set -x'. dash continues reading after the NULL 
value in argv, and usually that will be followed by another NULL if 'set 
-x' is not used, but not necessarily.

$ dash -c 'test ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! 
! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !'
$ dash -c 'test ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! 
! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !'
Segmentation fault
$ dash -c 'test ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! 
! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !'
$

When [ ! ] is used, the ! is necessarily followed by two NULLs (one 
after the ], and one because the ] is replaced by NULL), so the problem 
is hidden.

dash should check whether ! is followed by an argument, like bash does, 
which would give an error message without a segmentation fault for all 
three forms above.

This seems to be easily possible by manually inlining primary() into 
nexpr(), and treating UNOT similarly to STREZ e.a.:

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 90135e1..5cf4021 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -268,14 +268,6 @@ aexpr(enum token n)
  static int
  nexpr(enum token n)
  {
-       if (n == UNOT)
-               return !nexpr(t_lex(++t_wp));
-       return primary(n);
-}
-
-static int
-primary(enum token n)
-{
         enum token nn;
         int res;

@@ -289,11 +281,13 @@ primary(enum token n)
                         syntax(NULL, "closing paren expected");
                 return res;
         }
-       if (t_wp_op && t_wp_op->op_type == UNOP) {
+       if (t_wp_op && (t_wp_op->op_type == UNOP || t_wp_op->op_type == 
BUNOP)) {
                 /* unary expression */
                 if (*++t_wp == NULL)
                         syntax(t_wp_op->op_text, "argument expected");
                 switch (n) {
+               case UNOT:
+                       return !nexpr(t_lex(t_wp));
                 case STREZ:
                         return strlen(*t_wp) == 0;
                 case STRNZ:

Unfortunately, this exposes the fact that POSIX test requires special 
behaviour when called with fewer than five arguments. This change would 
cause "test !" to start returning an error. Something like

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 5cf4021..1e84423 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -177,6 +177,7 @@ testcmd(int argc, char **argv)
  {
         const struct t_op *op;
         enum token n;
+       int not;
         int res;

         if (*argv[0] == '[') {
@@ -191,25 +192,44 @@ testcmd(int argc, char **argv)
         if (argc < 1)
                 return 1;

+       not = 0;
+
         /*
          * POSIX prescriptions: he who wrote this deserves the Nobel
          * peace prize.
          */
-       switch (argc) {
-       case 3:
-               op = getop(argv[1]);
-               if (op && op->op_type == BINOP) {
-                       n = OPERAND;
-                       goto eval;
+       for (;;) {
+               switch (argc) {
+               case 1:
+                       res = strlen(argv[0]) == 0;
+                       goto exit;
+
+               case 3:
+                       op = getop(argv[1]);
+                       if (op && op->op_type == BINOP) {
+                               n = OPERAND;
+                               goto eval;
+                       }
+                       /* fall through */
+
+               case 2:
+               case 4:
+                       if (!strcmp(argv[0], "!")) {
+                               not = !not;
+                               argv++;
+                               argc--;
+                               continue;
+                       }
+
+                       if (!strcmp(argv[0], "(") && !strcmp(argv[argc - 
1], ")")) {
+                               argv[--argc] = NULL;
+                               argv++;
+                               argc--;
+                               continue;
+                       }
                 }
-               /* fall through */

-       case 4:
-               if (!strcmp(argv[0], "(") && !strcmp(argv[argc - 1], ")")) {
-                       argv[--argc] = NULL;
-                       argv++;
-                       argc--;
-               }
+               break;
         }

         n = t_lex(argv);
@@ -222,6 +242,10 @@ eval:
         if (argv[0] != NULL && argv[1] != NULL)
                 syntax(argv[0], "unexpected operator");

+exit:
+       if (not)
+               res = !res;
+
         return res;
  }


Although this is a bit ugly, it gets the right results:

$ ./dash -c 'test'; echo $?
1
$ ./dash -c 'test !'; echo $?
0
$ ./dash -c 'test ! !'; echo $?
1
$ ./dash -c 'test ! ! !'; echo $?
0
$ ./dash -c 'test ! ! ! !'; echo $?
1
$ ./dash -c 'test ! ! ! ! !'; echo $?
./dash: 1: test: !: argument expected
2

One comment about this approach: to keep the code slightly simpler, it 
also removes parentheses in two-argument calls to test. That is not 
standard behaviour, but the standard leaves the behaviour unspecified, 
so it is valid. This causes dash to return 1 for "test \( \)", and 
previous versions of dash already returned 1 for other reasons.

Cheers,
Harald
