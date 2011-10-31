From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 08:03:54 -0600
Message-ID: <4EAEAACA.7060401@redhat.com>
References: <20111031034146.GA19477@gondor.apana.org.au> <201110310023.45138.vapier@gentoo.org> <4EAE9ECB.4040607@redhat.com> <ACAAFE20-00AB-46BC-BEE4-3BFAA1F0141A@aim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099Ab1JaOED (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Oct 2011 10:04:03 -0400
In-Reply-To: <ACAAFE20-00AB-46BC-BEE4-3BFAA1F0141A@aim.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Paul Gilmartin <PaulGBoulder@aim.com>
Cc: dash@vger.kernel.org

On 10/31/2011 07:35 AM, Paul Gilmartin wrote:
> I used to know a statement in POSIX that builtins should behave
> identically to the executables in /bin (or perhaps /usr/bin)
> except for performance.

Only in regards to standardized use of those utilities.  'echo "\1"' is 
not standardized, so it is allowed to differ between the dash built-in 
and /bin/echo.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
