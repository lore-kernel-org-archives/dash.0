From: Tormen <quickhelp@gmail.com>
Subject: Re: sed script fails to run in dash
Date: Sat, 23 Nov 2013 01:14:01 +0100
Message-ID: <528FF349.9020804@gmail.com>
References: <528F9E5E.4020807@gmail.com> <528FAFCB.5090807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:62222 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660Ab3KWAOG (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Nov 2013 19:14:06 -0500
Received: by mail-we0-f180.google.com with SMTP id u56so1847727wes.11
        for <dash@vger.kernel.org>; Fri, 22 Nov 2013 16:14:05 -0800 (PST)
In-Reply-To: <528FAFCB.5090807@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On 22/11/13 20:26, Eric Blake wrote:
> On 11/22/2013 11:11 AM, Tormen wrote:
>
>>     sed -e 1$'{w/dev/stdout\n;d}' -i /tmp/x
>>
>> in a dash script will yield the error message:
>>
>>     sed: -e expression #1, char 2: unknown command: `$'
>>
>> But why ? :(
> Because $'' is not (yet) in POSIX.  It will be required in a future
> release, but dash hasn't implemented it yet.
>
> http://austingroupbugs.net/view.php?id=249
Now I get how this script works ;)

Thanks !! :)

!!! And also thanks to all the other answers !!! - really appreciated! :)))

