From: Peng Yu <pengyu.ut@gmail.com>
Subject: How to inherent non-zero exit status using pipe? (dash)
Date: Wed, 11 Aug 2010 07:34:43 -0500
Message-ID: <AANLkTimi+MdwWVLceKdNgjCaK5B=dm_+raH++Owdh_QS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41943 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab0HKMep convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 11 Aug 2010 08:34:45 -0400
Received: by wyb32 with SMTP id 32so67706wyb.19
        for <dash@vger.kernel.org>; Wed, 11 Aug 2010 05:34:44 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

The following example returns the exit status of the last command in a
pipe. I'm wondering if there is a way to inherent non-zero exit status
using pipe. That is, if there is any command in a pipe that return a
non-zero status, I'd like the whole pipe return a non-zero status.

$ cat main.sh
#!/usr/bin/env bash

echo abc 1>&2
echo abc 1>&2
echo abc 1>&2
echo abc 1>&2
echo abc 1>&2
exit 1
$ ./main.sh
abc
abc
abc
abc
abc
$ echo $?
1
$ =A0./main.sh |head -n 3
abc
abc
abc
abc
abc
$ echo $?
0

--=20
Regards,
Peng
