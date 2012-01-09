From: Michael Welsh Duggan <mwd@cert.org>
Subject: Question about job control in non-interactive shells
Date: Mon, 09 Jan 2012 11:17:03 -0500
Message-ID: <tntr4z8j1fk.fsf@waterbuck.yellow.cert.org>
Reply-To: mwd@cert.org
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from euclid.red.cert.org ([192.88.209.48]:35611 "EHLO
	euclid.red.cert.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170Ab2AIQ33 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 9 Jan 2012 11:29:29 -0500
Received: from bucknell.indigo.cert.org (bucknell.indigo.cert.org [10.60.10.121])
	by euclid.red.cert.org (8.14.4/8.14.4) with ESMTP id q09GCd0X025717
	for <dash@vger.kernel.org>; Mon, 9 Jan 2012 11:12:39 -0500
Received: from waterbuck.yellow.cert.org (waterbuck.yellow.cert.org [10.20.128.84])
	by bucknell.indigo.cert.org (8.14.4/8.14.4/2.80) with ESMTP id q09GH3nT018194
	for <dash@vger.kernel.org>; Mon, 9 Jan 2012 11:17:03 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I am trying to determine why:

  dash -c "sleep 5 & kill %1"

results in:

  dash: 1: kill: No such process

whereas from an interactive dash

  sleep 5 & kill %1

seems to do exactly what it should.  Any hints?

-- 
Michael Welsh Duggan
(mwd@cert.org)
