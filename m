From: Alexander Huemer <alexander.huemer@xx.vu>
Subject: How to list functions?
Date: Tue, 22 Oct 2013 14:05:56 +0200
Message-ID: <20131022120556.GD12206@yade.xx.vu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from yade.xx.vu ([78.47.92.94]:37363 "EHLO yade.xx.vu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab3JVMGB (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 22 Oct 2013 08:06:01 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

posh has support for functions.

$ f() { echo foo; }
$ f
foo
$ 

Unfortunately I am unable to list the defined functions.
I tried `typeset`, `declare` and `set` without success in posh 0.10.2 on 
Debain Wheezy.
Any hints very welcome.
Thanks in advance.

Kind regards,
-Alex
