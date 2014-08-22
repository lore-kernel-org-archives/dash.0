From: Chema Gonzalez <chema@google.com>
Subject: Re: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Fri, 22 Aug 2014 16:08:49 -0700
Message-ID: <CA+ZOOTP5-yygPphpBArwyw+xzgDr_zGHNW+MdaPs_Y+6_MAC6A@mail.gmail.com>
References: <1407256813-30944-1-git-send-email-chema@google.com>
	<53E10FBA.5070905@redhat.com>
	<CA+ZOOTOU31MTtLm13J2hiCmwMWMPPrvx6zjqZ_NQahjU31SqpA@mail.gmail.com>
	<53E1110D.7050309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:40728 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbaHVXIu (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Aug 2014 19:08:50 -0400
Received: by mail-ig0-f170.google.com with SMTP id h3so1858274igd.3
        for <dash@vger.kernel.org>; Fri, 22 Aug 2014 16:08:49 -0700 (PDT)
In-Reply-To: <53E1110D.7050309@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

I finally managed to test a FreeBSD 10.0 host, and it seems to respect
LC_ALL before LANG.

Next patch includes just setting LC_ALL (which trumps LC_COLLATE).

-Chema


On Tue, Aug 5, 2014 at 10:14 AM, Eric Blake <eblake@redhat.com> wrote:
> On 08/05/2014 11:12 AM, Chema Gonzalez wrote:
>>> Setting LC_ALL= to the empty string risks implementation-defined
>>> behavior.  Also, LC_ALL overrides LANG and LC_COLLATE.  It should be
>>> sufficient to merely do:
>>>
>>>         }}' $temp | LC_ALL=C sort -k 1,1 | tee $temp2 | awk '{
>>
>> Maybe:
>>     }}' $temp | LC_ALL=C LANG=C sort -k 1,1 | tee $temp2 | awk '{
>
> No need to specify LANG=C when LC_ALL is set.  I stand by my shorter line.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
