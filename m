From: Kevin Korb <kmk@sanitarium.net>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 12 Nov 2015 11:11:35 -0500
Message-ID: <5644BA37.2090606@sanitarium.net>
References: <5643F1B2.5050207@sanitarium.net>
 <20151112081006.GV19618@medion.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from asylum.sanitarium.net ([24.173.162.174]:54782 "HELO
	asylum.sanitarium.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751035AbbKLQLh (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Nov 2015 11:11:37 -0500
In-Reply-To: <20151112081006.GV19618@medion.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Bastian Bittorf <bittorf@bluebottle.com>
Cc: dash@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Then why is the -n behaviour documented in the man page?

On 11/12/2015 03:10 AM, Bastian Bittorf wrote:
> * Kevin Korb <kmk@sanitarium.net> [12.11.2015 08:52]:
>> $ echo -n testing - -n testing
> 
> in POSIX the '-n' switch (and -e) is undefined. you can work around
> this via hijacking the call:
> 
> #!/bin/sh echo() { case "$1" in '-n') shift printf '%s' "$@" ;; *) 
> printf '%s\n' "$@" ;; esac }
> 
> echo foo echo -n bar
> 
> if you really want to remove all the bashisms, it can be a lot of
> work. dont blame dash for this, but the script author. also
> consider using shellsheck.net for this with the correct shebang.
> 
> bye, bastian -- To unsubscribe from this list: send the line
> "unsubscribe dash" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 

- -- 
~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,
	Kevin Korb			Phone:    (407) 252-6853
	Systems Administrator		Internet:
	FutureQuest, Inc.		Kevin@FutureQuest.net  (work)
	Orlando, Florida		kmk@sanitarium.net (personal)
	Web page:			http://www.sanitarium.net/
	PGP public key available on web site.
~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlZEujcACgkQVKC1jlbQAQfIuQCeJrtFu94ThY+48k5zphx+s1i/
mJAAn2zHqfppmvh7mCrWuXHJGnkq9XJ6
=pqKh
-----END PGP SIGNATURE-----
