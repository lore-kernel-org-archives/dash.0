Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1F25A2A4
	for <dash@vger.kernel.org>; Sat, 14 Feb 2026 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771045802; cv=pass; b=lKM7Gyb3NXco9qZ1yTQY8VUi8A4wELJId0xCgDAL1kyK4aJcRTxjwWWMHiyqc7trnN9aQ+/2Df0iS/KpO7HqwMYSN6qgxXsLRU7laP54+CfqG7n0H4K+t0u6qTxIXK1Y9AQg7GnljVTrzmAWKnJhJ3ot9jvB+uPPqeQHL7N+gas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771045802; c=relaxed/simple;
	bh=yvM6Ys3BbQCifhTkY0byRXpZ1EPBLZgxm87nZMLSA1Q=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=cAicluDNJ3U7b+f1J6TpnTQUkE/UiquHmKiKjpZrRStdGIButgSci1hLB60K3ZYI38OiwqDqkSC/QR+QImpTeL+P9Wk5GT2x6AXUBi/kVlI8aYSzYZ8GT96W281CmRs4FMdfdW7EW05OKzK+zIeiRduBOWYZ+2DxMgGuCsCf5mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtW8kQ72; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtW8kQ72"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso3211840a12.1
        for <dash@vger.kernel.org>; Fri, 13 Feb 2026 21:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771045799; cv=none;
        d=google.com; s=arc-20240605;
        b=HtmOShCb/2pswP4NDFVzkPJh2mrouG+2MzP5WUHdaW+gPCPNJCmMvYX2ma1tdb2s91
         a+d5O8AZJWt6AhHhTYfU5Izs8+aXRmCbB1k+W6rnctjNUU74bIi/pWm2dn8SpDWiPbm0
         9K1wUxdzslAmD+FTzVWCN5TVMTPMogS/sGX89DV2or3BaIY0RF+Xfk3ICeArEw3v2wOG
         ap3xz23J4cB5+knmHt0408OwlaVEd8hYwR3CQSLF80eIt+XNqZDrzymvf3jGG6pJ0PBF
         FCxXqvuDL7eFQ1M3gaHY8KuwhZ223IIB946vitkR7oFlzd2JGVL5HTkjOLOr4xt+rDh+
         phqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=wqRNbPfXm5fm7eDy9bUsTrxsO0ORF9ntN1Zb09pEyIU=;
        fh=PxKmzUxN8oq96mZ5c3iTvnFc9UQ/YCLc1yZXXoLJMv8=;
        b=k/AubjROKimGtLe2OZtRqDJKKLr+iVpMDtpTYaoLtEf4B4mAWE8cPKhxlOE+2Soe8d
         qSFAgD61TKX/hdpAE/kkhz7tR2+cq/x/duGalHI3nx9WbSTv6/VCj1FymUlNmCZs+p5X
         GgVatCOcvGojQDesC1UCh2wShgtzHJGN6WAumHL1wYGaAbCDbmwAMgsn+XLyxHjBY3Nw
         iXmQkhgk2PXj/nvegjxqLP8tc9xEWmdyBpvsGoVYaS6NsDPsHFL91eQHAj20dOMGfzE7
         7N6yCA+FRBKOkEPcc54Fc40noR3t/0BKqPxbXgZ+TF7RMCsLj7hRJlHe1huppLKz/hjs
         D8uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771045799; x=1771650599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wqRNbPfXm5fm7eDy9bUsTrxsO0ORF9ntN1Zb09pEyIU=;
        b=EtW8kQ72MKNC3NiKqNAeMORiNcJdPzL29rlMKSNw0ermgje2oBOaNXMdWDdcjuSFZF
         RJpQRE8yH1o9G0wHs6i6Oa28UEfUH0nIqF6jEo2AtbFVAI5GBxJfJiRW2kXTZw+YUq19
         qUU4sF8uhFPm+hjnjvSOeflV4IulrVKWjhxSjN82BrZYlf4AJ35M6u4++5OYi848Q9+3
         2oONnoACYChVVdmCm2ve0emdTtyaU53eQ0do+oP/zK/Z4ms45Q6JEHjlWafzS3RsNbW4
         ElUs0uqHfrnfc+gsnH3lLEraIOU4VUxblkVR6H8jgwqn1ATpEU2RjRzamaHGNIDKcpwv
         yT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771045799; x=1771650599;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqRNbPfXm5fm7eDy9bUsTrxsO0ORF9ntN1Zb09pEyIU=;
        b=e/9TJ+oYXM3h4WhVjT0mmz3d989hG5cMJKQS1OmVZqL9IPN7s0CCgVx/wV0HK4Y2Y3
         2AKC7M7VSRv5a0Z+z5Nery8G74TGlMZ82IgTotFnALsBpaJ+f9DpVmyzWDpoLUMNgvlU
         450PdF6yKajtirhbkFTdjyFzgAgI/lDUgT/L9Vvg5BoNfAG845ojdkdYEtc5YCWbORqz
         YIk/ZrT1V67LO0E7sKFu7407D4Ck5EEXADr5Wwzr6DPMeSXXfALBsU//RKIZ4VcwnTqF
         t2oU/Xz5rdS/8G+I7njGKRIHXZLj5koKP9FbwTANoydrjb2wO1fByyu3msuGysp2khhn
         lwYw==
