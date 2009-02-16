From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] [SHELL] execute EXIT trap if the shell is killed through a signal
Date: Mon, 16 Feb 2009 13:23:19 +0000 (UTC)
Message-ID: <loom.20090216T131932-924@post.gmane.org>
References: <20090211145509.21298.qmail@bfa063280f4838.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:54110 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898AbZBPNaE (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 16 Feb 2009 08:30:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LZ3Xu-0007Ci-FJ
	for dash@vger.kernel.org; Mon, 16 Feb 2009 13:30:02 +0000
Received: from host3.bln.innominate.com ([77.245.32.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 16 Feb 2009 13:30:02 +0000
Received: from pape by host3.bln.innominate.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 16 Feb 2009 13:30:02 +0000
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Gerrit Pape <pape <at> smarden.org> writes:
> From: Chris Lamb <chris <at> chris-lamb.co.uk>
> 
> dash used to print the following output when running this test script
> 
>  $ dash -c 'trap "echo EXIT trap executed" EXIT; kill -HUP $$'
>  Hangup
>  $
> 
> With this commit, it properly executes the EXIT trap defined
> 
>  $ dash -c 'trap "echo EXIT trap executed" EXIT; kill -HUP $$'
>  EXIT trap executed
>  $
> 
> The missing trap handling was reported by Martin Dickopp through
>  http://bugs.debian.org/390433

Hi, sorry, the patch causes severe problems, and so should not be applied, see

 http://bugs.debian.org/515229
 http://bugs.debian.org/515064

Regards, Gerrit.


