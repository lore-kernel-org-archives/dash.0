From: "Vitaly Zuevsky" <vitaly.zuevsky@gmail.com>
Subject: RE: Bug#953421: dash: Resident Set Size growth is unbound (memory leak) on an infinite shell loop
Date: Thu, 2 Apr 2020 14:18:28 +0100
Message-ID: <004401d608f1$3349e670$99ddb350$@gmail.com>
References: <158376996556.31988.8584094104007124674.reportbug@ec2-34-240-101-198.eu-west-1.compute.amazonaws.com> <CACujMDPfs5mJs8CVaxqM6wkCRANYQ71wTUkvHiNvOg+MPSTECQ@mail.gmail.com> <07ce01d605f3$103f1610$30bd4230$@gmail.com> <a2efaae8-db1b-39ae-d7c2-8d119a4f14d4@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39478 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbgDBNS0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 2 Apr 2020 09:18:26 -0400
Received: by mail-wr1-f49.google.com with SMTP id p10so4157969wrt.6
        for <dash@vger.kernel.org>; Thu, 02 Apr 2020 06:18:25 -0700 (PDT)
Content-Language: en-gb
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: 'Harald van Dijk' <harald@gigawatt.nl>, 'Andrej Shadura' <andrew@shadura.me>, 953421@bugs.debian.org, dash@vger.kernel.org
Cc: 'Debian Bug Tracking System' <submit@bugs.debian.org>

Hi Harald,

Thanks for comprehensive account of the job flow - all worked as =
expected now.

Interestingly, I originally assumed it was a bug due to observed =
discrepancy with bash...

On 29/03/2020 23:07, Jilles Tjoelker wrote:
> I agree that the change is incorrect, but I do not agree that this =
kind
> of script must leak memory. Per POSIX.1-2008 XCU 2.9.3.1 Asynchronous
> Lists, an implementation has additional ways to forget about jobs than
> just an appropriate completion of the wait utility: if another
> asynchronous job is started when $! was not referenced or if the =
number
> of known process IDs would exceed {CHILD_MAX} (which tends to be =
rather
> big, though).

I can see in Bash man pages:

CHILD_MAX
  Set the number of exited child status values for the shell to =
remember.  Bash will not allow this value to be decreased
  below a POSIX-mandated minimum, and there is a maximum value =
(currently 8192) that this may not  exceed.   The  minimum
  value is system-dependent.

Running above scripts under bash shell manifests growing RSS just =
initially, and with sleep .1 that growth will end after some 800 seconds =
as one could deduce from the man pages. That is, RSS growth is bound.

I understand dash philosophy could be focussed on the most minimalistic =
solution possible. Such solution would inherently be less forgiving in =
terms of mistakes. On the other hand, the mistake in question can be =
difficult to detect and leads all the way to OOM, negatively affecting =
user experience.

It is up to you and community where that balance should rest. And if you =
decide the change would be worthy of doing - I will be more than happy =
to contribute.

Cheers,
Vitaly=20
