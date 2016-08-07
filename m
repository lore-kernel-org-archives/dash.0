From: Seb <sbb@tuxfamily.org>
Subject: Re: [PATCH 1/2] mkbuiltins: Use a `while` loop rather than `nl`
Date: Sun, 7 Aug 2016 12:17:39 +0200
Message-ID: <20160807101739.GA4738@woland.sadovaia.lan>
References: <20160804055411.23558-1-somasissounds@gmail.com>
 <be6ddf83-041e-7dca-5f5c-16167faa9d95@gigawatt.nl>
 <20160806090242.GA4686@woland.sadovaia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:46970 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbcHGKRq (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 7 Aug 2016 06:17:46 -0400
Received: from woland (unknown [88.181.135.123])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 9C5B05FF8A
	for <dash@vger.kernel.org>; Sun,  7 Aug 2016 12:26:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160806090242.GA4686@woland.sadovaia.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Sat, Aug 06, 2016 at 11:02:42AM +0200, Seb wrote:
> This is an attempt to simplify the current implementation [...]

BTW, I wonder if there is not a (virtual) bug with the current
mkbuiltins. Look at the TRUECMD macro in the generated builtins.h:

 #define TRUECMD (builtincmd + 1)

It doesn't point on "true" (mask=2, "special builtin") but on ":"
(mask=3, "standard builtin"), whatever the order of the aliases
you set in builtins.def.in. Maybe it's a mere problem with the
macro name ("TRUECMD" should rather be "COLONCMD"), but I don't
know if it is really an intended behaviour as the result is
finally a matter of sorting.

++
Seb.



