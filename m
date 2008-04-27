From: Oleg Verych <olecom@flower.upol.cz>
Subject: executing with Bash (Re: Shell source with relative pathname does not work)
Date: Sun, 27 Apr 2008 14:19:39 +0200
Message-ID: <20080427121939.GO24008@flower.upol.cz>
References: <1209282837.21826.6.camel@aurora.internal> <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:55842 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbYD0L6z (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 07:58:55 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 810FF21FFC0
	for <dash@vger.kernel.org>; Sun, 27 Apr 2008 13:58:45 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id ENN64q67V0HOtHf5 for <dash@vger.kernel.org>; Sun, 27 Apr 2008 13:58:45 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Jq5r1-0002mG-2U
	for dash@vger.kernel.org; Sun, 27 Apr 2008 14:19:39 +0200
Content-Disposition: inline
In-Reply-To: <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> `bash` seem to do searching in `.', but this must be its feature.

And this one seem like potential problem:

Bash actually finds valid "commands" (other than first line with
'%PDF-1.3') in a PDF file and tries to execute them.

olecom@flower:/tmp$ dash -c '. ./AT32UC3A-doc32058.pdf'
: not founddoc32058.pdf: 1: %PDF-1.2
./AT32UC3A-doc32058.pdf: 1: Syntax error: Unterminated quoted string
olecom@flower:/tmp$ bash -c '. ./AT32UC3A-doc32058.pdf'
./AT32UC3A-doc32058.pdf: line 1: fg: no job control
./AT32UC3A-doc32058.pdf: line 2: 57950: command not found
olecom@flower:/tmp$
olecom@flower:/tmp$ dash -c '. ./foo.pdf'
: not found1: %PDF-1.3
./foo.pdf: 1: Syntax error: Unterminated quoted string
olecom@flower:/tmp$ bash -c '. ./foo.pdf'
./foo.pdf: line 1: fg: no job control
./foo.pdf: line 2: e: command not found
./foo.pdf: line 2: g: command not found
./foo.pdf: line 2: 102: command not found
olecom@flower:/tmp$


Even '-e' flag is somewhat wired:


olecom@flower:/tmp$ dash -e -c '. ./foo.pdf'
: not found1: %PDF-1.3
olecom@flower:/tmp$
olecom@flower:/tmp$ bash -e -c '. ./foo.pdf'
./foo.pdf: line 1: fg: no job control
olecom@flower:/tmp$
____
