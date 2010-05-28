From: Kris Maglione <maglione.k@gmail.com>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Fri, 28 May 2010 11:34:23 -0400
Message-ID: <20100528153423.GA3885@jg.home>
References: <20100527202157.08a1fa53@gmail.com>
 <20100528045316.GA18560@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45852 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0E1PlO (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 11:41:14 -0400
Received: by wya21 with SMTP id 21so278253wya.19
        for <dash@vger.kernel.org>; Fri, 28 May 2010 08:41:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100528045316.GA18560@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On Fri, May 28, 2010 at 02:53:16PM +1000, Herbert Xu wrote:
>Kris Maglione <maglione.k@gmail.com> wrote:
>>
>> I'm not sure how to describe this bug, but it's affected one of my
>> scripts, and those of several of my users. Basically, we've had loops
>> dieing when backgrounded programs exit. This is the simplest test case
>> I can come up with:
>>
>> #!/bin/dash
>> {
>>        echo foo
>>        sleep 1
>>        echo foo
>>        echo done>/dev/tty
>> } | while read p; do
>>        ( echo good & ) &
>> done
>> echo done
>>
>>
>> In versions prior to 3800d4934391b, the output would
>> "good\ndone\ndone\ngood" (or some permutation thereof depending on
>> system load), but from 3800d4934391b on, it's "good\ndone".
>
>This should be fixed by the patch that I posted yesterday.

I should have mentioned that I tested it with every revision 
upto and including that one (especially as it looked promising).

I definitely still have this problem as of 
207e4c2a322fe: [JOBS] Fix wait regression where it does not wait for all jobs  master 

Thanks,
-- 
Kris Maglione

Real Programmers don't believe in schedules.  Planners make up
schedules.  Managers "firm up" schedules.  Frightened coders strive to
meet schedules.  Real Programmers ignore schedules.

