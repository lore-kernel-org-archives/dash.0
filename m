From: Alex Waite <alexqw85@gmail.com>
Subject: Pattern matching faster than math
Date: Wed, 25 Mar 2015 14:51:56 +0100
Message-ID: <meuehs$n4e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42650 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbbCYNwH (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 25 Mar 2015 09:52:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1Yalj2-0007DO-MZ
	for dash@vger.kernel.org; Wed, 25 Mar 2015 14:52:04 +0100
Received: from 141.44.98.42 ([141.44.98.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 25 Mar 2015 14:52:04 +0100
Received: from alexqw85 by 141.44.98.42 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 25 Mar 2015 14:52:04 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

This isn't a problem per-se, but I'm curious if anyone can shed some 
light on why this is so.

I have a script where I'm checking if the contents of a variable is an 
integer. An easy/hacky way to do this is

[ "$var" -ge 0 2> /dev/null ] || echo "is not int"

But this caused posh to segfault, so I went for a pattern matching 
solution instead:

[ -z "${var##*[!0-9]*}" ] && echo "is not int"

This works well, and it makes posh happy. But what's surprising to me is 
that it's faster.

I have more of a write-up in a commit message: 
https://github.com/zfsnap/zfsnap/commit/ed6326f0006ed18b7d8bb79d5ee8f06142847f41

Any thoughts or insight? Am I making some faulty assumption here?

Thanks for your time.

---Alex

