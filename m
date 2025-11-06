Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D8338F56
	for <dash@vger.kernel.org>; Thu,  6 Nov 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440794; cv=none; b=K86PW3xabU4FHKRbB/cHWoGpBsUyuOP6ch0PhhlC0nKgMo2dAzq1E0Pwt8cEVKePcxuOiCENH3pDKuWhVSp9538Dj6JwHGWJhTtKuyttHm15sX5EFnWqObjCZcB4VSc6narX5ebHI3+bl5TgR89Op04fNin8z4XtphvHDtAPFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440794; c=relaxed/simple;
	bh=s7xOzR36UYfhX8DU1sT1lubr34nhAwKL6EcFuROJpIU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eNQZRqs3oKRUozC88TekAfLb9e0D1p9K3wrtDWjYaLEHbYzLbq2AOtxmIDG351vpYigCWIel8SEkx1YE6BuM5sG9W4LD5vjELyF04zvjKzFk+nEQhibnaKeM3XG0VHEHipW29mKzHU+7NenQPqRUFXzo7NWv6GFzOCtNd5psvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sim-and-cure.com; spf=pass smtp.mailfrom=sim-and-cure.com; dkim=pass (2048-bit key) header.d=sim-and-cure.com header.i=@sim-and-cure.com header.b=GiHAp4b/; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sim-and-cure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sim-and-cure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sim-and-cure.com header.i=@sim-and-cure.com header.b="GiHAp4b/"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-656b8900ac1so521272eaf.0
        for <dash@vger.kernel.org>; Thu, 06 Nov 2025 06:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sim-and-cure.com; s=google; t=1762440791; x=1763045591; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7xOzR36UYfhX8DU1sT1lubr34nhAwKL6EcFuROJpIU=;
        b=GiHAp4b/VxM4hNsirqcWsvA8Ix9BwGPFgG5vmodu/FxNQZePqyldvL+7kh0f6RrMpn
         QOID88FbjR2cKW8d0BaeuLlPoCruLs7Rspv9Gvdavz51iGWTzMQma1JtuiSaKmWpG40j
         0084e9H1bVGEOC7ZI/wJARJtrnn2HV5hk+VEznv6FWxNmrcoIxD3RLmsYhorl+2HmuuP
         E37gxo9vlRmwjS1IqXEGelfV739DHwbOj7vWMnTbtldNHeaWjV5fsPMFnFF4BFljsXVp
         Wk6Pn5ypY3faUfRYfeODlazHFYZF+iXvGz8cmp5grCRF8pWrPJT2aa1OjyNNpODhw7FN
         gzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440791; x=1763045591;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7xOzR36UYfhX8DU1sT1lubr34nhAwKL6EcFuROJpIU=;
        b=J48+6mCVZ9e8dOLseKgbygVfhjeyk7fcIoI5giwa3MyhP0nE9JpTt2HcJWDcJfh01w
         9snP9xRcdeiY63NrIq+jA7mmrGB9DjfvqJWgXOa+E6vwDyz6TqH+bboYn1/N51tuPDZB
         C98FAdA3T4yINmShUuNZMVF87WeCzi+5wJ49ThgEffn0JAqc7qFYXCoYmd8TNFYVVBLY
         chgc7+LBxOkT6o8m/YL5977IzUmSoWpKASJLcHjEKkHKcbF2Ff4SNA8BxMsemooGPeSP
         MUbylPgy36GHM45EBvC5BuAs2K+ESxCKmQB28UwNt/gzOe2ea/EnObLMRIqlCvsqre8r
         U70w==
X-Gm-Message-State: AOJu0Yy6uRSw9fgc/Nj3elrtPaTT7BoRfFQZfIzQMMULztohjnev4akH
	Gm4tdYRzaDAVn92LufOYJbst3VcClip8UP0xIHVO960TQjDrBQ8x69amKZxLVedd0YqZhVOY2yo
	rP1wP0Edxe5RFzqlbROsEqzsaPjbScU01iTHYLqRS1PSP8JKB6nd9n9M=
