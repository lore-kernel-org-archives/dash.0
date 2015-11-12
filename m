From: Bastian Bittorf <bittorf@bluebottle.com>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 12 Nov 2015 09:10:06 +0100
Message-ID: <20151112081006.GV19618@medion.lan>
References: <5643F1B2.5050207@sanitarium.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.bluebottle.com ([176.9.67.91]:54091 "EHLO
	mail.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbKLIY2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Nov 2015 03:24:28 -0500
Content-Disposition: inline
In-Reply-To: <5643F1B2.5050207@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kevin Korb <kmk@sanitarium.net>
Cc: dash@vger.kernel.org

* Kevin Korb <kmk@sanitarium.net> [12.11.2015 08:52]:
> $ echo -n testing
> - -n testing

in POSIX the '-n' switch (and -e) is undefined.
you can work around this via hijacking the call:

#!/bin/sh
echo()
{
	case "$1" in
		'-n')
			shift
			printf '%s' "$@"
		;;
		*)
			printf '%s\n' "$@"
		;;
	esac
}

echo foo
echo -n bar

if you really want to remove all the bashisms, it
can be a lot of work. dont blame dash for this, but
the script author. also consider using shellsheck.net
for this with the correct shebang.

bye, bastian
