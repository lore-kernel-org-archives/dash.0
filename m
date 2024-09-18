Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDE4D8CE
	for <dash@vger.kernel.org>; Wed, 18 Sep 2024 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726635898; cv=none; b=XR5IsJ+gkhKvd5jVgdlqOGH25tqLhQUFo/obBacN9lTGDpF6eEEyUW01YISgWBoH09CCBL2wuBvpr43twOC4Y3H2DmpqmymmTosRDvAjlSRst6OBRbYvnhS2R2O5JxRQV7taVvj/hGU3YTodr1BMOST/Ya+9MuA9hgFoBP3oUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726635898; c=relaxed/simple;
	bh=FUKlHY80j90ZjYEv+6XsJ9N90T0DJ01wXC6dYQyIsPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=trH1R77sGYR8BVLc8wg3j+QD3iVJfF8KCxMNMph0mg4YPWfCcvL0/M/l41WT85BcZh5luMfT16yqyh1Y0/ioPqSW1z0phs5YaIcJZ1aLLXaqGDILeMWPPWR1w9f54Kj87Th14upxvLWkzy3PkCXcQraX/p/3SZTHYJKiJnTOSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0ZZyvMz; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0ZZyvMz"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a0b5973fe0so5151465ab.3
        for <dash@vger.kernel.org>; Tue, 17 Sep 2024 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726635896; x=1727240696; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfoukLViKTEKyVuQAAn/2FIzBnBpwZVQgeZcGaoqyrw=;
        b=H0ZZyvMzPn0P7wC8PxLuZgz+ewYpJBChtVjwIUJeK+IeQQKNFMhyVGMWbYvkM+uELL
         KQaxwafI0JRIevhhz1edME8KoIA7KhOcYbkM1sVWd0SUYSE2MXNCA6iWOVkffstFWsor
         1vExew7tZIVQ9rUmOAUbqQoJoj7sVDnKDQJfNKQwyAVnMqx9+25/8ksffPZolzmw8fpQ
         i0m2w1z04VirlylYTVfWUN9sHVbtSn/sDz70MQ0/s+AIlt9lsLJX9RFEdGoSJL5gwv5o
         9pjc/9+5pa/v1ocegxPTR6HK6rihe+CNY/D1n6P4Ah/vl9gNWkmvPHSS9ggYf7FYTvo2
         ZxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726635896; x=1727240696;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfoukLViKTEKyVuQAAn/2FIzBnBpwZVQgeZcGaoqyrw=;
        b=q64OuwCi0QiRa8H3JqNQISGphOxWJBChlqTTy/V5Przo8pt/uATcEfMykqtB+ECteF
         K07fTph+bU5iBwlZF1GEoQLIb4A86p7LqnLzVn3IUJbF/PXthIGH+wpObUmfAEVGMNoc
         oj332S76jLTRmjxIgl7lM9Ojt7/600ioKYEeWotGUOaIcC8P2NAj2nBlqm6fgWibRhq9
         z0y6PLi15O5nvBjHvmZllT6fE5x/DHsNK20Y7QTfEPNAkpKfgAhrO9XRYa/J25ijyqzw
         qsdEfCl+Q/sSNtKC9zkwufCPawY/90K2ZVVEdDF4ftkEpKRWfOsaP39DAaOXPrQvgOjr
         SjyA==
X-Gm-Message-State: AOJu0YyANnRBV0OCfZT9ws9GXvyTokePxtJDAKsoHrATl0yfn1hgpPAr
	nWBjGMJIqhVo7AEKutE71NS4HXpcfmTVxp+FF0vhanm4hdubfISNy12osliAnzUIxYAJSGLJYy5
	zwLJW3abHVOkq6V+uxwnRIveOTAz8MXL3
X-Google-Smtp-Source: AGHT+IFk3XGCRpqKbPiKw0EmqIePFmT4Zd0j7S9+YBYPrOkkZs0K/HEuCr4CoWhNWjDnqU3SQpJp3oGrbt6zARK2oF4=
X-Received: by 2002:a05:6e02:1489:b0:3a0:8edc:d133 with SMTP id
 e9e14a558f8ab-3a08edcd3abmr142176575ab.9.1726635896280; Tue, 17 Sep 2024
 22:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918011443.AVR6sOQ3@steffen%sdaoden.eu>
In-Reply-To: <20240918011443.AVR6sOQ3@steffen%sdaoden.eu>
From: =?UTF-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>
Date: Wed, 18 Sep 2024 08:05:10 +0300
Message-ID: <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>
Subject: Re: Question on $IFS related differences (Was: Question on $@ vs $@$@)
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org, 
	Steffen Nurpmeso <steffen@sdaoden.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 4:19=E2=80=AFAM Steffen Nurpmeso <steffen@sdaoden.e=
u> wrote:
>

It boils down to this:

  f(){ echo $#;}; set "" "" ""; IFS=3Dx; f $*

bash, NetBSD and FreeBSD sh, and ksh88 all agree and print 2. pdksh
prints 3 but mksh and oksh print 1. dash, ksh93, yash, and zsh print
0.
