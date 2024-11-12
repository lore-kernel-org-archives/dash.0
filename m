Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242382185AD
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451727; cv=none; b=mczOtdq3qHV8TboAp9dHzkK/uYnfCv031RtL4p4CuemcYYwPc9noYSManNkPmvqNjnH3A5aw0hW0CIg64TZkde3i7WKHF7QSthXsGnMM7jrt+HY3kZvc3ve6axoVbBeF6rsu+9KjV/FOpmPPNcajFaXvbDLSojUpJVPBGYMUWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451727; c=relaxed/simple;
	bh=4G4j6tKLfB5qYwVY1gERoxKVAMz/A4HaSa8Sg97+Oo4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=hqvRA4/f6VTGvLN+MOydUqO2ccFSdG2e+81lcegvB1xc/qnzZVachnNCWy/M5W/DqV/aJ+2s4nU8nPWv4MQs1hFiVSR5MBYjPrXrDbJU0mq2uqlkAVJESX5PZ+s4s59eOyL65u7FBqrzfBfbzdKYfo/H801sEcPBdIJu7M8swhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMlXTG4067260
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:47:34 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMlVDu077954
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:47:33 +0100
Content-Type: multipart/mixed; boundary="------------kV8WXf69grzWeORqBruJxtDF"
Message-ID: <a8796158-3bf1-4a48-87ca-a01628307f3e@knaff.lu>
Date: Tue, 12 Nov 2024 23:47:31 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 13-wait3-replacement
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
Content-Language: en-US
From: Alain Knaff <alain@knaff.lu>
Autocrypt: addr=alain@knaff.lu; keydata=
 xsDiBEk9qFcRBADO4trPtib39qvAEBlkAIcBGnZ137EmmNLU1pFZC5acLyJ4wYhVdcol97lC
 4ZkD0DJek6DVidQfz4hA7JbZy2W8l6O/o2k/Ja2bWkb8qtrcUNVDJzdJjNqXmmxdsyLd5QVt
 uCHgi3Zz0kq9aJnRCVuAyfrjMdaUsOThi07u1EyEywCgjxVKODAifumqfdjVxS5NoV7x7TkD
 /0k2F3/5/NYchgLz6Qu3As5MVtPs7NkJ0Mpal4Gy8CaKefHcynY+zCziM/oBw0+PIFxyFud0
 uT9HRIdEp1DlaTTUYlt95HeDYmCUh0Wt1PwNNRWcm+vTUuK7tOxzYadUqbzO+F6C+WN8msxA
 hcxzUgsL/YyXVilvL8XqB+RlS5bBA/9OxXc2mJs01nWu5khvVFNwUCDS8FRYyoHeodVZFGLC
 UG1PrV9nHva5vYJk1QlZP3qEotnK+6l4708X9yhdw2+UCtxvseTQ6JWBtIdJyo+Qv7apSQA3
 kkau6Om7SOyW1i/2LcCZU84SC923uBH7VNeUzCnzelVFubk6eRwzjNvrj80cQUxBSU4gS05B
 RkYgPGFsYWluQGtuYWZmLmx1PsJgBBMRAgAgBQJJPahXAhsDBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQyAYxsm9DGWFEsgCeOSavzyOp8Bj3nOP8hC6XeCX/3k4Anj0KegsyeIVxuj5X
 TUnh535vXfZvzsFNBEk9qFoQCACt2vctXYAr+ndRbaeR4ygJ8rKH8ARu68nDuQuxOKCasaQr
 xm8+/RxvmTfriP00tYZAca2tmCjwntKVsK4eNSivvo6c7BwziCnQx/vW+kJK4ctckMHSZPqe
 4a1HWYURg5oxaqGo4f06YAn9O0yDo6xdGGNUMpYHv2O1/jsAEgAM/c/US+gNctzsNKQ4lVwp
 HH4NEabev+zlisnTO3V39iXijZbe9AYlD4qZH/0nFBDCCt9EDTe+/6IFfvIrnVx7o367U9XL
 SCLVQt4k7xqCIow7RP5BlOYLDV50yMva8c62yhWpDYKSyJsQGn/nGiiv6P4Ye/monfkQD+PC
 nKPXDYCjAAMFB/9D2FSYHyikvOoXXMTfjGHUyIQK6FCtKINTFfBPuwlWOWCukrQrzH0BmTVC
 /WuMOrrmxl0IFHGtOV2Zp+bdsjhlzgZ4kXAmqw1Qiphb/YLD6VY5TQ59Tkl7+nCQ0wjcRim1
 Sg6OzmoNttHpTt9eAvLZMz7yi9Nq40yKXh+zXZtzHIgdsXG+tO9+LEWojdbXgIdZin2yUKYt
 KxbpwyM0qCN9oGtKTAi0GX+tuHdAqWwYEgVnd27LcBGLTs6QJPsjQKHiAtYJwu6MWiF7bvCr
 iBNyVG3yU3inZcQvIdYxO0VUN3wVSEIbRHcNzG2u1UD6ZuF+3bv39dh54m1CQzbzzRepwkkE
 GBECAAkFAkk9qFoCGwwACgkQyAYxsm9DGWHNLwCfWr4DLrBZMktv9RTGbcIZ+/NgTswAn3aG
 LBuTFPDEO0bfA+7PlpCctCJT
