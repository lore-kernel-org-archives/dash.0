From: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Subject: Re: heredoc and subshell
Date: Wed, 24 Feb 2016 13:32:23 +0100
Message-ID: <56cda2d7.BQQZnsNWLLDg81ia%Joerg.Schilling@fokus.fraunhofer.de>
References: <56cd8cd1.LdVYbpfe+0tQMm8I%Joerg.Schilling@fokus.fraunhofer.de>
 <153133f6f0b-66ff-2f8@webprd-a36.mail.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mx-relay35-dus.antispameurope.com ([94.100.134.235]:59558 "EHLO
	mx-relay35-dus.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849AbcBXMc3 (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 24 Feb 2016 07:32:29 -0500
In-Reply-To: <153133f6f0b-66ff-2f8@webprd-a36.mail.aol.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: shwaresyst@aol.com, oleg@bulatov.me, eblake@redhat.com, dash@vger.kernel.org, austin-group-l@opengroup.org

Shware Systems <shwaresyst@aol.com> wrote:

> Near as I can tell, from 2.3, io_here has precedence over string conc=
atenation of normal tokenization so the output of bash should be:
> A:echo line 1
> Syntax error: Missing right paren
> Syntax error: Missing closing double quote
>
> as the list production terminates at the first newline, and a new one=
 doesn't start until after the second line with XXX to satisfy the seco=
nd io_here. It can be argued provisions for trying to find the end of a=
n open string should continue after the io_here body, but Item 7 of 2.3=
 has the newline terminating it.

So you are arguing that $(...) and `...` behave different?

The interesting news is that the Schily Bourne Shell and mksh currently=
 behave=20
similar to what you like to see.

J=F6rg

--=20
 EMail:joerg@schily.net                    (home) J=F6rg Schilling D-13=
353 Berlin
       joerg.schilling@fokus.fraunhofer.de (work) Blog: http://schily.b=
logspot.com/
 URL:  http://cdrecord.org/private/ http://sourceforge.net/projects/sch=
ilytools/files/'
