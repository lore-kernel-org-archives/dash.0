From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] \e in "echo" and "printf" builtins
Date: Sun, 29 Jun 2014 11:28:50 +0200
Message-ID: <53AFDC52.3060902@gigawatt.nl>
References: <20140628045653.GA5097@angband.pl> <53AEF2E3.5080205@gigawatt.nl> <3DBAFEEE-9555-483E-8260-7D5E9B47F9AD@aim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.104]:39868 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752383AbaF2J35 (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 29 Jun 2014 05:29:57 -0400
In-Reply-To: <3DBAFEEE-9555-483E-8260-7D5E9B47F9AD@aim.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Paul Gilmartin <PaulGBoulder@aim.com>
Cc: dash <dash@vger.kernel.org>

On 28/06/14 19:33, Paul Gilmartin wrote:
> On 2014-06-28, at 10:52, Harald van Dijk wrote:
>> No comment on whether dash itself should accept \e, but you already
>> found a compiler that doesn't support it at all, and many of the ones
>> that do support it also (optionally) issue a warning for it. Should the
>> C code perhaps be using \033 instead of \e?
>>
> And here I put on my EBCDIC hat (crown of thorns) and say, "Be careful
> using numeric code points; they're not portable."

The way GCC does this is to hard-code the values for ASCII, and to
hard-code the values for EBCDIC, both hidden behind preprocessor macros.
Taking that approach in dash would look something like

#if defined(ASCII)
#define ESCAPE '\033'
#elif defined(EBCDIC)
#define ESCAPE '\047'
#else
#error Unknown character set
#endif

and then use ESCAPE.

ASCII and EBCDIC would be detected (or specified) by the configure script.

But dash does have an assumption of ASCII already, which is why I didn't
think it would hurt to add one more. At the very least, it uses
hard-coded \033s in src/hetio.c, so that part of the code already cannot
be used on EBCDIC systems.

Cheers,
Harald van Dijk
