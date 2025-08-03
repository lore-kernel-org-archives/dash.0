Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F448CFC
	for <dash@vger.kernel.org>; Sun,  3 Aug 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754237727; cv=none; b=SqBhbXvME0OVNW90Xp9QPdq11UglNISF8x7BW6O1em3QqGvswru9LnQmGetFhzAKV5WMdWUP2dYyn275OY4z9ND/WrilcJT2X8VA8LATNsQyvziN7AQkrUp99gaW4hb62eN9cvVy32KQX5oJHqfiMINafaE/QJnT/QOAWqNPfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754237727; c=relaxed/simple;
	bh=DOP07CvyOiOQsVamUWzQ0w0Q6AemKec5WyfgCa64/PM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nGceO78wq2RHsFjkmyww4KHlDm9l14d8Fy3Db0y8JKp7lX+RNc2SzfmrpTIM0Y5YaVaAXLfIEAj8nfYkzWMIwDn5Lyv8t3XKpxfVVnnBINidfiN2QMLGJAxYyg64SmwN5GadQpxU49u1ioBGHNBhKBynYhSskZCRs6PF0oy9Kyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kWYX1gDi; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kWYX1gDi"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8fe14f9297so346884276.0
        for <dash@vger.kernel.org>; Sun, 03 Aug 2025 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1754237725; x=1754842525; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9H9aV6ORG98Qb/a69gj3u8zK3DMx+RI1RlZ6NDTErHs=;
        b=kWYX1gDiJvHzzj8J9WT3yS+uADmtvikyzLo2pliYqEmjyhTqmwRvhyAnuIi+H5584p
         IaVFeWyi96xfpIZs5QHtNYY6y4ScoxaKRrRfkgYLWW0ERzqdWiQgb3xSaIQxfYFr7Qfw
         9B2rMY/nuxMWZiY5oBiZILwb9EComJ6b/bQRmL+30vWwKgDrZdhxT1pyZBuCox7X44Fa
         RO4VDoWU7+o7AHJGHxdMVc8dtMBodJhmfbzGXKJt/bhr4W8BYr11ZI/IoTYdlVp9oQDa
         JUn/CNUmQlm/QoRq0ZeeDBtZkLBjq2z0jYVB4inKxxhgoF7XsqBNYxzeBkySwQdoFgJm
         jNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754237725; x=1754842525;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9H9aV6ORG98Qb/a69gj3u8zK3DMx+RI1RlZ6NDTErHs=;
        b=vV70Vev/1mt5eXP2/ZSt5liQiIGztnnPE+r41x8SJMaV6wixiH3XzmsNLX3uAg5WsX
         NWLlPBSX8Z5gdlZg1NWlPpD0Af6FNTQZYCcnQ7yRaWnf1adGF70IyhSJ5wEpmL83ih3f
         +9V+N56nVxMnYnqHJ0ugY5WQgmmh0Xp5TYZ+V7U4Ytr1/XA+WIXF2DbB4kRDVf0E6DSS
         yzLgLxe8caft9NC0bEsnbGxjLbAUBRM43zlsOK5kCi4w28r5vNq4kRLy7e2suxvrQpCc
         EYx2AEAeqplwh9jd8Fgk6jtiND97SqY4cxF4hOUC7MfE0Fu6q90hpKtyCZlzyWYVrOVH
         sXgA==
X-Gm-Message-State: AOJu0YzAJvBgNb1wW30SVfShEuHYcmPQcYmXlMAajYHoyXD6jKmpgSIu
	kYeR9qYx9LjuDm9MjVvcBZWrCNsfpkCxM9mqcHVTwCJkZX0f2kh4nlNuau6X7jRsjUBDFe0yFJf
	Mgyesjs/8ZDvY3DGB6DIpcGlI00/M8iqxFaTf
X-Gm-Gg: ASbGncv4C7bYbag5X5XsERgCReFvoN1lM7uQfjwm9r63S3aiHz6MD5o5dTwI3yQ2kqq
	Izp/Qihj+z6DxGRk84NBI594OM3oLoSGv7Tm4fhT71FGRBjCdiwp68uwULhZ7FrSlDr8Cw9i+AI
	Dp5X3ZpTq8sIpgY4w39hl5XHGbuKZAdLkitjrswpsDzzRKkhuQLsgxdLdhbGQNBmXoBb6vb92UF
	lp9L30klA==
