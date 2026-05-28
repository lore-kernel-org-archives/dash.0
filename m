Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261B317142
	for <dash@vger.kernel.org>; Thu, 28 May 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011990; cv=none; b=A/tobJQ8WnfJsBOH/OoKqiWTpFtgCHn5F4gff6nSW03cZfYsmLtqnswnY6KqFSbhKtLRWGcSD256y+mFcKIavdomit5E2onADpA+GNF+yydX7Kce63xudOha1LLPFXm8Rm3oqL7zP4SLiUqSEPturSUGjkLvXR/JbF4Yt1ylNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011990; c=relaxed/simple;
	bh=asplaDL5P5WvmUPlb4RdwldJYGpyOC3V+iF5R64FHH0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=NGU37tVpa613aQ0p3GiSD+sxK0hhK1JwBhdf1xrwsn5Kyq8zI5n8I908FJZwo9GvIGX2hZdYN4nSR9YDnCfP+mUSO5wa4MAUaWocr9r0JJqE7juAhKv+UEq0F5AtWK2/FQEbjHDcyYQfwnlmpnLZAG4dzpTC2n6Ztsi0I58GDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=kEvJsPL6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpFcH6SR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="kEvJsPL6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpFcH6SR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B9D4F1D00125;
	Thu, 28 May 2026 19:46:27 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 19:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1780011987; x=1780098387; bh=ZtM6VAvIGR2jgl3IqAZTk
	5hlNhkLIVouO9jDi7+EMe4=; b=kEvJsPL62OGACFDNvh0SaW2e4x7XLS+dtH0hK
	xLle1h9wfMVH0CqKpZ5Id3a2Ok+S5cQR6899J46rSc7dFjLyAuZnxN108neN26uf
	Prcm36iDeiDrj3uCh8xM3J8u0Bek5Hd3ctGWwoAFDtyTbIIxDFn27R1zqHywc/lm
	0pWy9FBj6zpWr+6DzzmFYsbKNE1jsxb9Pl000wtze0QuOexbEqHDAPa72Wpg0OJL
	gqjwDtzetqE6N4xWN3wlRiAmO5VaJr1FjOcfsd/4IOseuUS1xxet7Oarvg+gqw9w
	jEGZPaBDSsgdGUfU5IcPmeAUu1p1puHnUMBG1P8y40A7XqHrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780011987; x=
	1780098387; bh=ZtM6VAvIGR2jgl3IqAZTk5hlNhkLIVouO9jDi7+EMe4=; b=S
	pFcH6SRxPiRHgHFrH5cD4s2r5l5QanzKyTkhkuwvmV0KgZ7d2vX5t92h3GdZTJYw
	QCGn9cw6VTENbRzJkT6yiO5LTmy7jJljWI5uEsUr2IBKo5fBZ20gupyWcmNAeco3
	Q/X2VHpBXAsl8XrAx9bqLeDueUVX0XK2hTUPxFXherfjHESnUdCuhspmPFbrG+0N
	HLBPC9IshwJ/tjOVfg9oRAqJHIUdMVgTlMzOI+Ef7nTcnkHqmZYsUjrSdvxbBCZ4
	IxlX//ZnNbE0Em7FEpF6RjEzEf2N3lGn/ZEtGhUM+EMhwBixm0Vjk0ocBPVp+3L9
	JTY0A8Na+6tsykS7PVRgQ==
X-ME-Sender: <xms:09MYajrRDz10GDIaES_jfFomoxddMuWjx0WkZSoIHSJb-9_r-UqRmQ>
    <xme:09MYaocFvT6t4HGEPS6m-rqkzkD6MsyyOni74gupDOUpgqokPgPLl_2QwM0wrKhKQ
    5qz9W07NX6XX0VbIhlT0PFdINm3bckFPhDbu8hOdIcOJxIvyOk>
