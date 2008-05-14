From: Oleg Verych <olecom@flower.upol.cz>
Subject: strange `printf` arguments, parsing features (bugs?)
Date: Wed, 14 May 2008 18:59:31 +0200
Message-ID: <20080514165931.GB21428@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:54714 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYENQiP (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 14 May 2008 12:38:15 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 5A65B13CCFA
	for <dash@vger.kernel.org>; Wed, 14 May 2008 18:37:49 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id g5udMwMEJX5xhUO5 for <dash@vger.kernel.org>; Wed, 14 May 2008 18:37:49 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JwKKB-0002sh-RO
	for dash@vger.kernel.org; Wed, 14 May 2008 18:59:31 +0200
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

# (1) parameters to `printf`?

olecom@flower:/tmp$ sh -c 'printf "-1"'
printf: 1: Illegal option -1

# (2) parsing features?

olecom@flower:/tmp$ sh -c 'echo 1; } echo 2'
1
2
olecom@flower:/tmp$ sh -c '} echo 2'
sh: Syntax error: "}" unexpected
olecom@flower:/tmp$ sh -c 'echo 2; }'
2
olecom@flower:/tmp$

# (3) '\' in `` and in $();
# what is POSIX "literal meaning" of '\' in `` and what is '\\' then?
# bash has its own opinion

olecom@flower:/tmp$ PS2=''
olecom@flower:/tmp$ dash -s << '='
`echo ' \' >&2`
`echo ' \\' >&2`
`echo ' \\\' >&2`
`echo ' \\\\' >&2`
$(echo ' \' >&2)
$(echo ' \\' >&2)
$(echo ' \\\' >&2)
$(echo ' \\\\' >&2)
echo --
$(echo ' \\\\\' >&2)
`echo  ' \\\\\' >&2`
=
 \
 \
 \
 \
 \
 \
 \\
 \\
--
 \\\
 \\
olecom@flower:/tmp$ bash -s << '='
`echo ' \' >&2`
`echo ' \\' >&2`
`echo ' \\\' >&2`
`echo ' \\\\' >&2`
$(echo ' \' >&2)
$(echo ' \\' >&2)
$(echo ' \\\' >&2)
$(echo ' \\\\' >&2)
echo --
$(echo ' \\\\\' >&2)
`echo  ' \\\\\' >&2`
=
 \
 \
 \\
 \\
 \
 \\
 \\\
 \\\\
--
 \\\\\
 \\\
olecom@flower:/tmp$
