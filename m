From: maximilian attems <max@stro.at>
Subject: (fwd) dash fix for job control off warning
Date: Fri, 2 Apr 2010 16:32:20 +0200
Message-ID: <20100402143220.GC6199@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:58179 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab0DBOc2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 10:32:28 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, klibc@zytor.com

----- Forwarded message from "H. Peter Anvin" <hpa@zytor.com> -----

Date: Mon, 29 Mar 2010 15:07:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: maximilian attems <max@stro.at>
Cc: Colin Watson <cjwatson@ubuntu.com>, klibc@zytor.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [klibc] [git pull v3] dash, sh4, ipconfig, dprintf, fstype,
	README's

On 03/27/2010 05:58 PM, maximilian attems wrote:
> hello hpa!
> 
> added on top of queue ext4 fix, that Ubuntu is carrying from cjwatson.
> Got missed out in previous pull requests. Btrfs recognition in fstype.
> 
> the patch queue contains sync with latest dash, sh4 fix by Debian porters,
> dprintf usage in ipconfig, kinit and nfsmount instead of buggy DEBUG
> macro. ipconfig memcpy usage to avoid strict aliasing warnings.
> Some interesting README's got renamed for easier packaging.
> Bonus is sparc32 socket test.
> 

Pulled this; there seems to be a problem with the new version of dash
with job control off.  I can't tell if it is just a warning or is a
manifest bug.

The solution is simple:

--- a/usr/dash/jobs.h
+++ b/usr/dash/jobs.h
@@ -105,5 +105,5 @@ int waitforjob(struct job *);
 int stoppedjobs(void);

 #if ! JOBS
-#define setjobctl(on)  /* do nothing */
+#define setjobctl(on) ((void)(on))     /* do nothing */
 #endif

... to keep the code syntactically valid even when setjobctl() is used
as the body of an if statement.

	-hpa

----- End forwarded message -----
-- 
maks