X-ME-Proxy-Cause: dmFkZTFnXqDDIdF6SHp26OKz+700mKdT/VPqn9Y9jwhIxK6yoJEjESrmKFaOJ+HJ8yyd49
    CFAmQzVXulIQnpA1MFD8qjErwvEym5RHOnFVsmB2AFnL105+AF6iN77nP/YnRdQ5EIgEN4
    yMx4UtOgwXvUpgbSbRQPXHflTJlRt2lcHMCwIn5c3euh8aLH+CLQjSH9MxPPqCLZMWlOCh
    uHmptZk6hJZFDnluUBfWXWV3d545FtXd8CTMmPlE18TSKFn/sXSEhMAEn8t3ksxKvNom9I
    gV6mskYjkf0wyTIKzDSPbuoU05pX2DMMkYsl2K3TSGhd1LKEuEmceY0Bg8TmptCaiNboh5
    LvlvtcWv8n5VLT0yvlA3blf4Ba+sipcvnIR+AlPKA9VqcnUGgfTB2rlH4SowGhYd222XK9
    eU4p+rpOyKWmK0xThANE5k1JSNULRHoWXfpkATA+MlP2K5mfiWUe56OR4P25aR976SzHUb
    LSd++t/gEJpRo0MoaGBSYSyJR4PXi2jwEj/ZvmKUMFuwje7UYcNuwkEvYrE1UpiKbTj+su
    dhc/gRYy19Ws6Tsvni3Kru6fCfor6ssMkeO8JrMfs25gDstcYaNCn/VC6dRlWJwPUnsfB6
    AuXeKQ2VSAWj6b0obYSReCkYZ0fdetEGMlf+/HgBYmTjU96ecpwJn7xnK7zQ
X-ME-Proxy: <xmx:09MYauX6OCpJwECf-Gr9sAZNhXXhprAnbfpZ1w7tO2SZyLBxI6LAWQ>
    <xmx:09MYaojaojR4u5IRnr4jV_Ke2bGt1kmfzt4kv0WNSxGlLOoiF1b6HQ>
    <xmx:09MYap-50whqLib8lDs8E6SJxFNO3aTsstlFP_7p7tw4Elu9fbUTow>
    <xmx:09MYaiDOFpmDPq1pPBzcYTJnnGb-ShjqSs_mMVmcC53IcHz94gy3sg>
    <xmx:09MYat5HOl3tgAzBH4Kthw2ZRRllxIXsOgxyTLJ3lFh2kSlBgiYj4GXY>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1E1E8216008B; Thu, 28 May 2026 19:46:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ0hmDZD3yyk
Date: Fri, 29 May 2026 00:46:06 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: dash@vger.kernel.org
Cc: "Sam James" <sam@gentoo.org>
Message-Id: <b08b2521-82a6-4b23-a5fc-f1922979222e@app.fastmail.com>
Subject: [PATCH] builtin: Fix octal escapes in dollar-single-quotes
Content-Type: multipart/mixed;
 boundary=3e618f2908bbfdec4a5b444bdd1662151c03ff99

--3e618f2908bbfdec4a5b444bdd1662151c03ff99
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The test suite of the gentoo-functions project recently uncovered a bug whereby octal sequences within dollar-single-quotes are evaluated as internal control characters, resulting in faulty decoding at best, and segmentation faults at worse. The attached patch rectifies this bug.

-- 
Kerin Millar
--3e618f2908bbfdec4a5b444bdd1662151c03ff99
Content-Disposition: attachment;
	filename*0="dash-0.5.13.4-fix-octal-escapes-in-dollar-single-quotes.patch"
Content-Type: text/x-patch;
	name="=?UTF-8?Q?dash-0.5.13.4-fix-octal-escapes-in-dollar-single-quotes.patch?="
Content-Transfer-Encoding: base64

