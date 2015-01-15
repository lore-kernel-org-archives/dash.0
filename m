From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: incorrect handling of quoted escapes
Date: Thu, 15 Jan 2015 17:40:34 +0000
Message-ID: <54B7FB92.5010901@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail5.vodafone.ie ([213.233.128.176]:12715 "EHLO
	mail5.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbAPRkn (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 16 Jan 2015 12:40:43 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

bash, ksh, zsh all support $'\n\x0a\012'

The POSIX discussion is at:
http://austingroupbugs.net/view.php?id=3D249

It would be great if dash supported it too.

I tested dash 0.5.8

thanks,
P=C3=A1draig
