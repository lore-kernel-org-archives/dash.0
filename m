From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] Fix exit status for 'exec nonexistent' and 'exec .'
Date: Wed, 6 Oct 2010 20:02:41 -0500
Message-ID: <20101007010241.GB1276@burratino>
References: <20100605160651.GA60028@stack.nl>
 <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
 <20100628065326.GA25667@gondor.apana.org.au>
 <20101006100420.GA361@burratino>
 <20101006100804.GB361@burratino>
 <20101006102930.GA6573@gondor.apana.org.au>
 <20101006105531.GB475@burratino>
 <4CAC68FD.4040602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58084 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab0JGBGE (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 21:06:04 -0400
Received: by gye5 with SMTP id 5so75822gye.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 18:06:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CAC68FD.4040602@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

Eric Blake wrote:

> Additionally, the standard REQUIRES that 'sh -c "exec /"' shall fail
> with status 126:
> 
> http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#exec
> "If command is found, but it is not an executable utility, the exit
> status shall be 126."
> 
> Right now, dash gets this wrong:
> 
> dash -c 'exec .'; echo $?
> exec: 1: /: Permission denied
> 2
> 
> And since you already have the code in dash to detect failure to
> 'exec' a directory, you should be able to reuse that code when
> detecting failure to run a directory as a script, as in 'dash .'.

Summary:

   Command		Status	Expected status
1) exec .		2	126
2) exec nonexistent	2	127
3) sh .			0	126
4) sh nonexistent	2	127

(1) and (2) seem to be regressions from about 5 years ago.
Reverting the problematic patch fixes it for me; see below.

(3) is not clearly documented in the standard, and there is
some disagreement between shells on how to handle it[1].  The
current behavior seems fine to me.

(4) is a clear bug, well documented in the EXIT STATUS section
of the description of sh in the "Utilities" chapter.  See
http://thread.gmane.org/gmane.comp.shells.dash/291/focus=390
for a patch[2].

Thoughts?
Jonathan Nieder (3):
  [EXCEPTIONS] Stop documenting EXSHELLPROC
  Revert "Eliminated global exerrno."
  [EXCEPTIONS] Eliminate global exerrno

 src/TOUR    |   11 +----------
 src/error.h |    5 ++---
 src/eval.c  |    8 ++++----
 3 files changed, 7 insertions(+), 17 deletions(-)

[1]
$ bash .; echo $?
.: .: is a directory
126
$ ksh93 .; echo $?
ksh93: .: cannot open [Is a directory]
126
$ pdksh .; echo $?
0

[2] Unfortunately this does not share code with the fix to (1)
and (2) as Eric hoped.  Why?  The system calls involved are
different: the exec builtin uses execve(), while 'sh <script>'
uses open() and read().
