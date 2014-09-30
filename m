From: Olof Johansson <olof@ethup.se>
Subject: Re: 'set' leaks garbage from environment
Date: Tue, 30 Sep 2014 17:14:49 +0200
Message-ID: <20140930151449.GB22440@brutus.ethup.se>
References: <542AC5C7.5090307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from brutus.ethup.se ([85.17.45.102]:39004 "EHLO brutus.ethup.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbaI3PWA (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Sep 2014 11:22:00 -0400
Content-Disposition: inline
In-Reply-To: <542AC5C7.5090307@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On 2014-09-30 09:01 -0600, Eric Blake wrote:
> $ dash -c 'unset "a|b"
> $ echo $?
> 0

Works for me (tested on both Debian package versions 0.5.7-3 (wheezy)
and 0.5.7-4 (unstable)):

$ dash -c 'unset "a|b"'
dash: 1: unset: a|b: bad variable name
$ echo $?
2

> $ env 'a|b=' dash -c 'set | grep a"."b'
> a|b=''

This I can reproduce though.

-- 
 --------------------------------------------------------------- 
| Olof Johansson                              http://stdlib.se/ |
|  irc: zibri                           https://github.com/olof |
 --------------------------------------------------------------- 
