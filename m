From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [v2 PATCH] parser: Catch errors in expandstr
Date: Sun, 17 May 2020 13:19:28 +0100
Message-ID: <15d522d8-e0f5-be2a-f2a2-8b17290fce31@gigawatt.nl>
References: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
 <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
 <5e56df24.H24u7mxAPbLPL6fI%rmy@frippery.org>
 <20200228004023.GA9163@gondor.apana.org.au>
 <20200428061758.GA1771@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:35920 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgEQMUH (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 17 May 2020 08:20:07 -0400
In-Reply-To: <20200428061758.GA1771@gondor.apana.org.au>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Ron Yorston <rmy@frippery.org>
Cc: contact@emersion.fr, dash@vger.kernel.org

On 28/04/2020 07:17, Herbert Xu wrote:
> ---8<---
> On Fri, Dec 13, 2019 at 02:51:34PM +0000, Simon Ser wrote:
>> Just noticed another dash bug: when setting invalid PS1 values dash
>> enters an infinite loop.
>>
>> For instance, setting PS1='$(' makes dash print many of these:
>>
>>     dash: 1: Syntax error: end of file unexpected (expecting ")")
>>
>> It would be nice to fallback to the default PS1 value on error.
> 
> This patch fixes it by using the literal value of PS1 should an
> error occur during expansion.
> 
> On Wed, Feb 26, 2020 at 09:12:04PM +0000, Ron Yorston wrote:
>>
>> There's another case that should be handled.  PS1='`xxx(`' causes the
>> shell to exit because the old-style backquote leaves an additional file
>> on the stack.
> 
> Ron's change has been folded into this patch.

This still does not restore the state completely. It does not clean up 
any pending heredocs. I see:

   $ PS1='$(<<EOF "'
   src/dash: 1: Syntax error: Unterminated quoted string
   $(<<EOF ":
   >

That is, after entering the ':' command, the shell is still trying to 
read the heredoc from the prompt.

I have not looked in detail to see if anything else is not getting 
cleaned up that should be.

Cheers,
Harald van Dijk
