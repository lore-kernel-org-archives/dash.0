From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: Re: Bug#501566: dash: details of redirection/duplication in manpage
 are reversed
Date: Wed, 19 Nov 2014 00:46:03 +0100
Message-ID: <20141118234603.GA9586@free.fr>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
 <20141118232718.GA9223@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:1736 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932181AbaKRXsB (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 18 Nov 2014 18:48:01 -0500
Content-Disposition: inline
In-Reply-To: <20141118232718.GA9223@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephen Shirley <diamond@nonado.net>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: 501566@bugs.debian.org, dash@vger.kernel.org, =?utf-8?B?U3TDqXBoYW5l?= CHAZELAS <stephane.chazelas@gmail.com>

Hello Stephen and Herbert,

St=C3=A9phane Chazelas just made a complete proposal:


1) [n1]<&n2    Redirect standard input (or fd n1) from the same
               resource as open on fd n2.

2b) [n1]>&n2   Redirect standard output (or fd n1) to
               the same resource as open on fd n2.


What do you think about?

Regards,

--=20
St=C3=A9phane Aulery
