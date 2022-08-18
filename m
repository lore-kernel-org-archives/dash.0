Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C449DC00140
	for <linux-dash@archiver.kernel.org>; Thu, 18 Aug 2022 11:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiHRLoT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 18 Aug 2022 07:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244200AbiHRLoS (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 18 Aug 2022 07:44:18 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B73137D1C6
        for <dash@vger.kernel.org>; Thu, 18 Aug 2022 04:44:16 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F40CF14D6
        for <dash@vger.kernel.org>; Thu, 18 Aug 2022 13:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1660823054;
        bh=gs5Frsm+rn7XPkzX1JrjaIGIUa+viodTqKb9c5LKrZc=;
        h=Date:From:To:Subject:From;
        b=aedEnHb0K0H9+NzuzsEp5fDy60X8xPcS2O9Pn20LY3US/rtSMzy3pA70WRmbilHyq
         G2vkMVVHh678qR3otyKiM+R+F7TlZe8JBoPQM4Zt45qOC+RxnQ+v3QTT+esXCKcwdC
         CPFGPO7NpIVJ9412FwWuoSVjSASPbXw7xToLjWJOUprHF6cmfVLH2ppFeIYPvc7d/n
         0g/vDBw5Egc0k/2KkjRmVruC/18gDoANvK+hvSLuT+afz6AQJgbFoSnKLe4Zx0ovCK
         Pk7PaPlOavCedG2tbv6EpRZbHHOxHhaWXSkb9EgEs66BzrGmsajwZFBGOWRHAMXzzV
         OJAjXWzxtVPqtoNE5BTnnmnNIn659jE8gNGY1W/WsCSXnm7+4yJAQMcCJewt9DzmyA
         vkiT4j8j55KZSJfG2Iaf7MtPuAo4LC6/6DfUVyGc98Fhz6sjIk3wkefsidi7JtdVdD
         mPPKUTylz6hxQk5SDeRQEn7JF9nskngnC2ttkdxx7wgov4TNnRGUdmcLylONQ/OgJP
         FywefieQeOU7DXgWvMqVk3D2dQM/2YF5rDZWySdoGj10l6q3o2jtoaLKyObg2uAnEh
         gHnjOdSTFgtDlh0KphAVmQLU5s9NaBcYraWnIrN+tJLEi8bAQp4ymDcEP5eT1WWb9j
         S2a+W1aT/s2cuPnHUbfx17us=
Date:   Thu, 18 Aug 2022 13:44:12 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: Fwd: Bug#1017531: dash: for/while/if suppress errors from
 redirections with -e
Message-ID: <20220818114412.zeqv5auujpuvfskk@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qs5wwzwhit7jvto5"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--qs5wwzwhit7jvto5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thought I'd forward this upstream, considering I already tested on
current git, and it's pretty grave.

https://bugs.debian.org/1017531, trimmed down a bit, follows:

----- Forwarded message from =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczlew=
eli.xyz> -----

Subject: Bug#1017531: dash: for/while/if suppress errors from redirections
 with -e, POSIX violation

Dear Maintainer,

On current git (057cd650a4edd5856213d431a974ff35c6594489) and 0.5.11.5
the following holds:
-- >8 --
$ ./src/dash -ec 'while :; do :; done < /ENOENT; echo uhoh'
=2E/src/dash: 1: cannot open /ENOENT: No such file
uhoh
$ ./src/dash -ec 'for _ in :; do :; done < /ENOENT; echo uhoh'
=2E/src/dash: 1: cannot open /ENOENT: No such file
uhoh
$ ./src/dash -ec 'if :; then :; fi < /ENOENT; echo uhoh'
=2E/src/dash: 1: cannot open /ENOENT: No such file
uhoh
-- >8 --

The correct output, as demonstrated by bash, is:
-- >8 --
$ bash -ec 'while :; do :; done < /ENOENT; echo uhoh'
bash: line 1: /ENOENT: No such file or directory
$ bash -ec 'for _ in :; do :; done < /ENOENT; echo uhoh'
bash: line 1: /ENOENT: No such file or directory
$ bash -ec 'if :; then :; fi < /ENOENT; echo uhoh'
bash: line 1: /ENOENT: No such file or directory
-- >8 --

This is a POSIX violation, and quite a grave one at that:
set -e is oft[1] used to guard against precisely this type of error!

The same happens if set -e is executed.

All quotes POSIX.1, Issue 7, TC2:
sh, OPTIONS:
  > The -a, -b, -C, -e, -f, -m, -n, -o option, -u, -v, and -x options
  > are described as part of the set utility in Special Built-In
  > Utilities.=20

set, DESCRIPTION, -e:
  > When this option is on, when any command fails (for any of the
  > reasons listed in Consequences of Shell Errors or by returning an
  > exit status greater than zero), the shell immediately shall exit, as
  > if by executing the exit special built-in utility with no arguments,
  > with the following exceptions:
  >
  > 1. The failure of any individual command in a multi-command pipeline
  >    shall not cause the shell to exit. Only the failure of the
  >    pipeline itself shall be considered.
  > 2. The -e setting shall be ignored when executing the compound list
  >    following the while, until, if, or elif reserved word, a pipeline
  >    beginning with the ! reserved word, or any command of an AND-OR
  >    list other than the last.
  > 3. If the exit status of a compound command other than a subshell
  >    command was the result of a failure while -e was being ignored,
  >    then -e shall not apply to this command.

XCU, 2.9.4: Shell Command Language, Shell Commands, Compound Commands:
The while Loop:
  > The format of the while loop is as follows:
  >=20
  > while compound-list-1
  > do
  >   compound-list-2
  > done
(until is equivalent).
The if Conditional Construct:=20
  > The format for the if construct is as follows:
  >
  > if compound-list
  > then
  >   compound-list
  > [elif compound-list
  > then
  >   compound-list] ...
  > [else
  >   compound-list]
  > fi

It follows, therefore, that
  * Exception 1. does not apply as there is no pipeline
  * Exception 2. does not apply, as the redirection does /not/ follow
    "while" or "if" directly and is /not/ part of the conditional
	compound-list
  * in the "for" case, there is no such provision, so this is likely not
    a confusion w.r.t. the conditional compound-lists
  * Exception 3. does not apply as -e was not being ignored while the
    compound commands were being executed (indeed, the compound commands
    do not run at all, as evidenced by the program terminating)

[1]: https://salsa.debian.org/glibc-team/glibc/-/merge_requests/6#note_3298=
99
----- End forwarded message -----

Best,
=D0=BD=D0=B0=D0=B1

--qs5wwzwhit7jvto5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmL+JgkACgkQvP0LAY0m
WPGCnw/+Iu+5wkZDG9EHalMZea8U3vlYE7kuiM0RiXLcY+B/Bm5Z7Nik3e8n4EeK
/wdoZ8IkR2Su8FjrC90lnEubsCKQo/MG03oSt+fYkgc99xE4gXGWbnBYBbY+dRff
lolOFEb6Ae6j5YHgt9/j9hlrLKivX6Sg+USyt5by01Fc2bsF9f6iEfYjwqJGQdzs
GV7Ww/cuhAMgaUC1QwLpqSOuRDg0c/E/5KNdjgtXT0DLRf2lqh1WY3Nxxq7QBP4S
9HNFKwF/kaLHCZntz6+d7fc1DSuT42XFeQxD7DXnF4f2aQc5ri6ZSgueAagqEXl1
+MeoRV+xfMoEAnzgU3p3OpNSCT7AvX/H7E8xfBxeFXliQtWNdsKNjf5kD9bIyOtz
Z3t//AA/lYEC4vbkKXIKYNhmTvsMjdylvjnadUegkzFpKIFrtqC6mwHJBbgJQ3zh
X1L35dGnRGyBKzxyFihv0BJe7bMNrVna0y+b27VdGXLy8AQ+la+xsd49DF8Jj6r+
SjRmwuiTd4DAWfwbZL1AEONWaaWxlwXFL+0/jn8Ns2MYgESVvoZ8ZRxPXIJs7Dvi
IBifN49gPOE+k/7OcCjcIU6MFa3rh1Sv0KMZWuhCZUQSSewUl04EU2nyzEgEvIqB
e/0tjfu0Xb8RaTU5e8h5vUbLmWm4ncC3ZVrVRCH7DCxPn4T5VoA=
=XGtc
-----END PGP SIGNATURE-----

--qs5wwzwhit7jvto5--
