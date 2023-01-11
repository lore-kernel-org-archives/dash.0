Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7617FC54EBC
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 18:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjAKS7p (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 11 Jan 2023 13:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjAKS7h (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 11 Jan 2023 13:59:37 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADF123D1D7
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 10:59:35 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C80671214
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 18:59:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C80671214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673463571;
        bh=7/dO99ZzrpXYp2VB7Yrj8u9cDZbzHP7r/Tmhetg3bxA=; l=6598;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=PCuQ2RkbtTgDSIwaJ82ecJUDC+/zY15UVtRFV0EcguZ56JYTlKwsRn2fp1yDRPSpd
         XNINkQnwlsQbx4Rf9b44YOtHe4og43s/uSgS6JwRUIK1xODqxbQ9rJlglC2XkmeKuQ
         xs683QLRRECrwyqp5zy7AiIMJWFBT8KrU3sV8ysQ=
Content-Type: multipart/mixed; boundary="------------7sE9CR0UOz3ZRVbNs0QGRnZm"
Message-ID: <e8ed7c71-28c7-cc8e-0081-feaaa672097e@gigawatt.nl>
Date:   Wed, 11 Jan 2023 18:59:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: [PATCH][resend] Simplify alias storage.
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
To:     DASH shell mailing list <dash@vger.kernel.org>
References: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>
In-Reply-To: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------7sE9CR0UOz3ZRVbNs0QGRnZm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/01/2023 18:23, Harald van Dijk wrote:
> Rather than storing the alias name and value separately, we can reduce
> simplify code and reduce code size by storing them in name=value form.
> This allows us to re-use some code from var.c to handle hashing and
> comparisons, so long as we update that to account for aliases' special
> handling of a leading = character. This is okay to do for variables as
> well, as for variables the leading character is guaranteed to not be =.

Apparently this got messed up when I actually sent it. Re-sending as an 
attachment. Apologies for the noise.

Cheers,
Harald van Dijk
--------------7sE9CR0UOz3ZRVbNs0QGRnZm
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Simplify-alias-storage.patch"
Content-Disposition: attachment; filename="0001-Simplify-alias-storage.patch"
Content-Transfer-Encoding: base64

RnJvbSBlYWZmMWJlNzUzZjU4NzQxYTU5M2U2YjZhNDAzNTUzM2IyNDJhMTZkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJhbGQgdmFuIERpamsgPGhhcmFsZEBnaWdhd2F0
dC5ubD4KRGF0ZTogV2VkLCAxMSBKYW4gMjAyMyAxNDowODowMiArMDAwMApTdWJqZWN0OiBb
UEFUQ0hdIFNpbXBsaWZ5IGFsaWFzIHN0b3JhZ2UuCgpSYXRoZXIgdGhhbiBzdG9yaW5nIHRo
ZSBhbGlhcyBuYW1lIGFuZCB2YWx1ZSBzZXBhcmF0ZWx5LCB3ZSBjYW4gcmVkdWNlCnNpbXBs
aWZ5IGNvZGUgYW5kIHJlZHVjZSBjb2RlIHNpemUgYnkgc3RvcmluZyB0aGVtIGluIG5hbWU9
dmFsdWUgZm9ybS4KVGhpcyBhbGxvd3MgdXMgdG8gcmUtdXNlIHNvbWUgY29kZSBmcm9tIHZh
ci5jIHRvIGhhbmRsZSBoYXNoaW5nIGFuZApjb21wYXJpc29ucywgc28gbG9uZyBhcyB3ZSB1
cGRhdGUgdGhhdCB0byBhY2NvdW50IGZvciBhbGlhc2VzJyBzcGVjaWFsCmhhbmRsaW5nIG9m
IGEgbGVhZGluZyA9IGNoYXJhY3Rlci4gVGhpcyBpcyBva2F5IHRvIGRvIGZvciB2YXJpYWJs
ZXMgYXMKd2VsbCwgYXMgZm9yIHZhcmlhYmxlcyB0aGUgbGVhZGluZyBjaGFyYWN0ZXIgaXMg
Z3VhcmFudGVlZCB0byBub3QgYmUgPS4KLS0tCiBzcmMvYWxpYXMuYyB8IDMyICsrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBzcmMvdmFyLmMgICB8IDI3ICsrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogc3JjL3Zhci5oICAgfCAxNSArKysrKysrKysrKysrKysKIDMg
ZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc3JjL2FsaWFzLmMgYi9zcmMvYWxpYXMuYwppbmRleCBmY2FkNDNiLi5iYjk2
M2E2IDEwMDY0NAotLS0gYS9zcmMvYWxpYXMuYworKysgYi9zcmMvYWxpYXMuYwpAQCAtNDEs
NiArNDEsNyBAQAogI2luY2x1ZGUgIm15c3RyaW5nLmgiCiAjaW5jbHVkZSAiYWxpYXMuaCIK
ICNpbmNsdWRlICJvcHRpb25zLmgiCS8qIFhYWCBmb3IgYXJncHRyIChzaG91bGQgcmVtb3Zl
PykgKi8KKyNpbmNsdWRlICJ2YXIuaCIKIAogI2RlZmluZSBBVEFCU0laRSAzOQogCkBAIC01
NSwyNSArNTYsMjYgQEAgdm9pZAogc2V0YWxpYXMoY29uc3QgY2hhciAqbmFtZSwgY29uc3Qg
Y2hhciAqdmFsKQogewogCXN0cnVjdCBhbGlhcyAqYXAsICoqYXBwOworCXNpemVfdCBuYW1l
bGVuOwogCiAJYXBwID0gX19sb29rdXBhbGlhcyhuYW1lKTsKIAlhcCA9ICphcHA7CiAJSU5U
T0ZGOwogCWlmIChhcCkgewogCQlpZiAoIShhcC0+ZmxhZyAmIEFMSUFTSU5VU0UpKSB7Ci0J
CQlja2ZyZWUoYXAtPnZhbCk7CisJCQlja2ZyZWUoYXAtPm5hbWUpOwogCQl9Ci0JCWFwLT52
YWwJPSBzYXZlc3RyKHZhbCk7CiAJCWFwLT5mbGFnICY9IH5BTElBU0RFQUQ7CiAJfSBlbHNl
IHsKIAkJLyogbm90IGZvdW5kICovCiAJCWFwID0gY2ttYWxsb2Moc2l6ZW9mIChzdHJ1Y3Qg
YWxpYXMpKTsKLQkJYXAtPm5hbWUgPSBzYXZlc3RyKG5hbWUpOwotCQlhcC0+dmFsID0gc2F2
ZXN0cih2YWwpOwogCQlhcC0+ZmxhZyA9IDA7CiAJCWFwLT5uZXh0ID0gMDsKIAkJKmFwcCA9
IGFwOwogCX0KKwluYW1lbGVuID0gdmFsIC0gbmFtZTsKKwlhcC0+bmFtZSA9IHNhdmVzdHIo
bmFtZSk7CisJYXAtPnZhbCA9IGFwLT5uYW1lICsgbmFtZWxlbjsKIAlJTlRPTjsKIH0KIApA
QCAtMTUwLDggKzE1Miw3IEBAIGFsaWFzY21kKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJ
CX0gZWxzZQogCQkJCXByaW50YWxpYXMoYXApOwogCQl9IGVsc2UgewotCQkJKnYrKyA9ICdc
MCc7Ci0JCQlzZXRhbGlhcyhuLCB2KTsKKwkJCXNldGFsaWFzKG4sIHYgKyAxKTsKIAkJfQog
CX0KIApAQCAtMTkwLDM2ICsxOTEsMjMgQEAgZnJlZWFsaWFzKHN0cnVjdCBhbGlhcyAqYXAp
IHsKIAogCW5leHQgPSBhcC0+bmV4dDsKIAlja2ZyZWUoYXAtPm5hbWUpOwotCWNrZnJlZShh
cC0+dmFsKTsKIAlja2ZyZWUoYXApOwogCXJldHVybiBuZXh0OwogfQogCiB2b2lkCiBwcmlu
dGFsaWFzKGNvbnN0IHN0cnVjdCBhbGlhcyAqYXApIHsKLQlvdXQxc3RyKHNpbmdsZV9xdW90
ZShhcC0+bmFtZSkpOwotCW91dDFmbXQoIj0lc1xuIiwgc2luZ2xlX3F1b3RlKGFwLT52YWwp
KTsKKwlvdXQxZm10KCIlc1xuIiwgc2luZ2xlX3F1b3RlKGFwLT5uYW1lKSk7CiB9CiAKIFNU
QVRJQyBzdHJ1Y3QgYWxpYXMgKioKIF9fbG9va3VwYWxpYXMoY29uc3QgY2hhciAqbmFtZSkg
ewotCXVuc2lnbmVkIGludCBoYXNodmFsOwogCXN0cnVjdCBhbGlhcyAqKmFwcDsKLQljb25z
dCBjaGFyICpwOwotCXVuc2lnbmVkIGludCBjaDsKIAotCXAgPSBuYW1lOwotCi0JY2ggPSAo
dW5zaWduZWQgY2hhcikqcDsKLQloYXNodmFsID0gY2ggPDwgNDsKLQl3aGlsZSAoY2gpIHsK
LQkJaGFzaHZhbCArPSBjaDsKLQkJY2ggPSAodW5zaWduZWQgY2hhcikqKytwOwotCX0KLQlh
cHAgPSAmYXRhYltoYXNodmFsICUgQVRBQlNJWkVdOworCWFwcCA9ICZhdGFiW2hhc2h2YWwo
bmFtZSkgJSBBVEFCU0laRV07CiAKIAlmb3IgKDsgKmFwcDsgYXBwID0gJigqYXBwKS0+bmV4
dCkgewotCQlpZiAoZXF1YWwobmFtZSwgKCphcHApLT5uYW1lKSkgeworCQlpZiAodmFyZXF1
YWwobmFtZSwgKCphcHApLT5uYW1lKSkgewogCQkJYnJlYWs7CiAJCX0KIAl9CmRpZmYgLS1n
aXQgYS9zcmMvdmFyLmMgYi9zcmMvdmFyLmMKaW5kZXggYjcwZDcyYy4uNjRkOTNhYSAxMDA2
NDQKLS0tIGEvc3JjL3Zhci5jCisrKyBiL3NyYy92YXIuYwpAQCAtNjI1LDEyICs2MjUsNyBA
QCB2b2lkIHVuc2V0dmFyKGNvbnN0IGNoYXIgKnMpCiBTVEFUSUMgc3RydWN0IHZhciAqKgog
aGFzaHZhcihjb25zdCBjaGFyICpwKQogewotCXVuc2lnbmVkIGludCBoYXNodmFsOwotCi0J
aGFzaHZhbCA9ICgodW5zaWduZWQgY2hhcikgKnApIDw8IDQ7Ci0Jd2hpbGUgKCpwICYmICpw
ICE9ICc9JykKLQkJaGFzaHZhbCArPSAodW5zaWduZWQgY2hhcikgKnArKzsKLQlyZXR1cm4g
JnZhcnRhYltoYXNodmFsICUgVlRBQlNJWkVdOworCXJldHVybiAmdmFydGFiW2hhc2h2YWwo
cCkgJSBWVEFCU0laRV07CiB9CiAKIApAQCAtNjQ0LDE5ICs2MzksMTkgQEAgaGFzaHZhcihj
b25zdCBjaGFyICpwKQogaW50CiB2YXJjbXAoY29uc3QgY2hhciAqcCwgY29uc3QgY2hhciAq
cSkKIHsKLQlpbnQgYywgZDsKLQotCXdoaWxlICgoYyA9ICpwKSA9PSAoZCA9ICpxKSkgewot
CQlpZiAoIWMgfHwgYyA9PSAnPScpCi0JCQlnb3RvIG91dDsKKwlpbnQgYyA9ICpwLCBkID0g
KnE7CisJd2hpbGUgKGMgPT0gZCkgeworCQlpZiAoIWMpCisJCQlicmVhazsKIAkJcCsrOwog
CQlxKys7CisJCWMgPSAqcDsKKwkJZCA9ICpxOworCQlpZiAoYyA9PSAnPScpCisJCQljID0g
J1wwJzsKKwkJaWYgKGQgPT0gJz0nKQorCQkJZCA9ICdcMCc7CiAJfQotCWlmIChjID09ICc9
JykKLQkJYyA9IDA7Ci0JaWYgKGQgPT0gJz0nKQotCQlkID0gMDsKLW91dDoKIAlyZXR1cm4g
YyAtIGQ7CiB9CiAKZGlmZiAtLWdpdCBhL3NyYy92YXIuaCBiL3NyYy92YXIuaAppbmRleCBh
YTc1NzVhLi4yYWVjZTlkIDEwMDY0NAotLS0gYS9zcmMvdmFyLmgKKysrIGIvc3JjL3Zhci5o
CkBAIC0xNTMsNiArMTUzLDIxIEBAIGludCB1bnNldGNtZChpbnQsIGNoYXIgKiopOwogdm9p
ZCB1bnNldHZhcihjb25zdCBjaGFyICopOwogaW50IHZhcmNtcChjb25zdCBjaGFyICosIGNv
bnN0IGNoYXIgKik7CiAKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGhhc2h2YWwoY29u
c3QgY2hhciAqcCkKK3sKKwl1bnNpZ25lZCBpbnQgaGFzaHZhbDsKKworCWhhc2h2YWwgPSAo
KHVuc2lnbmVkIGNoYXIpICpwKSA8PCA0OworCXdoaWxlICgqcCkgeworCQloYXNodmFsICs9
ICh1bnNpZ25lZCBjaGFyKSAqcCsrOworCQlpZiAoKnAgPT0gJz0nKQorCQkJYnJlYWs7CisJ
fQorCisJcmV0dXJuIGhhc2h2YWw7Cit9CisKKwogc3RhdGljIGlubGluZSBpbnQgdmFyZXF1
YWwoY29uc3QgY2hhciAqYSwgY29uc3QgY2hhciAqYikgewogCXJldHVybiAhdmFyY21wKGEs
IGIpOwogfQotLSAKMi4zOS4wCgo=

--------------7sE9CR0UOz3ZRVbNs0QGRnZm--
