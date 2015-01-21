From: Seb <sbb@tuxfamily.org>
Subject: Re: Inconsistent behaviour between 'jobs' and 'echo "$(jobs)"'
Date: Wed, 21 Jan 2015 14:42:25 +0100
Message-ID: <20150121134225.GA708@ein.free.fr>
References: <54BD4691.7050906@ertelnet.rybnik.pl>
 <20150120084438.GA751@ein.free.fr>
 <54BE89D6.7040101@ertelnet.rybnik.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:62090 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbbAUNmZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 21 Jan 2015 08:42:25 -0500
Content-Disposition: inline
In-Reply-To: <54BE89D6.7040101@ertelnet.rybnik.pl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>

On Tue, Jan 20, 2015 at 06:01:10PM +0100, Damian Wrobel wrote:
> I would prefer not to code something like the following:
> 
> $ jobs -p >/tmp/jobs-$$ && kill $(cat /tmp/jobs-$$); rm /tmp/jobs-$$

As a better alternative, you could maybe try this:
  
  trap : TERM # in case we have something to do after...
  /bin/kill -s TERM -$$

Just an idea...

++
Seb.

