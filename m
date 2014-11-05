From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: % in $PATH
Date: Wed, 5 Nov 2014 11:59:47 +0000
Message-ID: <20141105115946.GA4029@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46635 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485AbaKEMAQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 5 Nov 2014 07:00:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1XlzG0-0004ze-4P
	for dash@vger.kernel.org; Wed, 05 Nov 2014 13:00:12 +0100
Received: from 5ec33b79.skybroadband.com ([94.195.59.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 05 Nov 2014 13:00:12 +0100
Received: from stephane.chazelas by 5ec33b79.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 05 Nov 2014 13:00:12 +0100
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

ash/dash have a nice feature that allows to have:

PATH=/bin:%builtin:/usr/bin:/some/dir%func:/sbin

To have commands in /bin take precedence over builtins and
files in /some/dir being looked up for autoloaded functions (a
bit like FPATH in ksh/zsh).

That's nice but the way it is implemented, that means that %
characters in $PATH cause problems. See for instance:

http://unix.stackexchange.com/questions/126955/percent-in-path-environment-variable

Where someone ran into it when they had a:

/home/torbjorr/deployed/vector/x86_64-GNU%2fLinux directory in
there.

Given than only "builtin" and "func" are recognised after "%", I
think it would be better if the PATH handling accepted any other
string like "foo%bar", "foo%2f", "foo%functions" as-is as a
normal $PATH component.

And foo%2fbar%func meaning "foo%2fbar" treated as a directory
with autoloadable functions.

-- 
Stephane

