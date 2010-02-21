From: Oleg Verych <olecom@gmail.com>
Subject: Re: test -nt/-ot behavior
Date: Sun, 21 Feb 2010 15:10:04 +0200
Message-ID: <8499950a1002210510k49fd54dds74b78f69319eecb0@mail.gmail.com>
References: <20100221122100.GA9005@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:48119 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0BUNKK (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 21 Feb 2010 08:10:10 -0500
Received: by bwz1 with SMTP id 1so1051538bwz.21
        for <dash@vger.kernel.org>; Sun, 21 Feb 2010 05:10:08 -0800 (PST)
In-Reply-To: <20100221122100.GA9005@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Cc: dash@vger.kernel.org

2010/2/21, Guido Berhoerster <guido+kernel.org@berhoerster.name>:
> So IMHO the consequence for ash should be to either merge the fix from pdksh
> or to drop -nt, -ot, and -ef altogether,

> I would prefer that
> latter since I think silently changing the behavior in an
> incompatible way is bad practice and these features are not
> specified in POSIX anyway.

Me is for the first + `sed` script to add `test -e &&` stuff in
bug-oriented scripts, for bug compatibility.

Breaking stuff is not building useful features.
> --
> Guido Berhoerster
-- 
sed 'sed && sh + olecom = love'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
