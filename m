Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4B17A5BC
	for <dash@vger.kernel.org>; Wed, 18 Sep 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726695487; cv=none; b=gNF+al3ehsYG2/1BDxVdNZmFV697sVtUdiwREqy+ho4gPULQQ++GFLh73iKuxHNBucC+YXBRMoFSn0gxtKxc6H/vxwm+uz6iviqX7R63XCkkgrZCZ4yHOzyPtfQknctSQ8tx79UvO+TW/mMvkyaTCIG7xeYHtAIMbDwmJiA8eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726695487; c=relaxed/simple;
	bh=VGAWA0tPMKEG1V1ePwdwNJ+igqd7VRQ4lwi0+9kO0BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Poo/9OpJ6Wf/mHn4UdXICqQQjL9VVFyiVgISNH267d64tIl7rbpOGC46GpvrxQ89GlKy5vQg02Olh//s+ieOcgnckH/zMeYd8gTKHsrQsd/NImxH4z84wHik7nEckmw0c4b1YKCwWXs4ngHjkV3/jvbvE2JFKQZiKBNyLnrMCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=EzkLo/69; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=FK+4RuJ0; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="EzkLo/69";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="FK+4RuJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1726695480; x=1727362146; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  mime-version:content-type:content-transfer-encoding:author:from:subject:
  date:to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=RbWYEH7g7L0dJxdlFUHEMhwgScoQet+2RYP/FTkv+xY=;
 b=EzkLo/69h+c369O5WC/n0NOteZZSi6d1J6ugjThK2LpVrlAJxwmJbQM/OBc/fQzRuyP/Zicf
  nkOnwoAmrzxh7rw9BypsP3SBAkGRw1XsMfoTg5hB9JKmcCl0gOLrEeRiAeII8YJTwuIqglLx1L
  gDN+3eMR6uCx4xX1pf1fyyNe5+ViWJpQfdFtQOjT86Tp3mdeHVqVn7w5XFSof1HrrOxBkndXKG
  CSRpxBBae3cGXeChqRZp2R6nqnyowOEmzA7ki8/CPdZWArQFuHZ9pCDoWtwEOymhBAwJ5JAG/A
  gOyxsz50vPXtdU79fNMYCC69fsC2wbx6ecJR35HTDI4Bk/3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1726695480; x=1727362146; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  mime-version:content-type:content-transfer-encoding:author:from:subject:
  date:to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=RbWYEH7g7L0dJxdlFUHEMhwgScoQet+2RYP/FTkv+xY=;
 b=FK+4RuJ0XT5PasXvP5sUOac1F2TxQWqagTvqDRVHT8a7fqP7tpmn6Ig0GJjPCKS1GiL50r6c
  AjqvQ/aiN0nCCw==
Date: Wed, 18 Sep 2024 23:37:59 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Chet Ramey <chet.ramey@case.edu>
Cc: =?utf-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>,
 dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $IFS related differences (Was: Question on
 $@ vs $@$@)
Message-ID: <20240918213759.xMVZejhQ@steffen%sdaoden.eu>
In-Reply-To: <b72edbc9-d336-4391-98a9-37c670afa435@case.edu>
References: <20240918011443.AVR6sOQ3@steffen%sdaoden.eu>
 <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>
 <b72edbc9-d336-4391-98a9-37c670afa435@case.edu>
Mail-Followup-To: Chet Ramey <chet.ramey@case.edu>,
 =?utf-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>, dash@vger.kernel.org,
 busybox@busybox.net, bug-bash@gnu.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.25-608-ge479530e8d
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Chet Ramey wrote in
 <b72edbc9-d336-4391-98a9-37c670afa435@case.edu>:
 |On 9/18/24 1:05 AM, O=C4=9Fuz wrote:
 |> On Wed, Sep 18, 2024 at 4:19=E2=80=AFAM Steffen Nurpmeso <steffen@sdaod=
en.eu> \
 |> wrote:
 |> It boils down to this:
 |>=20
 |>    f(){ echo $#;}; set "" "" ""; IFS=3Dx; f $*
 |>=20
 |> bash, NetBSD and FreeBSD sh, and ksh88 all agree and print 2. pdksh
 |> prints 3 but mksh and oksh print 1. dash, ksh93, yash, and zsh print
 |> 0.
 |
 |It's an implementation difference.
 |
 |The shells that print `0' treat the `may' as `shall' in this sentence from
 |
 |https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.htm\
 |l#tag_19_05_02
 |
 |"When the expansion occurs in a context where field splitting will be
 |performed, any empty fields may be discarded and each of the non-empty
 |fields shall be further split as described in 2.6.5 Field Splitting."
 |
 |So they immediately expand the $* to nothing.
 |
 |The shells that print `2' don't immediately discard the empty fields and
 |separate them with the first character of IFS. After quote removal and
 |removing the empty fields, since the individual words in $* are subject
 |to additional expansion, you're left with `xx'. When you split that,
 |you get two empty fields.

Thank you for this analysis.
(Here it is just a shell expander, ie, it acts like a format
string expander, and these steps you include, namely "quote
removal" etc, are nothing i can or want to mimic.)

 |I'm not sure what's going on with the shells that print `1' unless they
 |somehow don't use the first character of IFS to separate the arguments
 |and let multiple sequential delimiters terminate the first field.
 |
 |I assume that pdksh just expands each positional parameter to a quoted
 |empty string and passes them all to f.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
