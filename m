From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Fix additional use of 'j' printf length modifier.
Date: Thu, 7 Jul 2011 02:12:44 -0500
Message-ID: <20110707071244.GB11514@elie>
References: <1302921010.2620.3.camel@gemini>
 <1302921279.2620.6.camel@gemini>
 <20110707064154.GE16157@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37149 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1GGHMu (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 03:12:50 -0400
Received: by iyb12 with SMTP id 12so620871iyb.19
        for <dash@vger.kernel.org>; Thu, 07 Jul 2011 00:12:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110707064154.GE16157@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Brian Koropoff <bkoropoff@gmail.com>, dash@vger.kernel.org

Herbert Xu wrote:

> %j is part of ISO C99 and POSIX

*checks*  Oh, so it is!  Thanks; it's nice to learn the standard
offers more than expected.

Brian: fwiw gnulib printf seems to provide %j, though of course it's a
bit more heavyweight.  And of course there are alternative C libraries
--- e.g., glibc runs on Solaris.
