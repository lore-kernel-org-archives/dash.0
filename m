From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: echo do not print NUL byte
Date: Wed, 20 Jan 2016 23:32:11 +0100
Message-ID: <56A00AEB.5090606@gigawatt.nl>
References: <20160120223850.25cdf852@enterprise>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:32982
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750894AbcAUAUl (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 20 Jan 2016 19:20:41 -0500
In-Reply-To: <20160120223850.25cdf852@enterprise>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Trek <trek00@inbox.ru>, dash@vger.kernel.org

Hi,

On 20/01/2016 22:38, Trek wrote:
> there is no way to print the NUL byte with the echo utility
>
> with dash (XSI, no -e argument):
>
>    $ dash -c 'echo \\0 | od -An -c'
>      \n

This is https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=379227, which 
did get fixed already, but it was after 0.5.8. That should mean it will 
be in the next release of dash, but you can check out the sources from 
Git if you want to see it now.

Cheers,
Harald van Dijk
