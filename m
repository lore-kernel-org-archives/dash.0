From: Gioele Barabucci <gioele@svario.it>
Subject: Re: [BUG] dash uses $* instead of $@ in variable assignments
Date: Wed, 2 Dec 2015 23:10:05 +0100
Message-ID: <n3nq7u$t46$1@ger.gmane.org>
References: <n37neq$eem$1@ger.gmane.org>
 <20151126213753.GA8662@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47097 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336AbbLBWKO (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 2 Dec 2015 17:10:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1a4FbI-0007Kk-Cd
	for dash@vger.kernel.org; Wed, 02 Dec 2015 23:10:12 +0100
Received: from f048206007.adsl.alicedsl.de ([78.48.206.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 02 Dec 2015 23:10:12 +0100
Received: from gioele by f048206007.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 02 Dec 2015 23:10:12 +0100
In-Reply-To: <20151126213753.GA8662@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On 26/11/2015 22:37, Stephane Chazelas wrote:
> 2015-11-26 20:44:26 +0100, Gioele Barabucci:
>> Hello,
>>
>> I am forwarding a bug [1] reported by a Debian user: dash incorrectly
>> uses `$*` instead of the requested `$@` inside variable assignments.
>> The current version of dash is affected by this bug.
>>
>> A simple test from the original reporter:
>>
>>     $ dash -c 'IFS=:$IFS ; set -- a b c ; echo "$@" ; x="$@" ; echo "$x"'
>>     a b c
>>     a:b:c
> [...]
> 
> This behaviour is what I expect and is common to other shells as
> well.

Hi,

so from the answers I got this looks like an intended behaviour. Fair
enough. :) For the sake of triage I will then mark the Debian bug as
wontfix.

Regards,

--
Gioele Barabucci <gioele@svario.it>