X-Gm-Gg: ASbGncvkYjGrZeurWxnqILH2T0VHa+r/LzLa6r6ljJrNELrt3/r0pF9DAX6MpZ4OKfl
	4MMUm1gPuJHn3Jt2OsvTRImuq0xf9ueyoKXPRh90gToFqLzNas9WjqIEPfZ8D1JA1DH2PQJbeau
	nhFiRZkG8NL49tIM5WlJS6yloU2iKhD/tVCSbafReDHhUkQ44UgQ8+a2WO3shUF+/D6ZslU+jyB
	pnQ/J/dkdg0yX+q+3UwmnIxwZA8dINEUCoqFaVEeRdZj9Zp4jbHbaikyyBMZQ==
X-Google-Smtp-Source: AGHT+IE+fK9ZE+ZgBqY3j1lPJNmfOaX+cxH/qJmjkfBPpbBC3UCno4tFhGtY9c+zPwH0us/1T0uvmX7FdHZj9vFsLnc=
X-Received: by 2002:a05:6808:e84:b0:441:8f74:f1a with SMTP id
 5614622812f47-44fed4fb3c1mr3504787b6e.52.1762440791026; Thu, 06 Nov 2025
 06:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hadrien LACOUR <h.lacour@sim-and-cure.com>
Date: Thu, 6 Nov 2025 15:52:59 +0100
X-Gm-Features: AWmQ_blLqcJi1uFzv7nYdXvOXFeUdGOKGNQfMSyRtQ0JIVzBR5woCgC_W2sBRzg
Message-ID: <CAKmiXchO=0x573QEG6eZnOVkd8K=0PCiNM2x=qqrQPxDsoWpKQ@mail.gmail.com>
Subject: dash 0.5.13.1: heredoc parsing failure
To: dash@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004995850642ee395e"

--0000000000004995850642ee395e
Content-Type: text/plain; charset="UTF-8"

Hello, I'm on a ARM64 MacOS machine and updated from 0.5.12 to 0.5.13
via Macports only to get a very strange failure (nothing printed)
attached as a script. I then tried on
5139d6a27763fc0be386e15634db21e45598b299 ("shell: Fix unsigned char
promotion and truncation") since my problem seemed similar but not
cigar; tried using a modern clang (21) instead of the system one too.

Hope GMail doesn't botch anything (nothing else at work).

--0000000000004995850642ee395e
Content-Type: application/x-sh; name="heredoc-fail.sh"
Content-Disposition: attachment; filename="heredoc-fail.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mhnjmekw0>
X-Attachment-Id: f_mhnjmekw0

Y29uYW5maWxlPXh5egoKY2F0IDw8J0VPRicKewogICJ2ZXJzaW9uIjogNSwKICAke2NvbmFuZmls
ZSsiXCJpbmNsdWRlXCI6IFtcImJ1aWxkL2N1cnJlbnQvQ01ha2VQcmVzZXRzLmpzb25cIl0sIn0K
ICAiY29uZmlndXJlUHJlc2V0cyI6IFsKICAgIHsKICAgICAgIm5hbWUiOiAiZGVmYXVsdCIsCgkg
ICJkZXNjcmlwdGlvbiI6ICJEZWZhdWx0IGNvbmZpZyAke2NvbmFuZmlsZStmb3IgQ29uYW4gfWdl
bmVyYXRlZCBieSAkMCIsCiAgICB9CiAgXSwKICJidWlsZFByZXNldHMiOiBbCiAgICB7CiAgICAg
ICJuYW1lIjogImRlZmF1bHQiLAogICAgICAiY29uZmlndXJlUHJlc2V0IjogImRlZmF1bHQiLAog
ICAgICAiam9icyI6CiAgICB9CiAgXSwKICJ0ZXN0UHJlc2V0cyI6IFsKICAgIHsKICAgICAgIm5h
bWUiOiAiZGVmYXVsdCIsCiAgICAgICJjb25maWd1cmVQcmVzZXQiOiAiZGVmYXVsdCIsCiAgICAg
ICJleGVjdXRpb24iOiB7CiAgICAgIH0sCiAgICAgICJvdXRwdXQiOiB7CiAgICAgICAgIm91dHB1
dE9uRmFpbHVyZSI6IHRydWUKICAgICAgfQogICAgfQogIF0KfQpFT0YK
--0000000000004995850642ee395e--
