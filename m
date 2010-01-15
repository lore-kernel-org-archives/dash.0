From: SamLT <samuel.lethiec@intelunix.fr>
Subject: parameter expansion and double quotes
Date: Fri, 15 Jan 2010 21:20:54 +0100
Message-ID: <20100115202052.GE14452@slt>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.intelunix.fr ([88.191.80.46]:34924 "EHLO www2.intelunix.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab0AOU3D (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 15 Jan 2010 15:29:03 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org



Hello,

I'm using dash 0.5.5.1, and noticed a strange behaviour:

| $ t=123
| $ echo ${t%${t#?}}
| 1
| $ echo "${t%${t#?}}"
| 
| $

Is it a bug or something?

Thank you

