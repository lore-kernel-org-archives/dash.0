From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Dash quoting bug?
Date: Fri, 30 Nov 2007 09:33:31 -0500
Message-ID: <47501F3B.8030208@sunshineco.com>
References: <474EBF87.3040103@sunshineco.com> <20071130002328.GH23769@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:59773 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753943AbXK3OeE (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 30 Nov 2007 09:34:04 -0500
In-Reply-To: <20071130002328.GH23769@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Herbert Xu wrote:
> On Thu, Nov 29, 2007 at 08:32:55AM -0500, Eric Sunshine wrote:
>> According to the dash manual, within single quotes, all characters are 
>> treated as literals (except single quote), which appears to agree with 
>> POSIX, so the above behavior seems incorrect.
> We need a patch for the dash manual :)
> Unfortunately according to POSIX we must interpret these escape sequences:
> 12682 SYNOPSIS
> 12683   echo [string ...]
> 12695     The following character sequences shall be recognized
> 12696     within any of the arguments:
> 12703       \n        Write a <newline>.

Thank you for the response and for pointing out this documentation.

> I suggest that you switch over printf for portability.  That is,
> replace all occurances of
> 	echo "string"
> with
> 	printf "%s\n" "string

Unfortunately, in this case, a portability requirement to older 
platforms lacking 'printf' negates the viability of such a solution. As 
it turns out, however, I was able to resolve the issue by eliminating 
the need to emit backslashes, thus altogether side-stepping the problem.

-- ES

