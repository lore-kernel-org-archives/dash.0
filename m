From: "Taylan Ulrich B." <taylanbayirli@gmail.com>
Subject: 'continue' does not work in files sourced with dotcmd
Date: Sat, 26 Feb 2011 19:23:54 +0100
Message-ID: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39637 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab1BZSXz (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 26 Feb 2011 13:23:55 -0500
Received: by qyg14 with SMTP id 14so2327618qyg.19
        for <dash@vger.kernel.org>; Sat, 26 Feb 2011 10:23:54 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

Using latest dash from git.
Transcript:

$ echo continue > foo
$ for i in 1; do . ./foo; echo foobar; done
foobar
$

By the way you guys should look into the Debian bugtracker for their
dash package, if you don't already; most of the bugs there are
probably upstream.

Dash is awesome.
Regards,
Taylan
