From: Oleg Verych <olecom@gmail.com>
Subject: Re: Dash problem with IFS
Date: Thu, 7 May 2009 19:01:56 +0300
Message-ID: <8499950a0905070901o7337acbex451810a8091e81c9@mail.gmail.com>
References: <822b241f0905011133l3bcbf9dci4799abc80ec9de99@mail.gmail.com>
	 <20090502020131.GA19531@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46263 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbZEGQB5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 May 2009 12:01:57 -0400
Received: by fxm2 with SMTP id 2so880537fxm.37
        for <dash@vger.kernel.org>; Thu, 07 May 2009 09:01:56 -0700 (PDT)
In-Reply-To: <20090502020131.GA19531@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Haibo Xu <haibo.xu@gmail.com>, dash@vger.kernel.org

>  So if you want it to have a tab and newline you need to specify
>  them literally, or use something that does interpret escapes,
>  like

newline and tab, because in output substitution trailing '\n's
(default in any `echo`) are removed.

>  IFS=$(echo '\n\t $')

`echo` isn't a good example due to historical feature-support problems, imho.

# newline and tab
IFS=`printf '\n\t'`
# just newline
IFS=`printf '\n+'`; IFS=${IFS%+}

last example is POSIXly correct ugliness. Bashizm looks better (:

IFS=$'\n'

where $' ' is one, not "\t is <tab> in $IFS", guys.
-- 
sed 'sed && sh + olecom = love'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
