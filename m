Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A1142910
	for <dash@vger.kernel.org>; Tue, 21 May 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302688; cv=none; b=N2CUQgXkYQmQUZwL1VHBfUMXq2Dp8/TvslHr7C+TL5M7N5pkgxOvW0IEncbBw8khBBj88NZZs197xStxjMPXJDm2krjxT7WP6jWS4IXhl2rD7r7lP9WPwrptL0HQfG6Dy6MWkZFkpKn3ycknPLfojSbjvMekpsX4JokOWpxhdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302688; c=relaxed/simple;
	bh=Uh+5W7APRFcMI77fN4AQkRYtzR3cbLhrcSnqEM1IZuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riFPVAKuzCs2dOqufOTF6D/59Xw/1JDbxPcpxCHiHu+640Ymc+k3HSGYG03cQaUHLwXuThBVfXUc1/eEtCMMWqZI4l5azpb1eqY19pnfKJ6ILeTYYx40xEVq6qEkZnVaNYyGS4dXDwifEvDTAbabxYIN4oQw5xMuf0ciUaXqbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=WLZTpNTi; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="WLZTpNTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1716302325;
	bh=Uh+5W7APRFcMI77fN4AQkRYtzR3cbLhrcSnqEM1IZuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WLZTpNTiQQpDzEK0E4o8Wm921SQAvuwfiWFB5tY5byXiaPETernU1UR2ljNjxDgiu
	 iAxvvD2yBfdUhgzn0wSIPhoq2dEmS8TJjKsyqOR5m/tYAlWY6gvEM43EBht7iUB1gi
	 H4/sA1NJi7i5/gnb6YarAsiIXG5mkLVEPlF3c8QZLXtk7ZdPt54XRJP0ERcj+LE2BV
	 n5jslcckdL7xG4doaDLADa+8Ns7AcIxi3FlYdOO4oojHRsgD9zpvt6KnTbH+jsvpzy
	 eOXd4/V2bLdJ3r/8/wzCD0VltodzJTcVqHbeMqS5/eNdgRgYO/57U6jVUpccy5W2TE
	 kODb0pCoL8W9A==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 840215616;
	Tue, 21 May 2024 16:38:45 +0200 (CEST)
Date: Tue, 21 May 2024 16:38:45 +0200
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, 
	985478@bugs.debian.org
Subject: Re: [v2 PATCH] options: Always reset OPTIND in getoptsreset
Message-ID: <5nqzxkytkaqertmezltnvwzkg275ofugyez4hzwgodcixig2iu@tarta.nabijaczleweli.xyz>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>, 
	Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, 985478@bugs.debian.org
References: <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
 <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
 <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
 <20230104160526.7vuq3s2ivqaaot4l@tarta.nabijaczleweli.xyz>
 <b00cdaa5-0072-392c-3cf7-184aa8e45ae3@gigawatt.nl>
 <ZkngRVxkiUil_9aG@gondor.apana.org.au>
 <64b35f8d-32bc-4331-9e67-fc06305a2e34@gigawatt.nl>
 <ZkoK9vQYFz4vZ4wr@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zektgq2kaywqkmgx"
Content-Disposition: inline
In-Reply-To: <ZkoK9vQYFz4vZ4wr@gondor.apana.org.au>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--zektgq2kaywqkmgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 19, 2024 at 10:21:42PM +0800, Herbert Xu wrote:
> Always reset OPTIND if it is modified by the user, regardless of
> its value.
I disagree in principle, but I think this is basically fine actually;
strictly, we are allowed to do this
  98842  If the application sets OPTIND to the value 1, a new set of parameters can be used: either the
  98843  current positional parameters or new arg values. Any other attempt to invoke getopts multiple
  98844  times in a single shell execution environment with parameters (positional parameters or arg
  98845  operands) that are not the same in all invocations, or with an OPTIND value modified to be a
  98846  value other than 1, produces unspecified results.
but I cannot prove this breaks existing code in the wild.

I mean such code most likely definitely exists,
but I cannot prove this; but even if it does,
it relies on "unspecified" behaviour, which means it
"cannot be assured to be portable across conforming implementations"
such as dash 1 and dash 2.
I still think it should keep working, since it had worked.

While I found at least one changelog entry in DCS saying
"remove unset OPTIND to work around broken dash shell"
by searching for "unset.*OPTIND\b",
searching "OPTIND=[^01]" gives me heaps of OPTIND=digit
and OPTIND=expression users, but most of them are explicit bash users;
the first one with /bin/sh is
	https://sources.debian.org/src/sptk/3.9-3/debian/scripts/raw2wav/?hl=74#L74
reading
	OPTIND=0
	OPT=""
	for i in "$@"
	do
	    OPTIND=`expr $OPTIND + 1`
	    if [ "$OPT" = "" ]
	    then
		OPTARG=""
but this program doesn't use getopts.

This turns "unset OPTIND must work but doesn't"
         + "OPTIND=asd is invalid but probably shouldn't be"
         + "OPTIND=3 makes getopts parse the third argument (as a happy accident)"
into "unset OPTIND works"
   + "OPTIND=asd works (and restarts getopts as a happy accident)"
   + "OPTIND=3 restarts getopts (as a happy accident)".

So, overall, reasonable, if a tad solomonic.

--zektgq2kaywqkmgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmZMsfEACgkQvP0LAY0m
WPHAwQ/9FRDoVLWwca8+18CAJcLduZzwsGVdDjke/mrW9Ey6cGN6u2+gBwvbhSs2
UHDXdd1Xu08AU4jro2orNOm555LKC/xdqJeqOZv0f23xvFHUwl//83DVbnrpm+74
dx1807PF5X/I36mfkrH5bIeXhv8CyBsTuA0dM1AMEXQZpHife5uF1giAcj/k41/8
M+3MgoxC/zVIXpZunL1VtWSLpEhix4i9m8ESqey4uixtMDQNkQzBDwsiQp6jQuzk
f21E0gbSZy3J7zJ2SdMebPpduJ6NWsZ8/rvB1U2elrm8sZL6IEbV8OMSzMubgMPb
Y1vCVJV8tkpNRI/weZY0AxLwR+R+Ef9O9Rdu2bQVlS7ABbauuVlzKvX/oPseiBeH
adMj2/anT6CQoOVZx1w/vvfUpeICTbV6FLrGyk7fzK0u3wVJnC3N6EoC2rDGzbnu
WffNy1cEwxhJpEkQapW/1nFtcvsbrY/eLm6e6yN5P8I77jE+SmFG5s5vqZLLsyCm
t3TDkvmW4j53UW4iGRJOnVjm2XRPAjVlxnKbR2WnNRUPjSQM0UtgAlOdRpm2subM
KpwiQ8+vM6u3o6rLqszrvSOsWVQcuege348MaoK3mCM/m8wcUDufkjO4bYURQqjI
7QPUxFX9lsTpS86A5/+Mn/UDgptcNmwknidzjQLeyNDphmXggyw=
=V1dg
-----END PGP SIGNATURE-----

--zektgq2kaywqkmgx--
