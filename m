From: Luigi Tarenga <luigi.tarenga@gmail.com>
Subject: Re: possible bug in job control
Date: Tue, 30 Jul 2013 18:42:21 +0200
Message-ID: <CAKkO-Ej3N1MrKKkqxuVDgeky59joH8mN+X1EjXYaWMeuByd0RQ@mail.gmail.com>
References: <CAKkO-EgtZw6EuoBz1ishWc-V7LNOzFO98O7A8T=Rqq42DA_T1A@mail.gmail.com>
	<51F6F10C.4060109@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:44804 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab3G3QmW (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Jul 2013 12:42:22 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so705154obb.1
        for <dash@vger.kernel.org>; Tue, 30 Jul 2013 09:42:21 -0700 (PDT)
In-Reply-To: <51F6F10C.4060109@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

Hi Harald,
thanks for the patch. I tested it against source tarball (0.5.7) and
it works for me.
It works with the example scripts and with my script of parallel ssh
(tested with case of multiple of 4 jobs).

many thanks for the support
Luigi




On Tue, Jul 30, 2013 at 12:47 AM, Harald van Dijk <harald@gigawatt.nl> wrote:
> On 29/07/13 23:44, Luigi Tarenga wrote:
>> hi list,
>> while writing a script to execute parallel ssh command on many host I found
>> a strange behavior of dash. I can replicate it with a very simple script but
>> didn't find any documentation about dash or POSIX that can explain it.
>>
>> tested on centos 6.4 (dash 0.5.5.1) and wih dash compiled from source (0.5.7)
>> the following script reports error:
>>
>> #!/bin/dash
>>
>> sleep 3 &
>> sleep 3 &
>> sleep 3 &
>> sleep 3 &
>>
>> #/bin/true
>> jobs -l
>>
>> wait %1
>> wait %2
>> wait %3
>> wait %4
>>
>> [vortex@lizard ~]$ ./dash-0.5.7/src/dash test.sh
>> [4] + 4569 Running
>> [3] - 4568 Running
>> [2]   4567 Running
>> [1]   4566 Running
>> prova: 14: wait: No such job: %4
>> [vortex@lizard ~]$ echo $?
>> 2
>
> Yes, this looks like a bug to me. The number of allocated jobs is always
> kept as a multiple of four, and the first check in considering whether
> the job number is valid is "if it's greater than or equal to the number
> of allocated job, it's invalid". That doesn't look right. That would
> only be right if jobs were zero-based, but they aren't. If it's exactly
> equal to the number of available jobs, it can still be valid. It works
> when adding /bin/true, because four more more jobs end up allocated
> internally.
>
> The attached patch should fix it.
>
> Cheers,
> Harald
