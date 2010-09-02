From: Steve Schnepp <steve.schnepp@gmail.com>
Subject: Re: read() builtin doesn't read integer value /proc files (but bash's does)
Date: Thu, 2 Sep 2010 17:02:55 +0200
Message-ID: <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636457a1c4e931c048f481eb0
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64629 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab0IBPDl (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 2 Sep 2010 11:03:41 -0400
Received: by pzk9 with SMTP id 9so116148pzk.19
        for <dash@vger.kernel.org>; Thu, 02 Sep 2010 08:03:40 -0700 (PDT)
In-Reply-To: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: 595063@bugs.debian.org

--001636457a1c4e931c048f481eb0
Content-Type: text/plain; charset=UTF-8

2010/9/1 Steve Schnepp <steve.schnepp@gmail.com>:
> conforming to POSIX isn't a realistic option, would it be possible to
> have a workaround that doesn't involve an external tool like cat(1) ?

Hi, I just hacked & attached a little patch away to be able to solve this case.
Feel free to reply with your comments.

NB: I just targeted dash-0.5.5.1, but it might apply to any version.

--
Steve Schnepp
http://blog.pwkf.org/

--001636457a1c4e931c048f481eb0
Content-Type: application/octet-stream; name="chunked_bltin_read.diff"
Content-Disposition: attachment; filename="chunked_bltin_read.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdlqtdnh0

LS0tIGRhc2gtMC41LjUuMS9zcmMvbWlzY2JsdGluLmMub3JpZyAgIDIwMDktMDEtMTQgMDA6Mzc6
MTMuMDAwMDAwMDAwICswMTAwDQorKysgZGFzaC0wLjUuNS4xL3NyYy9taXNjYmx0aW4uYyAgICAg
ICAgMjAxMC0wOS0wMiAxNjo1NDoyOS4zMzA4MzA4NTkgKzAyMDANCkBAIC01OCw2ICs1OCwzNCBA
QA0KDQogI3VuZGVmIHJmbGFnDQoNCisjZGVmaW5lIENIVU5LX1JFQURfU0laRSAzMg0KKw0KKy8q
DQorICogUmVhZHMgZnJvbSBmZCAwLCB3aXRoIGEgQ0hVTktfUkVBRF9TSVpFLA0KKyAqIGJ1dCBl
bWl0dGluZyBvbmUgY2hhciBhdCBhIHRpbWUNCisgKi8NCitzdGF0aWMgaW50IF9yZWFkX2J1ZmZl
cnJlZChjaGFyKiBjKSB7DQorICAgICAgIHN0YXRpYyBjaGFyIGJ1ZmZlcltDSFVOS19SRUFEX1NJ
WkVdOw0KKyAgICAgICBzdGF0aWMgaW50IGJ1ZmZlcl9vZmZzZXQgPSAwOw0KKyAgICAgICBzdGF0
aWMgaW50IGJ1ZmZlcl9sZW4gPSAwOw0KKw0KKyAgICAgICBpZiAoYnVmZmVyX2xlbiA9PSAwKSB7
DQorICAgICAgICAgICAgICAgLy8gTm8gY2FyYWN0ZXIgbGVmdCwgcmVzZXR0aW5nIGJ1ZmZlciAm
IHJlYWQgc29tZSBtb3JlDQorICAgICAgICAgICAgICAgYnVmZmVyX29mZnNldCA9IDA7DQorICAg
ICAgICAgICAgICAgYnVmZmVyX2xlbiA9IHJlYWQoMCwgYnVmZmVyLCBDSFVOS19SRUFEX1NJWkUp
Ow0KKw0KKyAgICAgICAgICAgICAgIGlmIChidWZmZXJfbGVuID09IDApIHsNCisgICAgICAgICAg
ICAgICAgICAgICAgIC8vIE5vdGhpbmcgdG8gcmVhZCBhbnltb3JlDQorICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gMDsNCisgICAgICAgICAgICAgICB9DQorICAgICAgIH0NCisNCisgICAg
ICAgLy8gU3RpbGwgc29tZSBjaGFyYWN0ZXIgbGVmdA0KKyAgICAgICAqYyA9IGJ1ZmZlcltidWZm
ZXJfb2Zmc2V0KytdOw0KKyAgICAgICBidWZmZXJfbGVuLS07DQorDQorICAgICAgIHJldHVybiAx
Ow0KK30NCg0KDQogLyoNCkBAIC02NSw2ICs5Myw3IEBADQogICogZm9sbG93aW5nIGNoYXJhY3Rl
ci4NCiAgKg0KICAqIFRoaXMgdXNlcyB1bmJ1ZmZlcmVkIGlucHV0LCB3aGljaCBtYXkgYmUgYXZv
aWRhYmxlIGluIHNvbWUgY2FzZXMuDQorICogWFhYIC0gVXNlcyBfcmVhZF9idWZmZXJyZWQoKSB0
aGF0IGNodW5rcyByZWFkKCksIGJ1dCBlbWl0cyBvbmUgY2hhciBhdCBhIHRpbWUNCiAgKi8NCg0K
IGludA0KQEAgLTEwNCw3ICsxMzMsNyBAQA0KICAgICAgICBiYWNrc2xhc2ggPSAwOw0KICAgICAg
ICBTVEFSVFNUQUNLU1RSKHApOw0KICAgICAgICBmb3IgKDs7KSB7DQotICAgICAgICAgICAgICAg
aWYgKHJlYWQoMCwgJmMsIDEpICE9IDEpIHsNCisgICAgICAgICAgICAgICBpZiAoX3JlYWRfYnVm
ZmVycmVkKCZjKSAhPSAxKSB7DQogICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAxOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICAgICAgICAgfQ0K
--001636457a1c4e931c048f481eb0--
