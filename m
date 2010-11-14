From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: static vs. dynamic scoping
Date: Sun, 14 Nov 2010 01:09:55 +0059
Message-ID: <4CDF28EB.3080709@gigawatt.nl>
References: <4CD9C50D.5010305@redhat.com>	<4CDF1DA7.9000109@gigawatt.nl> <AANLkTimm=WL8xw7UxyaBVVzFUKxboCndc-Kv64OaZeQX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:32960 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754395Ab0KNAIw (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 19:08:52 -0500
In-Reply-To: <AANLkTimm=WL8xw7UxyaBVVzFUKxboCndc-Kv64OaZeQX@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: =?UTF-8?B?0L7Qu9GM0LPQsCDQutGA0YvQttCw0L3QvtCy0YHQutCw0Y8=?= <olga.kryzhanovska@gmail.com>, Eric Blake <eblake@redhat.com>

On 14/11/10 00:54, =D0=BE=D0=BB=D1=8C=D0=B3=D0=B0 =D0=BA=D1=80=D1=8B=D0=
=B6=D0=B0=D0=BD=D0=BE=D0=B2=D1=81=D0=BA=D0=B0=D1=8F wrote:
> Now function a uses typeset IFS=3D"X" to set the field separator to "=
X"
> via a local variable IFS. If function b now uses "read foo1 foo2 foo3=
"
> to read a line of a database the concept of dynamic scoping *BITES*.

The way I had seen "local IFS" used is to sanitise IFS -- to reset IFS=20
to the default value, when IFS was set to, for example, : before the=20
function was called, and the function wants to split on whitespace. In=20
that case, you don't want b to get IFS=3D:. Both forms are used, and in=
=20
your form, I agree, static scoping is more useful.
