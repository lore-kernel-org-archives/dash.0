From: Ron Yorston <rmy@frippery.org>
Subject: Re: Infinite loop expanding PS1='${PWD/#foo/bar} '
Date: Wed, 19 Feb 2020 12:24:37 +0000
Message-ID: <5e4d2905.gFLC0KwBSmUAqWey%rmy@frippery.org>
References: <0F40565C-5717-491C-8450-A747614F86A9@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from sov.nat64.mythic-beasts.com ([93.93.129.128]:47770 "EHLO
        frippery.frippery.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726491AbgBSMeP (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 19 Feb 2020 07:34:15 -0500
In-Reply-To: <0F40565C-5717-491C-8450-A747614F86A9@me.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: zygoon@me.com, dash@vger.kernel.org

Zygmunt Krynicki wrote:
>Setting PS1 to something that does not expand correctly, like the
>example in the title, causes Dash to enter an infinite loop.

This is a known problem.  There's a patch to fix it here:

   https://patchwork.kernel.org/patch/11343121/

Ron
