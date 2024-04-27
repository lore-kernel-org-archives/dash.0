Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050723A6
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714255024; cv=pass; b=jHoI80wW5xtSJaVBUC+OHnhS2eNFY8dJnf9+6PreiqtdMoAR9luwLahHFOVgFRXNdIRK5yaZwDVDbotL8Ws4j5iU83ZQP+S+TD05xyc+IX+jk6fRCa4rL0MzLVEJGopncYmqPDfAdAXgKR98MXAAVMfE1FHHKreLbdMN4SCxGH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714255024; c=relaxed/simple;
	bh=dcWD59cTwfM5IRu0ZdVAcTmyH3MNp+QLPn81b7SrIF0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVuJqMeP5kAcQU0Np97tGXMFGNVQ28NAgiCD+6Sxj0UUlqUM+gtTzXc+XfIZTZbq9TR8rwaVG9Wm6AfDGvNcskBKgLQx5kOHHCjbW5+Z8hh33fMKDiJOFGcgtjNeGfLPh2aITvLcs0JYMiNvznSXGpVNq548oGnk1uxYGph3PYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9770A802524;
	Sat, 27 Apr 2024 21:31:52 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0D1D28025AE;
	Sat, 27 Apr 2024 21:31:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1714253511; a=rsa-sha256;
	cv=none;
	b=V5/MqH6cXyrpcDPDIe4o39ZUoCiVoHtbcoedoqSNuI1ttyXwcrLGMxrA+cyG1txTRB0HD7
	7bBM9bhAus+gnF3HRG2tt/8iNTytqqPqTxjGX33+WJ/d1KYm1a8ZpmlOARRW1o2yo1Oe1c
	ZO6m0T2omUydmzlRX5oTT5awuU/Uf/8AffoHCV0ZYQEE0q39kX/o7k5523jz6iY5uredLB
	2MlZ5Zn5abl+YeC8NQOX6/+r9xBrLDdBygvdgzM4+tWQceTPZZDDHbqN7OCQz0EYXvWR9X
	W/wBTfT+T3Y9M8wuOU2AnDJ04xqoMvugdtsI845AunzxujPOILBgn+Q8bCac+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1714253511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgVzV2nwzRD/GOC3+/Px251PHgvZ+eMai4DQP2mfpIk=;
	b=Lsvrx3QwKQ1Nh7BRxB9zkhyBLWWb/8fz/bD5lQrdSoTnDHPGzNQPDXpc0meZvyAtJIL/h+
	XzX5qKFXStBGf3uOazYvzwihZx5vxE5jeQyNDIH+TvCFpFPEomGzNRKTTZbgqG/GCSsa68
	1uUfrYDPAnKBvtO6mj5A0It3F+t+fVCCOXtFc5CQ++9KISR529C9X/fmO13xMinGD3LE9P
	ydMLaAUUxPhbGV7If16nzso2aejNdUq0Um0106pN24tMQVQ8kw2QfgkcQ4z7z0FDG/SjAD
	KHhMZcNXGTZuiq0r5WDbsUw3MXP+KUii2y2RdY/xEpVoVB1ouFbeyGD2Gj4hWg==
ARC-Authentication-Results: i=1;
	rspamd-5c97bbd7c5-nq7qf;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Versed-Lonely: 3c677c4d2c08ffb5_1714253511703_2162660701
X-MC-Loop-Signature: 1714253511703:3074507184
X-MC-Ingress-Time: 1714253511703
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.222.159 (trex/6.9.2);
	Sat, 27 Apr 2024 21:31:51 +0000
Received: from p54b6d4bd.dip0.t-ipconnect.de ([84.182.212.189]:59256 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <calestyo@scientia.org>)
	id 1s0pe8-009CMl-3A;
	Sat, 27 Apr 2024 21:31:49 +0000
Message-ID: <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
Subject: Re: [PATCH 0/8] Add multi-byte support
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, DASH Mailing List
	 <dash@vger.kernel.org>
Date: Sat, 27 Apr 2024 23:31:43 +0200
In-Reply-To: <cover.1714215826.git.herbert@gondor.apana.org.au>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b2 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.


On Sat, 2024-04-27 at 19:03 +0800, Herbert Xu wrote:
> This patch series adds multi-byte support to dash.=C2=A0 For now only
> fnmatch is supported as the native pmatch function has not been
> modified to support multi-byte characters.

Nothing against the functionality per se, but I think for all scripts
that assumed dash's (and thus on may systems /bin/sh's) current
behaviour of being C locale only even without explicitly setting
LC_ALL=3DC, this may have quite some subtle issues.


AFAIU, in the C locale, all bytes is a character, and thus in
particular pattern matching notation is defined for every defined
outcome of command substitution respectively every content of variables
(that is: in every(!) locale every byte other than NUL).


For example:
************
A while ago I've asked on the Austin Group mailing list for a portable
way to get command substitution without stripping of trailing newlines.

Long story short:
The recommended way was to add a sentinel character '.' at the end of
the output within the command substitution and strip that off later
with parameter expansion.
But despite of the very special properties[0] of '.', it's apparently
still required to set LC_ALL=3DC when stripping the sentinel, because the
pattern matching notation in ${foo%.} is defined only on strings of
characters, not on strings of bytes.

Back then, Harald van Dijk had some ideas how that might be resolved
for good, but IIRC none of the shell implementors seemed to really have
interest.

My goal was to make a portable function like
   command_subst_with_newlines "eval-ed-command-string" "target-variable-na=
me"
which, with the requirement of setting LC_ALL proved more or less
impossible when the function should have no side effects (like keeping
the LC_ALL overridden, over possibly overriding some existing var like
OLD_LC_ALL).


Anyway... I could image, that if dash becomes multi-byte aware, there
might be more or less subtle surprises.


Cheers,
Chris.


[0] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap06.htm=
l
"The encoded values associated with <period>, <slash>, <newline>, and
<carriage-return> shall be invariant across all locales supported by
the implementation."
