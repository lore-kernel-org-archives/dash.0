From: Harald van Dijk <harald@gigawatt.nl>
Subject: test incorrectly rejecting valid expression with confusing ! placement
Date: Sat, 24 Aug 2013 16:01:17 +0200
Message-ID: <5218BCAD.2010107@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:58380 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754358Ab3HXOBc (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 24 Aug 2013 10:01:32 -0400
Received: from hosting12.csv-networks.nl ([84.244.151.141])
	by mailfilter.csv-networks.nl with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <harald@gigawatt.nl>)
	id 1VDEPC-0007Re-8l
	for dash@vger.kernel.org; Sat, 24 Aug 2013 16:01:30 +0200
Received: from 541b2160.cm-5-4a.dynamic.ziggo.nl ([84.27.33.96] helo=[10.0.1.200])
	by hosting12.csv-networks.nl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1VDEPC-000270-2l
	for dash@vger.kernel.org; Sat, 24 Aug 2013 16:01:30 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

Hi,

Now that Herbert fixed the reported crash in test (in a far simpler
manner than I had suggested, which I like), I did some more testing, and
came across one case that does not currently work, and did not work in
the past, but is perfectly valid:

$ src/dash -c 'test ! ! = !'
src/dash: 1: test: =: unexpected operator

POSIX requires special behaviour for four-argument tests:

4 arguments:
  If $1 is '!', negate the three-argument test of $2, $3, and $4.
  [...]

so this is supposed to evaluate as the negation of test ! = !. That test
does work properly in dash.

There are also some cases where test gives incorrect results when
combining ! with -o, but ( ), -a and -o have been obsoleted in favour of
the built-in shell operators ( ), && and ||, so I am not sure if that is
worth fixing. Details anyway:

$ src/dash -c 'test ! -o !'
src/dash: 1: test: -o: unexpected operator

This is covered by the special rule for three arguments, where the
second argument is a binary operator. -o is a boolean binary operator,
but a binary operator nonetheless, so this should test whether the two !
arguments are empty strings.

$ src/dash -c 'test ! "" -o !'; echo $?
0

This is covered by the special rule for four arguments, there ! as the
first argument evaluates the remaining three-argument test and negates
the result. In this special case, ! does not have higher precedence than
-o, so the correct exit status is 1, which bash's test gives.

Cheers,
Harald
