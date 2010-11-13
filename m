From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: static vs. dynamic scoping
Date: Sun, 14 Nov 2010 00:21:51 +0059
Message-ID: <4CDF1DA7.9000109@gigawatt.nl>
References: <4CD9C50D.5010305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:43005 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752736Ab0KMXUt (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 18:20:49 -0500
In-Reply-To: <4CD9C50D.5010305@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Eric Blake <eblake@redhat.com>

On 09/11/10 23:02, Eric Blake wrote:
> 2. User aspect:
>    Is anyone aware of a script that intentionally uses the full power of
> dynamic scoping available through 'local' which would break if scoping
> switched to static?

FWIW, some scripts use "local IFS" to reset IFS to a sane value, and 
have the shell take care of restoring it afterwards. This works with 
ksh's typeset, but because of the static scoping only so long as no 
other shell functions get called, or those other shell functions also 
take the effort to handle IFS correctly. In the scripts I have been able 
to find, other shell functions do get called, but they themselves set 
IFS too. Still, it may be worth keeping in mind, if only to serve as one 
of the few examples of when dynamic scoping would have been slightly 
more useful.
