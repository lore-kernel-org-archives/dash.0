From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Sun, 6 Mar 2011 17:48:52 -0600
Message-ID: <20110306234845.GC18385@elie>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gw0-f51.google.com ([74.125.83.51]:41591 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab1CFXs7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 6 Mar 2011 18:48:59 -0500
Received: by gwb15 with SMTP id 15so2214175gwb.10
        for <dash@vger.kernel.org>; Sun, 06 Mar 2011 15:48:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <E1PwMwp-0001iy-B5@fenris.runbox.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Cc: dash@vger.kernel.org

Hi David,

David A. Wheeler wrote:

> This isn't required by POSIX, but "test" in dash already supports
> tests not in POSIX.  I think it'd be useful to add one that's
> already in common use.

Thanks for writing this.

Generally speaking, dash tends to support features that ash and older
versions of dash supported (to avoid breaking backward compatibility)
and features accepted for POSIX.  Has the Austin Group made a decision
on whether this syntax is going to be supported?  I'd be happier about
it once the Austin Group has accepted it[1].

But it's nice to see the patch is simple.

Just my two cents,
Jonathan

[1] http://austingroupbugs.net/view.php?id=375
