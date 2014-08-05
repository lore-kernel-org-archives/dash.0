From: Chema Gonzalez <chema@google.com>
Subject: Re: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Tue, 5 Aug 2014 10:11:12 -0700
Message-ID: <CA+ZOOTMsWT-WMQJfXH5Df-MKoYM3CqJm+JFgu+U6x1anP0A8yw@mail.gmail.com>
References: <1407256813-30944-1-git-send-email-chema@google.com>
	<87wqamswgh.fsf@ritchie.wxcvbn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59947 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbaHERLM convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 5 Aug 2014 13:11:12 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so1408787ier.27
        for <dash@vger.kernel.org>; Tue, 05 Aug 2014 10:11:12 -0700 (PDT)
In-Reply-To: <87wqamswgh.fsf@ritchie.wxcvbn.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?UTF-8?B?SsOpcsOpbWllIENvdXJyw6hnZXMtQW5nbGFz?= <jca+dash@wxcvbn.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On Tue, Aug 5, 2014 at 10:00 AM, J=C3=A9r=C3=A9mie Courr=C3=A8ges-Angla=
s
<jca+dash@wxcvbn.org> wrote:
> Actually the problem should only occur when you set LC_ALL, which
> overrides LANG and LC_COLLATE.  Even though some may find nice to
My FreeBSD notes (they may be really stale) state LANG overrides
LC_ALL in FreeBSD (4.x). If that's correct, we need to take care of
both.

> protect the unwary, but I'd expect lots of brokenness in this unusual
> build situation, and this not limited to dash.

-Chema


>
> --
> jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 152=
4 E7EE
