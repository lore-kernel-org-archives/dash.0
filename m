Received: from mta-outp-ksl-2.case.edu (mta-outp-ksl-2.case.edu [129.22.103.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906D40DFA3
	for <dash@vger.kernel.org>; Fri, 24 Apr 2026 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776990300; cv=pass; b=mHnJVBCATfPJaFmsjL0CuTKPwZaQWLEju1pUE1LEpCIJODamvtLw9DR7EzENFPKKMjrzET1JGDY4onGT4NmNLEeLC+BOShE9WyTE3v/iPmiWxmlHD4h84VURyopq8e41BahfOXLUEA1lkD9LV/xAlhM5CqgJIsj2VfsXBwH78OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776990300; c=relaxed/simple;
	bh=e9jZZhUfv3USY8r18ldN3l1W2NZkywWIzI/yWdGW/Rk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sA7MbwIf7HbZejColWKfMEtvu1VAmTWoohJNBUjpz4aPehHW/i4OxOIg8Jt08c80n1cf4fIDW+F5AZ7AjoG3OxZDYUAR++bejvWiHw+ORByAoCq3Jy7lFv8Z46s4FgVURMFqOpFbnI5TCcrV26my8IL3zJcmw2ud7T71QCxLYqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=PjrRCC+x; arc=pass smtp.client-ip=129.22.103.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="PjrRCC+x"
ARC-Filter: OpenARC Filter v1.3.0 mta-outp-ksl-2.case.edu 41CC931000B1
Authentication-Results: mta-outp-ksl-2; arc=none smtp.remote-ip=129.22.103.228
ARC-Seal: i=1; d=case.edu; s=cwru-mta; a=rsa-sha256; cv=none; t=1776989844;
	b=HzA0iPYsL/slSgdmNTFHyvVdbxC85bbAaytGtA4C5JzxIzMCBVw+/VWdeWPcI2VUhfZo
	 XywbWO79XuAkq544W/NdB0l+Q4vMSEgqhpr/dg55xty/l4vTUHpZ1oi+LmowYAiosTUth
	 nK/rfMBYFhwpDxhY7nXjkL7X79Uxpq9G8V93i1iVGGVl+7F8fXpJxiGntIVujS/BNDDOe
	 PTLb6rNpIQaSo+yPsD2+QGVXGaF5MS2dzoiTAk2lPiJrTjF874nVviUBW++1RPyP4pvxu
	 rVCkkIYr8SekYWZP9TuC7+4uwNYTmcpovb1plAP2NXZ6IF4Z0YryGRdyC7gxk9D+1NA==
ARC-Message-Signature: i=1; d=case.edu; s=cwru-mta; a=rsa-sha256;
	c=relaxed/simple; t=1776989844;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature;
	bh=e9jZZhUfv3USY8r18ldN3l1W2NZkywWIzI/yWdGW/Rk=;
	b=TDmXd/Sf1bIW9ODkL1i7w5OUtb8cIY8/GNmlUKnYHLoG97VcDx7AG+g4WodBgeyr95vN
	 cwsbtujgq1AiCL6+NIjleW3RNHzNOLf9gQEvq71pcJjk4BMx58yMG0yRKB9SYxwH/Pg0H
	 K59WFvwkDidv7pZ+BzuN46WxszOcNlJREwM8oP4cyu2D9/LlyNfogDxwggY43wiLPerXw
	 rsUGycm7KYrp3Njt107IcTGDutbUKFHerCwxz4+GQ/WecjjmCs+pt6KY63gcUfgG7mbWz
	 6gz5G8k4Q6AUUkddfku3PnrgKxKYXjLpV91InpKmjS0F7HduVTCQ1N+pmTHq4pnvywQ==
ARC-Authentication-Results: i=1; mta-outp-ksl-2; spf=pass smtp.mailfrom=case.edu;
	dkim=pass header.d=case.edu header.i=None header.s=g-case;
	dmarc=pass header.from=case.edu;
	arc=none smtp.remote-ip=129.22.103.228
Authentication-Results: mta-outp-ksl-2;
       spf=pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.160.200 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
Received-SPF: Pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.160.200 as permitted sender) client-ip=209.85.160.200
Received: from mpv-out-ksl-1.case.edu (mpv-out-ksl-1.case.edu [129.22.103.228])
	by mta-outp-ksl-2.case.edu (Postfix) with ESMTPS id 41CC931000B1
	for <dash@vger.kernel.org>; Thu, 23 Apr 2026 20:17:24 -0400 (EDT)
Received: from mpv-in-cfd-1.case.edu (EHLO mpv-in-cfd-1.case.edu) ([129.22.103.211])
	by mpv-out-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DWX39215;
	Thu, 23 Apr 2026 20:17:23 -0400 (EDT)
Received: from mail-qt1-f200.google.com (EHLO mail-qt1-f200.google.com) ([209.85.160.200])
	by mpv-in-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id RKV17174;
	Thu, 23 Apr 2026 20:17:23 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e5a336b44so75430031cf.0
        for <dash@vger.kernel.org>; Thu, 23 Apr 2026 17:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1776989842; x=1777594642; darn=vger.kernel.org;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e9jZZhUfv3USY8r18ldN3l1W2NZkywWIzI/yWdGW/Rk=;
        b=PjrRCC+xx1KhIWm7vaNAae1hzJQxyy7ev0//ecBGetmUCGfnGcMsl7cn5uEGUERlGU
         CQpKDAtpZMDZmaa8P6+MNEUi4U/Qp6c1iLV767gJIB4EgetpgzY8axetuI+tCQvW3zjE
         KMKHhGQDYSvM9/75oDcAQODoGPA2Fob/k9OxbqDYFa1DdWLa+ZABDXUDNWQx9tUAotSX
         dpQqBCm3AAT14b5dCxVt1sKMZHDyO+yOUpzRf7yLrFm8yBTyS//hXU+mHFsl1T3KPZrC
         Vl6nMJMz8BoHmGbHCzQnwZYf4r52n6wVRqwLbe3OYEnOmxbEgf4DAVQJinIN+0jpang4
         TlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989842; x=1777594642;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9jZZhUfv3USY8r18ldN3l1W2NZkywWIzI/yWdGW/Rk=;
        b=HuOk0E63b0ttjmh+hIVJYBa1OxKo4yXBgA5e/L3sdla2FJlFcq46ZF8Gq8Sznly2+g
         KmWJrqVVVEzEJJzNdcAAyemrJcMJeM5F4QL6QDPThUqsIVZvV1xQwYKHSLJquiprwAg/
         mvAgA5OrCZ2+e8UR2OgsKTCP/lcH/nyQQVHUb299Ms2984ynevJ/bNoWleeavh643wR/
         I4neMMh4ad7UH+gMcFiH8gFaQ6EH9H9XJKmUpeDN7Vm8wnoCqLyTxhA6+bQ8BpsCqrd2
         eAX+6WyU95Vi6upYQZivwPP3A0izNo3+AX7JkgjeJuq4CGZ9Dq0oCpmfuNjjGs/BhWCp
         anPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K73t3MijmaP5WZR+UD3aFUTf8A/lftEBX+dz2OGt4NbpEOJTTVjvUotgx03zKsVW3SvWe@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmY73dlsooszuu9SHzI3KkudNC6PmTTBYJVgf1fNp+xZBkJO8
	72HM2xv3hNXBk5/NpnAZGHLOU3hAk09WVVHGrPUEFSIWg5feSbnpEj8z5hn4k+MIM2AP+n2+GI7
	jwoDwCVSQDVTemaowPqNd3fEEvKt7g1mX4dRkxT1HX+8yKC2d4y0OyigD
X-Gm-Gg: AeBDiesqwzJLl68atpgHIdfUYELgfK+0xU7she1RE9Sw+pbunq6ZcdVVLFZaYvaLIl8
	T9gUvLS+/WdnahJSXVhJjN5zPjIWOGnohH3biNQGx0WhU8qwJISVjejXo1TLoekAIvldx70TtTW
	SUefepgYU2Zt4LriomnL0JCbHe0X7tgJMfc/QXaQkv+mNHo71utensduFOLm3a+K52LCF9+vF5l
	Wcg1VHA/PeuDZdVPqW1ZuCk80bawHhxgjX0apZTFYlXnmI3CXMby+guxVcZMiI4T9wo6TZZ/pnu
	tPIl31MN2LLNqnh78xhOZWsTYmJjGESVfd5ElYW3+PVd1XEgJkg7iWM9gdXtGn5XWDwA0Su/CZ5
	SDyGOax06hYmVhqUdkSBNzsJFdTPYmbFcQVZMi4gbVPDw0P7zWVN70k47LWh8a5WVyJ/BSedLwT
	NqMEOMZdH922C1Zgo=
X-Received: by 2002:a05:622a:13:b0:50f:c133:2dc6 with SMTP id d75a77b69052e-50fc133323amr127282181cf.19.1776989842314;
        Thu, 23 Apr 2026 17:17:22 -0700 (PDT)
X-Received: by 2002:a05:622a:13:b0:50f:c133:2dc6 with SMTP id d75a77b69052e-50fc133323amr127281781cf.19.1776989841871;
        Thu, 23 Apr 2026 17:17:21 -0700 (PDT)
Received: from ?IPV6:2603:6010:dc00:1e:d86b:f24:8c42:afc9? ([2603:6010:dc00:1e:d86b:f24:8c42:afc9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392e4db4sm170825181cf.11.2026.04.23.17.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 17:17:20 -0700 (PDT)
Message-ID: <aa17c927-f25e-4556-88df-df9cb0aba199@case.edu>
Date: Thu, 23 Apr 2026 20:17:18 -0400
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu, "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: stty -echo doesn't work?
Content-Language: en-US
To: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
References: <aemGV--9_pn_ABU2@HQ>
 <b7d62511-4a17-427e-ab7b-468f9896e6de@gigawatt.nl> <aeqQ-ExEzduLIW3W@HQ>
From: Chet Ramey <chet.ramey@case.edu>
Autocrypt: addr=chet.ramey@case.edu; keydata=
 xsDiBEEOsGwRBACFa0A1oa71HSZLWxAx0svXzhOZNQZOzqHmSuGOG92jIpQpr8DpvgRh40Yp
 AwdcXb8QG1J5yGAKeevNE1zCFaA725vGSdHUyypHouV0xoWwukYO6qlyyX+2BZU+okBUqoWQ
 koWxiYaCSfzB2Ln7pmdys1fJhcgBKf3VjWCjd2XJTwCgoFJOwyBFJdugjfwjSoRSwDOIMf0D
 /iQKqlWhIO1LGpMrGX0il0/x4zj0NAcSwAk7LaPZbN4UPjn5pqGEHBlf1+xDDQCkAoZ/VqES
 GZragl4VqJfxBr29Ag0UDvNbUbXoxQsARdero1M8GiAIRc50hj7HXFoERwenbNDJL86GPLAQ
 OTGOCa4W2o29nFfFjQrsrrYHzVtyA/9oyKvTeEMJ7NA3VJdWcmn7gOu0FxEmSNhSoV1T4vP2
 1Wf7f5niCCRKQLNyUy0wEApQi4tSysdz+AbgAc0b/bHYVzIf2uO2lIEZQNNt+3g2bmXgloWm
 W5fsm/di50Gm1l1Na63d3RZ00SeFQos6WEwLUHEB0yp6KXluXLLIZitEJM0wQ2hldCBSYW1l
 eSAoQ2FzZSBzdGFuZGFyZCkgPGNoZXQucmFtZXlAY2FzZS5lZHU+wl8EExECAB8FAkPi19EC
 GwMHCwkIBwMCAQMVAgMDFgIBAh4BAheAAAoJELtYafBk6nSrelkAn31Gsuib7GcCZHbv5L5t
 VKYR9LklAJ4hzUHKA49Z0QXR+qCb80osIcmPSc7ATQRBDrBvEAQAkK6TAOKBEM+EC4j6V/7o
 /riVZqcgU5cid2qG9TXdwNtD9a3kvA/ObZBO93sX59wc6Bnwo4VJxsOmMlpGrAjJsxNwg3QH
 akEtf8LXRbVpj5xStdmBdQZUhIQyalo/2/TZq5OijtddUQcL5cs70hTv/FpT3wUvr2Xr8rjF
 41IFEz8AAwcD/A0CZEGlzIrT5WCBnl6xBog/8vKiUCbarByat3d1mL6DbizvKNXQRTC9E/vE
 dENAWCQCjr75Bu55xT8n3SXGtWdDC5xmZ/P3OBYORP8yl8H8I1FIosWOFirbIeYdZPq8SPD1
 HL+EXo9zSiHVrrZRJ19ooCKKbSdXHFCY+aJG+0KZwkkEGBECAAkFAkEOsG8CGwwACgkQu1hp
 8GTqdKvjcACfZlkVCDwaz/NTO9cy3t69oWpVPNwAnRwe0qk/WL/gfhH346xh5B3HFbFN
Organization: ITS, Case Western Reserve University
In-Reply-To: <aeqQ-ExEzduLIW3W@HQ>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7P0653UIEr5njOMWSwuc005L"
X-Mirapoint-Received-SPF: 209.85.160.200 mail-qt1-f200.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.211 mpv-in-cfd-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=10/90, host=mpv-out-ksl-1.case.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A2D030A.69EAB694.0009,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
	ip=0.0.0.0,
	so=2016-11-06 16:00:04,
	dmn=2013-03-21 17:37:32,
	mode=single engine
X-Junkmail-IWF: false

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7P0653UIEr5njOMWSwuc005L
Content-Type: multipart/mixed; boundary="------------G1bJ0GrTVRHUYtRaO8WIKwP7";
 protected-headers="v1"
From: Chet Ramey <chet.ramey@case.edu>
Reply-To: chet.ramey@case.edu
To: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
Cc: chet.ramey@case.edu, "dash@vger.kernel.org" <dash@vger.kernel.org>
Message-ID: <aa17c927-f25e-4556-88df-df9cb0aba199@case.edu>
Subject: Re: stty -echo doesn't work?
References: <aemGV--9_pn_ABU2@HQ>
 <b7d62511-4a17-427e-ab7b-468f9896e6de@gigawatt.nl> <aeqQ-ExEzduLIW3W@HQ>
In-Reply-To: <aeqQ-ExEzduLIW3W@HQ>

--------------G1bJ0GrTVRHUYtRaO8WIKwP7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yMy8yNiA1OjM2IFBNLCBTZWJhc3RpZW4gUGV0ZXJzb24tQm91ZHJlYXUgd3JvdGU6
DQo+PiBzdHR5IGlzIG5vdCBhIHNoZWxsIGJ1aWx0LWluIGNvbW1hbmQgYW5kIGRhc2ggaGFz
IG5vIGNvbnRyb2wgb3ZlciB3aGF0IGl0DQo+PiBkb2VzLg0KPiANCj4gSSBrbmV3IHRoYXQs
IGJ1dCB0aGlzIHdhcyBzdGlsbCBhIGJlaGF2aW91ciBJIHdhcyBvbmx5IHNlZWluZyBpbiBk
YXNoDQo+IGFuZCBub3Qgb3RoZXIgc2hlbGxzLg0KDQpMZXQncyBzZWUgaWYgSSBjYW4gZXhw
bGFpbiB3aGF0IG90aGVyIHNoZWxscyBhcmUgZG9pbmcuDQoNCj4gSSByZWFsbHkgc2hvdWxk
IGhhdmUgZG9uZSBtb3JlIHRob3JvdWdoIHRlc3RpbmcuLi4gWW91J3JlIHJpZ2h0OyBJIHNl
ZQ0KPiB0aGF0IGVjaG8gaXMgZGlzYWJsZWQgd2hlbiBJIHRyeQ0KPiANCj4gCSQgc3R0eSAt
ZWNobzsgY2F0ID4gZm9vDQo+IA0KPiBGb3IgdGhlIGR1cmF0aW9uIG9mIGNhdCgxKSAoSU9X
LCB1bnRpbCBJIGhpdCBeRCksIHRoZSB0ZXJtaW5hbCBkb2VzIG5vdA0KPiBlY2hvLCBidXQg
dXBvbiByZXR1cm5pbmcgdG8gdGhlIHNoZWxsIGVjaG8gaXMgcmVzdG9yZWQuDQpUaGUgYGNh
dCcgYmVoYXZpb3IgaXMgY29uc2lzdGVudCB3aXRoIGhvdyBQT1NJWCBkZXNjcmliZXMgYHN0
dHkgZWNobyc6DQoNCmVjaG8gKC1lY2hvKQ0KICAgICBFY2hvIGJhY2sgKGRvIG5vdCBlY2hv
IGJhY2spIGV2ZXJ5IGNoYXJhY3RlciB0eXBlZC4gVGhpcyBzaGFsbCBoYXZlIA0KdGhlIGVm
ZmVjdCBvZiBzZXR0aW5nIChub3Qgc2V0dGluZykgRUNITyBpbiB0aGUgdGVybWlvcyBjX2xm
bGFnIGZpZWxkLCBhcyANCmRlZmluZWQgaW4gWEJEIDExLiBHZW5lcmFsIFRlcm1pbmFsIElu
dGVyZmFjZS4NCg0KU28gdGhlIGBlY2hvJyBzdWJvcHRpb24gb25seSBjb250cm9scyBlY2hv
aW5nIG9mIGlucHV0LiBJZiBkYXNoLCB3aGVuDQp1c2luZyBsaWJlZGl0IGFuZCB3aXRoIGVk
aXRpbmcgZW5hYmxlZCAoZS5nLiwgYHNldCAtbyBlbWFjcycpLCByZXN0b3Jlcw0KZWNobyB3
aGVuIHJlYWRpbmcgdGhlIGNvbW1hbmQgbGluZSwgaXQgd291bGQgYXBwZWFyIHRoYXQgbGli
ZWRpdCBpcw0KZm9yY2luZyBhIGtub3duIHNldCBvZiB0dHkgZmxhZ3MuDQoNCj4+IFdoYXQg
YmVoYXZpb3VyIGFyZSB5b3UgZXhwZWN0aW5nIGhlcmU/IEFyZSB5b3UgZXhwZWN0aW5nIGVj
aG8gdG8gc3RpbGwgYmUNCj4+IHR1cm5lZCBvZmYgd2hlbiBlbnRlcmluZyB0aGUgbmV4dCBj
b21tYW5kLCBvciB0byBiZSB0dXJuZWQgb2ZmIGFnYWluIGFmdGVyDQo+PiB0aGUgbmV4dCBj
b21tYW5kIGhhcyBiZWVuIGVudGVyZWQgc3VjY2Vzc2Z1bGx5PyBCb3RoIG9wdGlvbnMsIGFz
IHdlbGwgYXMNCj4+IGRhc2gvbGliZWRpdCdzIGN1cnJlbnQgYmVoYXZpb3VyLCBzZWVtIHJl
YXNvbmFibGUgYXQgZmlyc3QgZ2xhbmNlIHRvIG1lLg0KPiANCj4gQXNzdW1pbmcgSSBhbSB1
bmRlcnN0YW5kaW5nIHRoZSB0d28gb3B0aW9ucyB5b3UgbGlzdCwgSSB0aGluayB3aGF0IEkN
Cj4gZXhwZWN0ZWQgd2FzIHRoZSBzZWNvbmQ/IEZvciBiYXNoLCB0aGUgdXNlciBpbnB1dCBp
cyBub3QgZWNob2VkIHVudGlsDQo+IGVjaG8gaXMgcmVzdG9yZWQgd2l0aCBgc3R0eSBlY2hv
JywgYnV0IHRoZSBwcm9tcHQgaXMgc3RpbGwgcHJpbnRlZA0KPiBhZnRlciBlYWNoIGNvbW1h
bmQgaXMgZW50ZXJlZC4gDQoNClRoaXMgaXMgY29uc2lzdGVudCB3aXRoIHRoZSBhYm92ZSBk
ZXNjcmlwdGlvbjogb3V0cHV0IGlzIG5vdCBzdXBwcmVzc2VkLA0KYnV0IGlucHV0IGlzIG5v
dCBlY2hvZWQuDQoNCklmIHlvdSB3ZXJlIHRvIGNoYW5nZSB5b3VyIGV4YW1wbGUgYWJvdmUg
dG8gZG8gc29tZXRoaW5nIGxpa2UNCg0Kc3R0eSAtZWNobw0KZWNobyAtbiAnZW50ZXIgZGF0
YTogJw0KY2F0ID4gZm9vDQpzdHR5IGVjaG8NCg0KWW91J2xsIHNlZSB0aGF0IHRoZSBgZWNo
byBkYXRhOiAnIGlzIHZpc2libGUsIGJ1dCB1c2VyIGlucHV0IGlzIG5vdCwNCmFuZCB0aGUg
YmFzaCBiZWhhdmlvciBpcyBjb25zaXN0ZW50IHdpdGggdGhhdC4NCg0KDQo+IFRvIG1ha2Ug
bXlzZWxmIGV4dHJlbWVseSBjbGVhciAobm90DQo+IGJlY2F1c2UgSSBkb24ndCB0aGluayB5
b3UncmUgY2FwYWJsZSBvZiB1bmRlcnN0YW5kaW5nLCBidXQgYmVjYXVzZSBJDQo+IGRvbid0
IHRoaW5rIEknbSBjYXBhYmxlIG9mIGV4cGxhaW5pbmcuLi4pLCBJIHdpbGwgZG8gYSBsaWwg
ZGlhZ3JhbSB0aGluZw0KPiANCj4gCSQgZWNobyBoaQ0KPiAJaGkNCj4gCSQgc3R0eSAtZWNo
bw0KPiAJJCAgICAgICAgICAgICMgdXNlciB0eXBlcyBgZWNobyBub3QgZWNob2VkJywgYnV0
IGl0IGlzIG5vdCBzaG93bg0KPiAJbm90IGVjaG9lZA0KPiAJJCAgICAgICAgICAgICMgdXNl
ciB0eXBlcyBgc3R0eSBlY2hvJywgYnV0IGl0IGlzIG5vdCBzaG93bg0KPiAJJCBlY2hvIGhp
IGFnYWluDQo+IAloaSBhZ2Fpbg0KPiANCj4gbm93IHRoYXQgaXMgd2hhdCBJIF9leHBlY3Rl
ZF8gdG8gaGFwcGVuLCBidXQgdGhhdCBpcyBiYXNlZCBvbiBiYXNoJ3MNCj4gYmVoYXZpb3Vy
LCB3aGljaCBpcyBiYXNlZCBvbiByZWFkbGluZSAod2hhdCBiYXNoIHVzZXMgKEkgdGhpbms/
KSkuDQoNCkl0IGRvZXMuDQoNCj4gV2hhdA0KPiBkbyBJIHRoaW5rIF9zaG91bGRfIGhhcHBl
bj8gDQoNCkRvIHlvdSB0aGluayB0aGF0IHRoZSBlZGl0aW5nIGxpYnJhcnkgc2hvdWxkIGhv
bm9yIHRoZSB1c2VyJ3MgdHR5IHNldHRpbmdzDQptb2RpZmllZCB1c2luZyBgc3R0eScsIHVz
ZSBpdHMgb3duIGludGVybmFsIGBzYW5lJyBzZXR0aW5ncyB0byBwcm92aWRlDQpjb25zaXN0
ZW50IGJlaGF2aW9yLCBvciB1c2UgaW50ZXJuYWwgc2V0dGluZ3Mgc2VwYXJhdGUgZnJvbSB0
aGUgb25lcyBzZXQNCnVzaW5nIGBzdHR5JyBidXQgcHJvdmlkZSBhIHNoZWxsIGJ1aWx0aW4g
dGhhdCBhbGxvd3MgdXNlcnMgdG8gbW9kaWZ5IHRob3NlDQppbnRlcm5hbCBzZXR0aW5ncyAo
ZS5nLiwgdGNzaCdzIGBzZXR0eScpPw0KDQpBbGwgb2YgdGhlc2UgYXJlIHJlYXNvbmFibGUg
Y2hvaWNlcyB0aGF0IGRpZmZlcmVudCBzaGVsbHMgaGF2ZSBtYWRlLg0KUmVhZGxpbmUsIG9i
dmlvdXNseSwgdXNlcyB0aGUgZmlyc3Qgb3B0aW9uLg0KDQo+IFdlbGwgbm93IEkgZmVlbCBs
aWtlIEkgbWlnaHQgbmVlZCB0byBkbw0KPiBzb21lIG1vcmUgcmVzZWFyY2guIE1heWJlIHRo
aXMgaXMgYSBzaXR1YXRpb24gd2hlcmUgYmFzaCBkb2VzIHNvbWV0aGluZw0KPiB3ZWlyZCBi
dXQgd2UncmUgYWxsIHVzZWQgdG8gaXQuDQoNCkkgd291bGQgYXJndWUgb3RoZXJ3aXNlLCBv
ZiBjb3Vyc2UuDQoNCi0tIA0KYGBUaGUgbHlmIHNvIHNob3J0LCB0aGUgY3JhZnQgc28gbG9u
ZyB0byBsZXJuZS4nJyAtIENoYXVjZXINCgkJIGBgQXJzIGxvbmdhLCB2aXRhIGJyZXZpcycn
IC0gSGlwcG9jcmF0ZXMNCkNoZXQgUmFtZXksIFVUZWNoLCBDV1JVICAgIGNoZXRAY2FzZS5l
ZHUgICAgaHR0cDovL3Rpc3d3dy5jd3J1LmVkdS9+Y2hldC8NCg==

--------------G1bJ0GrTVRHUYtRaO8WIKwP7--

--------------7P0653UIEr5njOMWSwuc005L
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmIEABEIACMWIQR8ATX7CIqvbGbGULm7WGnwZOp0qwUCaeq2jwUDAAAAAAAKCRC7WGnwZOp0qwKr
AJdw1gB5MdL0b87gm+Ia/KEiJms1AJ9mbJuiOXUG1EeCKRGz49XucW0mWQ==
=snMm
-----END PGP SIGNATURE-----

--------------7P0653UIEr5njOMWSwuc005L--
