From: Stephen Shirley <diamond@nonado.net>
Subject: Re: Bug#501566: dash: details of redirection/duplication in manpage
 are reversed
Date: Tue, 11 Nov 2014 14:23:21 +0100
Message-ID: <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
References: <20141110111951.GA4185@free.fr> <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36226 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaKKNXm convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 11 Nov 2014 08:23:42 -0500
Received: by mail-ig0-f172.google.com with SMTP id a13so929373igq.17
        for <dash@vger.kernel.org>; Tue, 11 Nov 2014 05:23:41 -0800 (PST)
In-Reply-To: <20141110134957.GA5664@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?UTF-8?Q?St=C3=A9phane_Aulery?= <saulery@free.fr>, 501566-quiet@bugs.debian.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org, 501566@bugs.debian.org, 501566-submitter@bugs.debian.org

Hi,

On 10 November 2014 14:49, St=C3=A9phane Aulery <saulery@free.fr> wrote=
:
> Le lundi 10 novembre 2014 =C3=A0 09:24:09, Herbert Xu a =C3=A9crit :
>> St=C3=A9phane Aulery <saulery@free.fr> wrote:
>> >
>> > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D501566
>> >
>>
>> I'm sorry but this patch looks wrong and the text looks correct
>> to me as is.
>
> Ok. I passed the information but I'm not really able to judge its
> pertinence. In this case I close this bug.

So, i finally managed to figure out what the problem is. The wording
is ambiguous (or maybe just insufficiently clear).

"[n1]>&n2    Duplicate standard output (or n1) to n2."

How i read it (6 years ago :P) was that meant dup2(n1, n2), because
the only actual /duplication/ is of file descriptors. I've just
realised that the intended meaning is "redirect n1 to where n2 is
currently", i.e. dup2(n2, n1), as expected. Can i suggest a simple
fix:

"[n1]>&n2    Redirect standard output (or n1) to n2."

It doesn't cover the case where n2 is later changed, and how n1 does
not follow this, but it's the simplest fix i see.

Steve
--=20
"You are technically correct, the best kind of correct."
- Bureaucrat 1.0, Futurama
