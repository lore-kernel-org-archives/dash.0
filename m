From: maximilian attems <max@stro.at>
Subject: [patch v2] dash fix for job control off warning
Date: Wed, 7 Apr 2010 00:19:25 +0200
Message-ID: <20100406221925.GE7863@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:42382 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab0DGACa (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 6 Apr 2010 20:02:30 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, klibc@zytor.com

fix subject and added warning to patch mail,
thanks for review.

----- Forwarded message from "H. Peter Anvin" <hpa@zytor.com> -----

Date: Mon, 29 Mar 2010 15:07:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: maximilian attems <max@stro.at>
Cc: Colin Watson <cjwatson@ubuntu.com>, klibc@zytor.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [klibc] dash fix for job control off warning

There seems to be a problem with the new version of dash
with job control off.  I can't tell if it is just a warning or is a
manifest bug.

usr/dash/trap.c: In function `exitshell':
usr/dash/trap.c:376: warning: suggest braces around empty body in an `if' statement

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

