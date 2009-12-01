From: William Immendorf <will.immendorf@gmail.com>
Subject: Re: Dash fails to compile on UTF-8 with the Coreutils i18n patch
Date: Mon, 30 Nov 2009 21:09:52 -0600
Message-ID: <62234dc60911301909x3c96cb10h115e6c0d8fd35183@mail.gmail.com>
References: <62234dc60911291654k6a4fc375o131af7460db907e4@mail.gmail.com>
	 <20091130063621.GA9950@gondor.apana.org.au>
	 <62234dc60911300509n7c7b28b5n9b668c28e01b431e@mail.gmail.com>
	 <20091201030351.GC20669@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:45907 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbZLADJr (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 30 Nov 2009 22:09:47 -0500
Received: by ewy19 with SMTP id 19so4497715ewy.21
        for <dash@vger.kernel.org>; Mon, 30 Nov 2009 19:09:52 -0800 (PST)
In-Reply-To: <20091201030351.GC20669@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, Nov 30, 2009 at 9:03 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Please check the archive, we have already established that sort
> isn't the issue, it simply papers over the fact that sed didn't
> cut out the necessary fields.
Herbert, have you lost your mind?!?!?! It's not about Sed, it's about
the i18n enabled sort, and the fact you have to use LC_CTYPE instead
of LC_COLLATE to get it to compile under LFS 6.5 with en_US.UTF-8.
Please, at least fix this issue as soon as possible.

-- 
William Immendorf
The ultimate in free computing.
Messages in plain text, please, no HTML.

--------------

"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman
