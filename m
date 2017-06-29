From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] Here-document redirection with vi/emacs on
Date: Fri, 30 Jun 2017 01:33:29 +0200
Message-ID: <d343eac0-b110-609b-6f7e-aa85e29f9091@gigawatt.nl>
References: <CAPLrsYe1hemq+pOTRERmxc3M0-QrHhGm9PUOhs7pJUN5-cOk6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------293E6FE26571E21BC95879A8"
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:43546 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbdF2Xde (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 29 Jun 2017 19:33:34 -0400
In-Reply-To: <CAPLrsYe1hemq+pOTRERmxc3M0-QrHhGm9PUOhs7pJUN5-cOk6A@mail.gmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Zando Fardones <bluesun654@gmail.com>, dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------293E6FE26571E21BC95879A8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/17 16:29, Zando Fardones wrote:
> Hello,
> 
> I think I've found a bug when using the here-document redirection in
> an interactive shell. What basically happens is that you can't see the
> command output if you set the "vi" or "emacs" options.

That's not quite what happens: the here-document contents got lost, so 
there is no command output to see. Nice find.

The problem is that getprompt() is implicitly called by el_gets(). This 
messes with the memory used by the parser to store the here-document's 
contents. In the non-emacs/vi case, the prompt is explicitly written by 
setprompt(), which wraps the getprompt() call in a 
pushstackmark()/popstackmark() pair to restore the state so that parsing 
can continue. But when getprompt() is called by el_gets(), it knows 
nothing about this.

The whole call to el_gets() can be surrounded by another 
pushstackmark()/popstackmark() pair to solve the problem, as attached.

Cheers,
Harald van Dijk

--------------293E6FE26571E21BC95879A8
Content-Type: text/x-patch;
 name="dash-libedit-heredoc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-libedit-heredoc.patch"

--- a/src/input.c
+++ b/src/input.c
@@ -147,8 +147,12 @@ retry:
 		static const char *rl_cp;
 		static int el_len;
 
-		if (rl_cp == NULL)
+		if (rl_cp == NULL) {
+			struct stackmark smark;
+			pushstackmark(&smark, stackblocksize());
 			rl_cp = el_gets(el, &el_len);
+			popstackmark(&smark);
+		}
 		if (rl_cp == NULL)
 			nr = 0;
 		else {

--------------293E6FE26571E21BC95879A8--
