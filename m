From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Mon, 23 Apr 2012 19:09:40 +0200
Message-ID: <4F958CD4.5000604@gmail.com>
References: <4F958907.9030508@gmail.com> <20120423170339.GA9635@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63198 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab2DWRJr (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 13:09:47 -0400
Received: by eaaq12 with SMTP id q12so3281256eaa.19
        for <dash@vger.kernel.org>; Mon, 23 Apr 2012 10:09:45 -0700 (PDT)
In-Reply-To: <20120423170339.GA9635@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org

Hi Jonathan, thanks for the quick reply.

On 04/23/2012 07:03 PM, Jonathan Nieder wrote:
> Hi Stefano,
> 
> Stefano Lattarini wrote:
> 
>> How to reproduce:
>>
>>   $ dash -c ':; fi'; echo stat = $?
>>   stat = 0
> 
> Since this doesn't affect conforming scripts,
>
True, it it makes "dash -n" less useful (not that I deeply care, just pointing
it out).

> I suspect it falls squarely within the "patches welcome as long as they
> don't make dash bigger" category.
> 
> Thanks for finding it.
> 
> Sincerely,
> Jonathan

Thanks,
  Stefano
