Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D286DD0D
	for <dash@vger.kernel.org>; Wed,  3 Apr 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150064; cv=none; b=IfuY8sfB5bqaUBHGSd6OQw5B2TQY3gX5OZRVdWXFyOPd0UjGlzXDEtzQKiRwZiRZt4RUkn4fCWaQRjarVVRNawezvmtwN7LYzbioNcVFYwBEEonWHnk3TXCW66w5NcbOZnLTI2QIytKnVqRc9NDViljhZSialYQoNCsjkkOvUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150064; c=relaxed/simple;
	bh=ZNLx7A2ms5iZGp8rfF10QnjMA4DttRIHvGhs2JyIukk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nTTBsipzUyImcbJfiiw5kK/C6o8rrBFeEbjOhhOBOwpGrJEvA7/zMlRLVGgfPAkRXowQX3vRd9FQMeB6mq1GRR9sRdOO+R4zbB46COULdF9xdOEfE+6Tbqssl6sWablMF7REq41FC4zPCzXEa0subBMhO7tIVhit4S5970nA/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy6qjKuG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy6qjKuG"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so1913167e87.3
        for <dash@vger.kernel.org>; Wed, 03 Apr 2024 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150061; x=1712754861; darn=vger.kernel.org;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNLx7A2ms5iZGp8rfF10QnjMA4DttRIHvGhs2JyIukk=;
        b=jy6qjKuGA8yt9yDdU8b3DyUqX0CyqpcmZ8eQE8mNBPw30eZ04Y7guG+t1GBf8U+K/O
         wCLQbiePeTxP+j3cvvhmRVaIKCtYDd+VSYkjhAc7sY6ZBX8TChJ4M3bnAkveU8zpcJNz
         CYdQBaIKo6xBeap+Lj9JEtFarbTYbjQMEgG/zJqCRo0hR69zfUfjTsqGwlr7u9oYky7X
         kIFYJ7LVcYbbZPSL5dMFxComwPXJvOU1WW/eul38q3++nRCZ44NSBxb8OvOCdn/DfcJw
         vUyxg4KlxhAFJsEe7UrH2t+g4EL/cOdUPO7zEc0gqq7OE7CwLNARswm8pSjqkshExMTd
         t55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150061; x=1712754861;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNLx7A2ms5iZGp8rfF10QnjMA4DttRIHvGhs2JyIukk=;
        b=N0+I9Imem1fLVzl9twUE92jGpe/N07dTCUMQ0SLGGcSLykZrJqu8D46PqHMxb/jqPH
         Fw4tjyBgdxPUuFjHeVtp1Jc5ni228zpVkZeLONpl2+OW+aIdy6KXYr0WtwH4cOuLWXgl
         t9LXqKaboLyQWikfY1T8i2Y1vv4to4KeefrG0bw5Ohgdf5+9ir83k12Nr82+rfgVo8Ih
         8a2olEcZKHJ6N8Rwrm+9Chd9IntaRd1eEvlhfR7YHJTJnxhlDFQboE4cWcY0IcXzsb9m
         i7ngcOg2t6blxA4BW0UkKsa8auZM8uqSSKKofft0o66EMxz2lbKWty3yAVN1QjLFpqkE
         8mtw==
X-Gm-Message-State: AOJu0Yw0YzJAUYXYInBu6EaQJ2VmdM/I/ZItZhtER8Egxp4QbCc2iWr9
	uKcoXJ2mgeTOVt3veKCSvUv9Ko+w8RuvdnlYE8yb1DEEQMUEOOz+XcHjsGXQ
X-Google-Smtp-Source: AGHT+IGXN89gw3mJwKbG2xJTwU04UOGdxrNvqn/xgndzat80vrES3FIo/iz/oxqtl4wezIqT2XHJnQ==
X-Received: by 2002:a50:d6d2:0:b0:56d:c88a:f37 with SMTP id l18-20020a50d6d2000000b0056dc88a0f37mr6591174edj.26.1712149667558;
        Wed, 03 Apr 2024 06:07:47 -0700 (PDT)
