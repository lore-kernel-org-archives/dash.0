From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] [EXCEPTIONS] Stop documenting EXSHELLPROC
Date: Wed, 6 Oct 2010 22:04:14 -0500
Message-ID: <20101007030414.GA2285@burratino>
References: <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
 <20100628065326.GA25667@gondor.apana.org.au>
 <20101006100420.GA361@burratino>
 <20101006100804.GB361@burratino>
 <20101006102930.GA6573@gondor.apana.org.au>
 <20101006105531.GB475@burratino>
 <4CAC68FD.4040602@redhat.com>
 <20101007010241.GB1276@burratino>
 <20101007010347.GC1276@burratino>
 <20101007030153.GA15132@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56566 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759963Ab0JGDHX (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 23:07:23 -0400
Received: by ywh1 with SMTP id 1so107985ywh.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 20:07:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101007030153.GA15132@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

Herbert Xu wrote:
> On Wed, Oct 06, 2010 at 08:03:47PM -0500, Jonathan Nieder wrote:

>> --- a/src/error.h
>> +++ b/src/error.h
>> @@ -66,9 +66,8 @@ extern int exception;
>>  /* exceptions */
>>  #define EXINT 0		/* SIGINT received */
>>  #define EXERROR 1	/* a generic error */
>> -#define EXSHELLPROC 2	/* execute a shell procedure */
>> -#define EXEXEC 3	/* command execution failed */
>> -#define EXEXIT 4	/* exit the shell */
>> +#define EXEXEC 2	/* command execution failed */
>> +#define EXEXIT 3	/* exit the shell */
>
> There is no need to renumber things.  Just leave a gap.

Ok.  Should I fix it up or would you like to?

Thanks,
Jonathan
