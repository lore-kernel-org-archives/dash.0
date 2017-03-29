From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: [BUG] 'nolog' and 'debug' options cause "$-" to wreak havoc
Date: Wed, 29 Mar 2017 22:59:24 +0100
Message-ID: <20170329215924.GA4546@chaz.gmail.com>
References: <5bdf99b4-2bde-3710-c323-25162ace143f@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:44605 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753717AbdC2WAV (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 29 Mar 2017 18:00:21 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcsd-dash@m.gmane.org>)
        id 1ctLdU-00046a-0b
        for dash@vger.kernel.org; Thu, 30 Mar 2017 00:00:12 +0200
Content-Disposition: inline
In-Reply-To: <5bdf99b4-2bde-3710-c323-25162ace143f@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2017-03-29 21:02:19 +0200, Martijn Dekker:
[...]
> [*] "nolog: Prevent the entry of function definitions into the command
> history; see Command History List."
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_25_03
[...]

For the record, nolog is approved for deprecation:
http://austingroupbugs.net/view.php?id=981

-- 
Stephane

