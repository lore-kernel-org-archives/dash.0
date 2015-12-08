From: Jonathan Perkin <jperkin@joyent.com>
Subject: Re: [PATCH] trap: Implement POSIX.1-2008 trap reset behaviour (#2)
Date: Tue, 8 Dec 2015 09:51:36 +0000
Message-ID: <20151208095136.GA96236@joyent.com>
References: <20151207175047.GG735@joyent.com>
 <20151208082451.GA17236@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:32922 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933419AbbLHJvy (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Dec 2015 04:51:54 -0500
Received: by wmec201 with SMTP id c201so204401805wme.0
        for <dash@vger.kernel.org>; Tue, 08 Dec 2015 01:51:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151208082451.GA17236@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

* On 2015-12-08 at 08:25 GMT, Herbert Xu wrote:

> Jonathan Perkin <jperkin@joyent.com> wrote:
> > Clarifies a couple of issues with the previous patch, and expands on
> > the rationale in the commit message.  Sorry for the noise -- jperkin
> > 
> > POSIX.1-2008 for trap adds the following behaviour:
> > 
> >    If the first operand is an unsigned decimal integer, the shell shall
> >    treat all operands as conditions, and shall reset each condition to
> >    the default value.
> > 
> > The interpretation of this behaviour differs among other shells.  In the
> > case where the first operand is an invalid signo:
> > 
> >  bash-4.3.39(1), zsh-5.1.1:
> > 
> >    $ trap echo 1 2 3
> >    $ trap 100 1 2
> >    $ trap
> >    trap -- '100' SIGHUP
> >    trap -- '100' SIGINT
> >    trap -- 'echo' SIGQUIT
> 
> So dash's behaviour is the same as bash.  I'm not changing this.

Ok, that's fair enough.  New patch below which supports the new
behaviour but matches bash for all cases, as well as retaining
historical dash behaviour for invalid signos.

  1. First operand an integer but invalid signo:

    bash-4.3.39(1), dash (without patch), dash (with patch)

      $ trap 100 1 2; trap
      trap -- '100' HUP
      trap -- '100' INT

  2. First operand not an integer but valid signame:

    bash-4.3.39(1), dash (without patch), dash (with patch)
    
      $ trap HUP 2; trap
      trap -- '100' HUP
      trap -- 'HUP' INT

  3. First operand an integer and valid signo:

    dash (without patch)

      $ trap 1 2; trap
      trap -- '100' HUP
      trap -- '1' INT

    bash-4.3.39(1), dash (with patch)

      $ trap 1 2; trap
      [no output]

Hopefully that's acceptable.  I've inlined most of the format-patch
below, I didn't know if attachments are welcome to this list.

Cheers,

-- 
Subject: [PATCH] trap: Implement POSIX.1-2008 trap reset behaviour

POSIX.1-2008 for trap adds the following behaviour:

    If the first operand is an unsigned decimal integer, the shell shall
    treat all operands as conditions, and shall reset each condition to
    the default value.

Historically dash has treated the first operand as an action.  In order
not to change this behaviour, only valid signal numbers will trigger the
additional clause.  This matches the behaviour of bash in this regard.
---
 src/jobs.c | 4 ++--
 src/trap.c | 9 +++++----
 src/trap.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index c2c2332..0b1ae79 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -259,7 +259,7 @@ usage:
 	}
 
 	if (**++argv == '-') {
-		signo = decode_signal(*argv + 1, 1);
+		signo = decode_signal(*argv + 1, 1, 0);
 		if (signo < 0) {
 			int c;
 
@@ -273,7 +273,7 @@ usage:
 					list = 1;
 					break;
 				case 's':
-					signo = decode_signal(optionarg, 1);
+					signo = decode_signal(optionarg, 1, 0);
 					if (signo < 0) {
 						sh_error(
 							"invalid signal number or name: %s",
diff --git a/src/trap.c b/src/trap.c
index 82d4263..f2988bc 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -112,12 +112,12 @@ trapcmd(int argc, char **argv)
 		}
 		return 0;
 	}
-	if (!ap[1])
+	if ((!ap[1]) || (decode_signal(*ap, 0, 1)) >= 0)
 		action = NULL;
 	else
 		action = *ap++;
 	while (*ap) {
-		if ((signo = decode_signal(*ap, 0)) < 0) {
+		if ((signo = decode_signal(*ap, 0, 0)) < 0) {
 			outfmt(out2, "trap: %s: bad trap\n", *ap);
 			return 1;
 		}
@@ -400,7 +400,7 @@ out:
 	/* NOTREACHED */
 }
 
-int decode_signal(const char *string, int minsig)
+int decode_signal(const char *string, int minsig, int numonly)
 {
 	int signo;
 
@@ -410,7 +410,8 @@ int decode_signal(const char *string, int minsig)
 			return -1;
 		}
 		return signo;
-	}
+	} else if (numonly)
+		return -1;
 
 	for (signo = minsig; signo < NSIG; signo++) {
 		if (!strcasecmp(string, signal_names[signo])) {
diff --git a/src/trap.h b/src/trap.h
index 7573fd7..edbdb45 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -49,7 +49,7 @@ void onsig(int);
 void dotrap(void);
 void setinteractive(int);
 void exitshell(void) __attribute__((__noreturn__));
-int decode_signal(const char *, int);
+int decode_signal(const char *, int, int);
 
 static inline int have_traps(void)
 {
-- 
2.4.9 (Apple Git-60)

-- 
Jonathan Perkin  -  Joyent, Inc.  -  www.joyent.com
