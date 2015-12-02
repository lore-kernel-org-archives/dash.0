From: Gioele Barabucci <gioele@svario.it>
Subject: dash: read does not ignore trailing spaces
Date: Wed, 2 Dec 2015 23:37:17 +0100
Message-ID: <n3nrqu$mj2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49225 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756296AbbLBWh0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 2 Dec 2015 17:37:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1a4G1c-0002S8-BI
	for dash@vger.kernel.org; Wed, 02 Dec 2015 23:37:24 +0100
Received: from f048206007.adsl.alicedsl.de ([78.48.206.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 02 Dec 2015 23:37:24 +0100
Received: from gioele by f048206007.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 02 Dec 2015 23:37:24 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I am forwarding a bug [1] reported by a Debian user: `read` does not
ignore trailing spaces. The current version of dash is affected by
this bug.

A simple test from the original reporter:

    $ dash -c 'echo "  a b  " | { read v ; echo "<$v>" ; }'
    <a b  >

    $ bash -c 'echo "  a b  " | { read v ; echo "<$v>" ; }'
    <a b>

Other shells like posh and mksh behave like bash.

This error is reproducible with dash 0.5.7 and with the current master
git master branch, commit 2e5842258bd5b252ffdaa630db09c9a19a9717ca.

[1] https://bugs.debian.org/794965

--
Gioele Barabucci <gioele@svario.it>

