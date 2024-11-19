Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319ED14831D
	for <dash@vger.kernel.org>; Tue, 19 Nov 2024 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045151; cv=none; b=H5G8gv9N6Mq/rDeop8TRAmMTYLNGZ2MpS/mLNjLuGT3tpceWdejz/i1H8dhHEOJZyr8BJmtEjPmPxMEEkW6leIg/S2erQ9BP9AbrP/5TOHXUuXSPl9Tqfc7XslnH0RrBzGh7DqYC24EwuK4Y/XIExzvFV+5szoI0pFw3c7ho7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045151; c=relaxed/simple;
	bh=h26AiMNABm6S8Tm6IG2+vC7Ge+vD/8fPXcv1HRA3gCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z/prQvgBheM0tLFwAoryodPXC754jSaemxN21dWdrYuxz1t4IpHCkzJVMld0H5f88I08Fq5UKQlV1T6KFcqe7pAMT9WVIY07JZfuMCbAlZ12y1jWmWjA8WAYDrtgZSm6ncUV4ErLln7ogbQfXunNRDEJXrvIejL1xgrAJDnoiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=k90OBKdf; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="k90OBKdf"
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 76B6A3C00FB23
	for <dash@vger.kernel.org>; Tue, 19 Nov 2024 11:32:16 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id nO-mE0t2zSjA; Tue, 19 Nov 2024 11:32:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 0D0F53C00FB20;
	Tue, 19 Nov 2024 11:32:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 0D0F53C00FB20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1732044736;
	bh=9HIingjWUEVQWJDEfVU9m4m4jh7vEPKddFDntev7ybg=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=k90OBKdfcoTexixDebxgDLE6oInN9JjPgttpC/oW6RWsfZ+LJsa0GXaPUoxGHscdG
	 IxT+AcYD/Oj+NuolizL20vgkcax6brGfKOs5iCVArsnirod4kGR+nHIBmcn5wF4x7g
	 oWQLb4LSbgJh4yJErp5NJULunrMAJ1wm7EqyfeG1tDwhVaBM8cID0TproqRMrXYuAn
	 7vvyJCpxX6eKfzoEmtaeaLYEnV6IOOEyHTpHqf2kDcQsYFm7uAIQx/CPEaJwThdSbz
	 tNfFvPEjZUh76SPly8Pf8/hwr8R0yv4HryZjihjZf4HnL1i/2jMinJFcC//JoN89rm
	 LRdUoFCXMOHaw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id VbsN-Lqal8Uz; Tue, 19 Nov 2024 11:32:15 -0800 (PST)
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id E30113C011BE0;
	Tue, 19 Nov 2024 11:32:15 -0800 (PST)
From: Paul Eggert <eggert@cs.ucla.edu>
To: dash@vger.kernel.org
Cc: Paul Eggert <eggert@cs.ucla.edu>
Subject: [PATCH] builtin: diagnose attempt to printf '' as number
Date: Tue, 19 Nov 2024 11:31:41 -0800
Message-ID: <20241119193211.1585716-1-eggert@cs.ucla.edu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Fix "printf %d ''" to issue a diagnostic and exit nonzero, as
done by traditional printf and as required by POSIX.  See
https://pubs.opengroup.org/onlinepubs/9799919799/utilities/printf.html
which says "If an argument operand cannot be completely converted into
an internal value appropriate to the corresponding conversion
specification, a diagnostic message shall be written to standard error
and the utility shall not exit with a zero exit status".

GNU coreutils has already been patched to do the same thing.
I plan to send in a patch to GNU Bash shortly.
---
 ChangeLog          |  4 ++++
 src/bltin/printf.c | 10 +++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 406e20c..4c16886 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2024-11-19  Paul Eggert <eggert@cs.ucla.edu>
+
+	* printf now diagnoses attempts to treat empty strings as numbers.
+
 2014-11-17  St=C3=A9phane Aulery <saulery@free.fr>
=20
 	* Correct typo in manual page.
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 46c6295..11fcefa 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -540,11 +540,11 @@ getdouble(void)
 static void
 check_conversion(const char *s, const char *ep)
 {
-	if (*ep) {
-		if (ep =3D=3D s)
-			warnx("%s: expected numeric value", s);
-		else
-			warnx("%s: not completely converted", s);
+	if (ep =3D=3D s) {
+		warnx("%s: expected numeric value", s);
+		rval =3D 1;
+	} else if (*ep) {
+		warnx("%s: not completely converted", s);
 		rval =3D 1;
 	} else if (errno =3D=3D ERANGE) {
 		warnx("%s: %s", s, strerror(ERANGE));
--=20
2.47.0

