From: Gerrit Pape <pape@smarden.org>
Subject: unexpected parameter expansion
Date: Wed, 19 May 2010 19:19:28 +0000
Message-ID: <20100519191928.28202.qmail@10218569f54974.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:45931 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751682Ab0ESTTa (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 May 2010 15:19:30 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi, I get unexpected output with dash doing parameter expansions with }
within quotes involved, e.g.

$ dash -c 'foo=; echo ${foo:-"{a}bar"}'
{abar}
$ 

I expected:
{a}bar

http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=581428

Sorry, I don't have a patch to suggest.

Thanks, Gerrit.
