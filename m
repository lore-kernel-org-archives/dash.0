From: Kevin Korb <kmk@sanitarium.net>
Subject: [bug?] echo -n does not work as described
Date: Wed, 11 Nov 2015 20:56:02 -0500
Message-ID: <5643F1B2.5050207@sanitarium.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from asylum.sanitarium.net ([24.173.162.174]:57622 "HELO
	asylum.sanitarium.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752340AbbKLCCo (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Nov 2015 21:02:44 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am on dash version 0.5.8.2 on Gentoo Linux (USE=libedit -static).

The echo builtin does not work as described.  In the man page:
 echo [-n] args...
   Print the arguments on the standard output, separated by spaces.
   Unless the -n option is present, a newline is output following the
   arguments.

However, in actual usage:
% dash
$ echo testing
testing
$ echo -n testing
- -n testing
$ /bin/echo -n testing
testing$

This is causing me problems when I attempt to switch /bin/sh from bash
to dash.

- -- 
~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,
- -*~
	Kevin Korb			Phone:    (407) 252-6853
	Systems Administrator		Internet:
	FutureQuest, Inc.		Kevin@FutureQuest.net  (work)
	Orlando, Florida		kmk@sanitarium.net (personal)
	Web page:			http://www.sanitarium.net/
	PGP public key available on web site.
~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,
- -*~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlZD8bIACgkQVKC1jlbQAQc0DQCaAt6x4XveLhPjaPiPaSG8ll5a
3ZEAn0J5mkr1wd7Nd2l3Q6xKpB2LZ39+
=lljb
-----END PGP SIGNATURE-----
