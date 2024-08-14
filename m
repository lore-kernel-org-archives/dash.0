Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED711B3745
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647519; cv=none; b=APnD1camIP/hyjG/qJO5n5hDIxLHfL0MTWn2woCdPkaHWzyytFG5j9F+K5Exz4inM6E6970niXxPgWLEmfzQf9AEdiVOLYziCnt7A6E0puc7b6WALVlZ0EgyYIPl3X4gLEtLSDyWcUQf7hPQSca6KncEEFaMWcdkRHrTWUG1QNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647519; c=relaxed/simple;
	bh=9MHWEvzbYwnB3U5DBnCNSfnI/xtM3mIKPTLZuuMMjQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHoZLF23My64W9Kv6V6zJ5oLhJRETfWMfTYzg2XXzFmm/c2PAmQGH1LmuXIrY/BQ3ZUnj1TPQlM8EI1eJO4CPFhaeyZ9XfF7mpYc6r3sAwRYLYEA6yfHpHozjGxdD9QCp93Nf1LP6LOFd9g2WtJ9QocHZHX/6LKUgaArrvzxTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP42WtO/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP42WtO/"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39b06af1974so25696855ab.2
        for <dash@vger.kernel.org>; Wed, 14 Aug 2024 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723647516; x=1724252316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MHWEvzbYwnB3U5DBnCNSfnI/xtM3mIKPTLZuuMMjQs=;
        b=fP42WtO/UGxkpRGUer9FpRGS3i03d5Ulmkt+Nz3UNNf4sDoO7vXopIkWOeDYjUirIR
         AFb+ih8nkJrWR9WaXO7uYJeafDGEe3ozuI4bjR7A3fNEcpCvXF1ijN2py94Pk1J5JEh1
         ZnmqIeqeqYxxjqXE7uG3ta3Vr+BXu5YWfPkMQ8OsXe8WeU+vZiOyt5Os3Z3X4ud+5o0f
         u8EH+hSFsuCOLNYH8jF8gR6F5fYKZoW85r4y0AN/c+xnDCiIVttPt0cEVZay9GyPXDli
         Zfjz/MChzTkhVXMgql4h+TreqTfPfK5EwWy+SWQComXS3ijOEUZbS7DQrEdJSrVWCOkg
         lkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647516; x=1724252316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MHWEvzbYwnB3U5DBnCNSfnI/xtM3mIKPTLZuuMMjQs=;
        b=KCVxewxrNMlz5f1Wu/ZLOdqk4nSOocQ/yd/Fq8teAaYBp54h4ptwDMrpKk4/FqB5FC
         YFQi/flMENwleIvbFNWocyYyRuroufh8Gq/yCUhOI0liwGW7MkcYqMiHdeV6TnYXOcAG
         +KCTSpBZRluhev3IESdQ8kmcxoMjOz4ILGNJGfuu8mIV7KdrxvNbDaraz8v5ZLGj3ogJ
         vX4rOOj2J4WNO2ZA/D75Zr2Ym0Ms3WTu1a9P84KocIQ4HXjeLBeTDDlYzWWb4qzwxTRT
         UuBsQ/qu38s7SQUYfxoTWUSRpn0bgX8h3Am/0eli684LEKohR/psUAdDLFLn59f5H9SJ
         +Dng==
X-Forwarded-Encrypted: i=1; AJvYcCXF7ZGA0ieMiDsvZPNs6GzGTx9RF/UQlFgbYsjueqm+nmYCFpaUwh/yKi3MCzTkfiu66TtKHmh8zFKEZMfb1MSnf9Rv7g==
X-Gm-Message-State: AOJu0Yy+te86F4nlwd8cg/Wwm415wwJOKOou85hlUuKUVGECJZnVchFn
	0s5gXfNldipEcrPHZGC9xSilKFNDfRcaHKC3XtNffST9Pgb1LC3wx7kU2XQJNL72ShFqVvLg3hc
	No08KyNR8BzAfPbN9AbBYBOMA0dPzhUrU
X-Google-Smtp-Source: AGHT+IEcJrAlaXqQcgkDCFEee2YklpiIXnf31/wgxsZOw4Es29S1TDPOuuT1MuaqKg6cTa4qzf74yjaJxmGxeiSLwyM=
X-Received: by 2002:a05:6e02:1546:b0:398:39f:8b4d with SMTP id
 e9e14a558f8ab-39d124410dbmr41651065ab.5.1723647516546; Wed, 14 Aug 2024
 07:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu> <ZrwTnBvk8_2mdQUS@wooledge.org>
 <ZrxzCOnZv-HffFuB@prometheus> <17108.1723645239@jacaranda.noi.kre.to>
In-Reply-To: <17108.1723645239@jacaranda.noi.kre.to>
From: =?UTF-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>
Date: Wed, 14 Aug 2024 17:58:15 +0300
Message-ID: <CAH7i3LrWppOACxUU6zaLupJzX4WrtkiMGx2roVq0yvY90JHrQg@mail.gmail.com>
Subject: Re: Question on $@ vs $@$@
To: Robert Elz <kre@munnari.oz.au>
Cc: Marc Chantreux <mc@unistra.fr>, dash@vger.kernel.org, busybox@busybox.net, 
	bug-bash@gnu.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:23=E2=80=AFPM Robert Elz <kre@munnari.oz.au> wrot=
e:
> However, as ksh93 makes "" from this
> expansion, and so probably ksh88 might have done as well

No, both Sun and SCO variants expand "$@$@" to zero fields when $# is 0.
