From: Parke <parke.nexus@gmail.com>
Subject: Re: dash unset idiosyncrasies
Date: Mon, 6 Jul 2015 09:02:57 -0700
Message-ID: <CAPxz1+bDwhGNBzv-b5cD6iML6jTkNbRLjJT-hsVCgk3pOWVsYw@mail.gmail.com>
References: <CAPxz1+Zuye=Oj=tWvto9_ir5XcgazBY=2asesR77qRrFuTbc2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35627 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbGFQDi convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 6 Jul 2015 12:03:38 -0400
Received: by labgy5 with SMTP id gy5so8736311lab.2
        for <dash@vger.kernel.org>; Mon, 06 Jul 2015 09:03:36 -0700 (PDT)
In-Reply-To: <CAPxz1+Zuye=Oj=tWvto9_ir5XcgazBY=2asesR77qRrFuTbc2A@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Sun, Jul 5, 2015 at 7:18 PM, Parke <parke.nexus@gmail.com> wrote:

> Based on my experiments, I would recommend the dash man page be
> changed as follows.  Changes are in capital letters.
>
>      unset [-fv] name ...
>             The specified VARIABLES OR FUNCITONS
>             (BUT NOT BOTH) are
>             unset and unexported.  If -f or -v is speci=E2=80=90
>             fied, the corresponding functionS or variableS
>             ARE unset, respectively.  IF NEITHER OPTION
>             IS GIVEN, ONLY THE NAMED VARIABLES
>             ARE UNSET.

I just realized that, perhaps most importantly, the first line should
be changed to:

unset [ -f | -v ] name ...

Cheers,

Parke
