Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D74582CC
	for <dash@vger.kernel.org>; Wed, 12 Aug 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549246; cv=none; b=TbEp8GhKMeTlBt0EB8/hhOUvxO2OfVItmLBdrKdMVl6LCGcX/LPIwgSgFujBwVmN7xd6+/+Mesbe94mzcQedTHk8yEZhuD3x2ePsuGNhicAWisMVS1YYOFrEu/1YRK3p0wvVjc7C+9vYFDdAU++6EdNWuf8bvCpUPb7Vp64CDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549246; c=relaxed/simple;
	bh=MCk/b6tao6HDyXlvEnYaHInimGLKz6qDd15FMdKYLLE=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References; b=kCdkXaStVedf+U+l1mwB0okgUDL/68Rx0FF7F5erSxpBR6chXpVCwoAGkxrelhTSLHWnnnK0EiFuzWBoW1PG6Y6MKaZHRn/1pGfsj9EbF8GsdKQlddE9TH324MNWgleb7yhiENMua3nrpnP/gNm3qcyLhfVvx/TZpEiv2gf5+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=Zzo+HrTi; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="Zzo+HrTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1786549233; x=1787215899; h=date:author:from:to:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=glBPns0odhBc1+iNNYgCy530GFSeGxCUZmHe5HiTUMk=;
 b=Zzo+HrTi8fPiNLdczjDKX/3evv8OlqCFEZPPHhB4mzvbxCUYcPNN5RTQEcddPWIo3h74Qc7x
  6Uaxx1L/FFZySeU/gAzBTic+OhOgPvef+Nd0/JPuu316axPcrIcFPvSOAVSYmPaF9p6VMYCJ95
  Sqk1/dzCRPArnI9rPZY2udHJDOMnZxGZKY07WQFR67MvuDqAbQVcxU1a23YkNhkJRJr5CwjkN9
  FQCoDqrCMf7qcJ9FYuX3c7AlsSLKMYklhifhax/BbYUYaZsHaZ9/Vc6NyUL7ZFrWukUQHYm7be
  G+vNfRQtikLhOKfwa04r70zhYDCrksaQXG9ilU2TiUE6ZY1w==
Date: Wed, 12 Aug 2026 17:40:33 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org
Subject: Re: 0.5.13.5: unwanted alias expansions
Message-ID: <20260812154033.1lYxKwQU@steffen%sdaoden.eu>
In-Reply-To: <20260810214025.uEv9z5qG@steffen%sdaoden.eu>
References: <20260810214025.uEv9z5qG@steffen%sdaoden.eu>
User-Agent: s-nail v14.10.0-alpha-51-g0f7aa93363
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Steffen Nurpmeso wrote in
 <20260810214025.uEv9z5qG@steffen%sdaoden.eu>:
 ..
 |I have a quite clumsy script environment with ~/.profile, ~/.shrc,
 |~/.bash_logout etc that i try to use for all shells.  Tried at

..and i cannot create a reproducer for the EXIT case as shown in
the last email: i think this really happens only in interactive
shells.
However, here is a very weird thing that shows multiple problems
of i think dash.  You get several different outputs for
  $ dash t.sh; DUDU=: dash t.sh
vs
  $ bash t.sh; DUDU=: bash t.sh

With DUDU=: the read does not "hang", as in the interactive case.
That is all i know.

I say Ciao! already here.

  : ${DUDU:='exit 0'}

  trap : EXIT

  doit() {
    PROCID=$$
    export PROCID
    trap "echo 'Timeout expired'; rm -f \"$TMPDIR\"/.$$.sh; eval $DUDU" QUIT
    /bin/sh -c '/bin/sleep 3 && kill -QUIT $PROCID' </dev/null >/dev/null 2>&1 &
    killer=$!
    read input
    kill -TERM $killer
    echo "input<$input>"
  }

  ___on_exit() {
    echo ex1
    . "$TMPDIR"/.$$.sh
    echo ex2
    doit
    echo ex3
  }
  trap ___on_exit EXIT

  { echo 'trap : EXIT'; echo 'rm -f "$TMPDIR"/.'$$'.sh'; echo 'doit'; } > "$TMPDIR"/.$$.sh
  echo 1
  alias l='echo -1'
  echo 2
  k= l=
  echo 3 && l=-2 || l=-3
  echo 4 && l='-2' || l='-3'
  echo 5
  exit

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
