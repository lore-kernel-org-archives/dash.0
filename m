From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] \e in "echo" and "printf" builtins
Date: Sat, 28 Jun 2014 18:52:51 +0200
Message-ID: <53AEF2E3.5080205@gigawatt.nl>
References: <20140628045653.GA5097@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.104]:33387 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751309AbaF1ROL (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 28 Jun 2014 13:14:11 -0400
In-Reply-To: <20140628045653.GA5097@angband.pl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: dash@vger.kernel.org

On 28/06/14 06:56, Adam Borowski wrote:
> Hi!
> 
> I'm not sure what's your policy towards extensions, but \e as \033 is
> something ubiquitous in the Unix world.  C compilers (gcc, clang, icc and
> tcc -- but not MSVC), perl, shells (bash and zsh -- but not dash), etc.
> 
> What about supporting it in dash as well?
> Patch attached.

Hi,

No comment on whether dash itself should accept \e, but you already
found a compiler that doesn't support it at all, and many of the ones
that do support it also (optionally) issue a warning for it. Should the
C code perhaps be using \033 instead of \e?

Cheers,
Harald van Dijk
