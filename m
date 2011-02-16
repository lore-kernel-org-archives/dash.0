From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: dash breaks u0441
Date: Thu, 17 Feb 2011 01:25:38 +0300
Message-ID: <4D5C4EE2.9060504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:61157 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab1BPWZn (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 16 Feb 2011 17:25:43 -0500
Received: from localhost.localdomain (unknown [77.91.195.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mojo.unsafe.ru (Postfix) with ESMTP id E0D5A86815B
	for <dash@vger.kernel.org>; Thu, 17 Feb 2011 01:25:39 +0300 (MSK)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Greetings!

dash breaks cyrillic_small_letter_es (U+0441) in UTF8 encoding:

$ /usr/bin/printf '[\u0441]\n'
[=D1=81]
$ /usr/bin/printf '[\u0441]\n' |dash -c 'read c; echo "$c"'
[=C3=91]


But the characters around are displayed correctly:

$ /usr/bin/printf '[\u0440]\n' |dash -c 'read c; echo "$c"'
[=D1=80]
$ /usr/bin/printf '[\u0442]\n' |dash -c 'read c; echo "$c"'
[=D1=82]
$ /usr/bin/printf '[\u0451]\n' |dash -c 'read c; echo "$c"'
[=D1=91]

0d7d66039b614b642c775432fd64aa8c11f9a64d was good.
55c46b7286f5d9f2d8291158203e2b61d2494420 is bad.
49a94e2bab1e4f601a9fbdf9615d9e4e0150e412 is bad too.

--=20
Rgrds, legion

