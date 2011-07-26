From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Avoid imaxdiv when only one of the results is wanted
Date: Tue, 26 Jul 2011 02:26:21 +0200
Message-ID: <1311639981.15439.11.camel@linux>
References: <1311635376.10727.8.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:36329 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab1GZA0Y (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 25 Jul 2011 20:26:24 -0400
Received: from 541f32bc.cm-5-8a.dynamic.ziggo.nl ([84.31.50.188] helo=[10.0.1.100])
	by hosting12.csv-networks.nl with esmtpa (Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1QlVQW-0005C8-8R
	for dash@vger.kernel.org; Tue, 26 Jul 2011 02:23:12 +0200
In-Reply-To: <1311635376.10727.8.camel@linux>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Tue, 2011-07-26 at 01:09 +0200, Harald van Dijk wrote:
> dash rather pointlessly calls imaxdiv, only to discard one of its
> results. The call was already made conditional a while back because some
> systems don't have imaxdiv, but the generated code for the version with
> imaxdiv and the one with / and % is identical (with GCC 4.6.1 or ICC
> 12.0.2, with -O0, -O2 or -Os), so it could just as well go entirely to
> clean up the code a little bit.

As I should have expected from those results, I messed up on the
comparisons. I still had an alternate definition of imaxdiv I was
testing with. The size actually decreases with the patch.

