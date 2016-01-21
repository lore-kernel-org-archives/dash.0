From: Gioele Barabucci <gioele@svario.it>
Subject: Re: [PATCH] man: Document ulimit -v
Date: Thu, 21 Jan 2016 08:25:59 +0100
Message-ID: <n7q168$u95$1@ger.gmane.org>
References: <87fuxs5dtk.fsf@ritchie.wxcvbn.org>
 <20160121050323.GA4908@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40459 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbcAUH0K (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 21 Jan 2016 02:26:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1aM9d9-0000XF-8Q
	for dash@vger.kernel.org; Thu, 21 Jan 2016 08:26:07 +0100
Received: from natoutside2.wlan.uni-koeln.de ([134.95.7.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 21 Jan 2016 08:26:07 +0100
Received: from gioele by natoutside2.wlan.uni-koeln.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 21 Jan 2016 08:26:07 +0100
In-Reply-To: <20160121050323.GA4908@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On 21/01/2016 06:03, Herbert Xu wrote:
> J=C3=A9r=C3=A9mie Courr=C3=A8ges-Anglas <jca@wxcvbn.org> wrote:
>> Gioele Barabucci <gioele@svario.it> writes:
>>
>>> Document that `ulimit` can set the `RLIMIT_AS` limit (virtual memor=
y) with
>>> the `-v` flag.
>>
>> I don't know much about RLIMIT_AS, but I know that it isn't supporte=
d on
>> all systems where dash runs, eg OpenBSD.  Maybe is it Linux-specific=
?
>>
>> Anyway, it would be better if the manpage said that the -v flag may =
not
>> be implemented on all platforms.
>>
>> The same could be said about ulimit -w. (I did not check the other f=
lags).
>=20
> Rather than doing that we could just pass the manpage through
> cpp or some similar mechanism so that this becomes conditional.

I wonder how much it is worth the effort in this case.

RLIMIT_AS is defined by POSIX [1] since 1997 [2], so one can suppose
that it is available anywhere (indeed the man page of OpenBSD refers to
the missing RLIMIT_AS as a bug). If it is not available, an invocation
of `ulimit -v` will complain about the unknown option. We could just ad=
d
to the description "(not available on systems that lack support for
RLIMIT_AS, e.g. OpenBSD)".

Other cases like `-w` can be ignored: they manipulate non-standard
RLIMIT extensions that are no-ops on Linux since long ago (and I suppos=
e
also in other systems).

Regards,

[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/setrlimit=
=2Ehtml
[2] http://pubs.opengroup.org/onlinepubs/7908799/xsh/sysresource.h.html

--
Gioele Barabucci <gioele@svario.it>

