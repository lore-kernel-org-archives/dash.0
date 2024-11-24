Received: from antelope.elm.relay.mailchannels.net (antelope.elm.relay.mailchannels.net [23.83.212.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6836C
	for <dash@vger.kernel.org>; Sun, 24 Nov 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462389; cv=pass; b=J9HsidNedHr/DSFpRlJr8QtMAcIx0kUS6BCcBFdlepteV3Jb344mEIWZA250Pd+PAG6wwimx8KJsblzr3JulDdhAPjwZ8FgQGsS2xV+IUDd57K21CgKe8jBbkiI0LbLdV/ZvJOC8UY9NR+mrEBfJ+61Ri6Sw2+YPvbq4vJsWPmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462389; c=relaxed/simple;
	bh=nvk7AB0tXPH6qJKcQITgdWMTSXNM2r8rIVBxgQ70ymU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MBUt1JUrDL56pgYs4voVvsPaW9vS0+gVYwZiLaetUbnSWDIPsl6ZkBJ2tiPR6V5hAI+Yc/09YxCNGtPjqP6PAlWf7Nvw7iToPruoOKGMUTYVP2d8YfD9LWrNPB2RDz0EXFIvIg8OYZuw7oiXjHK9+D2+3spkBYnOwPam/1CsSdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 67BDB2C1E2E;
	Sun, 24 Nov 2024 15:15:18 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-112-192-241.trex-nlb.outbound.svc.cluster.local [100.112.192.241])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 64D232C11D5;
	Sun, 24 Nov 2024 15:15:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732461317; a=rsa-sha256;
	cv=none;
	b=I3Sx4d5JADTDvd3ahDxiiuI7XNfCy7V843Wq+HhMfo1SdTi/PjDK5kIMFOFLsVSUR8x8P3
	bJkIdWGzsH4Q9Pf5JAJoqwP3fZ776kDapIwZ0Z8vDWizD9YVKRVW2k0e6wIBAMDB8s0AU2
	oPUOYIrh58KcSy/ufhkXH9tQUiiccn6DcDofCpB1AkTFeajNozw5mzJzt0DKbGQstUJXmW
	kt6t2wHM8fWb6IXVL07rHPuox2HQV1Ksi0Z/tUgSSxBmihkIGQs4TjuAiIiiAkCsiTmchW
	4OMwcP/MHTXVX5oWmz1pn7kV8QUWE49CP7PqyFD4RVf0c5qXorhWukEgfVSmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732461317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCkygbrIebn9+Fb3YSj54skLZ4F8Iqqy7LVfchTo+Eo=;
	b=PMlespGGYZYX5Np9QtUc3WWYE5cO+bavoxKeUwjcl2oQQB7mX7WHHpMG2DOvIVtu1S7lUO
	+D8fBgLo1JXDG4KDHPgIM2O1eLa3ihZtAkEcUngideE5Fz5utbFXEL7wpjevp9JrW4XHx3
	JV6uTbvZg+CI8PbFLGkElIjwYRQU5ix1uS3UUOwmM5/TA4vgaBw4EiYs5DDFmn8MWRCCof
	50udpe/2469cSYG1aW8CwTbyGd/yp1s8DQDtTq8kdkxMm5zGNq+nAG7bgMZgqa3EmVgIeU
	MUNl2/LX0JtfQ123qYMcUfxv0P13oXeW8qpzuiSrDGVffEVo5+zyRQUKF3aGJg==
ARC-Authentication-Results: i=1;
	rspamd-dcc6979f6-k9lvq;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Skirt-Whimsical: 3f81ebf922045459_1732461318167_2723725631
X-MC-Loop-Signature: 1732461318167:1134513362
X-MC-Ingress-Time: 1732461318167
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.192.241 (trex/7.0.2);
	Sun, 24 Nov 2024 15:15:18 +0000
Received: from p5b3145f9.dip0.t-ipconnect.de ([91.49.69.249]:47448 helo=[127.0.0.1])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tFEKR-00000005laK-1x7H;
	Sun, 24 Nov 2024 15:15:15 +0000
Date: Sun, 24 Nov 2024 16:15:13 +0100
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: set -e not ignored in AND-OR list
In-Reply-To: <Z0MU448KJwA-03C4@gondor.apana.org.au>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au> <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org> <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl> <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org> <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl> <20715fc311f5d3655e2d6d9dc1a911e8cfbccc3f.camel@scientia.org> <be8c2692-ab69-46f2-a487-2f99452a0c2f@gigawatt.nl> <ff11abc014305b31343cc220fa503b927d3e4454.camel@scientia.org> <Z0MU448KJwA-03C4@gondor.apana.org.au>
Message-ID: <D890E0B3-5FF6-4B5F-A0F4-C53D67B61414@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-AuthUser: calestyo@scientia.org

Hey=2E

On November 24, 2024 12:58:27 PM GMT+01:00, Herbert Xu <herbert@gondor=2Ea=
pana=2Eorg=2Eau> wrote:
>It's simple really, POSIX says:
>
>	or any command of an AND-OR list other than the last=2E
>
>The word "command" refers to the commands that make up the AND-OR
>list=2E  Command substitution is not part of that at all=2E

AFAIU, an assignment with a command substitution as well as a lone command=
 substitution, is just a simple command, as follows from 2=2E9=2E1 Simple C=
ommands=2E
Which are then one kind of command, as follows from 2=2E9 Shell Commands=
=2E


That also follows from the grammar:

Command substitutions are quite clearly word expansions and thus words=2E

cmd_name : WORD /* Apply rule 7a */ ;
cmd_word : WORD /* Apply rule 7b */ ;
cmd_prefix : io_redirect | cmd_prefix io_redirect | ASSIGNMENT_WORD | cmd_=
prefix ASSIGNMENT_WORD;
cmd_suffix : io_redirect | cmd_suffix io_redirect | WORD | cmd_suffix WORD=
 ;

Which then form simple commands:

simple_command : cmd_prefix cmd_word cmd_suffix | cmd_prefix cmd_word | cm=
d_prefix | cmd_name cmd_suffix | cmd_name

Which form commands:

command : simple_command | compound_command | compound_command redirect_li=
st | function_definition

Which form:

pipe_sequence : command | pipe_sequence '|' linebreak command

Those then pipelines:

pipeline : pipe_sequence | Bang pipe_sequence

And those in turn, the AND-OR lists:

and_or : pipeline | and_or AND_IF linebreak pipeline | and_or OR_IF linebr=
eak pipeline

If don't see how that could be interpreted as command substitutions not be=
ing part of that=2E


Cheer,=20
Chris=2E 
