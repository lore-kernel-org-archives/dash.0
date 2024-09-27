Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B793C6BA
	for <dash@vger.kernel.org>; Fri, 27 Sep 2024 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727480252; cv=none; b=ns0EVglpuqIyhHPuACSezuvRxQBSWSDoCnhKkYVPNN6GthC6CyfwoUhV9eyoRwbwxhB7sU1TXsfyc1F0LE/XWdff/uDrDMC6nnnGDPqeKpcLwEcP4q0klc7G6eZNZfFglHArIgbnjDcjJhUskRQPNEUAm3b8iF3FNBcd69dlyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727480252; c=relaxed/simple;
	bh=tKVQIBwWU2ZvV+fyzSkdXUBWLFMGKGxhG8gRGIJkW0c=;
	h=Date:From:To:Subject:Message-ID; b=rEDIgEC3baCQ4f6oOV8Gz2TMgriCkRvKXga5Ho+55tzCe75JQotjTBR0xbFzrEk8dI22yQPXoIWKRy6B+k+TfB4IcdhRzIK1JeDWBdJJ55b8CvkHXCJc4o8x+04htJ45z4jy/iKdPXsL6UUlACz+x0WcG+NCb6wO7Vlg1ktl1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=Qp6kqrIe; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=DMNaWM/V; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="Qp6kqrIe";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="DMNaWM/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1727479791; x=1728146457; h=date:author:from:to:subject:
  message-id:openpgp:blahblahblah:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=mtjVTe2tyOabvBhOWaGww+CffSvtHDs4KGp13o6Mk8c=;
 b=Qp6kqrIeEFU51JP9JHQtTCrmpVYSP6qzACCt/Xn5qcuTVOM5SsczgJ8ubP+IkmmKrD0q7+nu
  VBOsV/7xQT1z9VB3920gkxD0jMzeR/IfxyreslArhhc8XieWrbvq+hWXKoATn/bv6NWjXcde9H
  rLdhk/OnQT/A3443eFIxBqqOUu63MeQ8o9a2YlootdcqFrGHHtglKs8yHAcg0Uiu97dzP/S7Yo
  YUnvVcUiqB7UM1iKkC8sAnImxaV/oG2N15HSb0m3tJCw4QiU9FR1E8rI4ryOXsIS8yfKpKADm0
  VKQ0Exr4GSU5dzb12HEIQJnwargVcj7zsWskvMNmZTpYeVhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1727479791; x=1728146457; h=date:author:from:to:subject:
  message-id:openpgp:blahblahblah:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=mtjVTe2tyOabvBhOWaGww+CffSvtHDs4KGp13o6Mk8c=;
 b=DMNaWM/V1X1Hkj01uE0HQgFS8X9WuEIw/K/klTFr5BMEdaSKOHmefo4AgSNJneT52v5Q6S/1
  NacvvTLPGHOhBg==
Date: Sat, 28 Sep 2024 01:26:52 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org
Subject: procargs(): interactivity falsely detected (acc. to POSIX)
Message-ID: <20240927232652.bpLrmgJb@steffen%sdaoden.eu>
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

Hello.

In an email communication with kre@ on NetBSD's tech-userlevel we
came over

  commit a373e69a196cd8d45f2806d805e548fa65a982ba
  Author:     kre <kre@NetBSD.org>
  AuthorDate: 2017-07-24 12:35:37 +0000
  Commit:     kre <kre@NetBSD.org>
  CommitDate: 2017-07-24 12:35:37 +0000

      PR standards/52406

      Absent other information, the shell should be interactive if reading
      from stdin, and stdin and stderr are ttys, not stdin and stdout.

and i had in mind that dash changed this already (i thought i saw
a patch flying by on the ML?), but looking at procargs() there is

        if (iflag == 2 && sflag == 1 && stdin_istty && isatty(1))
                iflag = 1;

where that would require

        if (iflag == 2 && sflag == 1 && stdin_istty && isatty(2))
                iflag = 1;

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
