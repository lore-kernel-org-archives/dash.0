From: "solsTiCe d'Hiver" <solstice.dhiver@gmail.com>
Subject: Re: "if [ s1 > s2 ]" broken, writing a s2 file
Date: Mon, 8 Dec 2014 18:46:03 +0100
Message-ID: <CAE4vF2eOY_nAHKWeQTza2L48+19Z_hibK+BSd7sqodY9o=v5UQ@mail.gmail.com>
References: <CAE4vF2dip455tXT4K3XwJy1Pp_qrw0fupd3xoAKUgbCG7vcFzg@mail.gmail.com>
	<5485E25D.9080100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:54638 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbaLHRqF (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Dec 2014 12:46:05 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so4354717lab.10
        for <dash@vger.kernel.org>; Mon, 08 Dec 2014 09:46:03 -0800 (PST)
In-Reply-To: <5485E25D.9080100@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

thank you to enlighten me on that. I just learned another thing today. ;-)

2014-12-08 18:39 GMT+01:00 Eric Blake <eblake@redhat.com>:
> On 12/08/2014 10:32 AM, solsTiCe d'Hiver wrote:
>> hello,
>> folowing that bug
>> https://bugs.launchpad.net/ubuntu/+source/update-notifier/+bug/1400357,
>> I follow through to investigate and I found out
>> that whatever I try, when comparing 2 strings I always end up with a
>> file written to disk
>>
>>>From the man page
>> test expression
>>      [ expression ]
>> [...]
>> s1 > s2       True if string s1 comes after s2 based on the ASCII
>> value of their characters.
>
> You HAVE to escape the > so that it is interpreted as an argument and
> not a redirection operator.  The bug is not in dash, but in your usage.
>
>>
>> when I try to use it:
>> a="ert"
>> b="aze"
>> if [ $a > $b ] ; then
>
> Wrong.  Use:
>
> if [ "$a" ">" "$b" ]; then
>
>
>>
>> so this "if syntax" is broken or I don't knwo how to use it.
>
> The latter.
>
>>
>> Also it is really dangerous  to use a syntax similar to file
>> redirection and this is exactly what is happening here.
>
> POSIX is proposing the addition of the shell builtin [[ ]], where
> because it is a syntactical part of the shell, it would have safe
> semantics (that is, [[ $a > $b ]] would be perfectly safe and do the
> right thing). But until the POSIX standardization is complete, dash does
> not implement [[; and as long as only '[' is portable (with its
> unfortunate but historically-mandated semantics of operating as if it
> were NOT a builtin, in that shell parsing happens before test sees its
> arguments), then you have to quote anything that might otherwise be
> misinterpreted during parsing.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
