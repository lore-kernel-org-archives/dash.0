From: Martijn Dekker <martijn@inlv.org>
Subject: Re: "case" bug in dash
Date: Wed, 02 Mar 2016 22:18:44 +0100
Message-ID: <56D758B4.6000005@inlv.org>
References: <20160302210914.GC1056@timmy>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:52827 "EHLO kahlil.inlv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbcCBVSs (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 2 Mar 2016 16:18:48 -0500
In-Reply-To: <20160302210914.GC1056@timmy>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Adam Endrodi <adam.endrodi@nokia.com>

Adam Endrodi schreef op 02-03-16 om 22:09:
> The following program prints "boo" incorrectly (I'm trying to match
> non-numbers):

That's correct. In shell glob pattern bracket expressions, the standard
negator is '!' and not '^'. Many shells support '^' as a synonym, but
that's an extension to the standard and not mandatory. Dash usually
doesn't support such extensions. But all shells support '!', so just
that instead and you're safe.

Reference:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_13
"If an open bracket introduces a bracket expression as in XBD RE Bracket
Expression, except that the <exclamation-mark> character ( '!' ) shall
replace the <circumflex> character ( '^' ) in its role in a non-matching
list in the regular expression notation, it shall introduce a pattern
bracket expression."

- M.

