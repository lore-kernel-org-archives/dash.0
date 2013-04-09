From: Dan Kegel <dank@kegel.com>
Subject: Re: Crash on valid input
Date: Mon, 8 Apr 2013 20:44:27 -0700
Message-ID: <CAPF-yOZXSWKW9tEY1uXCRBvQ6rg-WRHqaTdJiNMXD6EWyr1diQ@mail.gmail.com>
References: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com>
	<51638620.4030603@redhat.com>
	<CAPF-yOZmkcKSpU+jVMsSi6Q8harUYZ-hS5Ugn7SsbBwm-GzhiQ@mail.gmail.com>
	<51638AA0.4080701@redhat.com>
	<51638C52.50206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:47910 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab3DIDo3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Apr 2013 23:44:29 -0400
Received: by mail-lb0-f170.google.com with SMTP id x11so6440416lbi.1
        for <dash@vger.kernel.org>; Mon, 08 Apr 2013 20:44:28 -0700 (PDT)
In-Reply-To: <51638C52.50206@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

Yeah, even valgrind doesn't see anything without -x.


On Mon, Apr 8, 2013 at 8:34 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/08/2013 09:27 PM, Eric Blake wrote:
>> On 04/08/2013 09:12 PM, Dan Kegel wrote:
>>> Yes, my script was crap, I've fixed it.
>>>
>>> Here's the reproducer.  Called with foo unset.  I think it doesn't
>>> crash without -x.
>>>
>>> #!/bin/dash
>>> set -x
>>> test ! $foo
>>
>> The 'set -x' was indeed the key to reproducing the problem.  In fact,
>> this is the shortest I could make it:
>>
>> dash -cx 'test !'
>
> If it helps, dash -cx '[ ! ]' does not crash.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
