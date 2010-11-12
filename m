From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Fri, 12 Nov 2010 20:39:30 +0059
Message-ID: <4CDD980A.6020801@gigawatt.nl>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl> <4CDD8481.1060306@gigawatt.nl> <4CDD8908.9010206@redhat.com> <4CDD9095.5070106@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:38292 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753700Ab0KLTif (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 12 Nov 2010 14:38:35 -0500
In-Reply-To: <4CDD9095.5070106@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Eric Blake <eblake@redhat.com>, Jilles Tjoelker <jilles@stack.nl>

On 12/11/10 20:08, Harald van Dijk wrote:
> On 12/11/10 19:35, Eric Blake wrote:
>> On 11/12/2010 11:17 AM, Harald van Dijk wrote:
>>> (
>>> :
>>> :
>>> :
>>> :
>>> :
>>> )>test-$LINENO
>>>
>> Umm - there was more than one word in that example (each : in the
>> subshell is a word)
>
> That was because it was a poor example. I meant to use comments,

...which don't work, because a command is required between ( and ). 
Never mind that part.
