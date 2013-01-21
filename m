From: Mark Lentczner <mark@glyphic.com>
Subject: Parameter substitution bug
Date: Mon, 21 Jan 2013 13:36:07 -0800
Message-ID: <CAPnksqRxUvwGGQwXBPVj-yrA8a18nmLctZGD0BtBnh_vC-Muhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d043c7d6000915404d3d34161
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:50969 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3AUVga (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 21 Jan 2013 16:36:30 -0500
Received: by mail-vc0-f173.google.com with SMTP id fy7so2938333vcb.32
        for <dash@vger.kernel.org>; Mon, 21 Jan 2013 13:36:29 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--f46d043c7d6000915404d3d34161
Content-Type: text/plain; charset=UTF-8

Strangely I ran across this issue in the real world: A doubly nested
parameter substitution with an inner glob pattern (breath) fails /only
when in double quotes/! That is, these two expressions produce
different results:

${f%${f#?}}   --vs--  "${f%${f#?}}"

Strangely, that is the simplest case I get to fail.

The following script walks through the issue, and if run with bash,
ksh, or busybox exhibits those two expressions as producing the same
result.

- Mark
(Note: Not on mailing list, so please reply all to include me!)

--f46d043c7d6000915404d3d34161
Content-Type: application/x-sh; name="dash-bug.sh"
Content-Disposition: attachment; filename="dash-bug.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hc84vo9s0

IyBEZW1vbnN0cmF0aW9uIG9mIGEgcGFyYW1ldGVyIHN1YnN0aXRpb24gYnVnIGluIERhc2gKIyAg
ICAgICBNYXJrIExlbnRjem5lcgojICAgICAgIG1hcmtAZ2x5cGhpYy5jb20KIyAgICAgICBKYW51
YXJ5IDIwMTMKCmVjaG8gVGhpcyB0ZXN0cyBjZXJ0YWluIHBhcmFtZXRlciBzdWJzdGl0dXRpb25z
IHdoZW4gYm90aCBiYXJlIGFuZCBxdW90ZWQKZWNobyBJbiBhbGwgY2FzZXMsIHRoZSB2YWx1ZXMg
c2hvdWxkIGJlIHRoZSBzYW1lLgplY2hvCmVjaG8gSW4gdGhlIHRlc3QsIGEgcGFyYW1ldGVyIGlz
IHNldCB0byBcImFiY1wiLCBhbmQgdGhlbiB0aGUgJSBzdWJzdGl0dXRpb24gaXMKZWNobyB1c2Vk
IHRvIHJlbW92ZSBhIG1hdGNoaW5nIHRhaWwuIFRoZSBwYXR0ZXJuIHRvIG1hdGNoIHdpbGwgYWx3
YXlzIGJlIFwiYmNcIgplY2hvIGJ1dCBpdCB3aWxsIHByb3ZpZGVkIHNldmVyYWwgZGlmZmVyZW50
IHdheXMuCmVjaG8KCmY9YWJjIGc9JHtmJWJjfSBoPSIke2YlYmN9IgplY2hvICdmPWFiYyBnPSR7
ZiViY30gaD0iJHtmJWJjfSIgICAgICAgICAgID09PiBnIGlzJyBcIiRnXCIsIGFuZCBoIGlzIFwi
JGhcIgoKZj1hYmMgej1iYyBnPSR7ZiUken0gaD0iJHtmJSR6fSIKZWNobyAnZj1hYmMgej1iYyBn
PSR7ZiUken0gaD0iJHtmJSR6fSIgICAgICA9PT4gZyBpcycgXCIkZ1wiLCBhbmQgaCBpcyBcIiRo
XCIKCmY9YWJjIHo9YmMgZz0ke2YlJHt6fX0gaD0iJHtmJSR7en19IgplY2hvICdmPWFiYyB6PWJj
IGc9JHtmJSR7en19IGg9IiR7ZiUke3p9fSIgID09PiBnIGlzJyBcIiRnXCIsIGFuZCBoIGlzIFwi
JGhcIgoKZWNobwoKZWNobyBUaGVzZSBhcmUgYWxsIHRoZSBzYW1lIGVpdGhlciB3aXRoaW4gcXVv
dGVzIG9yIHdpdGhvdXQuIE5vdywgd2UgdHJ5IGl0CmVjaG8gd2l0aCBhIG5lc3RlZCBzdWJzdGl0
dXRpb24uIEZpcnN0IHdlIGVzdGFibGlzaCB0aGF0IHRoZSBpbm5lciBzdWJzdGl0dXRpb24KZWNo
byByZXN1bHRzIGluIFwiYmNcIiwgd2hldGhlciBxdW90ZWQgb3Igbm90OgplY2hvCgpmPWFiYyBn
PSR7ZiM/fSBoPSIke2YjP30iCmVjaG8gJ2Y9YWJjIGc9JHtmIz99IGg9IiR7ZiM/fSIgICAgICAg
ICAgICAgPT0+IGcgaXMnIFwiJGdcIiwgYW5kIGggaXMgXCIkaFwiCmVjaG8KCmVjaG8gQW5kIG5v
dywgd2UgbG9vayBhdCB3aGF0IGhhcHBlbnMgdGhhdCBpcyB1c2VkIGFzIHRoZSBwYXR0ZXJuIGlu
IHRoZQplY2hvIG91dGVyIHN1YnN0aXR1dGlvbi4gVGhpcyBpcyB0aGUgY2FzZSB0aGF0IGZhaWxz
IGluIGRhc2g6CmVjaG8KCmY9YWJjIGc9JHtmJSR7ZiM/fX0gaD0iJHtmJSR7ZiM/fX0iCmVjaG8g
J2Y9YWJjIGc9JHtmJSR7ZiM/fX0gaD0iJHtmJSR7ZiM/fX0iICAgPT0+IGcgaXMnIFwiJGdcIiwg
YW5kIGggaXMgXCIkaFwiCmVjaG8KCmVjaG8gSW50ZXJlc3RpbmdseSwgaWYgd2UgdHJ5IGl0IHVz
aW5nIGEgZml4ZWQgcGF0dGVybiBpbiB0aGUgaW5uZXIKZWNobyBzdWJzdGl0dXRpb24sIGl0IGFs
bCB3b3JrczoKZWNobwoKZj1hYmMgZz0ke2YlJHtmI2F9fSBoPSIke2YlJHtmI2F9fSIKZWNobyAn
Zj1hYmMgZz0ke2YlJHtmI2F9fSBoPSIke2YlJHtmI2F9fSIgICA9PT4gZyBpcycgXCIkZ1wiLCBh
bmQgaCBpcyBcIiRoXCIKZWNobwo=
--f46d043c7d6000915404d3d34161--
