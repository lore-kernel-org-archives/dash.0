From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Don't include config.h when building helpers using the
 native compiler
Date: Mon, 22 Jun 2020 09:53:37 +0100
Message-ID: <b26fe976-2937-3c0e-8543-e7360d03059b@gigawatt.nl>
References: <20200622052513.1850288-1-fontaine.fabrice@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:39724 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgFVIxm (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 22 Jun 2020 04:53:42 -0400
In-Reply-To: <20200622052513.1850288-1-fontaine.fabrice@gmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, dash@vger.kernel.org
Cc: Peter Korsgaard <jacmet@sunsite.dk>

On 22/06/2020 06:25, Fabrice Fontaine wrote:
> config.h contains settings for the cross compiler (most importantly
> 32/64bit versions of functions), so don't include it when calling the
> native compiler to build the helpers.
> 
> Otherwise we get build errors like:
> 
> /usr/bin/gcc -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -g -O2 -Wall    -o mkinit mkinit.c
> In file included from /usr/include/sys/stat.h:107,
>                   from /usr/include/fcntl.h:38,
>                   from mkinit.c:50:
> /usr/include/bits/stat.h:117: error: redefinition of ‘struct stat’
> In file included from /usr/include/fcntl.h:38,
>                   from mkinit.c:50:
> /usr/include/sys/stat.h:504: error: redefinition of ‘stat’
> /usr/include/sys/stat.h:455: note: previous definition of ‘stat’ was here
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> [Retrieved from:
> https://git.buildroot.net/buildroot/tree/package/dash/0001-no-config.h-for-helpers.patch]
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

A better version of this patch has already been submitted and accepted 
in 2018: <https://www.spinics.net/lists/dash/msg01629.html>.

Cheers,
Harald van Dijk
