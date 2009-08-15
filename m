From: Matthew Burgess <matthew@linuxfromscratch.org>
Subject: Allow dash to build with i18n version of Coreutils
Date: Sat, 15 Aug 2009 12:07:16 -0600
Message-ID: <ae958968e4a4099d81d92479ccde0167@quantum.linuxfromscratch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_0633a8adf62aa2c65409646b7da934d4"
Return-path: <dash-owner@vger.kernel.org>
Received: from quantum.linuxfromscratch.org ([216.171.237.234]:43999 "EHLO
	quantum.linuxfromscratch.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751357AbZHOSjZ (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 15 Aug 2009 14:39:25 -0400
Received: from localhost (quantum.linuxfromscratch.org [216.171.237.234])
	by quantum.linuxfromscratch.org (Postfix) with ESMTP id F03E314109
	for <dash@vger.kernel.org>; Sat, 15 Aug 2009 12:07:16 -0600 (MDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--=_0633a8adf62aa2c65409646b7da934d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

My system has Coreutils-7.4 compiled with the i18n patch from
http://cvs.fedoraproject.org/viewvc/devel/coreutils/coreutils-i18n.patch.

Using this to compile dash, when in an en_GB.UTF-8 locale, I get the following error:

if gcc -DHAVE_CONFIG_H -I. -I. -I..  -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -Wall -g -O2 -MT eval.o -MD -MP -MF ".deps/eval.Tpo" -c -o eval.o eval.c; \
        then mv -f ".deps/eval.Tpo" ".deps/eval.Po"; else rm -f ".deps/eval.Tpo"; exit 1; fi
eval.c: In function ‘evalcommand’:
eval.c:810: error: ‘EXECCMD’ undeclared (first use in this function)
eval.c:810: error: (Each undeclared identifier is reported only once
eval.c:810: error: for each function it appears in.)
eval.c:812: error: ‘COMMANDCMD’ undeclared (first use in this function)
make[3]: *** [eval.o] Error 1

This is because the src/mkbuiltins script ends up generating an incomplete
src/builtins.h file.  This, in turn, is caused by 'sort -u -k 3,3' not
working correctly.

The attached patch fixes/works around things by setting LC_CTYPE=C, thus
overriding the build environment (in a similar manner to the earlier call to
'sort' in that same script).

Regards,

Matt.
--=_0633a8adf62aa2c65409646b7da934d4
Content-Transfer-Encoding: base64
Content-Type: text/x-diff; name="dash-0.5.5.1-sort_utf8-1.patch"
Content-Disposition: attachment; filename="dash-0.5.5.1-sort_utf8-1.patch"

U3VibWl0dGVkIGJ5OiBNYXR0IEJ1cmdlc3MgKG1hdHRoZXdfYXRfbGludXhmcm9tc2NyYXRjaF9k
b3Rfb3JnKQpEYXRlOiAyMDA5LTA4LTE1CkluaXRpYWwgUGFja2FnZSBWZXJzaW9uOiAwLjUuNS4x
ClVwc3RyZWFtIFN0YXR1czogU3VibWl0dGVkCk9yaWdpbjogTWF0dCBCdXJnZXNzCkRlc2NyaXB0
aW9uOiBJbiBVVEYtOCBsb2NhbGUncyB3aXRoIGFuIAoKZGlmZiAtTmF1ciBkYXNoLTAuNS41LjEu
b3JpZy9zcmMvbWtidWlsdGlucyBkYXNoLTAuNS41LjEvc3JjL21rYnVpbHRpbnMKLS0tIGRhc2gt
MC41LjUuMS5vcmlnL3NyYy9ta2J1aWx0aW5zCTIwMDktMDEtMTMgMjM6Mzc6MTMuMDAwMDAwMDAw
ICswMDAwCisrKyBkYXNoLTAuNS41LjEvc3JjL21rYnVpbHRpbnMJMjAwOS0wOC0xNSAxNzozMTox
OS4wMDAwMDAwMDAgKzAwMDAKQEAgLTgzLDcgKzgzLDcgQEAKICAqLwogCiAhCi1zZWQgJ3MvCS1b
YS16XSovLycgJHRlbXAyIHwgbmwgLXYgMCB8IHNvcnQgLXUgLWsgMywzIHwKK3NlZCAncy8JLVth
LXpdKi8vJyAkdGVtcDIgfCBubCAtdiAwIHwgTENfQ1RZUEU9QyBzb3J0IC11IC1rIDMsMyB8CiB0
ciBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5eiBBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWiB8
CiAJYXdrICd7CXByaW50ZiAiI2RlZmluZSAlcyAoYnVpbHRpbmNtZCArICVkKVxuIiwgJDMsICQx
fScKIHByaW50ZiAnXG4jZGVmaW5lIE5VTUJVSUxUSU5TICVkXG4nICQod2MgLWwgPCAkdGVtcDIp
Cg==
--=_0633a8adf62aa2c65409646b7da934d4--

