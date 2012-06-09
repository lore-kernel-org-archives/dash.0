From: Christoph Mathys <eraserix@gmail.com>
Subject: [PATCH] support ulimit -r
Date: Sat, 9 Jun 2012 23:00:30 +0200
Message-ID: <CALqGcGo3ncBKBE6Z5fUHS8aDJ0QuKRV=8+HpczQbN4CBfo8=PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae93408ab36ff0104c210688f
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56819 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab2FIVAb (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 9 Jun 2012 17:00:31 -0400
Received: by obbtb18 with SMTP id tb18so4374991obb.19
        for <dash@vger.kernel.org>; Sat, 09 Jun 2012 14:00:30 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--14dae93408ab36ff0104c210688f
Content-Type: text/plain; charset=UTF-8

I recently found myself in need to have dash support 'ulimit -r' to
set maximum realtime priority. Attached is a patch that adds the
parameter to the builtin ulimit command and updates the manpage.

Thanks!
Christoph

--14dae93408ab36ff0104c210688f
Content-Type: application/octet-stream; name="rtlimit-rtprio.patch"
Content-Disposition: attachment; filename="rtlimit-rtprio.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h395xeyy0

LS0tIGEvc3JjL2Rhc2guMQorKysgYi9zcmMvZGFzaC4xCkBAIC0yMTYzLDYgKzIxNjMsOCBAQAog
aGF2ZSBhdCBvbmUgdGltZQogLkl0IEZsIG4KIHNob3cgb3Igc2V0IHRoZSBsaW1pdCBvbiB0aGUg
bnVtYmVyIGZpbGVzIGEgcHJvY2VzcyBjYW4gaGF2ZSBvcGVuIGF0IG9uY2UKKy5JdCBGbCByCitz
aG93IG9yIHNldCB0aGUgbGltaXQgb24gdGhlIHJlYWwtdGltZSBzY2hlZHVsaW5nIHByaW9yaXR5
IG9mIGEgcHJvY2VzcwogLkVsCiAuUHAKIElmIG5vbmUgb2YgdGhlc2UgaXMgc3BlY2lmaWVkLCBp
dCBpcyB0aGUgbGltaXQgb24gZmlsZSBzaXplIHRoYXQgaXMgc2hvd24KLS0tIGEvc3JjL21pc2Ni
bHRpbi5jCisrKyBiL3NyYy9taXNjYmx0aW4uYwpAQCAtMzkyLDYgKzM5MiwxMCBAQAogI2lmZGVm
IFJMSU1JVF9MT0NLUwogCXsgImxvY2tzIiwJCQlSTElNSVRfTE9DS1MsCSAgIDEsICd3JyB9LAog
I2VuZGlmCisjaWZkZWYgUkxJTUlUX1JUUFJJTworCXsgInJ0cHJpbyIsCQkJUkxJTUlUX1JUUFJJ
TywJICAgMSwgJ3InIH0sCisjZW5kaWYKKwogCXsgKGNoYXIgKikgMCwJCQkwLAkJICAgMCwgICdc
MCcgfQogfTsKIAo=
--14dae93408ab36ff0104c210688f--