In-Reply-To: <ZhDq9L88eTrLxlWW@gondor.apana.org.au>

This is a multi-part message in MIME format.
--------------kV8WXf69grzWeORqBruJxtDF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The 13th patch caters to unavailability of wait3() system call on older
SYSV systems such as UnixPC.

On these systems, only an always blocking wait() is available. In
order to get non-blocking wait, you have to use a SIGCLD handler (not
a typo, child signal handling on SYSV was subtly different from what
we are used to now). This handler sets a flag (gotsigchld) when a
child dies.

When upper layers request a non-blocking wait, we test for this
flag. If the gotsigchld flag is set, we can wait(), confident in the
knowledge that this call will return right away. Then clear the flag,
and re-instore SIGCLD handler.
If the gotsigchld flag is not set, we return right away with 0 ("process
does have children, but none have exited so far")


The "subtle difference" between SIGCLD and SIGCHLD is that SIGCLD is
"level triggered": i.e. the system continues raising the signal as long
as there is a terminated child around on which the parent has not yet
waited. Thus, SIGCLD should not be re-enabled in the handler, but only
after wait()

https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xsh_chap02.html

"Some implementations (System V, for example) will deliver a SIGCLD
signal immediately when a process establishes a signal-catching
function for SIGCLD when that process has a child that has already
terminated. Other implementations, such as 4.3 BSD, do not generate a
new SIGCHLD signal in this way. In general, a process should not
attempt to alter the signal action for the SIGCHLD signal while it has
any outstanding children. However, it is not always possible for a
process to avoid this; for example, shells sometimes start up
processes in pipelines with other processes from the pipeline as
children. Processes that cannot ensure that they have no children when
altering the signal action for SIGCHLD thus need to be prepared for,
but not depend on, generation of an immediate SIGCHLD signal."

Actually, in a way we do "depend on" this peculiarity to implement
non-blocking wait(). However, if it is not available, the only thing
that breaks is "monitor mode" (notification of terminated children
when pressing return in an interactive shell).

Regards,

Alain
--------------kV8WXf69grzWeORqBruJxtDF
Content-Type: text/x-patch; charset=UTF-8;
 name="dash-0.5.12+13-wait3-replacement.diff"
Content-Disposition: attachment;
 filename="dash-0.5.12+13-wait3-replacement.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzEyLXNpZ2FjdGlvbi9j
b25maWd1cmUuYWMgZGFzaC0wLjUuMTIrMTMtd2FpdDMtcmVwbGFjZW1lbnQvY29uZmlndXJl
LmFjCi0tLSBkYXNoLTAuNS4xMisxMi1zaWdhY3Rpb24vY29uZmlndXJlLmFjCTIwMjQtMTEt
MTAgMTc6MDg6MDEuMTU1MDI1ODg4ICswMDAwCisrKyBkYXNoLTAuNS4xMisxMy13YWl0My1y
ZXBsYWNlbWVudC9jb25maWd1cmUuYWMJMjAyNC0xMS0xMCAyMDoyNjoxOS4xMDU0NzQyMTUg
KzAwMDAKQEAgLTExNyw3ICsxMTcsNyBAQAogCSAgICAgICBtZW1wY3B5IG1lbW1vdmUgXAog
CSAgICAgICBzaWdzZXRtYXNrIHN0cGNweSBzdHJjaHJudWwgc3Ryc2lnbmFsIHN0cnRvZCBz
dHJ0b2ltYXggXAogCSAgICAgICBzdHJ0b3VtYXggc3lzY29uZiBcCi0JICAgICAgIHZmb3Jr
IHNpZ2FjdGlvbiBzaWdwcm9jbWFzayBsc3RhdCBkdXAyIGdldGdyb3VwcyBcCisJICAgICAg
IHZmb3JrIHdhaXQzIHNpZ2FjdGlvbiBzaWdwcm9jbWFzayBsc3RhdCBkdXAyIGdldGdyb3Vw
cyBcCiAJICAgICAgIHN0cnN0ciBzdHBuY3B5IHN0cmNhc2VjbXAgc3RyZXJyb3Igc3RyZHVw
IHN0cnRvdWwgdnNucHJpbnRmIFwKIAkgICAgICAgcmVhZGRpcikKIApkaWZmIC1YIC4uL2V4
Y2x1ZGUudHh0IC11ck4gZGFzaC0wLjUuMTIrMTItc2lnYWN0aW9uL3NyYy9qb2JzLmMgZGFz
aC0wLjUuMTIrMTMtd2FpdDMtcmVwbGFjZW1lbnQvc3JjL2pvYnMuYwotLS0gZGFzaC0wLjUu
MTIrMTItc2lnYWN0aW9uL3NyYy9qb2JzLmMJMjAyNC0xMC0yNyAyMDoxOToxMy42MjUyMzE1
ODAgKzAwMDAKKysrIGRhc2gtMC41LjEyKzEzLXdhaXQzLXJlcGxhY2VtZW50L3NyYy9qb2Jz
LmMJMjAyNC0xMS0xMCAyMTo1MTo1NS45MTE1MTk2OTYgKzAwMDAKQEAgLTExNTQsNiArMTE1
NCw1MCBAQAogCXJldHVybiBycGlkOwogfQogCisjaWZuZGVmIEhBVkVfV0FJVDMKKworIyBp
Zm5kZWYgV05PSEFORworIyAgZGVmaW5lIFdOT0hBTkcgMQorIyBlbmRpZgorCisvKiBSZXBs
YWNlbWVudCB3YWl0MyAqLworU1RBVElDIGlubGluZSBwaWRfdAord2FpdDMoaW50ICp3c3Rh
dHVzLCBpbnQgb3B0aW9ucywgdm9pZCAqIHJ1c2FnZSkKK3sKKwlwaWRfdCBwaWQ7CisKKwkv
KiBpZiB3ZSBhcmUgY2FsbGVkIGFzIG5vbi1ibG9ja2luZywgYW5kIGhhdmUgbm8gU0lHQ0xE
CisJICAgcGVuZGluZywgcmV0dXJuICovCisJaWYoKG9wdGlvbnMgJiBXTk9IQU5HKSAmJiAh
Z290c2lnY2hsZCkKKwkJcmV0dXJuIDA7IC8qIDAgaXMgcmV0dXJuZWQgYnkgd2FpdDMgaWYg
dGhlIHByb2Nlc3MgZG9lcyBoYXZlCisJCQkgICAqIGNoaWxkcmVuLCBidXQgbm9uZSBoYXZl
IGV4aXRlZCBzbyBmYXIgKi8KKwlwaWQgPSB3YWl0KHdzdGF0dXMpOworCWlmKHBpZCA8PSAw
KQorCQkvKiBubyBwcm9jZXNzIHJlYXBlZCwgb3IgZXJyb3IgKi8KKwkJcmV0dXJuIHBpZDsK
KworCQorCS8qIGlmIHdlIGNvbWUgaGVyZSwgd2UgZGlkIGluZGVlZCByZWFwIGEgcHJvY2Vz
cy4gID0+CisJICogY2xlYXIgZ290c2lnY2hsZCwgYW5kIHJlLWluc3RvcmUgU0lHQ0xEIGhh
bmRsZXIuCisJICoKKwkgKiBPbiBvbGQgU1lTViBzeXN0ZW1zIHdoZXJlIHRoZXJlIGlzIG5v
IHdhaXQzIGNhbGwsCisJICogc2lnbmFsKFNJR0NMRCkgaXMgbGV2ZWwtdHJpZ2dlcmVkLCBh
bmQgd2lsbCB0cmlnZ2VyIGFzCisJICogbG9uZyBhcyB0aGVyZSBhcmUgc3RpbGwgdW53YWl0
ZWQtZm9yIGNoaWxkcmVuCisJICogYXJvdW5kLiBIb3dldmVyLCBpdCBpcywgbGlrZSBhbGwg
b3RoZXIgc2lnbmFscywgZGlzYWJsZWQgYXMKKwkgKiBzb29uIGFzIGl0cyBzaWduYWwgaGFu
ZGxlciBpcyBpbnZva2VkLCB3aGljaCBwcmV2ZW50cyBzdG9ybQorCSAqIDotKS4gU28gd2Ug
bmVlZCB0byByZS1lbmFibGUgaXQgYWZ0ZXIgd2FpdCgpLCBpbiBvcmRlciB0bworCSAqIGJl
IG5vdGlmaWVkIG9mIGZ1cnRoZXIgY2hpbGRyZW4gZHlpbmcuCisJICoKKwkgKiBJZiBtb3Jl
IHRoYW4gb25lIGNoaWxkIGhhZCBkaWVkIHNpbmNlIGxhc3QgcmVzZXQgb2YKKwkgKiBnb3Rz
aWdjaGxkLCBhIHNpZ25hbCB3aWxsIGJlIGRlbGl2ZXJlZCBpbW1lZGlhdGVseSBhZnRlcgor
CSAqIHJlLWFjdGl2YXRpb24gb2YgdGhlIHNpZ25hbCwgYmVjYXVzZSBpdCBpcyBsZXZlbC10
cmlnZ2VyZWQuCisJICovCisJZ290c2lnY2hsZCA9IDA7CisJc2V0c2lnbmFsKFNJR0NMRCk7
CisJcmV0dXJuIHBpZDsKK30KKyNlbmRpZgorCiAvKgogICogRG8gYSB3YWl0IHN5c3RlbSBj
YWxsLiAgSWYgYmxvY2sgaXMgemVybywgd2UgcmV0dXJuIC0xIHJhdGhlciB0aGFuCiAgKiBi
bG9ja2luZy4gIElmIGJsb2NrIGlzIERPV0FJVF9XQUlUQ01ELCB3ZSByZXR1cm4gMCB3aGVu
IGEgc2lnbmFsCkBAIC0xMTgyLDcgKzEyMjYsMTUgQEAKICNlbmRpZgogCiAJZG8geworI2lm
ZGVmIEhBVkVfV0FJVDMKKwkJLyogcmVzZXQgZ290c2lnY2hsZCAqb25seSogaWYgd2UgYXJl
IG5vdCB1c2luZyBhCisJCSAqIHJlcGxhY2VtZW50IHdhaXQzKCkuIEluZGVlZCwgdGhlIHJl
cGxhY2VtZW50CisJCSAqIHdhaXQzKCkgbmVlZHMgb3JpZ2luYWwgdmFsdWUgb2YgZ290c2ln
Y2hsZCBpbiBvcmRlcgorCQkgKiB0byBkZWNpZGUgd2hldGhlciBpdCBkb2VzIGluZGVlZCBu
ZWVkIHRvCisJCSAqIHdhaXQuIFJlcGxhY2VtZW50IHdhaXQzIHdpbGwgdGhlbiByZXNldCBn
b3RzaWdjaGxkCisJCSAqIHdoZW4gZG9uZSB3aXRoIGl0ICovCiAJCWdvdHNpZ2NobGQgPSAw
OworI2VuZGlmCiAJCWRvCiAJCQllcnIgPSB3YWl0MyhzdGF0dXMsIGZsYWdzLCBOVUxMKTsK
IAkJd2hpbGUgKGVyciA8IDAgJiYgZXJybm8gPT0gRUlOVFIgJiYgIXBlbmRpbmdfc2lnKTsK
ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzEyLXNpZ2FjdGlvbi9z
cmMvc3lzdGVtLmggZGFzaC0wLjUuMTIrMTMtd2FpdDMtcmVwbGFjZW1lbnQvc3JjL3N5c3Rl
bS5oCi0tLSBkYXNoLTAuNS4xMisxMi1zaWdhY3Rpb24vc3JjL3N5c3RlbS5oCTIwMjQtMTEt
MTAgMTY6MjY6NDcuNDY0MTY2OTk5ICswMDAwCisrKyBkYXNoLTAuNS4xMisxMy13YWl0My1y
ZXBsYWNlbWVudC9zcmMvc3lzdGVtLmgJMjAyNC0xMS0xMCAxNDo1MzowOC40MTg2MTgwOTAg
KzAwMDAKQEAgLTE1OSw2ICsxNTksMTAgQEAKICMgZGVmaW5lIE9fTk9OQkxPQ0sgT19OREVM
QVkKICNlbmRpZgogCisjaWYgIWRlZmluZWQgU0lHQ0hMRCAmJiBkZWZpbmVkIFNJR0NMRAor
IyBkZWZpbmUgU0lHQ0hMRCBTSUdDTEQKKyNlbmRpZgorCiAjaWZuZGVmIEZEX0NMT0VYRUMK
ICMgZGVmaW5lIEZEX0NMT0VYRUMgMQogI2VuZGlmCmRpZmYgLVggLi4vZXhjbHVkZS50eHQg
LXVyTiBkYXNoLTAuNS4xMisxMi1zaWdhY3Rpb24vc3JjL3RyYXAuYyBkYXNoLTAuNS4xMisx
My13YWl0My1yZXBsYWNlbWVudC9zcmMvdHJhcC5jCi0tLSBkYXNoLTAuNS4xMisxMi1zaWdh
Y3Rpb24vc3JjL3RyYXAuYwkyMDI0LTExLTEwIDIwOjI2OjQ0LjIyMjA3MTE1OCArMDAwMAor
KysgZGFzaC0wLjUuMTIrMTMtd2FpdDMtcmVwbGFjZW1lbnQvc3JjL3RyYXAuYwkyMDI0LTEx
LTEwIDIwOjI3OjQxLjA1NTQyMTkwMyArMDAwMApAQCAtNTMsNiArNTMsNyBAQAogI2luY2x1
ZGUgImVycm9yLmgiCiAjaW5jbHVkZSAidHJhcC5oIgogI2luY2x1ZGUgIm15c3RyaW5nLmgi
CisjaW5jbHVkZSAic3lzdGVtLmgiCiAKIC8qCiAgKiBTaWdtb2RlIHJlY29yZHMgdGhlIGN1
cnJlbnQgdmFsdWUgb2YgdGhlIHNpZ25hbCBoYW5kbGVycyBmb3IgdGhlIHZhcmlvdXMKQEAg
LTg3LDYgKzg4LDcgQEAKICNpZmRlZiBta2luaXQKIElOQ0xVREUgIm1lbWFsbG9jLmgiCiBJ
TkNMVURFICJ0cmFwLmgiCitJTkNMVURFICJzeXN0ZW0uaCIKIAogSU5JVCB7CiAJc2lnbW9k
ZVtTSUdDSExEIC0gMV0gPSBTX0RGTDsKQEAgLTMwMiw3ICszMDQsMTAgQEAKIG9uc2lnKGlu
dCBzaWdubykKIHsKICNpZm5kZWYgSEFWRV9TSUdBQ1RJT04KLQlzaWduYWwoc2lnbm8sIG9u
c2lnKTsKKyNpZmRlZiBTSUdDTEQKKwlpZihzaWdubyAhPSBTSUdDTEQpCisjZW5kaWYKKwkJ
c2lnbmFsKHNpZ25vLCBvbnNpZyk7CiAjZW5kaWYKIAlpZiAodmZvcmtlZCkKIAkJcmV0dXJu
Owo=

--------------kV8WXf69grzWeORqBruJxtDF--
