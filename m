From: Eric Blake <eblake@redhat.com>
Subject: Re: evaluation of env variables in DASH
Date: Wed, 19 Oct 2011 15:42:51 -0600
Message-ID: <4E9F445B.2090609@redhat.com>
References: <87aa8woesd.fsf@minignu.minidns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754607Ab1JSVm7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 Oct 2011 17:42:59 -0400
In-Reply-To: <87aa8woesd.fsf@minignu.minidns.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dima Sorkin <dima@minignu.minidns.net>
Cc: dash@vger.kernel.org, herbert@gondor.hengli.com.au

On 10/19/2011 03:24 PM, Dima Sorkin wrote:
> Hi.
>    The following DASH behaviour seems buggy to me

The only bug here is your expectations.

>
> -----------------
> $ export A='\n'
> $ echo $A
>

Passing a literal backslash to echo is non-portable.  POSIX even says 
so.  And bash can match dash behavior:

$ (shopt -s xpg_echo; A='\n'; echo -$A-)
-
