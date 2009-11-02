From: Sven Mascheck <mascheck@in-ulm.de>
Subject: Re: export + default value parameter expansion -> broken dash parser
Date: Mon, 2 Nov 2009 21:40:18 +0100
Message-ID: <20091102204017.GD18579@lisa.in-ulm.de>
References: <200911011520.38362.vapier@gentoo.org>
Reply-To: mascheck@in-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.in-ulm.de ([217.10.8.10]:55260 "HELO mail.in-ulm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932399AbZKBUqz (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 Nov 2009 15:46:55 -0500
Content-Disposition: inline
In-Reply-To: <200911011520.38362.vapier@gentoo.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Sun, Nov 01, 2009 at 04:20:37PM -0400, Mike Frysinger wrote:
> dash is unable to parse:
> unset A; export ${A- -E}

...let alone:

$ unset A; export ${A- -p}

hell is loose!

no, phew, just a mishap about the parameter
itself going poof when being expanded.
