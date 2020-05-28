From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Improving xtrace output from subshells
Date: Thu, 28 May 2020 12:57:27 +0100
Message-ID: <d068031c-7ff4-22bd-4951-eeeaea278386@gigawatt.nl>
References: <E1hJgiD-0002yZ-Qb@smtp.tt-solutions.com>
 <6102c49c-573b-0fee-9a5d-f844eab2e8c0@gigawatt.nl>
 <E1hKNxE-0007Iw-04@smtp.tt-solutions.com>
 <6e753e30-1df6-ec65-07c4-5337b9f93901@gigawatt.nl>
 <E1hL7Vk-0005Me-22@smtp.tt-solutions.com>
 <e9cdb884-89d6-9b9d-3cb8-38b9b862aa9d@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:57902 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389025AbgE1L5b (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 28 May 2020 07:57:31 -0400
In-Reply-To: <e9cdb884-89d6-9b9d-3cb8-38b9b862aa9d@gigawatt.nl>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Vadim Zeitlin <vz-dash@zeitlins.org>, dash@vger.kernel.org

On 29/04/2019 23:55, Harald van Dijk wrote:
> On 29/04/2019 15:44, Vadim Zeitlin wrote:
>> On Sat, 27 Apr 2019 22:58:23 +0100 Harald van Dijk 
>> <harald@gigawatt.nl> wrote:
>> HvD> It wastes memory: the code should be re-worked so that output and
>> HvD> preverrout share the same buffer, given that there can never be 
>> pending
>> HvD> output for one when the other is being written to.
>>
>>   I'm a bit worried about this one, it doesn't seem completely obvious 
>> to me
>> that the 2 objects can't be used at the same time.
> 
> It's indeed not completely obvious, but all bits that print to output 
> will flush the buffer when they're done, before a next command starts 
> executing, before the next command requires an xtrace string to be 
> printed. It's usually the flushall() in evalbltin() that handles this.

I have managed to verify that using a single buffer for all streams 
(output, errout and preverrout) works well and simplifies logic so that 
the shell with that change is actually smaller than the one without it. 
I do not know whether there would be interest in getting that in dash.

Cheers,
Harald van Dijk
