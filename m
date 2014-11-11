From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: Bug#501566: dash: details of redirection/duplication in manpage
 are reversed
Date: Tue, 11 Nov 2014 14:19:11 +0000
Message-ID: <20141111141911.GC4343@chaz.gmail.com>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52377 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbaKKOUS (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Nov 2014 09:20:18 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1XoCIp-0008AN-No
	for dash@vger.kernel.org; Tue, 11 Nov 2014 15:20:15 +0100
Received: from 5ec33b79.skybroadband.com ([94.195.59.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 11 Nov 2014 15:20:15 +0100
Received: from stephane.chazelas by 5ec33b79.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 11 Nov 2014 15:20:15 +0100
Content-Disposition: inline
In-Reply-To: <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2014-11-11 14:23:21 +0100, Stephen Shirley:
[...]
> "[n1]>&n2    Redirect standard output (or n1) to n2."
> 
> It doesn't cover the case where n2 is later changed, and how n1 does
> not follow this, but it's the simplest fix i see.
[...]

That's ambiguous.

Maybe:

[n1]>&n2    Redirect standard output (or fd n1) to the same "open
            file description" as on fd n2.

[n1]>&n2    Redirect standard output (or fd n1) to the same
            resource as open on fd n2.

[n1]>&n2    Copy fd n2 as stdout (or fd n1)

?

-- 
Stephane



