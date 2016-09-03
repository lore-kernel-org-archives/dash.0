From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Sat, 3 Sep 2016 15:19:57 +0200
Message-ID: <1acf6563-5a42-2bfa-ac7a-fbdd2c315b85@gigawatt.nl>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902142928.GA13022@gondor.apana.org.au>
 <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
 <20160902145153.GA13458@gondor.apana.org.au>
 <b25fbf0a-1b36-24d4-9a6c-7d8a9d8dd894@gigawatt.nl>
 <20160903130506.GA19749@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:45081
        "EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751091AbcICNUF (ORCPT
        <rfc822;dash@vger.kernel.org>); Sat, 3 Sep 2016 09:20:05 -0400
In-Reply-To: <20160903130506.GA19749@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, olof@ethup.se, dash@vger.kernel.org

On 03/09/16 15:05, Herbert Xu wrote:
> On Sat, Sep 03, 2016 at 02:03:28PM +0200, Harald van Dijk wrote:
>>>>>>
>>>>>>>> This also affects
>>>>>>>>
>>>>>>>>    case [a in [?) echo ok ;; *) echo bad ;; esac
>>
>> We're talking about something that dash has had code to handle for
>>> 10 years, that's been documented by dash as supported for >10
>> years, and now that it turns out there's a flaw in the code where
>> dash does not behave as documented and as clearly intended by the
>> code, it's POSIX's fault?
>
> dash has never worked this way.

Very misleading to continue quoting the complicated case but leave out 
the simple case again: dash doesn't handle even ${foo#[} correctly. And 
again, by correctly I mean as documented by dash, as required by POSIX, 
and as clearly intended by the author at the time the code was written. 
I do not know if you were the author of that specific piece of code.

But yeah, sure, if the bug has been there for over 10 years, and I'm 
unable to find older versions of dash to check, I would have guessed 
that dash indeed has never worked this way.

> What's worse is that your patch
> changes dash's behaviour in a way that is inconsistent with every
> shell out there except bash.

For the simple case, ksh and posh also strip a leading [ if doing ${foo#[}.

For the complicated case, at the very least, it makes dash consistent 
between builds. If you feel that for the complicated case, bad should be 
printed rather than ok, then that just makes dash buggy in the 
--enable-fnmatch builds, it still means there's something to fix.
