From: Sjon Hortensius <Sjon@hortensius.net>
Subject: Fwd: bug? Spawned childs always remain in zombie state
Date: Sun, 20 Jan 2013 13:04:04 +0100
Message-ID: <CAMqPLXX4GtCXcfrOnBkhPw+PEFRXh0x9X54H9paqm6b7vDnzNA@mail.gmail.com>
References: <CAMqPLXWsMhPBjYa3JnCmuO=M6m2F=hSdiEfRx390VKdgC5qxZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:44242 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATMEF (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 20 Jan 2013 07:04:05 -0500
Received: by mail-vb0-f51.google.com with SMTP id fq11so3851309vbb.10
        for <dash@vger.kernel.org>; Sun, 20 Jan 2013 04:04:04 -0800 (PST)
In-Reply-To: <CAMqPLXWsMhPBjYa3JnCmuO=M6m2F=hSdiEfRx390VKdgC5qxZg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi. I'm trying to create a script which monitors a directory using
inotify and spawns a background process for all events. However I
found that all childs will remain in zombie state until the script
quits and I am unable to find a proper fix.

A minimal testcase:

#!/bin/dash
while true
do
    sleep 1 &
#    jobs >/dev/null
done

If you open a second terminal you'll see that all the 'sleep'
processes end up being defunct. I have tried playing with `set -ma`
but the only workaround I found is the commented 'jobs' line.
Uncommenting that line will result in expected behavior where childs
are properly reaped. Is this a bug, or is there an alternative
solution I'm missing?

Thanks,
Sjon
