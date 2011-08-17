From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/2] [SHELL] Allow building without LINEO support.
Date: Wed, 17 Aug 2011 06:35:48 -0600
Message-ID: <4E4BB5A4.10702@redhat.com>
References: <20110816.174502.2209127983953431973.davem@davemloft.net>	 <20110817011235.GA22867@elie.gateway.2wire.net> <1313561086.28006.6.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab1HQMgZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 17 Aug 2011 08:36:25 -0400
In-Reply-To: <1313561086.28006.6.camel@linux>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On 08/17/2011 12:04 AM, Harald van Dijk wrote:
> On Tue, 2011-08-16 at 20:12 -0500, Jonathan Nieder wrote:
>> David Miller wrote:
>>
>>> [Subject: [SHELL] Allow building without LINEO support.]
>>
>> Thanks!  Debian has been using something like this (but unconditional)
>> to convince autoconf not to use dash as CONFIG_SHELL, to work around
>> bugs in various configure scripts[1].  I imagine other users might
>> want the same thing, so a patch like this seems like a good idea.
>
> If you don't mind me asking, if you want configure scripts to run from
> bash, why not simply run configure scripts from bash, instead of running
> them from sh and trusting that sh will call bash if it is really some
> other shell?

And remember, most configure scripts already support that:

CONFIG_SHELL=path/to/bash path/to/bash ./configure

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
