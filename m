Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255924A33
	for <dash@vger.kernel.org>; Sat, 28 Jun 2025 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751087481; cv=none; b=RUg7ThuFHRaPu4P3AJGXpt8jLoNxofUtQ/DgxFkwuAAzvrUbCKYzBL2LTBgb4LP9k18amgjZMdIEkIz+Ccf8rbRyxfBgJYKcZmL7sLEmnE+Hhdw3vsov0EDLzS6QQIHFKgT8BCQorQKF6pcF497Qnyy+EBX55NQFyMVQvhDr32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751087481; c=relaxed/simple;
	bh=/Bm4A2pv+BDitlSasK/q7xXH8AQz1gZzFWDWU0ICJjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nqw5qNbeo/CFB2WVxg1x7mcHEPZuABXbtz0FGKO2mlAv/TQWUuepqTy6pFV4LO8OhjEg8JTuvARw/FGkgxbxisxM6U5SQFyzbmf6bVWoVe7IhyFSxoqsxBcSv/MNiU/f3dE/CZh5gzlrvLBUvN0rM/ZiI+vmwz/QOytYrKCufSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CFE2D340C39;
	Sat, 28 Jun 2025 05:11:18 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: dash@vger.kernel.org
Cc: Anna (navi) Figueiredo Gomes <navi@vlhl.dev>, Eli Schwartz
 <eschwartz@gentoo.org>
Subject: New release (or blessing to take a snapshot)?
Organization: Gentoo
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Sat, 28 Jun 2025 06:11:16 +0100
Message-ID: <8734bkv4az.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

There's many commits in master, especially wrt POSIX 2024
conformance. Would it be possible for a new release to be made? If not,
would it be possible to have your blessing to ship a snapshot of master
in Gentoo? (It's completely fine if the answer is no, I just figured I'd
ask -- Debian experimental seems to be doing that).

cheers,
sam
