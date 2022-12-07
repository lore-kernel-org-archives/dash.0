Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113DAC352A1
	for <linux-dash@archiver.kernel.org>; Wed,  7 Dec 2022 03:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLGD70 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 6 Dec 2022 22:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGD7Z (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 6 Dec 2022 22:59:25 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0300254B01
        for <dash@vger.kernel.org>; Tue,  6 Dec 2022 19:59:22 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2laa-004lmB-8E; Wed, 07 Dec 2022 11:59:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 Dec 2022 11:59:20 +0800
Date:   Wed, 7 Dec 2022 11:59:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: [PATCH] eval: Check eflag after redirection error
Message-ID: <Y5APmNVQrIXFS7es@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818114412.zeqv5auujpuvfskk@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> 
> Thought I'd forward this upstream, considering I already tested on
> current git, and it's pretty grave.
> 
> https://bugs.debian.org/1017531, trimmed down a bit, follows:
> 
> ----- Forwarded message from наб <nabijaczleweli@nabijaczleweli.xyz> -----
> 
> Subject: Bug#1017531: dash: for/while/if suppress errors from redirections
> with -e, POSIX violation
> 
> Dear Maintainer,
> 
> On current git (057cd650a4edd5856213d431a974ff35c6594489) and 0.5.11.5
> the following holds:
> -- >8 --
> $ ./src/dash -ec 'while :; do :; done < /ENOENT; echo uhoh'
> ./src/dash: 1: cannot open /ENOENT: No such file
> uhoh
> $ ./src/dash -ec 'for _ in :; do :; done < /ENOENT; echo uhoh'
> ./src/dash: 1: cannot open /ENOENT: No such file
> uhoh
> $ ./src/dash -ec 'if :; then :; fi < /ENOENT; echo uhoh'
> ./src/dash: 1: cannot open /ENOENT: No such file
> uhoh
> -- >8 --
> 
> The correct output, as demonstrated by bash, is:
> -- >8 --
> $ bash -ec 'while :; do :; done < /ENOENT; echo uhoh'
> bash: line 1: /ENOENT: No such file or directory
> $ bash -ec 'for _ in :; do :; done < /ENOENT; echo uhoh'
> bash: line 1: /ENOENT: No such file or directory
> $ bash -ec 'if :; then :; fi < /ENOENT; echo uhoh'
> bash: line 1: /ENOENT: No such file or directory
> -- >8 --
> 
> This is a POSIX violation, and quite a grave one at that:
> set -e is oft[1] used to guard against precisely this type of error!
> 
> The same happens if set -e is executed.
> 
> All quotes POSIX.1, Issue 7, TC2:
> sh, OPTIONS:
>  > The -a, -b, -C, -e, -f, -m, -n, -o option, -u, -v, and -x options
>  > are described as part of the set utility in Special Built-In
>  > Utilities. 
> 
> set, DESCRIPTION, -e:
>  > When this option is on, when any command fails (for any of the
>  > reasons listed in Consequences of Shell Errors or by returning an
>  > exit status greater than zero), the shell immediately shall exit, as
>  > if by executing the exit special built-in utility with no arguments,
>  > with the following exceptions:
>  >
>  > 1. The failure of any individual command in a multi-command pipeline
>  >    shall not cause the shell to exit. Only the failure of the
>  >    pipeline itself shall be considered.
>  > 2. The -e setting shall be ignored when executing the compound list
>  >    following the while, until, if, or elif reserved word, a pipeline
>  >    beginning with the ! reserved word, or any command of an AND-OR
>  >    list other than the last.
>  > 3. If the exit status of a compound command other than a subshell
>  >    command was the result of a failure while -e was being ignored,
>  >    then -e shall not apply to this command.
> 
> XCU, 2.9.4: Shell Command Language, Shell Commands, Compound Commands:
> The while Loop:
>  > The format of the while loop is as follows:
>  > 
>  > while compound-list-1
>  > do
>  >   compound-list-2
>  > done
> (until is equivalent).
> The if Conditional Construct: 
>  > The format for the if construct is as follows:
>  >
>  > if compound-list
>  > then
>  >   compound-list
>  > [elif compound-list
>  > then
>  >   compound-list] ...
>  > [else
>  >   compound-list]
>  > fi
> 
> It follows, therefore, that
>  * Exception 1. does not apply as there is no pipeline
>  * Exception 2. does not apply, as the redirection does /not/ follow
>    "while" or "if" directly and is /not/ part of the conditional
>        compound-list
>  * in the "for" case, there is no such provision, so this is likely not
>    a confusion w.r.t. the conditional compound-lists
>  * Exception 3. does not apply as -e was not being ignored while the
>    compound commands were being executed (indeed, the compound commands
>    do not run at all, as evidenced by the program terminating)
> 
> [1]: https://salsa.debian.org/glibc-team/glibc/-/merge_requests/6#note_329899
> ----- End forwarded message -----

Yes we should check the exit status after redirections.

Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index eda251e..7aa5cc2 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -246,15 +246,18 @@ evaltree(union node *n, int flags)
 			lineno -= funcline - 1;
 		expredir(n->nredir.redirect);
 		pushredir(n->nredir.redirect);
-		status = redirectsafe(n->nredir.redirect, REDIR_PUSH) ?:
-			 evaltree(n->nredir.n, flags & EV_TESTED);
+		status = redirectsafe(n->nredir.redirect, REDIR_PUSH);
+		if (status)
+			checkexit = EV_TESTED;
+		else
+			status = evaltree(n->nredir.n, flags & EV_TESTED);
 		if (n->nredir.redirect)
 			popredir(0);
 		break;
 	case NCMD:
 		evalfn = evalcommand;
 checkexit:
-		checkexit = ~flags & EV_TESTED;
+		checkexit = EV_TESTED;
 		goto calleval;
 	case NFOR:
 		evalfn = evalfor;
@@ -316,7 +319,7 @@ calleval:
 out:
 	dotrap();
 
-	if (eflag && checkexit && status)
+	if (eflag && (~flags & checkexit) && status)
 		goto exexit;
 
 	if (flags & EV_EXIT) {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
