From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: inconsistency with handling of symlinked ttys in background
Date: Tue, 09 Nov 2010 10:18:35 +0000
Message-ID: <4CD91FFB.40105@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:9750 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754680Ab0KIKZu (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 9 Nov 2010 05:25:50 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I noticed a bug with dash-0.5.6-2.fc11.i586
in that it doesn't redirect from symlinked ttys
correctly for background processes.

$ dash -c "tty < /dev/stdin&"
$ dash -c "tty < /dev/stdin"
/dev/pts/3
$ bash -c "tty < /dev/stdin&"
/dev/pts/3
$ dash -c "tty < $(readlink -f /dev/stdin)&"
/dev/pts/3

cheers,
P=C3=A1draig.
