From: Dan Muresan <danmbox@gmail.com>
Subject: dash "set -e" breaks "trap INT"
Date: Wed, 10 Nov 2010 15:49:19 +0200
Message-ID: <AANLkTimrXpDb5z1d4PC3M=8hyN-Ob7sVb1ngF-JTem4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44077 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0KJNtW (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Nov 2010 08:49:22 -0500
Received: by qwi4 with SMTP id 4so465363qwi.19
        for <dash@vger.kernel.org>; Wed, 10 Nov 2010 05:49:21 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I've submitted a bug regarding trap + "set -e" on Ubuntu Launchpad
[1], but that's probably not the best place to talk about the issue.

I'm using dash 0.5.5.1-3ubuntu2 from Ubuntu Lucid on an x86 machine.
With "set -e", only the first command in an INT trap handler gets
executed -- UNLESS that first command is a call to a function that
returns 0. Here's an example of the problem:

--- 8-x ---

#!/bin/sh
set -e

trap 'hnd' INT
trap 'echo EXIT' EXIT

zero() {
  return 0;
}

hnd() {
  #zero
  echo "Ignored 1"; echo "Ignored 2"
  sleep 1
  echo Back
}

for i in 3 2 1; do
    echo "$i"
    sleep 1 # || true
done

echo OUT

--- 8-x ---

If we uncomment either the call to zero, or the || true check, the
entire handler gets executed. A set +e inside the handler makes no
difference.

My workaround at the moment is to trap both INT and EXIT (I'm not
going to rely on the "zero" bit of magic). I suppose this workaround
will unfortunately have to stick around for a while -- even if this
bug gets fixed, scripts can't assume they are running on the latest
version of dash.

[1] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/673119

-- Dan
