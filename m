From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 07:52:11 -0700
Message-ID: <B333ED2E-7C56-480D-8245-34FB1FA80DCB@aim.com>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20767 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbaA1Owd convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 28 Jan 2014 09:52:33 -0500
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s0SEqVXw004703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 14:52:32 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s0SEqUQF010864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 14:52:31 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s0SEqUhW004149
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 14:52:30 GMT
In-Reply-To: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

On 2014-01-28, at 05:16, =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=
=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:

> $ dpkg -l | fgrep dash
> ii  dash                                   0.5.7-2ubuntu2
>                POSIX-compliant shell
>=20
> $ exec 9<no_such_file && echo TEST
> dash: 1: cannot open no_such_file: No such file
>=20
> $ exec 9<no_such_file || echo TEST
> dash: 2: cannot open no_such_file: No such file
>=20
> So, I cannot test this operation without using $?
>=20
> in BASH this works as expected (even in sh mode)
> =20
o I believe POSIX (which I haven't read recently)
  allows, but does not require, failure of cd or
  redirection to terminate a noninteractive shell.
  (Were you trying your test interactively or in a
  script?)

o In various shells, I have become accustomed to $? being
  set only by wait() after exec() of a command.

I have become accustomed to dealing with this by coding:
    ( some_command <no_such_file ) && echo TEST
    ( some_command <no_such_file ) || echo TEST

I have never tried to deal with the failure of "exec redirection".

-- gil

