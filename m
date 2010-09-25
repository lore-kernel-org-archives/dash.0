From: =?iso-8859-1?Q?Lo=EFc?= Minier <lool@dooz.org>
Subject: exit-ing in a trap handler uses the wrong exit code
Date: Sat, 25 Sep 2010 13:59:00 +0200
Message-ID: <20100925115900.GA9732@bee.dooz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from duck.dooz.org ([194.146.227.125]:33364 "EHLO duck.dooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722Ab0IYMRo (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Sep 2010 08:17:44 -0400
Received: from bee.dooz.org (serris.dooz.org [88.166.229.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by duck.dooz.org (Postfix) with ESMTP id C92DEC809C
	for <dash@vger.kernel.org>; Sat, 25 Sep 2010 13:59:04 +0200 (CEST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

        Hi there

 qemu's configure uses a trap handler which calls exit; configure would
 call exit 1, but with the trap handler in place the configure script
 would return with exit 0.

 dash -c 'trap "sh -c \"exit 4\"; exit" 0 1 2 3 9 11 13 15;exit 3'; ech=
o $?
 4

 Blue Swirl on the qemu-devel list points out that according to POSIX
 this should be 3:
 http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_21

 bash and zsh get this right:
 bash -c 'trap "sh -c \"exit 4\"; exit" 0 1 2 3 9 11 13 15;exit 3'; ech=
o $?
 3

 I've logged https://bugs.launchpad.net/ubuntu/+source/dash/+bug/647450
 to track this as I'm seeing this with the Ubuntu version of dash.

   Cheers,

NB: Not subscribed to the list, please Cc: me on replies
--=20
Lo=EFc Minier
