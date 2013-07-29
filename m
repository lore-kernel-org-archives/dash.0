From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: possible bug in job control
Date: Tue, 30 Jul 2013 00:47:40 +0200
Message-ID: <51F6F10C.4060109@gigawatt.nl>
References: <CAKkO-EgtZw6EuoBz1ishWc-V7LNOzFO98O7A8T=Rqq42DA_T1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000800050105030302040703"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:56347 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755681Ab3G2Wr5 (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 29 Jul 2013 18:47:57 -0400
In-Reply-To: <CAKkO-EgtZw6EuoBz1ishWc-V7LNOzFO98O7A8T=Rqq42DA_T1A@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Luigi Tarenga <luigi.tarenga@gmail.com>
Cc: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------000800050105030302040703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 29/07/13 23:44, Luigi Tarenga wrote:
> hi list,
> while writing a script to execute parallel ssh command on many host I found
> a strange behavior of dash. I can replicate it with a very simple script but
> didn't find any documentation about dash or POSIX that can explain it.
> 
> tested on centos 6.4 (dash 0.5.5.1) and wih dash compiled from source (0.5.7)
> the following script reports error:
> 
> #!/bin/dash
> 
> sleep 3 &
> sleep 3 &
> sleep 3 &
> sleep 3 &
> 
> #/bin/true
> jobs -l
> 
> wait %1
> wait %2
> wait %3
> wait %4
> 
> [vortex@lizard ~]$ ./dash-0.5.7/src/dash test.sh
> [4] + 4569 Running
> [3] - 4568 Running
> [2]   4567 Running
> [1]   4566 Running
> prova: 14: wait: No such job: %4
> [vortex@lizard ~]$ echo $?
> 2

Yes, this looks like a bug to me. The number of allocated jobs is always
kept as a multiple of four, and the first check in considering whether
the job number is valid is "if it's greater than or equal to the number
of allocated job, it's invalid". That doesn't look right. That would
only be right if jobs were zero-based, but they aren't. If it's exactly
equal to the number of available jobs, it can still be valid. It works
when adding /bin/true, because four more more jobs end up allocated
internally.

The attached patch should fix it.

Cheers,
Harald

--------------000800050105030302040703
Content-Type: text/x-patch;
 name="dash-getjob-off-by-one.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-getjob-off-by-one.patch"

commit ddeba5485c3309ffc7010f8924d604a781908e1d
Author: Harald van Dijk <harald@gigawatt.nl>
Date:   Tue Jul 30 00:36:53 2013 +0200

    getjob: Fix off-by-one error for multiple of four job numbers

diff --git a/src/jobs.c b/src/jobs.c
index bf40204..c2c2332 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -699,7 +699,7 @@ check:
 
 	if (is_number(p)) {
 		num = atoi(p);
-		if (num < njobs) {
+		if (num <= njobs) {
 			jp = jobtab + num - 1;
 			if (jp->used)
 				goto gotit;

--------------000800050105030302040703--
