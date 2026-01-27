Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425E200C2
	for <dash@vger.kernel.org>; Tue, 27 Jan 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769487988; cv=pass; b=MlLwLM+QczGNzDO0DfWXCPh/TWRUuN3j0WqvIoyHKXFz+9nMOgOqiPAKiBXjJfZk0PV8vnsvJWsuXa5amSlpcZMmp4foEoPH3nr/cOXdb7jADsmNC4r3MtU2BmttdHS9cDQJpcrU7RmnFOg/PTBLYIXcKDgSTFOGeez4LikM50g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769487988; c=relaxed/simple;
	bh=E7KSaftpz5w8XxlHsmvWRtgbvyaSR1GjhDVMLXAb3VY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U7T24l7oQjS2H64+0pIEC5s3/aPH5w3cmr4beiXdmrlo1Dj9ZcCjLGYV8yUOc25kQf4ZQEAYDyb/KzBxIdHun04JhPSQfjpuNYQmUc+pi5+7SWiXaYtSXgHSorv2t4FKKmKuy1VvKeEQmGcoFy3+Rtmuo7qz9m7/67v6tcqgFgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ih3mDRRn; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ih3mDRRn"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649392cc2efso861169d50.3
        for <dash@vger.kernel.org>; Mon, 26 Jan 2026 20:26:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769487985; cv=none;
        d=google.com; s=arc-20240605;
        b=gSnUXRUIJrs2I/J+1xRPvAhBQT5MSXjtssARXcwTQLfXZ0y+Gyx4pjFCERz+fX3Rr9
         Ae0mtrj6L0KpaQ0XEZ6q2z3svdFxDDsbDydTY/ghFETDs8uglRpvLTGJwU5Xqe9YHK2i
         ganBcZObgvPINLOkZ5mIYYyJXj+p6GnvtW0AtlwzVAeXcXWuZqH6jz7thE8RFHnbBeGD
         9fPo4gVJVnP2K8tf2OIeA0jfi2vCt+m2E6JjsSmvF6n/bmPhbJ4dfZGimuMIlHgVsRH3
         I6OuD+QW60btGt+5weLBqG/DVvEvN54qZYB+P9dxN7WlASBj5WDQZcjo+SE+/1hm6hnh
         ePNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1abP9Ykq2HLe03TkXfODrjQcg8cSK8R3zGMZM6Vk0ls=;
        fh=8ViJBE7khi76CnJqQzrAav0OoHrBlpLAVTsfTw9REA8=;
        b=kDqmeMRldxPTqhvQB66I0PgK+hJevj3HPwXAll+qrc6bieusY5GS4eEbM48maqJX6h
         CncWZjcWq3OxoTa078GXIjJTx0wsgkEZ4It9PPKak0Tw0lOS+aCZTEHuQTCyETQsT9v2
         +WmJZEDB+Dx5BUBtripCDaEXJYc381eaVTWd0jNQWh9NC9KzRb4dPf30Qzx4BMMmLqWc
         qj152mMa+7szGpGiFPsHY/V9ZPagmibZJHdk/VmjW4E7SM4X6cH1t0NiqNaX2TC3lSqw
         OkviK6mMGYkKBdyjxvJqWYJW8q2gOeNmfO46RYDHExwX7COBobYoHni6eiSn+mvkoJtf
         sxYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769487985; x=1770092785; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1abP9Ykq2HLe03TkXfODrjQcg8cSK8R3zGMZM6Vk0ls=;
        b=ih3mDRRnZUe71VIdb1KNn+FcO9CrwUkMCn7FQR/KfqZChXHO2qdjsGhSOXAq5XmhHN
         u9B+2NZw8VvAgWFoJbltYx6z5uoXZulH9KcY9oWuJWOMligDOXP2NQIRn827uQ0mucVg
         rrHSXgtD42AtU4i7LNDaruPke8my3Zu3zIdqJSiBZd1dgj/npOewKBi+4GcfMo18k9/5
         V48afPdJx4cytZ/OmfZuYD5m/u9P6hdRUUJcn4MfiVu6rnUu6KUCipswd/hDU0J8cYbV
         8EXdEXi2HnTS3PauaTH5NRFGno31ZOeZV5vhrOdJUXO1DGGoambrdVp/SsSt9l4CC8Wo
         WAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769487985; x=1770092785;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1abP9Ykq2HLe03TkXfODrjQcg8cSK8R3zGMZM6Vk0ls=;
        b=TJivN2BLj5rKQkmRXVVE+5no0LkxqhKO+NzZdMs+0vt8FN+XKlPzdrrcWCf6gnq3iE
         tsVnMOJTPmYiq5GIp7v3FCkhSMhnMDxAeG4HarX5tdvNpMMQS996zTnRLWA4LRTFLVJj
         Bm29ZJTlUAfuBnfzQ8bYPomohMx0NUOMovJTo5LfBkbt0ah7H/8kMA2KS+kFY2WjySlb
         tLhPtP9D3itU+zrUsLA+0c8GIWTPCiyuyy2hc6pawFN4UBd/aG4fb63+Bp/E6SNFaORi
         sLd45bFyCp8RBlb5QRDnVCQOfr+LOVnU5wVJ87MtzYJYLkDhGJPTBX/7dFZhYBbs7sC+
         gKCA==
