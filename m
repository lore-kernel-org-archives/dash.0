From: Kevin Korb <kmk@sanitarium.net>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 12 Nov 2015 11:12:28 -0500
Message-ID: <5644BA6C.4030400@sanitarium.net>
References: <5643F1B2.5050207@sanitarium.net> <56440406.7000201@redhat.com>
 <56440A1E.8070701@sanitarium.net> <56440B7A.4040508@sanitarium.net>
 <20151112083536.GA796@ein.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from asylum.sanitarium.net ([24.173.162.174]:64030 "HELO
	asylum.sanitarium.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751035AbbKLQMa (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Nov 2015 11:12:30 -0500
In-Reply-To: <20151112083536.GA796@ein.free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Seb <sbb@tuxfamily.org>, dash@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is what I get:
% dash -c 'type echo; echo -n foo; echo foo'
echo is a shell builtin
- -n foo
foo


On 11/12/2015 03:35 AM, Seb wrote:
> On Wed, Nov 11, 2015 at 10:46:02PM -0500, Kevin Korb wrote:
> 
>>>> By the way, 'echo -n' is non-portable, and POSIX says you 
>>>> should use 'printf' instead.
>> 
>> If dash refuses to supply a compatible version of echo then dash
>> must not include a builtin version of echo.  If dash didn't have
>> a broken embedded version of echo I wouldn't have a problem.
> 
> dash just claims to be compatible with POSIX, not with *sh. If you
> look for something like this (lighter than bash but with many of
> its features), glance rather at mksh:
> 
> https://www.mirbsd.org/mksh.htm
> 
> Now, I don't understand the present issue, all seems just work as 
> expected here (0.5.8):
> 
> $ dash -c 'type echo; echo -n foo; echo foo' echo is a shell
> builtin foofoo
> 
> ++ Seb.
> 
> -- To unsubscribe from this list: send the line "unsubscribe dash"
> in the body of a message to majordomo@vger.kernel.org More
> majordomo info at  http://vger.kernel.org/majordomo-info.html
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

iEYEARECAAYFAlZEumwACgkQVKC1jlbQAQciqwCeNRjcqFps3ZNtisqM3UI2rlQn
3NMAn2DAvJuycgyFnDTf10jP3y4Gu8x9
=lCLu
-----END PGP SIGNATURE-----
