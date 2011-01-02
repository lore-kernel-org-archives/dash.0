From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Rid dash of most undefined behavior + one bug fix
Date: Sun, 2 Jan 2011 03:42:12 -0600
Message-ID: <20110102094212.GA12175@burratino>
References: <AANLkTikBooagKbv1Nuk_Z_dzgFRCN_evadSJ8faEfwYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40551 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1ABJmV (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 2 Jan 2011 04:42:21 -0500
Received: by iwn9 with SMTP id 9so12622396iwn.19
        for <dash@vger.kernel.org>; Sun, 02 Jan 2011 01:42:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikBooagKbv1Nuk_Z_dzgFRCN_evadSJ8faEfwYw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: David Majnemer <david.majnemer@gmail.com>
Cc: dash@vger.kernel.org

Hi David,

David Majnemer wrote:

> The following is a series of diffs that should correct the above
> issues, feel free to apply what you want (my opinion is that none of
> them hurt too much and all of them make the code more portable):

Could you resend them as a thread, one patch per message, in the usual
form used for kernel patches[1] (including sign-off if you agree to
the developer's certificate of origin)?  It makes discussion much
easier.

Thanks, and sorry for the fuss.
Jonathan

[1] http://linux.yyz.us/patch-format.html
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD
