From: "Vitaly Zuevsky" <vitaly.zuevsky@gmail.com>
Subject: RE: Bug#953421: dash: Resident Set Size growth is unbound (memory leak) on an infinite shell loop
Date: Tue, 31 Mar 2020 20:07:55 +0100
Message-ID: <083501d6078f$afb4fc80$0f1ef580$@gmail.com>
References: <158376996556.31988.8584094104007124674.reportbug@ec2-34-240-101-198.eu-west-1.compute.amazonaws.com> <CACujMDPfs5mJs8CVaxqM6wkCRANYQ71wTUkvHiNvOg+MPSTECQ@mail.gmail.com> <07ce01d605f3$103f1610$30bd4230$@gmail.com> <a2efaae8-db1b-39ae-d7c2-8d119a4f14d4@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37429 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgCaTH4 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 31 Mar 2020 15:07:56 -0400
Received: by mail-wm1-f49.google.com with SMTP id j19so4148991wmi.2
        for <dash@vger.kernel.org>; Tue, 31 Mar 2020 12:07:55 -0700 (PDT)
In-Reply-To: <a2efaae8-db1b-39ae-d7c2-8d119a4f14d4@gigawatt.nl>
Content-Language: en-gb
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: 'Harald van Dijk' <harald@gigawatt.nl>, 'Andrej Shadura' <andrew@shadura.me>, 953421@bugs.debian.org, dash@vger.kernel.org
Cc: 'Debian Bug Tracking System' <submit@bugs.debian.org>

Hi Harald,


>   set -- $(seq 1 100)
>   for i
>   do
>     : &
>     sleep .1
>   done
>   for i
>   do
>     wait %$i
>   done
>
>This is a valid script and works fine in dash. Your change breaks this =
by not keeping the jobs around long enough, and I hope this test script =
shows that there is no way to keep the jobs around long enough but by =
allocating ever more memory.

I must have confused two concepts: waited process in OS -vs- waited job =
inside shell interpreter. I am trying to see how it work in practice:

# true & false &
#
[2] + Done(1)                    false
[1] + Done                       true
# wait 2
# echo $?
127

As we preserve job exit codes, I would expect wait command to read them =
and free associated jobtab slots. In above example I expect to see 1 in =
place of 127. What do I miss here?

Many thanks for your help.

Best,
Vitaly =20
