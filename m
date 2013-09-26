From: Miles Meloro <milesmeloro@yahoo.com>
Subject: Segmentation fault (core dumped) when enabling command line editing
Date: Thu, 26 Sep 2013 13:55:30 -0700 (PDT)
Message-ID: <1380228930.19036.YahooMailNeo@web160402.mail.bf1.yahoo.com>
Reply-To: Miles Meloro <milesmeloro@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from nm27-vm1.bullet.mail.bf1.yahoo.com ([98.139.213.148]:43416 "EHLO
	nm27-vm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951Ab3IZVCI (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 26 Sep 2013 17:02:08 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

I am receiving "Segmentation fault (core dumped)" any time I try the following commands in dash:

set -o vi
set -o emacs
dash -V
dash -E

I am using the latest git build with libedit enabled on an Arch Linux 
x86_64 machine. libedit (version 3.1-1 in the Arch Linux repositories) 
is also installed.

I've also tried all the Ubuntu versions of 0.5.7 on the same machine, but to no avail.
