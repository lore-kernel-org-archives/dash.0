From: Seb <sbb@tuxfamily.org>
Subject: Re: Fwd: variable scope bug in while loop when using pipe
Date: Sun, 20 Jan 2013 11:22:12 +0100
Message-ID: <20130120112212.c8592b53566496716dc81526@tuxfamily.org>
References: <CAOEkoLyvfc1-wdqGgUKwC2QLGJcUKVftf24zu_EYyAzPP9y3Gg@mail.gmail.com>
	<CAOEkoLy1j1BECiqZ9NMbi-488tQnHKqB_ZO7qN6xmB7GfOR=VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:35841 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3ATKYH (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 20 Jan 2013 05:24:07 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id D2CACD1AEAD
	for <dash@vger.kernel.org>; Sun, 20 Jan 2013 11:24:03 +0100 (CET)
In-Reply-To: <CAOEkoLy1j1BECiqZ9NMbi-488tQnHKqB_ZO7qN6xmB7GfOR=VA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: z7z8th <ybzhao1989@gmail.com>

Hello,

It's not a bug, both are POSIX, placing a pipe member in the current
environment instead of in a subshell being an extension:

 Command substitution, commands that are grouped with parentheses, and
 asynchronous lists shall be executed in a subshell environment.
 Additionally, each command of a multi-command pipeline is in a
 subshell environment; as an extension, however, any or all commands
 in a pipeline may be executed in the current environment.

 http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_12

++
Seb.
