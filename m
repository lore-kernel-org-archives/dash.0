From: Zygmunt Krynicki <zygoon@me.com>
Subject: Infinite loop expanding PS1='${PWD/#foo/bar} '
Date: Wed, 19 Feb 2020 12:46:02 +0100
Message-ID: <0F40565C-5717-491C-8450-A747614F86A9@me.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mr85p00im-ztdg06021801.me.com ([17.58.23.195]:43408 "EHLO
        mr85p00im-ztdg06021801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbgBSLwW (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 19 Feb 2020 06:52:22 -0500
Received: from [192.168.3.138] (178.182.246.167.nat.umts.dynamic.t-mobile.pl [178.182.246.167])
        by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id AB2DD1805E9
        for <dash@vger.kernel.org>; Wed, 19 Feb 2020 11:46:05 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello

I am no subscribed so please CC me on the relies to this thread.

I=E2=80=99d like to report a bug.

While working on another project I managed to reproduce and debug a =
problem in dash.
Setting PS1 to something that does not expand correctly, like the =
example in the title, causes
Dash to enter an infinite loop.

I didn=E2=80=99t attempt to fix it yet as I=E2=80=99m not familiar with =
dash internals.=
