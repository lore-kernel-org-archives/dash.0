From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [BUG] Interactive (d)ash exits on assigning to readonly from
 'command eval'
Date: Fri, 28 Oct 2016 15:55:59 +0200
Message-ID: <CAK1hOcO25fYP71DRxk=Dga5UZ6=FfmdDHTj6AWNNGSu_J0B+Dw@mail.gmail.com>
References: <177dba07-fb53-4958-3455-e047c7f32ee6@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35638 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbcJ1N4V (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 28 Oct 2016 09:56:21 -0400
Received: by mail-qk0-f195.google.com with SMTP id v138so2198373qka.2
        for <dash@vger.kernel.org>; Fri, 28 Oct 2016 06:56:20 -0700 (PDT)
In-Reply-To: <177dba07-fb53-4958-3455-e047c7f32ee6@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, busybox <busybox@busybox.net>

This will probably be mangled by gmail, but here is the proposed fix:

Date: Fri, 28 Oct 2016 15:43:50 +0200
Subject: [PATCH] ash: fix interactive "command eval STRING" exiting on errors.

This bug is also present in current dash

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
---
 shell/ash.c                             | 25 ++++++++++++++++++++++++-
 shell/ash_test/ash-vars/readonly1.right |  2 ++
 shell/ash_test/ash-vars/readonly1.tests |  7 +++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 shell/ash_test/ash-vars/readonly1.right
 create mode 100755 shell/ash_test/ash-vars/readonly1.tests

diff --git a/shell/ash.c b/shell/ash.c
index 1ef02b8..fe11245 100644
--- a/shell/ash.c
+++ b/shell/ash.c
@@ -2180,6 +2180,7 @@ setvareq(char *s, int flags)
             if (flags & VNOSAVE)
                 free(s);
             n = vp->var_text;
+            exitstatus = 1;
             ash_msg_and_raise_error("%.*s: is read only",
strchrnul(n, '=') - n, n);
         }

@@ -9599,7 +9600,7 @@ evalcommand(union node *cmd, int flags)
         if (evalbltin(cmdentry.u.cmd, argc, argv, flags)) {
             if (exception_type == EXERROR && spclbltin <= 0) {
                 FORCE_INT_ON;
-                break;
+                goto readstatus;
             }
  raise:
             longjmp(exception_handler->loc, 1);
@@ -12280,6 +12281,10 @@ expandstr(const char *ps)
 static int
 evalstring(char *s, int flags)
 {
+    struct jmploc *volatile savehandler = exception_handler;
+    struct jmploc jmploc;
+    int ex;
+
     union node *n;
     struct stackmark smark;
     int status;
@@ -12289,6 +12294,19 @@ evalstring(char *s, int flags)
     setstackmark(&smark);

     status = 0;
+    /* On exception inside execution loop, we must popfile().
+     * Try interactively:
+     *    readonly a=a
+     *    command eval "a=b"  # throws "is read only" error
+     * "command BLTIN" is not supposed to abort (even in non-interactive use).
+     * But if we skip popfile(), we hit EOF in eval's string, and exit.
+     */
+    savehandler = exception_handler;
+    exception_handler = &jmploc;
+    ex = setjmp(jmploc.loc);
+    if (ex)
+        goto out;
+
     while ((n = parsecmd(0)) != NODE_EOF) {
         int i;

@@ -12299,10 +12317,15 @@ evalstring(char *s, int flags)
         if (evalskip)
             break;
     }
+ out:
     popstackmark(&smark);
     popfile();
     stunalloc(s);

+    exception_handler = savehandler;
+    if (ex)
+                longjmp(exception_handler->loc, ex);
+
     return status;
 }

diff --git a/shell/ash_test/ash-vars/readonly1.right
b/shell/ash_test/ash-vars/readonly1.right
new file mode 100644
index 0000000..2b363e3
--- /dev/null
+++ b/shell/ash_test/ash-vars/readonly1.right
@@ -0,0 +1,2 @@
+One:1
+One:1
diff --git a/shell/ash_test/ash-vars/readonly1.tests
b/shell/ash_test/ash-vars/readonly1.tests
new file mode 100755
index 0000000..81b461f
--- /dev/null
+++ b/shell/ash_test/ash-vars/readonly1.tests
@@ -0,0 +1,7 @@
+readonly bla=123
+# Bare "eval bla=123" should abort ("eval" is a special builtin):
+(eval bla=123 2>/dev/null; echo BUG)
+echo One:$?
+# "command BLTIN" disables "special-ness", should not abort:
+command eval bla=123 2>/dev/null
+echo One:$?
-- 
2.9.2