X-Google-Smtp-Source: AGHT+IF7lXt7atWVx+Mzs4qlrBBQk1ujA+MLPDvyHU70FW90mZX5vDocUz+NUn7IxMgTXAwwYhVvuClUjk75LFQxczs=
X-Received: by 2002:a05:690c:4a02:b0:712:d70b:45d4 with SMTP id
 00721157ae682-71b7f3aa2d6mr46195667b3.3.1754237724865; Sun, 03 Aug 2025
 09:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Sun, 3 Aug 2025 18:15:13 +0200
X-Gm-Features: Ac12FXytECJQASJ8STehbBzb8peF5AJDPXMHKDnuS0VKCrReyuC85J2O-pD7d44
Message-ID: <CAK1hOcPiN8HPDR-Y-w+GXVa9gZNwHuahV=g=CJ_oOM-KQW1tiA@mail.gmail.com>
Subject: Simplify procargs
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000071717e063b784c9a"

--00000000000071717e063b784c9a
Content-Type: text/plain; charset="UTF-8"

procargs(int argc, char **argv)

argc is used in just one place:
        if (argc > 0)
                xargv++;

Trivially replaceable by if(xargv[0] != NULL), so can avoid passing
this argument.

        char **xargv;
        xargv = argv;

xargv is always equal to argv, so why having a separate variable?

        const char *xminusc;
        xminusc = minusc;

