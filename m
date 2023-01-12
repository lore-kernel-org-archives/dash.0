Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275DBC54EBD
	for <linux-dash@archiver.kernel.org>; Thu, 12 Jan 2023 16:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjALQKQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjALQJt (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 12 Jan 2023 11:09:49 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6B1479CD
        for <dash@vger.kernel.org>; Thu, 12 Jan 2023 08:00:11 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6826B3200754;
        Thu, 12 Jan 2023 11:00:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 12 Jan 2023 11:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        greenberg.science; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1673539209; x=
        1673625609; bh=+wafGyOgu4jCy3cpF64LSDwU6EyC8BNywKoatkEddn8=; b=U
        UeH9HMQ3KLRFiOsTh1uxF1vpgLmPIhkKSjKw86XFneW7D2zgFgyLJ9Ui8aqnZDOy
        IakjUZ8DcuM6qN768WRwpjvJmKCbiGDGei8qI+v79EA/+3cTDjjweIoc0/S3NiXV
        tH95EGrI/KFNklQkyDq6A5sQk+82EZIwcCuunO7PznE/1aFpelARu4jiq7y4cB/f
        Ee8hlHfSa3qLQwxZcwkMM11G+z0tHRysMW5QuJKdT8w8u4MfnJwGSlj0VE8j7kU1
        y08Rwq2xK4jOW0rz8eNzvhr/tb7TiqiA4i0oTvi+zTCBpnohTaiH/RnqsRmh2Wbj
        5SJ+tBvsyEv+fDw+3Iz/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673539209; x=1673625609; bh=+wafGyOgu4jCy3cpF64LSDwU6EyC
        8BNywKoatkEddn8=; b=TrPdwkRHHEcxkbiXdB4QHzPHaghLd0Xz6gvD5xgBOoio
        evNCS4yPalvXOvXPXGSsOgCRtXC7nZu5tJozYU0hu+IP9o5LIVoEfz9bHtE8b/N9
        N8FvqZhJ4ek6dOSkPbX3cTUHgmtLn4932kBKpxMvb+EdP+SWUFiujOLyJEwxmuRm
        5TS8FQ3BqLq1PntJCWNxAGaDPLuhL6pGElp6paqcH3MA3TRYUtOeA3BIwxOFUwva
        Lcpk0/875UDl0zHiijDhIMANSAxWGNP2emQzNWRuvwKrPJa/WYIEBoC2NAlTih7U
        r6OVDLRAE5y75XVeeMnuUUKehKGRV9KzEKhzAvybWg==
X-ME-Sender: <xms:iS7AY1ugVrbck1Rsni_3u1tDmCaLJtzc7LHJ5snouU8nc7EcvftG2Q>
    <xme:iS7AY-ckznyPNySH-dvjxIAvTXkSSBVwHvgcL2YJa-7GnJXgZ9jRGhBYxw7hF8Zri
    3MzTcEFPs56GLBwC7E>
X-ME-Received: <xmr:iS7AY4yYQad-V-b_a2Y5eauPg9D4SBlHYLLt3HcjrEeczuAE2GLZDcfmbpxpB6MWFaGnWImk6MxLXpsKb7qs7I-D6gzT60-teg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffujghffffkgggtsehttdertddttddtnecuhfhrohhmpefoihgthhgrvghl
    ucfirhgvvghnsggvrhhguceomhhitghhrggvlhesghhrvggvnhgsvghrghdrshgtihgvnh
    gtvgeqnecuggftrfgrthhtvghrnhephfetgfehveeugeekgfefvdelteehgfethffhjefg
    veekieduueejudduheejveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhhitghhrggvlhesghhrvggvnhgsvghrghdrshgtihgvnhgtvg
X-ME-Proxy: <xmx:iS7AY8Mn73PDrHfdTDk5k1Vv1IByTtvzqqTkv3RgAQo_txtOQ-4FAQ>
    <xmx:iS7AY1_klDjdrHBabwo1WIQuNzaI8awE78fOsdo2ru76O9SupX6FEw>
    <xmx:iS7AY8UyDUeWxDWPwnfek4sT8wcTA_NLqq39JhvNiKaG81G8kT6zUw>
    <xmx:iS7AYyG7vHW80G70iv4EFwV_9G9i69tP4gC9LzkPPUIdwIHVOiG6sA>
Feedback-ID: ib2794684:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 11:00:09 -0500 (EST)
From:   Michael Greenberg <michael@greenberg.science>
To:     Harald van Dijk <harald@gigawatt.nl>,
        DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: alias confusion due to internal word representation
In-Reply-To: <444eaa61-35a8-15f4-5aeb-14a56aa38d07@gigawatt.nl>
References: <444eaa61-35a8-15f4-5aeb-14a56aa38d07@gigawatt.nl>
Date:   Thu, 12 Jan 2023 07:56:14 -0800
Message-ID: <m2zganhhlt.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

I've seen this issue in interop with modernish, where dash doesn't
properly support multibyte character encodings. It would be great to
have proper support for more interesting character sets.

It's worth looking at how other shells implement this, but a natural
choice is to choose a more sophisticated representation of string, where
control characters are represented out-of-band rather than by using
'unused' values (well, unused by ASCII, but not by
others). Unfortunately, this rope-like representation is not very
convenient to work with.

Cheers,
Michael

On 2023-01-11 at 02:01:03 AM, Harald van Dijk wrote:

> Hi,
>
> Please consider
>
>    alias $(printf "\204")="exit 2"
>    $(:)
>    echo ok
>
> This is a perfectly valid shell script. The alias command is permitted 
> to either succeed or fail, and if it succeeds, it defines an alias whose 
> name is the single byte '\204'. No command by that name is ever 
> executed, so this script is required to then print 'ok' and exit 
> successfully.
>
> This is not what happens. Internally, '\204' is the value of CTLBACKQ, 
> and the word $(:) gets translated to an internal representation of just 
> that -- coupled with a pointer to the parsed command. Since the word 
> $(:) contains zero quote characters, it is subjected to alias expansion, 
> and picks up this alias definition that makes the command expand to
> exit 2.
>
> Consider also:
>
>    alias $(printf "\201")="echo ok" $(printf "\201\201")="echo bad" &&
>    eval $(printf "\201")
>
> This should either print "ok", or reject the aliases. Instead, it prints 
> "bad". This happens because '\201' is the internal representation of 
> CTLESC, and a literal byte of that value is represented by escaping it 
> with CTLESC. Therefore, it triggers the expansion of the \201\201 alias.
>
> Supporting alias names containing non-ASCII characters, while not 
> required by POSIX, seems desirable, and almost all other shells (mksh 
> being the exception) do appear to support this. I am not yet seeing a 
> good way of solving this.
>
> Cheers,
> Harald van Dijk
