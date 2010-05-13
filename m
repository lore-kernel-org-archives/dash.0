From: Gerrit Pape <pape@smarden.org>
Subject: IFS regression in 55c46b7
Date: Thu, 13 May 2010 23:50:17 +0000
Message-ID: <20100513235017.5480.qmail@9329a0bb15f239.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:59461 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751311Ab0EMXuU (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 13 May 2010 19:50:20 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

Hi, commit 55c46b7 introduces a regression in IFS handling, see
http://bugs.debian.org/581351

To reproduce, run
$ echo a:b |src/dash -c 'IFS=: read a b; echo $a $b'

with dash built from 55c46b7^:
$ echo a:b |src/dash -c 'IFS=: read a b; echo $a $b'
a b

with 55c46b7 and HEAD
$  echo a:b |src/dash -c 'IFS=: read a b; echo $a $b'
a:b

Thanks, Gerrit.
