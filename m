From: Martijn Dekker <martijn@inlv.org>
Subject: Re: [PATCH] alias: Fix handling of empty aliases
Date: Mon, 27 Apr 2020 21:31:41 +0100
Message-ID: <c52dbce2-1b7f-f38a-cafe-46fbbcf8e04b@inlv.org>
References: <m2y33ftyu7.fsf@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:34528 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgD0UpG (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 27 Apr 2020 16:45:06 -0400
Received: from [192.168.1.250] (host86-142-68-115.range86-142.btcentralplus.com [86.142.68.115])
        (authenticated bits=0)
        by kahlil.inlv.org (8.15.2/8.15.2) with ESMTPSA id 03RKVftu004856
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <dash@vger.kernel.org>; Mon, 27 Apr 2020 22:31:41 +0200
In-Reply-To: <m2y33ftyu7.fsf@pomona.edu>
Content-Language: nl
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

Op 09-05-19 om 16:46 schreef Michael Greenberg:
> Dash was incorrectly handling empty aliases.

For the record, the behaviour in Busybox ash, FreeBSD sh and NetBSD sh 
is the same.

- M.

-- 
modernish -- harness the shell
https://github.com/modernish/modernish
