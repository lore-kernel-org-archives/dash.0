From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] parser: Save and restore heredoclist in expandstr
Date: Sun, 17 May 2020 23:36:25 +1000
Message-ID: <20200517133625.GA15227@gondor.apana.org.au>
References: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
 <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
 <5e56df24.H24u7mxAPbLPL6fI%rmy@frippery.org>
 <20200228004023.GA9163@gondor.apana.org.au>
 <20200428061758.GA1771@gondor.apana.org.au>
 <15d522d8-e0f5-be2a-f2a2-8b17290fce31@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:44960 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgEQNgw (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 17 May 2020 09:36:52 -0400
Content-Disposition: inline
In-Reply-To: <15d522d8-e0f5-be2a-f2a2-8b17290fce31@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Ron Yorston <rmy@frippery.org>, contact@emersion.fr, dash@vger.kernel.org

On Sun, May 17, 2020 at 01:19:28PM +0100, Harald van Dijk wrote:
>
> This still does not restore the state completely. It does not clean up any
> pending heredocs. I see:
> 
>   $ PS1='$(<<EOF "'
>   src/dash: 1: Syntax error: Unterminated quoted string
>   $(<<EOF ":
>   >
> 
> That is, after entering the ':' command, the shell is still trying to read
> the heredoc from the prompt.

This patch saves and restores the heredoclist in expandstr.

It also removes a bunch of unnecessary volatiles as those variables
are only referenced in case of a longjmp other than one started by
a signal like SIGINT.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 3131045..54c2861 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1565,10 +1565,11 @@ setprompt(int which)
 const char *
 expandstr(const char *ps)
 {
-	struct parsefile *volatile file_stop;
+	struct parsefile *file_stop;
 	struct jmploc *volatile savehandler;
-	const char *volatile result;
-	volatile int saveprompt;
+	struct heredoc *saveheredoclist;
+	const char *result;
+	int saveprompt;
 	struct jmploc jmploc;
 	union node n;
 	int err;
@@ -1578,6 +1579,8 @@ expandstr(const char *ps)
 	/* XXX Fix (char *) cast. */
 	setinputstring((char *)ps);
 
+	saveheredoclist = heredoclist;
+	heredoclist = NULL;
 	saveprompt = doprompt;
 	doprompt = 0;
 	result = ps;
@@ -1603,6 +1606,7 @@ out:
 
 	doprompt = saveprompt;
 	unwindfiles(file_stop);
+	heredoclist = saveheredoclist;
 
 	return result;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
