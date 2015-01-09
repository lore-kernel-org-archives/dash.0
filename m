From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: [PATCH] Fix variable assignments in function invocations
Date: Fri, 09 Jan 2015 14:36:06 -0500
Message-ID: <54B02DA6.1010003@case.edu>
References: <54B00D36.7070707@gigawatt.nl> <54B01242.9000907@redhat.com>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv2.tis.cwru.edu ([129.22.105.37]:51383 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbbAITnT (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 9 Jan 2015 14:43:19 -0500
In-Reply-To: <54B01242.9000907@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Eric Blake <eblake@redhat.com>, dash <dash@vger.kernel.org>, chet.ramey@case.edu

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/9/15 12:39 PM, Eric Blake wrote:

> This behavior is tricky.  Here's the latest POSIX wording:
> http://austingroupbugs.net/view.php?id=654#c1559

The currently-published standard (as far as I know, I7 TC1 has not been
published yet) requires the dash behavior.  Bash implements it in
Posix mode.  Both shells will remain conformant when TC1 comes out.

See
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_05

which includes

"When a function is executed, it shall have the syntax-error and variable-
assignment properties described for special built-in utilities in the
enumerated list at the beginning of Special Built-In Utilities."

- -- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, ITS, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)

iEYEARECAAYFAlSwLaYACgkQu1hp8GTqdKsSTgCfaLS1d4s/Mtr56BRVmiO37rDj
MooAnRQZ50E86M/xLRsngYRe33fDCxFa
=jlKx
-----END PGP SIGNATURE-----
