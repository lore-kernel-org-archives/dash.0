From: Martijn Dekker <martijn@inlv.org>
Subject: Re: dash unset idiosyncrasies
Date: Mon, 06 Jul 2015 05:23:16 +0200
Message-ID: <5599F4A4.2040403@inlv.org>
References: <CAPxz1+Zuye=Oj=tWvto9_ir5XcgazBY=2asesR77qRrFuTbc2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:40983 "EHLO
	lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753149AbbGFDXT (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 5 Jul 2015 23:23:19 -0400
In-Reply-To: <CAPxz1+Zuye=Oj=tWvto9_ir5XcgazBY=2asesR77qRrFuTbc2A@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Parke schreef op 06-07-15 om 04:18:
> The man page does not say what happens if the given name corresponds
> only to a function.

Neither does POSIX, as you've found out: "[...] if a variable by that
name does not exist, it is unspecified whether a function by that name,
if any, shall be unset." I agree the dash man page could do with
clarifying this.

I've found it best, to avoid bugs and confusion, to always use 'unset'
with either the -v or the -f option (but not both). This should work
consistently on all POSIXly shells.

FYI, other shells produce similar output for your test script (except
AT&T ksh halts execution on 'unset' without parameters.) There seem to
be no shells that support unsetting both variables and functions with a
single 'unset' command.

- Martijn

