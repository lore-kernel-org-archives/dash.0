From: Nikola Vladov <v20-redir@riemann.fmi.uni-sofia.bg>
Subject: redirect bug
Date: Tue, 23 Jun 2009 13:06:30 +0300
Message-ID: <20090623100630.20118.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from riemann.fmi.uni-sofia.bg ([62.44.100.74]:4861 "HELO
	riemann.fmi.uni-sofia.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752048AbZFWKNv (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Jun 2009 06:13:51 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

May be this is a bug:

echo XX > uu
cat <> uu

dash truncates file uu.  The open flag O_TRUNC must be removed.
I'm not 100% shure what POSIX say about: program <> file

Nikola
