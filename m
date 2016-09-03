From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Sat, 3 Sep 2016 14:03:28 +0200
Message-ID: <b25fbf0a-1b36-24d4-9a6c-7d8a9d8dd894@gigawatt.nl>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902142928.GA13022@gondor.apana.org.au>
 <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
 <20160902145153.GA13458@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:46698
        "EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751953AbcICMDn (ORCPT
        <rfc822;dash@vger.kernel.org>); Sat, 3 Sep 2016 08:03:43 -0400
In-Reply-To: <20160902145153.GA13458@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Eric Blake <eblake@redhat.com>
Cc: olof@ethup.se, dash@vger.kernel.org

On 02/09/16 16:51, Herbert Xu wrote:
> On Fri, Sep 02, 2016 at 09:49:53AM -0500, Eric Blake wrote:
>> On 09/02/2016 09:29 AM, Herbert Xu wrote:
>>> On Fri, Sep 02, 2016 at 09:25:15AM -0500, Eric Blake wrote:
>>>>
>>>>>> This also affects
>>>>>>
>>>>>>     case [a in [?) echo ok ;; *) echo bad ;; esac
>>>>>>
>>>>>> which should print ok.
>>>>>
>>>>> Even ksh prints bad here.
>>>>
>>>> So ksh is also buggy.
>>>
>>> Good luck writing a script with an unquoted [ expecting it to be
>>> portable :)
>>
>> [ '' ] || echo empty
>>
>> There, I just wrote a portable script with unquoted [ portably
>> interpreted as itself and not as a bracket filename expansion pattern.
>
> dash handles that just fine.  We're not talking about a lone [
> in file expansion context here.

We were originally talking about the [ in ${foo#[}. That is a lone [ in 
pattern matching context, which is what file expansion context is.

We're talking about something that dash has had code to handle for >10 
years, that's been documented by dash as supported for >10 years, and 
now that it turns out there's a flaw in the code where dash does not 
behave as documented and as clearly intended by the code, it's POSIX's 
fault?
