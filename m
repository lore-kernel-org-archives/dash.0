From: Bastian Bittorf <bittorf@bluebottle.com>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 19 Nov 2015 13:36:17 +0100
Message-ID: <20151119123617.GL2741@medion.lan>
References: <5643F1B2.5050207@sanitarium.net>
 <20151112081006.GV19618@medion.lan>
 <5644BA37.2090606@sanitarium.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.bluebottle.com ([176.9.67.91]:59476 "EHLO
	mail.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbKSMhJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 19 Nov 2015 07:37:09 -0500
Content-Disposition: inline
In-Reply-To: <5644BA37.2090606@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kevin Korb <kmk@sanitarium.net>
Cc: dash@vger.kernel.org

* Kevin Korb <kmk@sanitarium.net> [19.11.2015 13:21]:
> Then why is the -n behaviour documented in the man page?

Because '-n' works with 'dash'.
Undefined means: it depends on the implementation.

bye, bastian
