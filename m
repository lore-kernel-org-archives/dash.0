Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB21CD0C
	for <dash@vger.kernel.org>; Tue,  5 Nov 2024 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773519; cv=pass; b=n1qJaJLg4JPw9axqhVwVkfAyXscTWzuXmkUUTcv5+ZY8nHSAQbh8Se6PXdp/UK3e664PCUuA2SSyOetAwN5PFbg9ZQXbdGBqwRJQofaISAU3WWn9O0sj3Guj3yZwnbxQ/8BUvg/wQkKksAH8LjphXFFtarHfNHhoOYjl4fDQUbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773519; c=relaxed/simple;
	bh=KrB3J78Uws1vhGMO7I1g06MHupb3Odx/rtUlvljljzw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGnEaqtUrCd1AfUjbtOxBOX/usG89ZkQFzCI7FDEqasoD1XJ4syT/rzaQucJRVYjS9sOedKuqhgUaDHbmaBKx+M/zPxJyjMseMceEDRCUOlc6haL2f8lZhEpOjh8LTjgJAAI4LG6J4v5ucZA5d+QVBjhk9rfDGThva+L4ymaqtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D5088182F74
	for <dash@vger.kernel.org>; Tue,  5 Nov 2024 02:25:11 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-102-251-19.trex-nlb.outbound.svc.cluster.local [100.102.251.19])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3F126183224
	for <dash@vger.kernel.org>; Tue,  5 Nov 2024 02:25:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730773511; a=rsa-sha256;
	cv=none;
	b=gP9J23zigWUULVfC/dsgrlSI9w9t1Jwq5IQi5k+FzpqhQRu0qadwyYZ0K+UrLrpI1hGPp3
	6Oh/tiYsixbwpLQY44LW7NhyHP/EimA52W+LmooLTYDgWikjZD6gEINVWPOAJidVndel4L
	NcjpfgqiC2aBVSiI2kNzizZDUE6abPl7nuYmsQ1MFzsbn0QlAf6Q0GhXbqNZixeiJtG29j
	C99hNlyPqlVDEwxC50/oMRHUvv39x8RcnozDxrxe2IhpknMkyTpU648si3AfDCeSiDYOBp
	mrjsL3LxuSC7EuchI016SAJilCVRhAiBC/mVQQ/hLQftLytlrPMX+GYS8eB9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730773511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+QMJ8ABc74di95+311ALWUc6mPnOgdFo4agmpdu/RA=;
	b=2SVimpOWG8v4H4ljhsD+6tESAXcDw9GuHzKGcflp1s0I/TPmj5k/PrUVnjSxkDs17XoT+2
	J1FjSuXnkEpQFAPNh6NydnnTRESDtZWv+zq3iUsQwD7bv9e+cucWSKH+XPk2vX2Z0uYftw
	tsCUYJLty4VQ8l7xlIE8slR4JXeKM53WsHzZnqsCb6MamUJcPCImu4vr7FM4E9JaYtzRv/
	7s2fV1w0gtUOV+Gp1G3aeNh2wpORTQUfb8dNIck5rsuDs77gs1k8zAz8DkkOiNEg1PyC2q
	Ivtx3dxRjtrcnPdthYZIJCfmJvCIwTP1MPpoNBU02o3Cc0CTi9B15DquOCQdmQ==
ARC-Authentication-Results: i=1;
	rspamd-696f47875-497cf;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Spot-Oafish: 3ba5db1937577748_1730773511749_1427029070
X-MC-Loop-Signature: 1730773511749:777701282
X-MC-Ingress-Time: 1730773511749
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.251.19 (trex/7.0.2);
	Tue, 05 Nov 2024 02:25:11 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:62107 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t89Fl-00000006L3J-1aOm
	for dash@vger.kernel.org;
	Tue, 05 Nov 2024 02:25:09 +0000
Message-ID: <103722908855e6b7d178338b76cfc374948f8a72.camel@scientia.org>
Subject: Re: set -e not ignored in AND-OR list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Date: Tue, 05 Nov 2024 03:25:08 +0100
In-Reply-To: <9c85323dbcf182c50cad4063742f4245d94daca8.camel@scientia.org>
References: <9c85323dbcf182c50cad4063742f4245d94daca8.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Think I found another case:


$ dash; echo shell left
$ set -e; foo() { echo a >&2; false; echo b >&2; }
$ echo "$(foo)"   =20
a

=3D> expected, no reason to ignore -e, no exit either, as part of word
   expansion (POSIX=E2=80=99 point (1))


$ echo "$(foo)" | true
a
=3D> expected, no reason to ignore -e, no exit either, as pipefail not in
   effect

$ echo "$(foo)" || true
a

$ echo "$(foo)" && true
a

=3D> the above two are probably the same bug from before, I just mention
   them again, as it does happen in a word expansion, so a future check
   for this might want t test both cases
   (bash in both prints a and b)


Here's the new one:

$ ! echo "$(foo)" | true
a
$=20
=3D> before,
     $ ! foo | true
   worked properly in dash, i.e. the -e WAS ignored
   but here it is NOT ignored, which I think it should be

And in fact, bash for the same gives:
$ bash; echo shell left
$ shopt -s inherit_errexit
$ set -e; foo() { echo a >&2; false; echo b >&2; }
$ ! echo "$(foo)" | true
a
b
$


Cheers,
Chris.
