From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: Re: --with-libedit as default
Date: Sun, 4 Aug 2013 18:16:06 -0600
Message-ID: <8EED643C-0420-4F70-AD19-3816EF9FD05E@aim.com>
References: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com> <20130804010244.GL2893@elie.Belkin> <CAA4sSt=7K=GXZFnQ741ZBfcUtj3xZ45ir0TCfg9dtekga-DahQ@mail.gmail.com> <20130804114350.fc97c50b21f4a63ad5f089d3@tuxfamily.org> <CAA4sStnUN0gQD0anxuTyqGrpa3nUAY2zndJBkVUkqa4=x8N=qA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from omr-m10.mx.aol.com ([64.12.143.86]:38079 "EHLO
	omr-m10.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab3HEAYI convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 4 Aug 2013 20:24:08 -0400
Received: from mtaout-db03.r1000.mx.aol.com (mtaout-db03.r1000.mx.aol.com [172.29.51.195])
	by omr-m10.mx.aol.com (Outbound Mail Relay) with ESMTP id E3695700F4D12
	for <dash@vger.kernel.org>; Sun,  4 Aug 2013 20:16:08 -0400 (EDT)
Received: from [192.168.0.3] (75-166-242-188.hlrn.qwest.net [75.166.242.188])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-db03.r1000.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id 61037E0000B2
	for <dash@vger.kernel.org>; Sun,  4 Aug 2013 20:16:08 -0400 (EDT)
In-Reply-To: <CAA4sStnUN0gQD0anxuTyqGrpa3nUAY2zndJBkVUkqa4=x8N=qA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

On 2013-08-04, at 10:21, Maur=EDcio Antunes wrote:

>>> I would like to use dash as an interactive shell.
>=20
>> The problem is that enabling the libedit support does not provide yo=
u
>> with auto-completion, AFAIK.
>=20
> You're right, just tested it.
>=20
> What would it take to have auto-completion in dash
> (even if disabled by default)?
> =20
Here, I'll be a POSIX fanatic.  I believe POSIX requires
command line editing; not auto-completion.  POSIX provides
a usually clear although not satisfactory to all line of
demarcation between standard function and bloat.

    http://aleksan.wordpress.com/2008/01/07/the-camels-nose-fable-a-fav=
ourite-for-teaching-about-setting-limits/

-- gil

