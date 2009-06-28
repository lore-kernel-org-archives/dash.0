From: Nikola Vladov <v20-sizeof@riemann.fmi.uni-sofia.bg>
Subject: Re: malloctests.c
Date: Sun, 28 Jun 2009 10:02:43 +0300
Message-ID: <20090628070243.3107.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from riemann.fmi.uni-sofia.bg ([62.44.100.74]:1087 "HELO
	riemann.fmi.uni-sofia.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751583AbZF1HCm (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Jun 2009 03:02:42 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Very sorry!
I have a made a stupid mistake.  Change the code of malloctest.c so:

 u = b-a;
+x = buf + sizeof(buf);
 *--x = '\n';

Resume:  include the line with sizeof after: u = b-a;

Nikola

