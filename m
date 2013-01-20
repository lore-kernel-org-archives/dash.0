From: z7z8th <ybzhao1989@gmail.com>
Subject: Fwd: variable scope bug in while loop when using pipe
Date: Sun, 20 Jan 2013 16:07:20 +0800
Message-ID: <CAOEkoLy1j1BECiqZ9NMbi-488tQnHKqB_ZO7qN6xmB7GfOR=VA@mail.gmail.com>
References: <CAOEkoLyvfc1-wdqGgUKwC2QLGJcUKVftf24zu_EYyAzPP9y3Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:33074 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab3ATIHm (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 20 Jan 2013 03:07:42 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so1157744wey.0
        for <dash@vger.kernel.org>; Sun, 20 Jan 2013 00:07:40 -0800 (PST)
In-Reply-To: <CAOEkoLyvfc1-wdqGgUKwC2QLGJcUKVftf24zu_EYyAzPP9y3Gg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

---------- Forwarded message ----------
From: z7z8th <ybzhao1989@gmail.com>
Date: 2013/1/18
Subject: variable scope bug in while loop when using pipe
To: dash@vger.kernel.org


$ ls -l /bin/sh
lrwxrwxrwx 1 root root 4 Aug 21 08:11 /bin/sh -> dash*

The script did not work as what I wanted? Do you think it's a bug?
>
> #!/bin/sh
>
> abc=99
>
> echo "1\n2" | while read line; do
>     echo "line=$line"
>     echo "abc=$abc"
>     abc=123
> done
>
> echo "abc=$abc"
>

The output looks like below:
>
> line=1
> abc=99
> line=2
> abc=123
> abc=99


I think the last line should be abc=123

If the while loop is not after the pipe, it works as what I wanted.

> #!/bin/sh
>
> abc=99
>
> line=1
> while [ $line -lt 3 ]; do
>     echo "line=$line"
>     echo "abc=$abc"
>     abc=123
>     line=$((line+1))
> done
>
> echo "abc=$abc"


the variable abc is 123 in the end.

Then I found this article talking about this problem.
http://www.kilala.nl/Sysadmin/index.php?id=741
It says that old bash has this problem.
But I found bash-4.2.37 and dash-0.5.7 has this problem too.

I'm using Debian testing.
Linux 3.2.0-4-amd64 #1 SMP Debian 3.2.35-2 x86_64 GNU/Linux
