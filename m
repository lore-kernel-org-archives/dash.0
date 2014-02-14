From: Dan Kegel <dank@kegel.com>
Subject: eval and export behave differently together in dash and ash than in
 bash, zsh, and ksh
Date: Fri, 14 Feb 2014 10:29:59 -0800
Message-ID: <CAPF-yOaxN0b3t-H8Vi3HirpAuV0gsdu9XWROws4o02JXAEdzAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36902 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbaBNSaB (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 14 Feb 2014 13:30:01 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so9778213lbd.29
        for <dash@vger.kernel.org>; Fri, 14 Feb 2014 10:29:59 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The script

eval export dir=~$LOGNAME
echo $dir

eval dir2=~$LOGNAME
echo $dir2

produces different results on different shells.

bash  (4.2-2ubuntu2.1) (with and without --posix)
zsh (4.3.17-1ubuntu1)
ksh (93u-1)
produce

/home/buildbot
/home/buildbot

dash (0.5.7-2ubuntu2)
ash (0.5.7-2ubuntu2)
produce

~buildbot
/home/buildbot

The easy workaround is to use the older form

eval dir=~$LOGNAME
export dir

but it'd be nice if that weren't needed.
