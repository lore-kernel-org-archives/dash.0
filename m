From: Gioele Barabucci <gioele@svario.it>
Subject: [BUG] dash uses $* instead of $@ in variable assignments
Date: Thu, 26 Nov 2015 20:44:26 +0100
Message-ID: <n37neq$eem$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55393 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbbKZTok (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 26 Nov 2015 14:44:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1a22T3-0005kC-5K
	for dash@vger.kernel.org; Thu, 26 Nov 2015 20:44:33 +0100
Received: from f049116199.adsl.alicedsl.de ([78.49.116.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 26 Nov 2015 20:44:33 +0100
Received: from gioele by f049116199.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 26 Nov 2015 20:44:33 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I am forwarding a bug [1] reported by a Debian user: dash incorrectly
uses `$*` instead of the requested `$@` inside variable assignments.
The current version of dash is affected by this bug.

A simple test from the original reporter:

    $ dash -c 'IFS=:$IFS ; set -- a b c ; echo "$@" ; x="$@" ; echo "$x"'
    a b c
    a:b:c

    $ bash --posix -c 'IFS=:$IFS ; set -- a b c ; echo "$@" ; x="$@" ;
echo "$x"'
    a b c
    a b c

This error is reproducible with dash 0.5.7 and with the current master
git master branch, commit 2e5842258bd5b252ffdaa630db09c9a19a9717ca.

[1] https://bugs.debian.org/764365

--
Gioele Barabucci <gioele@svario.it>

