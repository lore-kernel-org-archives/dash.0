From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH 1/2] mkbuiltins: Use a `while` loop rather than `nl`
Date: Thu, 4 Aug 2016 19:17:47 +0200
Message-ID: <be6ddf83-041e-7dca-5f5c-16167faa9d95@gigawatt.nl>
References: <20160804055411.23558-1-somasissounds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:57572
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934006AbcHDRRy (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 4 Aug 2016 13:17:54 -0400
In-Reply-To: <20160804055411.23558-1-somasissounds@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kylie McClain <somasissounds@gmail.com>, dash@vger.kernel.org
Cc: Kylie McClain <somasis@exherbo.org>

On 04/08/2016 07:54, Kylie McClain wrote:
> From: Kylie McClain <somasis@exherbo.org>
>
> nl, while specified in POSIX, is rather obscure and isn't provided by small
> coreutils implementations such as `busybox`. This while loop works just as
> well for our purposes.
...
> -sed 's/	-[a-z]*//' $temp2 | nl -ba -v0 |
> +sed 's/	-[a-z]*//' $temp2 | while read line;do \
> +	i=$(( ${i:--1} + 1 )); printf '%s %s\n' "${i}" "${line}";done |

$(( ... )) is mentioned in 
<https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Shell-Substitutions.html> 
as not universally supported, notably Solaris 10 /bin/sh does not have 
it. Given that dash was fairly recently changed to make it build on 
Solaris 9, it seems like a mistake to break that again.

Aside from that, i is such a common variable name that it seems risky to 
assume it is unset. I know I've set it myself in shell sessions that I 
ended up using for building dash. I never exported it, so it wouldn't 
break here, but it doesn't seem like a stretch that someone else does 
export it.

Cheers,
Harald van Dijk
