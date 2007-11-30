From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Dash quoting bug?
Date: Fri, 30 Nov 2007 11:23:28 +1100
Message-ID: <20071130002328.GH23769@gondor.apana.org.au>
References: <474EBF87.3040103@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:2751 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762760AbXK3AXf (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 29 Nov 2007 19:23:35 -0500
Content-Disposition: inline
In-Reply-To: <474EBF87.3040103@sunshineco.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Andres Freund <andres@anarazel.de>, dash@vger.kernel.org

On Thu, Nov 29, 2007 at 08:32:55AM -0500, Eric Sunshine wrote:
>
> According to the dash manual, within single quotes, all characters are 
> treated as literals (except single quote), which appears to agree with 
> POSIX, so the above behavior seems incorrect.

We need a patch for the dash manual :)

Unfortunately according to POSIX we must interpret these escape sequences:

12680 NAME
12681            echo - write arguments to standard output

12682 SYNOPSIS
12683            echo [string ...]

12684 DESCRIPTION
12685            The echo utility writes its arguments to standard output, followed by a <newline>. If there are
12686            no arguments, only the <newline> is written.

12687 OPTIONS
12688            The echo utility shall not recognize the "- -" argument in the manner specified by Guideline 10
12689            of the Base Definitions volume of IEEE Std 1003.1-200x, Section 12.2, Utility Syntax Guidelines;
12690            "- -" shall be recognized as a string operand.
12691            Implementations shall not support any options.

12692 OPERANDS
12693            The following operands shall be supported:
12694            string       A string to be written to standard output. If any operand is -n, it shall be treated as
12695                         a string, not an option. The following character sequences shall be recognized
12696                         within any of the arguments:
12697                         \a        Write an <alert>.
12698                         \b        Write a <backspace>.
12699                         \c        Suppress the <newline> that otherwise follows the final argument in the
12700                                   output. All characters following the '\c' in the arguments shall be
12701                                   ignored.
12702                         \f        Write a <form-feed>.
12703                         \n        Write a <newline>.
12704                         \r        Write a <carriage-return>.
12705                         \t        Write a <tab>.
12706                         \v        Write a <vertical-tab>.
12707                         \\        Write a backslash character.
12708                         \0num Write an 8-bit value that is the zero, one, two, or three-digit octal number
12709                                   num.

I suggest that you switch over printf for portability.  That is, replace
all occurances of

	echo "string"

with

	printf "%s\n" "string

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
