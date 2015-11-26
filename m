From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] dash uses $* instead of $@ in variable assignments
Date: Thu, 26 Nov 2015 22:07:46 +0100
Message-ID: <565774A2.8070800@gigawatt.nl>
References: <n37neq$eem$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:37494
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752823AbbKZVhE (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 26 Nov 2015 16:37:04 -0500
In-Reply-To: <n37neq$eem$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
Cc: dash@vger.kernel.org

On 26/11/2015 20:44, Gioele Barabucci wrote:
> Hello,
>
> I am forwarding a bug [1] reported by a Debian user: dash incorrectly
> uses `$*` instead of the requested `$@` inside variable assignments.
> The current version of dash is affected by this bug.
>
> A simple test from the original reporter:
>
>      $ dash -c 'IFS=:$IFS ; set -- a b c ; echo "$@" ; x="$@" ; echo "$x"'
>      a b c
>      a:b:c
>
>      $ bash --posix -c 'IFS=:$IFS ; set -- a b c ; echo "$@" ; x="$@" ;
> echo "$x"'
>      a b c
>      a b c

The behaviour for "$@" is underspecified except for very specific 
situations. Both behaviours are very defensible. There is an attempt to 
clear up the requirements for the future, but even with the cleared up 
wording, the behaviour of var=$@ and var="$@" would remain unspecified. 
See <http://austingroupbugs.net/view.php?id=888> for details.

Cheers,
Harald van Dijk

> This error is reproducible with dash 0.5.7 and with the current master
> git master branch, commit 2e5842258bd5b252ffdaa630db09c9a19a9717ca.
>
> [1] https://bugs.debian.org/764365
>
> --
> Gioele Barabucci <gioele@svario.it>
>
> --
> To unsubscribe from this list: send the line "unsubscribe dash" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

