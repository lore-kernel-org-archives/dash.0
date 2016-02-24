From: Oleg Bulatov <oleg@bulatov.me>
Subject: Re: heredoc and subshell
Date: Wed, 24 Feb 2016 23:27:39 +0300
Message-ID: <1528771456345659@web29m.yandex.ru>
References: <2978711456265264@web9h.yandex.ru>
	 <56CCE1E3.1060805@redhat.com> <56cd8cd1.LdVYbpfe+0tQMm8I%Joerg.Schilling@fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from forward16m.cmail.yandex.net ([5.255.216.147]:54819 "EHLO
	forward16m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757313AbcBXUcv (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 24 Feb 2016 15:32:51 -0500
In-Reply-To: <56cd8cd1.LdVYbpfe+0tQMm8I%Joerg.Schilling@fokus.fraunhofer.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Joerg Schilling <joerg.schilling@fokus.fraunhofer.de>, "eblake@redhat.com" <eblake@redhat.com>, "dash@vger.kernel.org" <dash@vger.kernel.org>, "austin-group-l@opengroup.org" <austin-group-l@opengroup.org>

24.02.2016, 13:58, "Joerg Schilling" <Joerg.Schilling@fokus.fraunhofer.de>:
> BTW: If I replace $(..) by `..` and feed the code to the original SVr4 Bourne
> Shell, I get the same output as you got from bash. I would guess that the bash
> output you added above is correct.

The behavior of `..` with heredoc has also interesting corner cases:

$ cat x.sh 
cat <<END ; echo `echo a
echo b`
hello
END
$ dash x.sh 
echo ba
x.sh: 3: x.sh: hello: not found
x.sh: 4: x.sh: END: not found
$ bash x.sh
hello
a b
$

On the one hand it reads heredoc, on the other hand it processes closing of the subshell.

-- 
Oleg
