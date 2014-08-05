From: Chema Gonzalez <chema@google.com>
Subject: Re: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Tue, 5 Aug 2014 10:12:11 -0700
Message-ID: <CA+ZOOTOU31MTtLm13J2hiCmwMWMPPrvx6zjqZ_NQahjU31SqpA@mail.gmail.com>
References: <1407256813-30944-1-git-send-email-chema@google.com>
	<53E10FBA.5070905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40570 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028AbaHERMM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 5 Aug 2014 13:12:12 -0400
Received: by mail-ie0-f173.google.com with SMTP id tr6so1416665ieb.18
        for <dash@vger.kernel.org>; Tue, 05 Aug 2014 10:12:11 -0700 (PDT)
In-Reply-To: <53E10FBA.5070905@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On Tue, Aug 5, 2014 at 10:09 AM, Eric Blake <eblake@redhat.com> wrote:
> On 08/05/2014 10:40 AM, Chema Gonzalez wrote:
>> If the user environment has either LC_ALL or LANG defined, the setting
>> of LC_COLLATE in src/mkbuiltins is overriden. With a non-POSIX locale,
>> the orders of dotcmd (remember that '.' is 0x2e in ascii) and truecmd
>> (':' is 0x3a in ascii) are reversed, which makes the ":" command fail
>> in the bsearch.
>>
>
>> -     }}' $temp | LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
>> +     }}' $temp | LC_ALL= LANG= LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
>
> Setting LC_ALL= to the empty string risks implementation-defined
> behavior.  Also, LC_ALL overrides LANG and LC_COLLATE.  It should be
> sufficient to merely do:
>
>         }}' $temp | LC_ALL=C sort -k 1,1 | tee $temp2 | awk '{

Maybe:
    }}' $temp | LC_ALL=C LANG=C sort -k 1,1 | tee $temp2 | awk '{

-Chema

>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