RnJvbSA1OWE1YjFkOGMzZjRiNTc2NTY5NTQyNjc3ZDU5N2FlZDQ0ZWM2ZWQzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZXJpbiBNaWxsYXIgPGtmbUBwbHVzaGthdmEubmV0
PgpEYXRlOiBUaHUsIDI4IE1heSAyMDI2IDE2OjU2OjQyICswMjAwClN1YmplY3Q6IFtQQVRD
SF0gYnVpbHRpbjogRml4IG9jdGFsIGVzY2FwZXMgaW4gZG9sbGFyLXNpbmdsZS1xdW90ZXMK
ClRoZSB0ZXN0IHN1aXRlIG9mIGdlbnRvby1mdW5jdGlvbnMgcmVjZW50bHkgdW5jb3ZlcmVk
IGEgYnVnIGNvbmNlcm5pbmcKdGhlIGhhbmRsaW5nIG9mIG9jdGFsIGVzY2FwZSBzZXF1ZW5j
ZXMgd2l0aGluIGRvbGxhci1zaW5nbGUtcXVvdGVzLgpIZXJlIGlzIGEgcmVwcm9kdWNlcjoK
CiAgICAkIGRhc2ggLWMgIng9XCQnXFwyMDEnOyBwcmludGYgJyVzJyBcIlwkeFwiIiB8IG9k
IC1BbiAtdHgxCiAgICA4OAoKVGhhdCBpcywgZGVzcGl0ZSB0aGUgaW5wdXQgYmVpbmcgMHg4
MSwgdGhlIG91dHB1dCBpcyAweDg4LiBJbmRlZWQsIGFueQppbnB1dCBiZXR3ZWVuIDB4ODEu
LjB4ODggaXMgYWR2ZXJzZWx5IGFmZmVjdGVkIGFuZCBzb21lIC0gc3VjaCBhcyAweDgyIC0K
aW5kdWNlIGEgc2VnZmF1bHQuCgpJIG5vdGljZWQgdGhlIGZvbGxvd2luZyBtYWNyb3MgaW4g
c3JjL3BhcnNlci5oOgoKICAgICNkZWZpbmUgQ1RMX0ZJUlNUIC0xMjcgLyogZmlyc3QgJ3Nw
ZWNpYWwnIGNoYXJhY3RlciAqLwogICAgI2RlZmluZSBDVExFU0MgICAgLTEyNyAvKiBlc2Nh
cGUgbmV4dCBjaGFyYWN0ZXIgKi8KICAgICNkZWZpbmUgQ1RMX0xBU1QgIC0xMjAgLyogbGFz
dCAnc3BlY2lhbCcgY2hhcmFjdGVyICovCgpSZWludGVycHJldGVkIGFzIHVuc2lnbmVkIGNo
YXIsIHRoZSBDVExfRklSU1QuLkNUTF9MQVNUIHJhbmdlIG1hcHMKZXhhY3RseSB0byAweDgx
Li4weDg4OgoKICAgICQgcGVybCAtZSAncHJpbnRmICIleFwwIiwgJF8gJiAweEZGIGZvciAt
MTI3Li4tMTIwJyB8IHhhcmdzIC0wCiAgICA4MSA4MiA4MyA4NCA4NSA4NiA4NyA4OAoKRnJv
bSB0aGlzLCBJIHdhcyBhYmxlIHRvIGRlZHVjZSB0aGF0IGFsbCBvZiB0aGVzZSBieXRlcyBt
dXN0IGJlIHByZWNlZGVkCmJ5IENUTEVTQyBpbiBvcmRlciB0byBiZSB0YWtlbiBsaXRlcmFs
bHkuIE1ha2UgaXQgc28uCgpMaW5rOiBodHRwczovL2dpdHdlYi5nZW50b28ub3JnL3Byb2ov
Z2VudG9vLWZ1bmN0aW9ucy5naXQvY29tbWl0Lz9pZD05NDcwOTBmYjc3MDQKU2lnbmVkLW9m
Zi1ieTogS2VyaW4gTWlsbGFyIDxrZm1AcGx1c2hrYXZhLm5ldD4KLS0tCiBzcmMvYmx0aW4v
cHJpbnRmLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3NyYy9ibHRpbi9wcmludGYuYyBiL3NyYy9ibHRpbi9wcmludGYuYwppbmRl
eCAxMDZhZWNkLi5lYmU4MWI2IDEwMDY0NAotLS0gYS9zcmMvYmx0aW4vcHJpbnRmLmMKKysr
IGIvc3JjL2JsdGluL3ByaW50Zi5jCkBAIC0zNTYsNiArMzU2LDkgQEAgdW5zaWduZWQgY29u
dl9lc2NhcGUoY2hhciAqc3RyMCwgY2hhciAqb3V0MCwgYm9vbCBtYmNoYXIpCiAJCQkJdmFs
dWUgPDw9IDM7CiAJCQkJdmFsdWUgKz0gb2N0dG9iaW4oKnN0cisrKTsKIAkJCX0gd2hpbGUg
KC0tY2ggJiYgaXNvZGlnaXQoKnN0cikpOworCQkJaWYgKG1iY2hhciAmJiAoc2lnbmVkIGNo
YXIpdmFsdWUgPj0gQ1RMX0ZJUlNUICYmCisJCQkgICAgKHNpZ25lZCBjaGFyKXZhbHVlIDw9
IENUTF9MQVNUKQorCQkJCVVTVFBVVEMoQ1RMRVNDLCBvdXQpOwogCQl9CiAKIAkJc3RyLS07
Ci0tIAoyLjUzLjAKCg==

--3e618f2908bbfdec4a5b444bdd1662151c03ff99--
