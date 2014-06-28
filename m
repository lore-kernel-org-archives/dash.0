From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: Re: [PATCH] \e in "echo" and "printf" builtins
Date: Sat, 28 Jun 2014 11:33:18 -0600
Message-ID: <3DBAFEEE-9555-483E-8260-7D5E9B47F9AD@aim.com>
References: <20140628045653.GA5097@angband.pl> <53AEF2E3.5080205@gigawatt.nl>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from omr-m05.mx.aol.com ([64.12.143.79]:39696 "EHLO
	omr-m05.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670AbaF1S1N (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 28 Jun 2014 14:27:13 -0400
Received: from mtaout-mac02.mx.aol.com (mtaout-mac02.mx.aol.com [172.26.222.206])
	by omr-m05.mx.aol.com (Outbound Mail Relay) with ESMTP id D828070000088
	for <dash@vger.kernel.org>; Sat, 28 Jun 2014 14:21:14 -0400 (EDT)
Received: from [192.168.1.22] (c-24-9-79-242.hsd1.co.comcast.net [24.9.79.242])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-mac02.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id F33DE3800008C
	for <dash@vger.kernel.org>; Sat, 28 Jun 2014 14:21:13 -0400 (EDT)
In-Reply-To: <53AEF2E3.5080205@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>

On 2014-06-28, at 10:52, Harald van Dijk wrote:

> On 28/06/14 06:56, Adam Borowski wrote:
>> 
>> 
>> I'm not sure what's your policy towards extensions, but \e as \033 is
>> something ubiquitous in the Unix world.  C compilers (gcc, clang, icc and
>> tcc -- but not MSVC), perl, shells (bash and zsh -- but not dash), etc.
>> 
>> What about supporting it in dash as well?
>> 
As a mostly passive lurker, I'm inclined to say, "No.  Dash doesn't
want to become bash."

   http://windtoons.com/images/Camel_-Head-Under-Tent-large.gif

OTOH, there's a POSIX requirement that builtins be indistinguishable
(except in performance) from the corresponding executables. 


> No comment on whether dash itself should accept \e, but you already
> found a compiler that doesn't support it at all, and many of the ones
> that do support it also (optionally) issue a warning for it. Should the
> C code perhaps be using \033 instead of \e?
> 
And here I put on my EBCDIC hat (crown of thorns) and say, "Be careful
using numeric code points; they're not portable."

-- gil

