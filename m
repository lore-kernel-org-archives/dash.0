From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 08:32:13 -0700
Message-ID: <0FD21713-3183-4512-9F0D-08CEC9439A5C@aim.com>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com> <20140128131759.GA17217@hal.lan>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17701 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbaA1Pce convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 28 Jan 2014 10:32:34 -0500
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s0SFWXZs003897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 15:32:34 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s0SFWXf9028907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 15:32:33 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s0SFWWjU028899
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 15:32:32 GMT
In-Reply-To: <20140128131759.GA17217@hal.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>


On 2014-01-28, at 06:17, Guido Berhoerster wrote:

> * =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=
=D1=80=D0=B3 <socketpair@gmail.com> [2014-01-28 13:16]:
>> $ dpkg -l | fgrep dash
>> ii  dash                                   0.5.7-2ubuntu2
>>                POSIX-compliant shell
>>=20
>> $ exec 9<no_such_file && echo TEST
>> dash: 1: cannot open no_such_file: No such file
>>=20
>> $ exec 9<no_such_file || echo TEST
>> dash: 2: cannot open no_such_file: No such file
>>=20
>> So, I cannot test this operation without using $?
>=20
> No, exec is a special built in and POSIX specifies that
> ...if a redirection error occurs (see Consequences of Shell
> Errors), the shell shall exit with a value in the range 1-125
>=20
> dash correctly exits with exit status of 2 as it should. ksh93,
> mksh, and pdksh do the same.
> =20
My approach, which is often suitable, is such as:

    (   exec 9<some_file || exit $?
            ...
        commands using descriptor 9
            ...
    )

In almost all noninteractive shells I've tried, this
exits with error status either either directly on
failure of the redirection or because of the exit
command.  It's hard, then, to report the error
properly.  Some particularly perverse shells skip the
remainder of the command line upon failure of a prior
command.

-- gil