Similar situation with xminusc being equal to minusc
during the range where it is live, they diverge here:

        if (xminusc) {
                minusc = *xargv++;

but after this, xminusc is not used.

--00000000000071717e063b784c9a
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-Simplify-procargs.patch"
Content-Disposition: attachment; filename="0001-Simplify-procargs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mdvvt63q0>
X-Attachment-Id: f_mdvvt63q0

RnJvbSA3ZjM2ZDhlZDkyMGY0ZGJiNzYyMzE3NWRmNWZhZWYyYTA5ZDg0ZDRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW55cyBWbGFzZW5rbyA8ZHZsYXNlbmtAcmVkaGF0LmNvbT4K
RGF0ZTogU3VuLCAzIEF1ZyAyMDI1IDE4OjEzOjAxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gU2lt
cGxpZnkgcHJvY2FyZ3MKClNpZ25lZC1vZmYtYnk6IERlbnlzIFZsYXNlbmtvIDxkdmxhc2Vua0By
ZWRoYXQuY29tPgotLS0KIHNyYy9tYWluLmMgICAgfCAgMiArLQogc3JjL29wdGlvbnMuYyB8IDEy
ICsrKystLS0tLS0tLQogc3JjL29wdGlvbnMuaCB8ICAyICstCiAzIGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL21haW4uYyBi
L3NyYy9tYWluLmMKaW5kZXggMWUxOTJmOC4uZTk3NzFmYyAxMDA2NDQKLS0tIGEvc3JjL21haW4u
YworKysgYi9zcmMvbWFpbi5jCkBAIC0xNDksNyArMTQ5LDcgQEAgbWFpbihpbnQgYXJnYywgY2hh
ciAqKmFyZ3YpCiAJcm9vdHBpZCA9IGdldHBpZCgpOwogCWluaXQoKTsKIAlzZXRzdGFja21hcmso
JnNtYXJrKTsKLQlsb2dpbiA9IHByb2NhcmdzKGFyZ2MsIGFyZ3YpOworCWxvZ2luID0gcHJvY2Fy
Z3MoYXJndik7CiAJaWYgKGxvZ2luKSB7CiAJCXN0YXRlID0gMTsKIAkJcmVhZF9wcm9maWxlKCIv
ZXRjL3Byb2ZpbGUiKTsKZGlmZiAtLWdpdCBhL3NyYy9vcHRpb25zLmMgYi9zcmMvb3B0aW9ucy5j
CmluZGV4IGM3NGU0ZmUuLjNlNmM0NTAgMTAwNjQ0Ci0tLSBhL3NyYy9vcHRpb25zLmMKKysrIGIv
c3JjL29wdGlvbnMuYwpAQCAtMTE5LDI2ICsxMTksMjIgQEAgU1RBVElDIGludCBnZXRvcHRzKGNo
YXIgKiwgY2hhciAqLCBjaGFyICoqKTsKICAqLwogCiBpbnQKLXByb2NhcmdzKGludCBhcmdjLCBj
aGFyICoqYXJndikKK3Byb2NhcmdzKGNoYXIgKip4YXJndikKIHsKIAlpbnQgaTsKLQljb25zdCBj
aGFyICp4bWludXNjOwotCWNoYXIgKip4YXJndjsKIAlpbnQgbG9naW47CiAKLQl4YXJndiA9IGFy
Z3Y7CiAJbG9naW4gPSB4YXJndlswXSAmJiB4YXJndlswXVswXSA9PSAnLSc7CiAJYXJnMCA9IHhh
cmd2WzBdOwotCWlmIChhcmdjID4gMCkKKwlpZiAoeGFyZ3ZbMF0pCiAJCXhhcmd2Kys7CiAJZm9y
IChpID0gMDsgaSA8IE5PUFRTOyBpKyspCiAJCW9wdGxpc3RbaV0gPSAyOwogCWFyZ3B0ciA9IHhh
cmd2OwogCWxvZ2luIHw9IG9wdGlvbnMoMSk7CiAJeGFyZ3YgPSBhcmdwdHI7Ci0JeG1pbnVzYyA9
IG1pbnVzYzsKIAlpZiAoKnhhcmd2ID09IE5VTEwpIHsKLQkJaWYgKHhtaW51c2MpCisJCWlmICht
aW51c2MpCiAJCQlzaF9lcnJvcigiLWMgcmVxdWlyZXMgYW4gYXJndW1lbnQiKTsKIAkJc2ZsYWcg
PSAxOwogCX0KQEAgLTE1Myw3ICsxNDksNyBAQCBwcm9jYXJncyhpbnQgYXJnYywgY2hhciAqKmFy
Z3YpCiAJZGVidWcgPSAxOwogI2VuZGlmCiAJLyogUE9TSVggMTAwMy4yOiBmaXJzdCBhcmcgYWZ0
ZXIgLWMgY21kIGlzICQwLCByZW1haW5kZXIgJDEuLi4gKi8KLQlpZiAoeG1pbnVzYykgeworCWlm
IChtaW51c2MpIHsKIAkJbWludXNjID0gKnhhcmd2Kys7CiAJCWlmICgqeGFyZ3YpCiAJCQlnb3Rv
IHNldGFyZzA7CmRpZmYgLS1naXQgYS9zcmMvb3B0aW9ucy5oIGIvc3JjL29wdGlvbnMuaAppbmRl
eCBmNDIxMzE2Li4wYWQ1NTM1IDEwMDY0NAotLS0gYS9zcmMvb3B0aW9ucy5oCisrKyBiL3NyYy9v
cHRpb25zLmgKQEAgLTc2LDcgKzc2LDcgQEAgZXh0ZXJuIGNoYXIgKiphcmdwdHI7CQkvKiBhcmd1
bWVudCBsaXN0IGZvciBidWlsdGluIGNvbW1hbmRzICovCiBleHRlcm4gY2hhciAqb3B0aW9uYXJn
OwkJLyogc2V0IGJ5IG5leHRvcHQgKi8KIGV4dGVybiBjaGFyICpvcHRwdHI7CQkvKiB1c2VkIGJ5
IG5leHRvcHQgKi8KIAotaW50IHByb2NhcmdzKGludCwgY2hhciAqKik7CitpbnQgcHJvY2FyZ3Mo
Y2hhciAqKik7CiB2b2lkIG9wdHNjaGFuZ2VkKHZvaWQpOwogdm9pZCBzZXRwYXJhbShjaGFyICoq
KTsKIHZvaWQgZnJlZXBhcmFtKHZvbGF0aWxlIHN0cnVjdCBzaHBhcmFtICopOwotLSAKMi40MS4w
Cgo=
--00000000000071717e063b784c9a--
