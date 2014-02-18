From: Alex Waite <alexqw85@gmail.com>
Subject: Re: dash and ANSI escape sequences
Date: Tue, 18 Feb 2014 14:27:55 +0100
Message-ID: <ldvn4d$pi$1@ger.gmane.org>
References: <ldvhl7$ns2$1@ger.gmane.org> <20140218131132.GA30525@hal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42812 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbaBRN2J (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 18 Feb 2014 08:28:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1WFkiV-0004w9-6f
	for dash@vger.kernel.org; Tue, 18 Feb 2014 14:28:07 +0100
Received: from 141.44.98.41 ([141.44.98.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 18 Feb 2014 14:28:07 +0100
Received: from alexqw85 by 141.44.98.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 18 Feb 2014 14:28:07 +0100
In-Reply-To: <20140218131132.GA30525@hal.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On 02/18/2014 02:11 PM, Guido Berhoerster wrote:
>> [snip]
>> Am I somehow missing some hidden functionality in printf, or is
>> there really no POSIX compliant method of printing colors, or is
>> Dash simply incomplete with its POSIX support in this regard?
>
> dash, POSIX, or C89 have nothing to do with colors, it depends on
> your terminal whether it interprets certain escape sequences as
> color attributes.

Ahh. Ok.

> You can print arbitrary bytes in a portable way (i.e. as
> specified by POSIX) by using octal notation, e.g. escape is 033
> in octal:
>
> printf "\033[1;32mpassed\033[0m\n"

Understood; I get how this all fits together now.

Thanks for your example and explanation!

---Alex


