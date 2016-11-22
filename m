From: =?UTF-8?Q?Andreas_Bofj=C3=A4ll?= <andreas@gazonk.org>
Subject: Re: [PATCH] trap: fix memory leak in exitshell()
Date: Tue, 22 Nov 2016 23:47:49 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1611222338400.12923@gazonk.org>
References: <20161121214052.32428-1-andreas@gazonk.org> <20161122215103.GA91593@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <dash-owner@vger.kernel.org>
Received: from h-85-24-133-13.na.cust.bahnhof.se ([85.24.133.13]:37138 "HELO
        gazonk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935180AbcKVWrw (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 22 Nov 2016 17:47:52 -0500
In-Reply-To: <20161122215103.GA91593@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Tue, 22 Nov 2016, Jilles Tjoelker wrote:

> On Mon, Nov 21, 2016 at 10:40:52PM +0100, Andreas Bofjall wrote:
>> diff --git a/src/trap.c b/src/trap.c
>> index edb9938..5418b07 100644
>> --- a/src/trap.c
>> +++ b/src/trap.c
>> @@ -389,6 +389,7 @@ exitshell(void)
>>  		trap[0] = NULL;
>>  		evalskip = 0;
>>  		evalstring(p, 0);
>> +		ckfree(p);
>>  	}
>>  out:
>>  	/*
>
> This patch will shut up valgrind in the common case, but does not handle
> the general case. The command string may contain an error or invoke the
> exit builtin and in either case the command string will be leaked
> (SIGINT might be expected to have a similar effect, but behaves
> strangely from an EXIT trap in dash).
>
> You can probably use the exception handling already present in the
> function to fix this. Note that ckfree() should only be used while
> INTOFF is in effect, both to avoid longjmp'ing out of free() and to
> ensure exactly one free in the presence of interruptions and errors.

Thanks for the feedback! Would something simple like moving the call to 
ckfree() to after the out: label and wrapping it in INTOFF/INTON (thereby 
catching both the normal return path and the exception) be ok, or do you 
mean something more elaborate?

/Andreas
