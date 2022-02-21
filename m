Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B4C4332F
	for <linux-dash@archiver.kernel.org>; Mon, 21 Feb 2022 16:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiBUQlh (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:41:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380934AbiBUQkF (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Feb 2022 11:40:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60DA227CF2
        for <dash@vger.kernel.org>; Mon, 21 Feb 2022 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645461558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcwXIbLZUDU5EjQvdM+2qFGtz2L2sbkXgfEKGQXEaDw=;
        b=TgpkLDnpdgTr1W2gvNblnZTy/bw5FZjEabvtW4LoLcTs3ufwEDzMijok5+VsCqFR4rBInb
        AxlEi5ZTDLKa58mMf9qLyAr5BYTvOSDSf3gBbOMkNI0F5OOI6vRCQezG6pcE4AmJTY+w8N
        ZF7wnf88n7ySzhaPjTLKuhHGzACYcME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-N3V_nQC2NAGgaftUftydqQ-1; Mon, 21 Feb 2022 11:39:14 -0500
X-MC-Unique: N3V_nQC2NAGgaftUftydqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A11C31091DA0;
        Mon, 21 Feb 2022 16:39:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.240])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE611753DB;
        Mon, 21 Feb 2022 16:39:10 +0000 (UTC)
Date:   Mon, 21 Feb 2022 10:39:08 -0600
From:   Eric Blake <eblake@redhat.com>
To:     Stephane Chazelas <stephane@chazelas.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Harald van Dijk <harald@gigawatt.nl>, calestyo@scientia.org,
        dash@vger.kernel.org
Subject: Re: [v2 PATCH] expand: Always quote caret when using fnmatch
Message-ID: <20220221163908.hykzez677nlmve6x@redhat.com>
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
 <c31fb498-0f82-dcdc-b1c6-212b8c919c07@gigawatt.nl>
 <YeejsuVQaGCkQ97t@gondor.apana.org.au>
 <20220220071544.7odyx5urgcwjsobd@chazelas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220071544.7odyx5urgcwjsobd@chazelas.org>
User-Agent: NeoMutt/20211029-332-f3b9af
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sun, Feb 20, 2022 at 07:15:44AM +0000, Stephane Chazelas wrote:
> 2022-01-19 16:37:54 +1100, Herbert Xu:
> [...]
> > This patch forces ^ to be a literal when we use fnmatch.
> [...]
> The "fix" also seems incomplete and causes at least this
> regression:
> 
> $ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\^]'
> dash->fnmatch("[\\\\^]", "\\", 0)                              = 0
> match
> 
> See how that added \ caused it to be included in the set. Compare with:
> 
> +++ exited (status 0) +++
> $ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\!]'
> dash->fnmatch("[\\!]", "\\", 0)                                = 1
> +++ exited (status 0) +++
> $ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\x]'
> dash->fnmatch("[\\x]", "\\", 0)                                = 1
> +++ exited (status 0) +++

If you want to escape ^ to always be treated as a literal when calling
fnmatch(), you have to spell it something like [[=^=]...], not [\^...]
(that is, since \^ inside [] does NOT treat the \ as an escape
character, but as yet another literal character as part of the brakcet
group, you instead have to resort to calling out the literal character
^ via alternative spellings such as by a collation equivalent).
Another alternative is to rewrite the [] bracket exprsesion so that ^
is no longer first (but be careful if the character after ^ is -, ],
or !, as the rewrite is not always a trivial swap with the next
character).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

