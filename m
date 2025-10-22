Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD234B18F
	for <dash@vger.kernel.org>; Wed, 22 Oct 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142711; cv=none; b=R9IWhRGrfEdK9eHuFUlA4MVvSg4nOpdiflgCFf0f7d6XT7mWuUurHSkjhsBzonsL8VVvSzbOxBI1Qkg7ZFquidZQ6Zeah+fHuFdsEvGuSHb+id+MHaA48IZASJ9qrNZ/hqGBJXJz+YX8vYMAX5gkesWzUZml4qjuzDb2wSmN9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142711; c=relaxed/simple;
	bh=JztTUfo6RH9D+8q0b5nTRNSrno8J8bBwY/cs5sDCVFY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=IsIbdQ29r5yMU9LN4N8HKiEPYbeKZBL/UqouE5Qxv1xr4AOouxPs6krV3/Cm9Zi+pvYq/IW6wVG86L6N/gvkrCOhbzR3tRFs8ovAOyTNUQ6WkuRliPb6FEP3gA6Y4D4LII7X4EQYqlF4ox05dqzT6EC5rX13/ahFyRAa1WYuZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QX1A3kxP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QX1A3kxP"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D99C32531A
	for <dash@vger.kernel.org>; Wed, 22 Oct 2025 16:18:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uDcLMj9Tc0hu for <dash@vger.kernel.org>;
 Wed, 22 Oct 2025 16:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761142698; bh=JztTUfo6RH9D+8q0b5nTRNSrno8J8bBwY/cs5sDCVFY=;
	h=Date:Subject:From:To;
	b=QX1A3kxPkfxgKpMfcOhIVxVUik1OOfzVaf1ltazI0eEIGi1q6hGGQ8LwrehpBVVLY
	 pYm/MRgZRwKRlIJzjiCHDnhAZ92T2Y2bMg8nJ8HE/4gjGq1fchGbp7i1Nd6dB5ops2
	 Jd7AZxZcqEq3eyB8wFadaBgcgG6aUPhQc/ZLxarXTqJXbpdGZ7WoWIF5pE8hP5+k/8
	 +VGJtNJGUAzQQMcZJbSfl2gczcFw5rnYpGjoi94QfXcAT9lVYLVWSwPviABtwJPaQh
	 F9ChDbwTMztsTk127WwCuB5UrFatbjoevF1wjOZFjKO7UW27ZKgi5YbEF4ow3SU7si
	 sKPAz++nL/Inw==
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:18:13 +0000
Message-Id: <DDOWZC8VVBRJ.1451WK7WE6O79@disroot.org>
Subject: Treat $_ as a special variable
From: "Listeria monocytogenes" <listeria@disroot.org>
To: <dash@vger.kernel.org>

Hello,

The current treatment of the $_ variable leads to spilling the last
argument from a command into the environment of the next when dash is
invoked interactively from bash or zsh, as in:

  bash$ dash
  dash$ echo hello
  hello
  dash$ env | grep ^_=3D
  _=3Dhello

This is because bash exports _=3D/usr/bin/dash (or whatever the full
pathname used to invoke dash is) into dash's environment, which in turn
sets it to the last argument of the previous command, but as it has been
exported, it spills into the environment of the next command.

Currently, this can be mitigated by executing `unset _` in $ENV, but
this would not be a problem if $_ were treated as a special variable, as
its value in the environment would remain unmodified.