X-Gm-Message-State: AOJu0YywIqxtA8qwVXC53AMzPiyAuTbD4Jb/56D4TYsLNidb6iBSResQ
	0cdMEwCEXROf0/wk0gEVKdZFPvEc6TAhhaQ4LFvbWeJNXZZzc6pKWG6tvCv/iD4VPwd8sK1m++R
	FWI+SNsnUIQonW/Tttgc5VGvR8XKStPafIkrE
X-Gm-Gg: AZuq6aJZCgGJ+aoqLuJZ9Mq9T9y05LUWAPeNnwiRUvKxw3vKkHtrtfhvh3TPm1y/Bu+
	qHkYEWpkgj7utkKg8PzsGVdxi0Mkwxtq6xOyVEV15hPEkMw6lzghTckwqk15FDg2gNetyIU3rjJ
	C40cIDSwgXT1p0IwYoh9QhI1D9N7Fu9XgRrdFNcoUXuuvJ4MCR0LSnlGW2rNjI6TolgVbiReUnQ
	Shh3yVhVAdWT8XnCdEm1ZXfcgP89QQ4xi6dMKrLZNqhBRnxMAXtW/sJ2M8pg1vTKEk7tassroHN
	KoXhfjL1
X-Received: by 2002:a05:690c:10d:b0:78c:2fed:b9db with SMTP id
 00721157ae682-7947abfc6e8mr2053727b3.4.1769487985328; Mon, 26 Jan 2026
 20:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Tue, 27 Jan 2026 05:26:13 +0100
X-Gm-Features: AZwV_QgMXv8mlJuWxDfz_jPs5j_PbKGlNydLzBoqPlqE2kHQmY7BBNrNPwJZ68s
Message-ID: <CAK1hOcNHGv-7tkmD=XKw_oTy0s4NvZY0n1Mq4m_5_NX9miU2_Q@mail.gmail.com>
Subject: Unreachable code in evalsubshell()?
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

        switch (n->type) {
...
        case NBACKGND:
                evalfn = evalsubshell;  //THIS IS THE ONLY USE OF evalsubshell
                goto checkexit;
...
checkexit:
                checkexit = EV_TESTED;
                goto calleval;
...
calleval:
                status = evalfn(n, flags);

THe above means that in evalsubshell(n,...),
n->type is always NBACKGND.

STATIC int
evalsubshell(union node *n, int flags)
{
        struct job *jp;
        int backgnd = (n->type == NBACKGND);  // ALWAYS TRUE
        int status;

        errlinno = lineno = n->nredir.linno;
        if (funcline)
                lineno -= funcline - 1;

        expredir(n->nredir.redirect);
        INTOFF;
        if (!backgnd && flags & EV_EXIT && !have_traps()) {
//*** UNREACHABLE code branch *** !backgnd is FALSE
//*** (if we remove this, the nofork: label is also unused)
                forkreset(NULL);
                goto nofork;
        }
        jp = makejob(1);
        if (forkshell(jp, n->nredir.n, backgnd) == 0) {
//*** unreadable code: the backgnd is 1 in the line above, which in
this case means FORK_BG
//*** maybe make it explicit?
                flags |= EV_EXIT;
                if (backgnd)
                        flags &=~ EV_TESTED;
nofork:
