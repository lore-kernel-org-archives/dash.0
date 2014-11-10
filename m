From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash.1 - Confusion between two pages c[h]sh
Date: Mon, 10 Nov 2014 16:02:41 +0100
Message-ID: <5460D391.2090603@gigawatt.nl>
References: <20141110132742.GA8481@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:36002 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752723AbaKJPC6 (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 10 Nov 2014 10:02:58 -0500
In-Reply-To: <20141110132742.GA8481@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: =?windows-1252?Q?St=E9phane_Aulery?= <saulery@free.fr>, dash@vger.kernel.org, 646847@bugs.debian.org, 646847-submitter@bugs.debian.org

On 11/10/2014 2:27 PM, Herbert Xu wrote:
> St=E9phane Aulery <saulery@free.fr> wrote:
>> [-- text/plain, encoding 8bit, charset: utf-8, 12 lines --]
>>
>> Hello,
>>
>> Here is a small patch reported by a user of Debian [1]. Could you pl=
ease
>> integrate? Thank you for your help.
>>
>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D646847
>
> This patch also appears bogus as csh is an alternative to dash.

Even if csh is intentionally in the "See also" section despite not bein=
g=20
referenced anywhere else, is it also intentional that chsh is not in=20
that section despite the earlier reference? Would a patch that leaves=20
csh but also adds chsh be more appropriate, or do you prefer to leave i=
t=20
as it is now?

Cheers,
Harald van Dijk

> Cheers,

