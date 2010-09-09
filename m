From: maximilian attems <max@stro.at>
Subject: dash klibc DEBUG compile question
Date: Thu, 9 Sep 2010 10:16:11 +0200
Message-ID: <20100909081611.GF2919@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:37121 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0IIIQV (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 9 Sep 2010 04:16:21 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, klibc@zytor.com

now with the proper flags passed and the jobs.c fix dash
allmost compiles in DEBUG mode, the last two failures happen
in show.c, which assumes some buffering functions that klibc
doesn't provide:
usr/dash/show.o: In function `opentrace':
show.c:(.text+0x36): undefined reference to `freopen'
show.c:(.text+0x86): undefined reference to `setlinebuf'

afais this code dates from the initial git import.
any preferences on how to fix those Herbert?


-- 
maks
