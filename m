From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: shift "fatal error"
Date: Sat, 26 Mar 2011 02:27:17 -0500
Message-ID: <20110326072717.GA26739@elie>
References: <AANLkTik1TC3jv-imnbChRGqtHzRCvKCcB5_LnqEnDc9u@mail.gmail.com>
 <20110310192333.GE3948@wopr.local.invalid>
 <20110315213116.GA53303@stack.nl>
 <AANLkTinQyNdnbuE9Ytw43bnwVvFqXy4kxbsuiFReidDT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41746 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1CZH1Y (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 26 Mar 2011 03:27:24 -0400
Received: by iwn34 with SMTP id 34so1810464iwn.19
        for <dash@vger.kernel.org>; Sat, 26 Mar 2011 00:27:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinQyNdnbuE9Ytw43bnwVvFqXy4kxbsuiFReidDT@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org

Dan Muresan wrote:

> After reading the other part of the spec (about syntax errors in
> utilities), I reached the conclusion that dash has just enough excuses
> in the spec and in history to behave as it currently does

I have no strong opinion about this (and indeed the spec and history
not giving a clear answer reduces my motivation) but if you'd like to
change the spec, it's very easy.  See

 http://www.opengroup.org/austin/

Hope that helps,
Jonathan