X-Gm-Message-State: AOJu0YzaJDWtvv5xLcStmGkNcqr9wXXn28uRR+G2tc5+ZR9DLx/m5fa6
	onrJTPrekJ3Wil194ZZ6VYFIlA9AsdoPlZNY9+WeGkyMDd/fRaPDSaokvsn540bm5etyJrJqiGf
	oNHiaFiArJliO3Le4AWh2f8fwdpmqLcJ4/o0j
X-Gm-Gg: AZuq6aLERxayvjuEHcnpxA3oG9C8qJj4IQQcDNz0hv4MSv90R0LZmSx0Q4/HwKmVlwS
	F+Aqan8sOomp+K4JN4hXF5eAHLE7fT7Mh8j89EAgtOXGX3GIYIdtD4fZsDYVZu1IAD6G7PVGlq2
	e54FchfasnUU1dwGetPHVW6vzJ7TEhR+fshCQoPSE5PILhjx0FO81P931N3plTzRHLyaBW3EGfd
	R7xZfLp92BAJ7LN61XmuOYp/HYon05cYOF+yWQhVUqKg+2WgeMryWjukHdCyqvWyrFLWwR1MhHm
	exnN0Jn/AOBuLlw4edgyUoIwfUCsLYKPfRIRsgn8dVPP7EXPhnYDILgyOHiWxvxIlpNK920kW2I
	Umyks02Pz29gE9PvSwteHRSoro9SJQoAvVdSHyvyHFBRAMasXqRvV
X-Received: by 2002:a05:6402:1344:b0:64a:86db:526a with SMTP id
 4fb4d7f45d1cf-65bc424a677mr987388a12.4.1771045798472; Fri, 13 Feb 2026
 21:09:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 21:09:58 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 21:09:58 -0800
From: Tiago de Paula <tiagodepalves@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Feb 2026 21:09:58 -0800
X-Gm-Features: AZwV_Qg8jRPLqHVEtXzp92vyjAptIO-mCxgQMlj-Iolmi_vJfVojgaA4nWOxQNo
Message-ID: <CAO_NRt6m0gYC4A-O19mebUAePSQ_X7gbuSyuxHevWE4xHnWMAg@mail.gmail.com>
Subject: [PATCH] expand: Avoid unaligned access through uint64_t pointer
To: dash@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Tiago de Paula <tiagodepalves@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use memcpy to reduce alignment from 8 to 1. Unaligned access in this
case is undefined behavior and can lead to invalid machine code in
architectures with strict alignment requirements or after compiler
optimizations.

Fixes: c0c860df08c9 ("expand: Count multi-byte characters")
Signed-off-by: Tiago de Paula <tiagodepalves@gmail.com>
---
I was getting crashes when compiling with '-march=native -mtune=native -O3'.
Building with ASAN avoided the crashes, but I got these warnings instead:

    expand.c:964:13: runtime error: load of misaligned address
0x7ffe4892c997 for type 'uint64_t', which requires 8 byte alignment
    0x7ffe4892c997: note: pointer points here
    61 73 68 00 43  6f 6e 66 69 67 75 72 65  00 2d 64 65 00 2d 44 70
72 65 66 69 78 3d 2f 68  6f 6d 65
                ^
    expand.c:970:29: runtime error: store to misaligned address
0x558de50b48e3 for type 'uint64_t', which requires 8 byte alignment
    0x558de50b48e3: note: pointer points here
    00  6d 65 3d 00 8d 55 00 00  10 49 0b e5 8d 55 00 00  d8 48 0b e5
8d 55 00 00  00 00 00 00 00 00 00
                ^
    expand.c:1338:13: runtime error: load of misaligned address
0x7d49bf7e2889 for type 'uint64_t', which requires 8 byte alignment
    0x7d49bf7e2889: note: pointer points here
    7c 00 00  2f 62 69 6e 20 2f 75 73  72 2f 62 69 6e 20 2f 75  73 72
2f 6c 6f 63 61 6c  2f 62 69 6e 20
                ^

Which led me to connect the dots and make this fix. I was also able to
reproduce the crash with just '-march=x86-64-v2 -mtune=generic -O3 -g',
but not with -O2 or -march=x86-64 alone, so it might be triggered by
the interaction of two of more optimization flags. The patch does fix
the issue for me, though, so I didn't try to find the exact flags that
do that.

 src/expand.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 8c8bf0e..72d11cb 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -961,13 +961,14 @@ static size_t memtodest(const char *p, size_t
len, int flags)
 	if (likely(!(flags & (expq >> 3 | expq >> 4 | expq >> 8) &
 		     (QUOTES_ESC | EXP_MBCHAR)))) {
 		while (len >= 8) {
-			uint64_t x = *(uint64_t *)(p + count);
+			uint64_t x;
+			memcpy(&x, p + count, sizeof(uint64_t));

 			if ((x | (x - 0x0101010101010101)) &
 			    0x8080808080808080)
 				break;

-			*(uint64_t *)(q + count) = x;
+			memcpy(q + count, &x, sizeof(uint64_t));

 			count += 8;
 			len -= 8;
@@ -1335,7 +1336,7 @@ ifsbreakup(char *string, int maxargs, struct
arglist *arglist)
 						unsigned char b[8];
 					} x;

-					x.qw = *(uint64_t *)p;
+					memcpy(&x.qw, p, sizeof(uint64_t));

 					if ((x.qw & 0x8080808080808080))
 						break;
-- 
2.53.0