Received: from [192.168.0.152] (mob-5-91-247-24.net.vodafone.it. [5.91.247.24])
        by smtp.gmail.com with ESMTPSA id p28-20020a056402501c00b0056c4a5c350asm7952779eda.11.2024.04.03.06.07.46
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:07:46 -0700 (PDT)
Message-ID: <ce0529c8-872b-4ee5-9f9b-37f8b191d6ba@gmail.com>
Date: Wed, 3 Apr 2024 15:07:43 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dash@vger.kernel.org
From: Martin Guy <martinwguy@gmail.com>
Subject: Issue: Document ulimit's "unlimited" limit in manual page
Autocrypt: addr=martinwguy@gmail.com; keydata=
 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
 KCqywkkM
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jQrke1JAFPUiqbMOp8252sUK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jQrke1JAFPUiqbMOp8252sUK
Content-Type: multipart/mixed; boundary="------------8yQRZVXJTRAu5SH660HF03SF";
 protected-headers="v1"
From: Martin Guy <martinwguy@gmail.com>
To: dash@vger.kernel.org
Message-ID: <ce0529c8-872b-4ee5-9f9b-37f8b191d6ba@gmail.com>
Subject: Issue: Document ulimit's "unlimited" limit in manual page

--------------8yQRZVXJTRAu5SH660HF03SF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkuIEkgZG9uJ3Qgc2VlIGEgYnVnIHRyYWNrZXIsIHNvIGhlcmU6DQoNCg0KIMKgwqDCoCB1
bGltaXQgLWMgdW5saW1pdGVkDQoNCg0KVGhlICJ1bmxpbWl0ZWQiIGtleXdvcmQgaXMgbm90
IG1lbnRpb25lZCBpbiB0aGUgbWFudWFsIHBhZ2UsIGFuZCBzaG91bGQgYmUuDQoNCihub3Ig
aXMgaXQgZm9yIGJhc2goMSkgc28gaXQgbG9va3MgbGlrZSBzb21lb25lIGNvcGllZCBzb21l
IGVsc2UncyANCm1hbnVhbCBwYWdlISkNCg0KDQpXaXRoIHRoYW5rcyBmb3IgYSBmaW5lLCBs
ZWFuIHNoZWxsDQoNCg0KIMKgwqDCoCBNDQoNCg==

--------------8yQRZVXJTRAu5SH660HF03SF--

--------------jQrke1JAFPUiqbMOp8252sUK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEE7ruZ0Yy8BOSWJJ+Vi0B6xFixsSgFAmYNVKAFAwAAAAAACgkQi0B6xFixsSgZ
DAv9EgW+9xa5/5OUQOz8k+ItLa8NUe6xnv/qoY/E2wu/meiXTpPOniFnj7zy0LIpXg9FTiqTCtYH
vaS2toc4BTrZZ3n79PboXjkSFfONMSgB/Ij/u1ovgUvLKbtLEgntRWaK78WEffxxv3IJ6ZScQByV
+py2gN/n16opkgnDgz9o03KLwKaz/ft5/uimBn9f4Gzsg0d59qDd1d+aqt3lbEFlYuuWeLANOIH3
GYO+WufM2Ady7D99CMrWP2vk3oHf/PNkZ44Uf7GvJ/Q572yS9NwcLllAq8OcEihXY8t05M943Wfm
16BJsFxO8lk3gkiM8f6DoueOJeyrFXhjH+h8JNcPKCa/07oFsgNGd5aEJBH5wRccW7/MIlDPNNxd
WEXFtCa/8fvzLG/f77CRzgM5AE5YA0FxMjgWX1D0fYT890S8dLfp2rdFedm3Hv8SHotToSdsFwpw
AWATJAYUkKVenxVHhRQChEIURgmwxJ3fsFqCtg2wgPyPsqip66L4tgRz7s9o
=JKJo
-----END PGP SIGNATURE-----

--------------jQrke1JAFPUiqbMOp8252sUK--
