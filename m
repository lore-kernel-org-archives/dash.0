From: Martijn Dekker <martijn@inlv.org>
Subject: Re: dash: read does not ignore trailing spaces
Date: Fri, 29 Jan 2016 12:57:02 +0000
Message-ID: <56AB619E.4050605@inlv.org>
References: <n3nrqu$mj2$1@ger.gmane.org> <5660ADD6.4020308@gigawatt.nl> <20151203211748.GC9581@chaz.gmail.com> <5660C1A6.1010902@gigawatt.nl> <5661EEB7.8080908@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:55632 "EHLO kahlil.inlv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932112AbcA2M5F (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 29 Jan 2016 07:57:05 -0500
Received: from breedzicht.local (host-78-150-214-254.as13285.net [78.150.214.254])
	(authenticated bits=0)
	by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id u0TCv2Vr019341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <dash@vger.kernel.org>; Fri, 29 Jan 2016 13:57:02 +0100
In-Reply-To: <5661EEB7.8080908@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Harald van Dijk schreef op 04-12-15 om 19:51:
> Here it is. Attached is an updated patch that ignores the complete
> terminator if only a single field remains, otherwise ignores only
> trailing IFS whitespace.

I've tested the patch and it looks like it fixes the bug nicely.

With the patch, dash (like bash, ksh93, mksh and FreeBSD /bin/sh)
completely passes the IFS test suite written by the AT&T ksh93 people:
http://web.archive.org/web/20050414022354/http://www.research.att.com/~gsf/public/ifs.sh
(archive.org link because the AT&T research site is down)

Any chance of getting this patch pushed into the git repo?

Thanks,

- M.

