From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash: read does not ignore trailing spaces
Date: Thu, 3 Dec 2015 22:02:14 +0100
Message-ID: <5660ADD6.4020308@gigawatt.nl>
References: <n3nrqu$mj2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090404090108050700070003"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:49817
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753849AbbLCVCT (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 3 Dec 2015 16:02:19 -0500
In-Reply-To: <n3nrqu$mj2$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
Cc: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------090404090108050700070003
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2015 23:37, Gioele Barabucci wrote:
> Hello,
>
> I am forwarding a bug [1] reported by a Debian user: `read` does not
> ignore trailing spaces. The current version of dash is affected by
> this bug.
>
> A simple test from the original reporter:
>
>      $ dash -c 'echo "  a b  " | { read v ; echo "<$v>" ; }'
>      <a b  >
>
>      $ bash -c 'echo "  a b  " | { read v ; echo "<$v>" ; }'
>      <a b>
>
> Other shells like posh and mksh behave like bash.

This is indeed a bug based on the current specification. In the past, 
the specification was unclear and the dash interpretation was a 
legitimate one, but currently it explicitly spells out that trailing IFS 
whitespace gets ignored.

However, unless I'm misreading the spec, mksh and bash don't seem to 
implement it properly either: only trailing IFS whitespace is supposed 
to be dropped. IFS non-whitespace is supposed to remain, even at the end 
of the input. mksh and bash remove it, posh and zsh leave it in:

   $ for shell in bash mksh posh zsh; do printf %s: "$shell"; $shell -c 
'IFS=,; echo a, | { read v; echo "<$v>"; }'; done
   bash:<a>
   mksh:<a>
   posh:<a,>
   zsh:<a,>

As far as I can tell, the posh/zsh behaviour is the correct behaviour, 
but I'm not convinced yet my interpretation is correct.

Attached is a not fully tested proof of concept to implement the 
posh/zsh behaviour in dash by extending ifsbreakup() to allow specifying 
a maximum number of arguments instead of fixing it up in 
readcmd_handle_line(). It returns <a b> in your test, and <a,> in mine. 
Feedback welcome.

Cheers,
Harald van Dijk

> This error is reproducible with dash 0.5.7 and with the current master
> git master branch, commit 2e5842258bd5b252ffdaa630db09c9a19a9717ca.
>
> [1] https://bugs.debian.org/794965
>
> --
> Gioele Barabucci <gioele@svario.it>

--------------090404090108050700070003
Content-Type: text/plain; charset=UTF-8;
 name="dash-read-ifs.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dash-read-ifs.patch"

ZGlmZiAtLWdpdCBhL3NyYy9leHBhbmQuYyBiL3NyYy9leHBhbmQuYwppbmRleCBiMmQ3MTBk
Li42YWZkNTYyIDEwMDY0NAotLS0gYS9zcmMvZXhwYW5kLmMKKysrIGIvc3JjL2V4cGFuZC5j
CkBAIC0yMDMsNyArMjAzLDcgQEAgZXhwYW5kYXJnKHVuaW9uIG5vZGUgKmFyZywgc3RydWN0
IGFyZ2xpc3QgKmFyZ2xpc3QsIGludCBmbGFnKQogCSAqIFRPRE8gLSBFWFBfUkVESVIKIAkg
Ki8KIAlpZiAoZmxhZyAmIEVYUF9GVUxMKSB7Ci0JCWlmc2JyZWFrdXAocCwgJmV4cGFyZyk7
CisJCWlmc2JyZWFrdXAocCwgMCwgJmV4cGFyZyk7CiAJCSpleHBhcmcubGFzdHAgPSBOVUxM
OwogCQlleHBhcmcubGFzdHAgPSAmZXhwYXJnLmxpc3Q7CiAJCWV4cGFuZG1ldGEoZXhwYXJn
Lmxpc3QsIGZsYWcpOwpAQCAtMTAxNiw5ICsxMDE2LDExIEBAIHJlY29yZHJlZ2lvbihpbnQg
c3RhcnQsIGludCBlbmQsIGludCBudWxvbmx5KQogICogQnJlYWsgdGhlIGFyZ3VtZW50IHN0
cmluZyBpbnRvIHBpZWNlcyBiYXNlZCB1cG9uIElGUyBhbmQgYWRkIHRoZQogICogc3RyaW5n
cyB0byB0aGUgYXJndW1lbnQgbGlzdC4gIFRoZSByZWdpb25zIG9mIHRoZSBzdHJpbmcgdG8g
YmUKICAqIHNlYXJjaGVkIGZvciBJRlMgY2hhcmFjdGVycyBoYXZlIGJlZW4gc3RvcmVkIGJ5
IHJlY29yZHJlZ2lvbi4KKyAqIElmIG1heGFyZ3MgaXMgbm9uLXplcm8sIGF0IG1vc3QgbWF4
YXJncyBhcmd1bWVudHMgd2lsbCBiZSBjcmVhdGVkLCBieQorICogam9pbmluZyB0b2dldGhl
ciB0aGUgbGFzdCBhcmd1bWVudHMuCiAgKi8KIHZvaWQKLWlmc2JyZWFrdXAoY2hhciAqc3Ry
aW5nLCBzdHJ1Y3QgYXJnbGlzdCAqYXJnbGlzdCkKK2lmc2JyZWFrdXAoY2hhciAqc3RyaW5n
LCBpbnQgbWF4YXJncywgc3RydWN0IGFyZ2xpc3QgKmFyZ2xpc3QpCiB7CiAJc3RydWN0IGlm
c3JlZ2lvbiAqaWZzcDsKIAlzdHJ1Y3Qgc3RybGlzdCAqc3A7CkBAIC0xMDU0LDEyICsxMDU2
LDM2IEBAIGlmc2JyZWFrdXAoY2hhciAqc3RyaW5nLCBzdHJ1Y3QgYXJnbGlzdCAqYXJnbGlz
dCkKIAkJCQkJCXN0YXJ0ID0gcDsKIAkJCQkJCWNvbnRpbnVlOwogCQkJCQl9CisJCQkJCS8q
IElmIG9ubHkgcmVhZGluZyBvbmUgbW9yZSBhcmd1bWVudCwgY29tYmluZSBhbnkgZmllbGQg
dGVybWluYXRvcnMsCisJCQkJCSAqIGV4Y2VwdCBmb3IgdHJhaWxpbmcgSUZTIHdoaXRlc3Bh
Y2UuICovCisJCQkJCWlmIChtYXhhcmdzID09IDEpIHsKKwkJCQkJCXEgPSBwOworCQkJCQkJ
cCsrOworCQkJCQkJaWYgKGlmc3NwYykgeworCQkJCQkJCS8qIElnbm9yZSBJRlMgd2hpdGVz
cGFjZSBhdCBlbmQgKi8KKwkJCQkJCQlmb3IgKDs7KSB7CisJCQkJCQkJCWlmIChwID49IHN0
cmluZyArIGlmc3AtPmVuZG9mZikgeworCQkJCQkJCQkJKnEgPSAnXDAnOworCQkJCQkJCQkJ
Z290byBhZGQ7CisJCQkJCQkJCX0KKwkJCQkJCQkJaWYgKCpwID09IChjaGFyKUNUTEVTQykK
KwkJCQkJCQkJCXArKzsKKwkJCQkJCQkJaWZzc3BjID0gc3RyY2hyKGlmcywgKnApICYmIHN0
cmNocihkZWZpZnMsICpwKTsKKwkJCQkJCQkJcCsrOworCQkJCQkJCQlpZiAoIWlmc3NwYykg
eworCQkJCQkJCQkJYnJlYWs7CisJCQkJCQkJCX0KKwkJCQkJCQl9CisJCQkJCQl9CisJCQkJ
CQljb250aW51ZTsKKwkJCQkJfQogCQkJCQkqcSA9ICdcMCc7CiAJCQkJCXNwID0gKHN0cnVj
dCBzdHJsaXN0ICopc3RhbGxvYyhzaXplb2YgKnNwKTsKIAkJCQkJc3AtPnRleHQgPSBzdGFy
dDsKIAkJCQkJKmFyZ2xpc3QtPmxhc3RwID0gc3A7CiAJCQkJCWFyZ2xpc3QtPmxhc3RwID0g
JnNwLT5uZXh0OwogCQkJCQlwKys7CisJCQkJCWlmIChtYXhhcmdzKSBtYXhhcmdzLS07CiAJ
CQkJCWlmICghbnVsb25seSkgewogCQkJCQkJZm9yICg7OykgewogCQkJCQkJCWlmIChwID49
IHN0cmluZyArIGlmc3AtPmVuZG9mZikgewpkaWZmIC0tZ2l0IGEvc3JjL2V4cGFuZC5oIGIv
c3JjL2V4cGFuZC5oCmluZGV4IDZhOTBmNjcuLjI2ZGM1YjQgMTAwNjQ0Ci0tLSBhL3NyYy9l
eHBhbmQuaAorKysgYi9zcmMvZXhwYW5kLmgKQEAgLTY5LDcgKzY5LDcgQEAgY2hhciAqX3Jt
ZXNjYXBlcyhjaGFyICosIGludCk7CiBpbnQgY2FzZW1hdGNoKHVuaW9uIG5vZGUgKiwgY2hh
ciAqKTsKIHZvaWQgcmVjb3JkcmVnaW9uKGludCwgaW50LCBpbnQpOwogdm9pZCByZW1vdmVy
ZWNvcmRyZWdpb25zKGludCk7IAotdm9pZCBpZnNicmVha3VwKGNoYXIgKiwgc3RydWN0IGFy
Z2xpc3QgKik7Cit2b2lkIGlmc2JyZWFrdXAoY2hhciAqLCBpbnQsIHN0cnVjdCBhcmdsaXN0
ICopOwogdm9pZCBpZnNmcmVlKHZvaWQpOwogCiAvKiBGcm9tIGFyaXRoLnkgKi8KZGlmZiAt
LWdpdCBhL3NyYy9taXNjYmx0aW4uYyBiL3NyYy9taXNjYmx0aW4uYwppbmRleCBiNTk2ZmQy
Li4zOWI5YzQ3IDEwMDY0NAotLS0gYS9zcmMvbWlzY2JsdGluLmMKKysrIGIvc3JjL21pc2Ni
bHRpbi5jCkBAIC02NywyOCArNjcsMjEgQEAKICAqICBsZXNzIGZpZWxkcyB0aGFuIHZhcmlh
YmxlcyAtPiByZW1haW5pbmcgdmFyaWFibGVzIHVuc2V0LgogICoKICAqICBAcGFyYW0gbGlu
ZSBjb21wbGV0ZSBsaW5lIG9mIGlucHV0CisgKiAgQHBhcmFtIGFjIGFyZ3VtZW50IGNvdW50
CiAgKiAgQHBhcmFtIGFwIGFyZ3VtZW50ICh2YXJpYWJsZSkgbGlzdAogICogIEBwYXJhbSBs
ZW4gbGVuZ3RoIG9mIGxpbmUgaW5jbHVkaW5nIHRyYWlsaW5nICdcMCcKICAqLwogc3RhdGlj
IHZvaWQKLXJlYWRjbWRfaGFuZGxlX2xpbmUoY2hhciAqcywgY2hhciAqKmFwKQorcmVhZGNt
ZF9oYW5kbGVfbGluZShjaGFyICpzLCBpbnQgYWMsIGNoYXIgKiphcCkKIHsKIAlzdHJ1Y3Qg
YXJnbGlzdCBhcmdsaXN0OwogCXN0cnVjdCBzdHJsaXN0ICpzbDsKLQljaGFyICpiYWNrdXA7
Ci0JY2hhciAqbGluZTsKIAotCS8qIGlmc2JyZWFrdXAgd2lsbCBmaWRkbGUgd2l0aCBzdGFj
ayByZWdpb24uLi4gKi8KLQlsaW5lID0gc3RhY2tibG9jaygpOwogCXMgPSBncmFic3RhY2tz
dHIocyk7CiAKLQkvKiBuZWVkIGEgY29weSwgc28gdGhhdCBkZWxpbWl0ZXJzIGFyZW4ndCBs
b3N0Ci0JICogaW4gY2FzZSB0aGVyZSBhcmUgbW9yZSBmaWVsZHMgdGhhbiB2YXJpYWJsZXMg
Ki8KLQliYWNrdXAgPSBzc3RyZHVwKGxpbmUpOwotCiAJYXJnbGlzdC5sYXN0cCA9ICZhcmds
aXN0Lmxpc3Q7CiAJCi0JaWZzYnJlYWt1cChzLCAmYXJnbGlzdCk7CisJaWZzYnJlYWt1cChz
LCBhYywgJmFyZ2xpc3QpOwogCSphcmdsaXN0Lmxhc3RwID0gTlVMTDsKIAlpZnNmcmVlKCk7
CiAKQEAgLTEwNCwyMSArOTcsNiBAQCByZWFkY21kX2hhbmRsZV9saW5lKGNoYXIgKnMsIGNo
YXIgKiphcCkKIAkJCXJldHVybjsKIAkJfQogCi0JCS8qIHJlbWFpbmluZyBmaWVsZHMgcHJl
c2VudCwgYnV0IG5vIHZhcmlhYmxlcyBsZWZ0LiAqLwotCQlpZiAoIWFwWzFdICYmIHNsLT5u
ZXh0KSB7Ci0JCQlzaXplX3Qgb2Zmc2V0OwotCQkJY2hhciAqcmVtYWluZGVyOwotCi0JCQkv
KiBGSVhNRSBsaXR0bGUgYml0IGhhY2t5LCBhc3N1bWluZyB0aGF0IGlmc2JyZWFrdXAgCi0J
CQkgKiB3aWxsIG5vdCBtb2RpZnkgdGhlIGxlbmd0aCBvZiB0aGUgc3RyaW5nICovCi0JCQlv
ZmZzZXQgPSBzbC0+dGV4dCAtIHM7Ci0JCQlyZW1haW5kZXIgPSBiYWNrdXAgKyBvZmZzZXQ7
Ci0JCQlybWVzY2FwZXMocmVtYWluZGVyKTsKLQkJCXNldHZhcigqYXAsIHJlbWFpbmRlciwg
MCk7Ci0KLQkJCXJldHVybjsKLQkJfQotCQkKIAkJLyogc2V0IHZhcmlhYmxlIHRvIGZpZWxk
ICovCiAJCXJtZXNjYXBlcyhzbC0+dGV4dCk7CiAJCXNldHZhcigqYXAsIHNsLT50ZXh0LCAw
KTsKQEAgLTIxMSw3ICsxODksNyBAQCBzdGFydDoKIG91dDoKIAlyZWNvcmRyZWdpb24oc3Rh
cnRsb2MsIHAgLSAoY2hhciAqKXN0YWNrYmxvY2soKSwgMCk7CiAJU1RBQ0tTVFJOVUwocCk7
Ci0JcmVhZGNtZF9oYW5kbGVfbGluZShwICsgMSwgYXApOworCXJlYWRjbWRfaGFuZGxlX2xp
bmUocCArIDEsIGFyZ2MgLSAoYXAgLSBhcmd2KSwgYXApOwogCXJldHVybiBzdGF0dXM7CiB9
CiAK
--------------090404090108050700070003--
