From: Jesper Bengtsson <jesper.bengtsson@axis.com>
Subject: Parameter expansion fails when assigning a local variable
Date: Mon, 22 Jun 2009 10:13:22 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8xmail3seaxisc_"
Return-path: <dash-owner@vger.kernel.org>
Received: from krynn.se.axis.com ([193.13.178.10]:38890 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbZFVIpC (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 22 Jun 2009 04:45:02 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id n5M8DNWV029954
	for <dash@vger.kernel.org>; Mon, 22 Jun 2009 10:13:23 +0200
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "'dash@vger.kernel.org'" <dash@vger.kernel.org>

--_002_A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8xmail3seaxisc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I've found a problem with expanding $@.
If I declare a local variable and assigns the expanded positional parameter=
s:
        local v=3D"$@"
It fails with something like:
        local: 20: \/: bad variable name

If I split declaration and assignment into two lines it will work:
        local v
        v=3D"$@"

I've tried this on dash 0.5.5.1 and 0.5.3 and both fail in the same way.
I've also tried on bash and ash (Busybox) and both handles declaration and =
assignment on one line.

I'm attaching a small script that shows the problem.

Best regards,
Jesper Bengtsson

--_002_A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8xmail3seaxisc_
Content-Type: application/octet-stream; name="dash-arg-bug.sh"
Content-Description: dash-arg-bug.sh
Content-Disposition: attachment; filename="dash-arg-bug.sh"; size=371;
	creation-date="Wed, 17 Jun 2009 16:19:24 GMT";
	modification-date="Wed, 17 Jun 2009 16:19:24 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Rhc2gKCnNldCAtZQojc2V0IC14CiNzZXQgLXYKCmZ1bmMoKSB7Cglsb2NhbCB2PSIk
QCIJIyB1bmV4cGVjdGVkIGJlaGF2aW91ciA9PSBidWcKCSMgdj0iJEAiCSMgZXhwZWN0ZWQgYmVo
YXZpb3VyCgkjIGxvY2FsIHYJIyBhbHNvIGV4cGVjdGVkIGJlaGF2aW91ciB3aXRoIGRlY2xhcmF0
aW9uCgkjIHY9IiRAIgkjIGFuZCBhc2lnbm1lbnQgb24gc2VwYXJhdGUgbGluZXMKCgllY2hvICJm
dW5jOiB2PSckdicsIFwkMT0nJDEnLCBcJDI9JyQyJywgXCQzPSckMyciID4mMgoKCWVjaG8gIiR2
Igp9Cgp4eXo9IiAJICAxMjMJIAl4eXoJXFwvIAkiCmVjaG8gImluOiAgJyR4eXonIgphYmM9JChm
dW5jICR4eXopCmVjaG8gIm91dDogJyRhYmMnIgo=

--_002_A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8xmail3seaxisc_--
