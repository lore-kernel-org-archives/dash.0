From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Fix variable assignments in function invocations
Date: Fri, 09 Jan 2015 18:55:55 +0100
Message-ID: <54B0162B.80408@gigawatt.nl>
References: <54B00D36.7070707@gigawatt.nl> <54B01242.9000907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:45880 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752305AbbAIR5B (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 9 Jan 2015 12:57:01 -0500
In-Reply-To: <54B01242.9000907@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, dash <dash@vger.kernel.org>

On 09/01/2015 18:39, Eric Blake wrote:
> On 01/09/2015 10:17 AM, Harald van Dijk wrote:
>> A short test script:
>>
>>    f() {
>>      echo inside f, VAR is $VAR
>>      sh -c 'echo inside sh called from f, VAR is $VAR'
>>    }
>>
>>    VAR=value f
>
> This behavior is tricky.  Here's the latest POSIX wording:
> http://austingroupbugs.net/view.php?id=654#c1559

 > [...]

> So the existing dash behavior is compliant, even if different from bash.

Thank you for the reference! I wasn't aware that the wording has since 
changed.

> I have no opinion on whether to take the patch in order to behave more
> like bash, or whether to tell script-writers to fix their script to
> avoid unspecified behavior because dash is already compliant in
> providing a different behavior than bash.

Well, perhaps it was already compliant, perhaps it became compliant by 
changing the standard, but either way, it is compliant now. :)

If either behaviour is allowed, then I believe dash aims to avoid 
breaking changes. Existing scripts written for dash could conceivably 
rely on the current behaviour, so without any real benefit, my patch 
would be a bad idea. bash compatibility is usually not considered a big 
benefit for dash, POSIX compatibility is.

Because of that, I withdraw my patch.

Cheers,
Harald van Dijk
