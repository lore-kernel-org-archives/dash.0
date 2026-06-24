Received: from pmg.in-ulm.de (pmg.in-ulm.de [217.10.8.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307513E559B
	for <dash@vger.kernel.org>; Wed, 24 Jun 2026 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.8.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336571; cv=none; b=mZEMnKSQDGuWhTQSHtuVcZ9Y4ZOI2a+5fna5MivhCVi/9pUaWbi9ITiu6d7PSmdluGPSWhjWWkmH7hiuoo+8VxUscqL/zWi79jZelNwQX/TQcnainz4whnCYRyd/EnKYVFlkSuVTL61La5vhKsoi/f73qF4Buc3kEh18ea6pkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336571; c=relaxed/simple;
	bh=Kp/dmwhqXyBp6vyQqWLRdRrg+imuJJmgZ95bPz5yYs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AxvjiKBLyNK5lHcEryglk7kjUY5Ts9t62JK/mM9iCxTkCeqDIVDx4WKRvx0neQlKj3qBPmbHohrZzu/X+VztgO3O84BG23JwQ3uc+rJSWeuqPs3yaZetjSzk8If1/68DA/+T0Fi7jusvvCdUevq17Piz5pNuVgTuI3oLJUVtwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-ulm.de; spf=pass smtp.mailfrom=in-ulm.de; dkim=pass (1024-bit key) header.d=in-ulm.de header.i=@in-ulm.de header.b=btRFkpd+; arc=none smtp.client-ip=217.10.8.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-ulm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=in-ulm.de header.i=@in-ulm.de header.b="btRFkpd+"
Received: from pmg.in-ulm.de (localhost.localdomain [127.0.0.1])
	by pmg.in-ulm.de (Proxmox) with ESMTP id 028A72197F
	for <dash@vger.kernel.org>; Wed, 24 Jun 2026 23:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in-ulm.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=pmg; bh=Za6Ut5o0/wCyMmQC4xaFDL6WDKXB2/
	53BSTzbOkZZ68=; b=btRFkpd+ljsd9dH3RQ4hjOuoOdYAXIPSPxCBSqHove69r2
	me3x2sRoYgwyUlb86f5gdD2aPAC4b2BcpWPiI8vytj5MxrXlT6QA2Jabrh898IhZ
	V/x4ZfkW5LqCBc0R2jCzBWix1sIq569UAG8Ji7aD0F8Q8vstwFspjA6AsmyT4=
Received: from email.in-ulm.de (email.in-ulm.de [217.10.8.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by pmg.in-ulm.de (Proxmox) with ESMTPS
	for <dash@vger.kernel.org>; Wed, 24 Jun 2026 23:29:26 +0200 (CEST)
Message-ID: <c2dce0bc-9ee9-4b09-a3ae-7a5f167911f9@in-ulm.de>
Date: Wed, 24 Jun 2026 23:29:25 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: The read builtin erroneously consumes null bytes
To: dash@vger.kernel.org
References: <bf5516e9-e59f-444a-81c6-7b112b71563a@app.fastmail.com>
 <87h5myx9ji.fsf@gmail.com> <5a68f305-572f-4691-9984-2a502e468b9c@gigawatt.nl>
From: Sven Mascheck <mascheck@in-ulm.de>
In-Reply-To: <5a68f305-572f-4691-9984-2a502e468b9c@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.06.2026 um 04:51 schrieb Harald van Dijk:
 > On 6/20/26 02:52, Alexis wrote:

 >> POSIX doesn't require a `read` _builtin_,

 > It is not possible to implement the read utility as an external
 > utility because the read utility is required to modify shell
 > variables,

Offtopic, but what a nice memory:  One of Ken Thompson's aha-moments
(original: https://www.tuhs.org/pipermail/tuhs/2019-October/019167.html)

---- forwarded ----
i was writing the small utilities for the first
pdp-11 unix. (rm ls date ....)

so, cd was next.

% pwd
/usr/ken
% cd /tmp
% pwd
/usr/ken

Aha!

