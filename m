From: John Marshall <john.marshall@sanger.ac.uk>
Subject: builtin read -r and backslash-char escape sequences
Date: Mon, 3 Aug 2015 17:37:20 +0100
Message-ID: <EDC4419D-6669-4211-9005-8970B5499D9A@sanger.ac.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.sanger.ac.uk ([193.62.202.243]:14764 "EHLO
	smtp.sanger.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbbHCQ4w convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 3 Aug 2015 12:56:52 -0400
Received: from mib103854i.internal.sanger.ac.uk ([172.20.10.98])
	by intmail3a.internal.sanger.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john.marshall@sanger.ac.uk>)
	id 1ZMIjq-0008Jf-9V
	for dash@vger.kernel.org; Mon, 03 Aug 2015 17:37:22 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Problems with one of my scripts appear to have been caused by dash's read -r translating escape sequences (like \t) whereas several other shells read them literally.  For example:

$ printf '%s' '\a\t\x' > backslashes 
$ dash -c 'read -r foo < backslashes; echo "$foo"' | cat -t
^G^I\x
$ bash -c 'read -r foo < backslashes; echo "$foo"' | cat -t
\a\t\x
$ ksh -c 'read -r foo < backslashes; echo "$foo"' | cat -t
\a\t\x

POSIX says of -r, "Do not treat a <backslash> character in any special way. Consider each <backslash> to be part of the input line" [1].  Translating them as escape sequences doesn't appear to be particularly compatible with this, but conceivably the translation is occurring at some other stage.

Is this the intended behaviour?

Thanks,

    John

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/read.html#tag_20_109_04

-- 
 The Wellcome Trust Sanger Institute is operated by Genome Research 
 Limited, a charity registered in England with number 1021457 and a 
 company registered in England with number 2742969, whose registered 
 office is 215 Euston Road, London, NW1 2BE. 
