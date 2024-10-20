Received: from dane.soverin.net (dane.soverin.net [185.233.34.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCB194C67
	for <dash@vger.kernel.org>; Sun, 20 Oct 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456580; cv=none; b=OsjGjw+WjWc0pMylugbYRu97fIGuAGhHfc86nhBUtO8WjtmGFuF9JgoDz6msP4O97JlFTcW/HRpGFTGxl/6rBGzWvEoCuu++4zp9h92qdmk4g26eYrMAHZMUlngUGaYtsHh+XMpMSdUv6ID8bomJEbllsc94p0Q533TxMi3mxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456580; c=relaxed/simple;
	bh=nG7aOBtRLaD8RGMaPS0XFLeNAev99dJLZMS9SErc0zw=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=Gls56z0n3fBXMKq2sUuKy95Yjs17P977mxiOxKc6gzoQvPXM6+r2IPXZGPRjkLOKIlLbSzEh8p/Il6tdt6LMFd9qOZW7AQkNBtgu9Ep54GIJxakznupRhSTa3Re5Hk1UaT9ycxhQGsmwlIammrJg6M7MReVq3FTFtYAff21zWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpvos.org; spf=pass smtp.mailfrom=gpvos.org; dkim=pass (2048-bit key) header.d=gpvos.org header.i=@gpvos.org header.b=QW1Qqe94; arc=none smtp.client-ip=185.233.34.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpvos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpvos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gpvos.org header.i=@gpvos.org header.b="QW1Qqe94"
Received: from smtp.soverin.net (unknown [10.10.4.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by dane.soverin.net (Postfix) with ESMTPS id 4XWqkg0XjyzyRW
	for <dash@vger.kernel.org>; Sun, 20 Oct 2024 20:27:55 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4XWqkb6SCJz5L
	for <dash@vger.kernel.org>; Sun, 20 Oct 2024 20:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gpvos.org; s=soverin;
	t=1729456075; bh=nG7aOBtRLaD8RGMaPS0XFLeNAev99dJLZMS9SErc0zw=;
	h=Date:From:To:Subject:From;
	b=QW1Qqe94XxIvZYFwnYMZO1/MHJQ6mbAuCmT0H7l4UonZ91HgromfX2JHpUu5rmJ8A
	 +sM3+JVzqCz0cGPCu5t0KSJTAGlNDg8BGm9MYnwoaAUUgI+FMYrgcAYsUL9P1iyQTC
	 gqgCrTi8C9PIyha8mPkTSo/JJ/JkKIxJ5EaIxunOq5kuQF4gdvElBhBd+Nz8yKlTXG
	 VoxUNfyCPURYnhCyE2X/6XtK5AvXzSAmgbLXr9ui33ycAgmf66F6m6+arPEmPyrAhp
	 g2hweOF4q61FkQlYXGLcFf9AWIU+o6GCdkHR9p2grW3VYYhcLGgaNpGxisa6W22CT5
	 AkYCMb6yTsEzg==
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 22:27:51 +0200
From: Gerben Vos <gpvos@gpvos.org>
To: dash@vger.kernel.org
Subject: doc omission: . searches path
Message-ID: <359236b66220f58cdee2b59a1991c25b@gpvos.org>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

Hi all,

a small omission in the man page: it says: ". file: The commands in the 
specified file are read and executed by the shell."

However, dash only takes the specified file if it contains a '/'; if 
not, it searches $PATH for it (and errors if it is not found, even if 
the file exists in the current directory). The behaviour is fine, but 
this should be mentioned in the man page. The process is like the points 
1 and 2 under "Path Search" (but without checks for functions and 
builtins of course).

Cheers,
                                         Gerben Vos.
