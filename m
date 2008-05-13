From: Oleg Verych <olecom@flower.upol.cz>
Subject: arithmetics Re: command modifiers
Date: Tue, 13 May 2008 04:07:14 +0200
Message-ID: <20080513020714.GA21428@flower.upol.cz>
References: <8499950a0804301800x3577741ex3646035f8350e399@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:37669 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822AbYEMBqB (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 12 May 2008 21:46:01 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 047C1136C83
	for <dash@vger.kernel.org>; Tue, 13 May 2008 03:45:36 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id 3cN0oz3u8zhkP6Fp for <dash@vger.kernel.org>; Tue, 13 May 2008 03:45:36 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Jvjv8-00035h-RW
	for dash@vger.kernel.org; Tue, 13 May 2008 04:07:14 +0200
Content-Disposition: inline
In-Reply-To: <8499950a0804301800x3577741ex3646035f8350e399@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> To list of my failed shell inventions[0], i'd like to add following.
> 
> [0] ftp://flower.upol.cz/dts/ash0000_var/ideas

Arithmetics is the basic knowledge, anyone must have and develop over the
whole life. (i'm a dreamer)

Yet this is not the case in shell:

   original calculating size of variables in `sh` with `expr` and regular
   expressions. (no comments)

Now feature is implemented in shell natively, yet:

* only signed 32 values (don't say it's POSIX)
* "small" and "fast"` dash` has it in bulky bison and stuff (ou, crap)

For start, size and sign (thus, easy seek() in /dev/kmem, for example)

$(s32(...)) || $(s(...))
$(u32(...)) || $(u(...))
$(s64(...)) || $(ss(...))
$(u64(...)) || $(uu(...))

if this will have problems with $(), then more stupid postfix form:

$((...)s); $((...)uu)

Extending to the future: u128, or uuuu, etc.

maybe even to have

sizeof(s||u) = 32b; sizeof(S||U) = 16b; (for flexibility with 16-bit);
____
