From: Heiko Gerstung <heiko@am-anger-1.de>
Subject: Re: Dashhh
Date: Thu, 17 Nov 2011 21:46:45 +0100
Message-ID: <4EC572B5.8020907@am-anger-1.de>
References: <4EC53397.2030005@am-anger-1.de> <slrnjcaqkf.lrr.stephane.chazelas@spam.is.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49687 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1KQUqr (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 15:46:47 -0500
In-Reply-To: <slrnjcaqkf.lrr.stephane.chazelas@spam.is.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Am 17.11.11 21:11, schrieb Stephane CHAZELAS:
> 2011-11-17, 17:17(+01), Heiko Gerstung:
> [...]
>> 1. The usual "[[" and "==" stuff (pretty easy to change, thank you sed)
>> 2. shift returns with a critical error when no arguments are left (no really good solution found)
> [ "$#" -eq 0 ] || shift
>
>> 3. $[] arithmetic stuff not working (OK, worked around that with bc)
> $((...))
>
>> 4. The bash FUNCNAME variable was very valuable for debugging purposes and is nonexistent in dash
>
> If your functions are written as
>
> f() {
>    ...
> }
>
> sed 's/^[[:blank:]]*\([^[:blank:]]*\)[[:blank:]]*()[[:blank:]]*{/&  local FUNCNAME=\1;/'
>
Thanks for your helpful comments, in fact I did something like this 
before I added the FUNCNAME patch to my dash sourcetree. I still prefer 
the FUNCNAME implementation as provided by my patch, but it is certainly 
possible to work around that as proposed by you.

Regards,
  Heiko

