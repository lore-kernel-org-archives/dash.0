From: Oleg Verych <olecom@gmail.com>
Subject: Re: Dash problem with IFS
Date: Mon, 11 May 2009 22:31:58 +0300
Message-ID: <8499950a0905111231w2b4cb69fwb1869bef0ebecfb5@mail.gmail.com>
References: <822b241f0905011133l3bcbf9dci4799abc80ec9de99@mail.gmail.com>
	 <20090502020131.GA19531@gondor.apana.org.au>
	 <8499950a0905070901o7337acbex451810a8091e81c9@mail.gmail.com>
	 <20090511134826.GA13308@lisa.in-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:36763 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbZEKTb6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 11 May 2009 15:31:58 -0400
Received: by bwz22 with SMTP id 22so2864494bwz.37
        for <dash@vger.kernel.org>; Mon, 11 May 2009 12:31:58 -0700 (PDT)
In-Reply-To: <20090511134826.GA13308@lisa.in-ulm.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

On 5/11/09, Sven Mascheck:
> On Thu, May 07, 2009 at 07:01:56PM +0300, Oleg Verych wrote:
>
>  > # just newline
>  > IFS=`printf '\n+'`; IFS=${IFS%+}
>
>  > last example is POSIXly correct ugliness. Bashizm looks better (:
>  >
>  > IFS=$'\n'
>
>
> PS: I see the problem distinguishing a tab from a space,
>  but everything but a literal newline is bloat

Old plain WYSIWYG :)

>  IFS='
>
> '

but this is something, that doesn't look like one new line... (e-mail
or web text encodings/filters?)
-- 
sed 'sed && sh + olecom = love'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
