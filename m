From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Mon, 7 Mar 2011 16:00:49 -0600
Message-ID: <20110307220048.GE15732@elie>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie>
 <E1PwOzt-0007C2-Qw@fenris.runbox.com>
 <20110307103457.GA5987@wopr.local.invalid>
 <E1Pwbqm-00056z-0V@garm.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59310 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab1CGWAx (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Mar 2011 17:00:53 -0500
Received: by iwn34 with SMTP id 34so4312528iwn.19
        for <dash@vger.kernel.org>; Mon, 07 Mar 2011 14:00:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <E1Pwbqm-00056z-0V@garm.runbox.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Cc: dash@vger.kernel.org, guido+kernel.org@berhoerster.name

Hi David,

David A. Wheeler wrote:

> But is "==" a misfeature? I don't think so.

For what it's worth, I have no strong objections to "==" (though no
great excitement about it either).  I was only taking the opportunity
to explain the possibly mysterious-seeming current feature set.

> Jonathan Nieder said that dash "tends to support features [of] ash".
> Busybox ash is *also* an ash, as shown in this family tree:

I suppose you misunderstood.  dash decends from the original ash.
Sometimes features disappear --- then they tend to be gone for good.
Backward compatibility of the kind I was describing is meant to
facilitate upgrades.

> There was only one negative comment that I remember, and it
> primarily noted that == is not in dash and FreeBSD.

That comment was by a contributor to both of those projects, and I
seem to remember it noting _why_ "==" is not in dash and FreeBSD
yet.

> If the POSIX
> group will never add new capabilities until dash adds them,

I don't think that's the case.  If your goal is to advance this in
POSIX, I don't think implementing in dash is a necessary prerequisite.

> There's value in "lean and mean", but this is a few bytes we're
> talking about, for a feature that is already widely used.

Anyway, I suppose Herbert can decide whether it's worth applying
the patch, now that the explaining has been taken care of.

My (personal) advice is to wait.  Presumably soon we will know whether
== is to be part of the "test" builtin in POSIX or is going to be
allowed in "[[" only.

Kind regards,
Jonathan
