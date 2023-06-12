Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C644DC88CB4
	for <linux-dash@archiver.kernel.org>; Mon, 12 Jun 2023 15:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjFLPkw (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 12 Jun 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjFLPjz (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 12 Jun 2023 11:39:55 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 08:39:48 PDT
Received: from mpv-out-cfd-1.case.edu (mpv-out-cfd-1.CWRU.Edu [129.22.103.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2293410F2
        for <dash@vger.kernel.org>; Mon, 12 Jun 2023 08:39:47 -0700 (PDT)
Received: from mpv-local-ksl-1.CWRU.Edu (EHLO mpv-local-ksl-1.case.edu) ([129.22.103.235])
        by mpv-out-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
        with ESMTP id ATS89647;
        Mon, 12 Jun 2023 11:38:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=case.edu;
        s=smtp-primary; t=1686584326;
        bh=WZcw3YZ5aqJTd7TP86zUWYu+zCe3cNL88vKVAHVs1KE=; l=2060;
        h=Message-ID:Date:MIME-Version:Reply-To:Cc:Subject:To:References:
         From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=x+AHN7x45RW9o0uJ2PWB1Z6DF5q5Fu/F4X9Kmow8V758Xj9QnQahbGgPR7bWhFvtUq
         sCS2Y8HIe33RrrlifuGWRepsnvg0JpBseoJekajEt9TnZ2wJlHbPBUEXGAkSvHL9waI
         gIxonApWYPlKeE9WbfTYDlNfAHSHGwuLK79sGc3EE06ovTfVWCk1gqRujuVkdm3RZKX
         iCCeZxrUf3wI50oYafDI0fGZBqFuKN3Ztwvl7+uBTdrcxNYD71UWq0YS8JGpAffJXM5
         59891Wqlp4cKrY2ns5w8J6uSwVzhDu4gVvzbhfw+D9CkVuuTs2bfQt/9+f/no9M/iSc
         yC6I5GIw==
Received: from mail-qv1-f70.google.com (EHLO mail-qv1-f70.google.com) ([209.85.219.70])
        by mpv-local-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
        with ESMTP id BSR90162;
        Mon, 12 Jun 2023 11:38:45 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62def2d2814so6859256d6.2
        for <dash@vger.kernel.org>; Mon, 12 Jun 2023 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1686584325; x=1689176325;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:cc:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WZcw3YZ5aqJTd7TP86zUWYu+zCe3cNL88vKVAHVs1KE=;
        b=hWIpB2DXypGVbj8Qh9+h7/q4EV5RcAYQqlmNpspZwtOnKALX6L5UNW+rfiGkjhBLHZ
         mASz67OyZf/ZbJUK+gOvoLtMR5efvAAeqOqxgPOhTKn7zFTNvJRDDJ5uZRX5k7V8hmby
         Mflvf+/qU4O2Cl28lvXyPBs175Poj7W9WWiPPTEpNiARLjPvZPg/N0/o4zaOTMUZJc+f
         EJrXOrwDcWnsLGQ3VimorCBEhEzy6nBiHtUyd4AOl09kNxrtPbGbHZ5x6KFOHZH32diN
         A/o1Cdn6/mux9gLH5qxEMRT6qx0dLD7E/eGfxN+hY4YPrX97woYsiW+Yn0KwpoOjJXuO
         n+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584325; x=1689176325;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:cc:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZcw3YZ5aqJTd7TP86zUWYu+zCe3cNL88vKVAHVs1KE=;
        b=XxGBpwl3mgK0vJGdCyUSktRrZzY5S6/sZI8+Rg1+M+/2IDUGg7+4ViRJpDDCTatUaa
         xq4J1C4tV40QXHl6t27OZuwO9QGSBY++G96O6Qh3CmISm2QLEfNfGHwoYtmseXtKKSTE
         RetT30R3T6TB4udizRfjSSxovktLn3/622l59Fw1BVBAYH53YfXKSnAKv2BJIq4qUoyq
         5hlHvxtcR2okWi165syTvi7hIYZVMoAwVfMIhhcZbBXJJVrPPSbNYvkoFAv1DCv/g8kC
         zr1C6HsC8XvGsDUC/8JD017YMELa1OhFnECAYE+HFVenOZRKnwWHHpWd2/OtEZVYE9jR
         PMfw==
X-Gm-Message-State: AC+VfDyAVwLDEiENc9CzkfPMpj1sa9zWSSIgiNAqUi8I81erdsue5Pjs
        j2VJ806WPzYEo7v9kN7sI/xy8sj2m86RXtY3RStgvY110mb1njqAxcQ3asBLmFvOxqkICkM5TJP
        csW98joJH2xdVaI90
X-Received: by 2002:a05:6214:21ec:b0:626:c31:8df with SMTP id p12-20020a05621421ec00b006260c3108dfmr10665958qvj.34.1686584324742;
        Mon, 12 Jun 2023 08:38:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LCvFbo4mBbOV/fXd1nm03DozpffX0FxwmZs5JrYSwciCljdeMAzGs1T7bmspJstd+7AlXhQ==
X-Received: by 2002:a05:6214:21ec:b0:626:c31:8df with SMTP id p12-20020a05621421ec00b006260c3108dfmr10665944qvj.34.1686584324467;
        Mon, 12 Jun 2023 08:38:44 -0700 (PDT)
Received: from [192.168.0.109] (cpe-98-27-229-193.neo.res.rr.com. [98.27.229.193])
        by smtp.gmail.com with ESMTPSA id g15-20020a0cf08f000000b00625da789003sm3269084qvk.110.2023.06.12.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:38:43 -0700 (PDT)
Message-ID: <d3076b26-3794-8a34-1d96-4c2156d83b42@case.edu>
Date:   Mon, 12 Jun 2023 11:38:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Reply-To: chet.ramey@case.edu
Cc:     chet.ramey@case.edu, "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: Interested in porting Dash to Readline
Content-Language: en-US
To:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        S M <mythrowy777@hotmail.com>
References: <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outlook.com>
 <20230609212915.WlLQf%steffen@sdaoden.eu>
 <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.outlook.com>
 <20230610174959.5TEaR%steffen@sdaoden.eu>
From:   Chet Ramey <chet.ramey@case.edu>
Organization: ITS, Case Western Reserve University
In-Reply-To: <20230610174959.5TEaR%steffen@sdaoden.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mirapoint-IP-Reputation: reputation=Good-1,
        source=Queried,
        refid=tid=0001.0A742F90.64873B04.0051,
        actions=tag
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A742F28.64873C06.000A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2016-11-06 16:00:04,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: f4c1ddc3a97acc99432406ffd4fea2de
X-Mirapoint-IP-Reputation: reputation=good-1,
        source=Fixed,
        refid=n/a,
        actions=tag
X-Junkmail-Status: score=8/90, host=mpv-out-cfd-1.case.edu
X-Junkmail-PrAS-Raw: score=8/90,
        refid=2.7.2:2023.6.12.151525:17:8.707,
        ip=,
        rules=__YOUTUBE_RCVD,
                DKIM_SIGNATURE,
                __X_GOOGLE_DKIM_SIGNATURE,
                __X_GM_MESSAGE_STATE,
                __X_GOOGLE_SMTP_SOURCE,
                __HAS_MSGID,
                __SANE_MSGID,
                __MSGID_HEX_844412,
                DATE_TZ_NA,
                __MIME_VERSION,
                __USER_AGENT,
                __MOZILLA_USER_AGENT,
                __HAS_REPLYTO,
                __HAS_CC_HDR,
                __MULTIPLE_RCPTS_CC_X2,
                __CC_NAME,
                __SUBJ_REPLY,
                __BOUNCE_CHALLENGE_SUBJ,
                __BOUNCE_NDR_SUBJ_EXEMPT,
                __SUBJ_ALPHA_END,
                __TO_MALFORMED_2,
                __MULTIPLE_RCPTS_TO_X2,
                __TO_NAME,
                __TO_NAME_DIFF_FROM_ACC,
                __HAS_REFERENCES,
                __REFERENCES,
                __HAS_FROM,
                FROM_EDU_TLD,
                __IN_REP_TO,
                __CT,
                __CT_TEXT_PLAIN,
                __MIME_BOUND_CHARSET,
                __CTE,
                CTE_7BIT,
                __REPLYTO_SAMEAS_FROM_ADDY,
                __REPLYTO_SAMEAS_FROM_ACC,
                __FROM_DOMAIN_IN_ANY_CC2,
                __HEADER_ORDER_FROM,
                __RCPT_DOMAIN_NOT_TO,
                __REPLYTO_SAMEAS_FROM_DOMAIN,
                __DKIM_ALIGNS_1,
                __DKIM_ALIGNS_2,
                __FUR_HEADER,
                __ANY_URI,
                __URI_MAILTO,
                __URI_WITH_PATH,
                __URI_ENDS_IN_SLASH,
                __URI_NO_WWW,
                [TRUNCATED],
        so=2010-03-03 19:42:08,
        dmn=2016-08-03-0138
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 6/10/23 1:49 PM, Steffen Nurpmeso wrote:
> S M wrote in
>   <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.outl\
>   ook.com>:
>   |On Fri, Jun 09, 2023 at 11:29:15PM +0200, Steffen Nurpmeso wrote:
>   |> Quoting Dalai Lama (50 years in India jubilee) "it is all there".
>   |> FreeBSD bin/sh/histedit.c:sh_matches() as well as :sh_complete()
>   |> (all BSD licensed).
>   |
>   |So is it a licensing concern? I still think Readline is more
> 
> I do not think BSD-3-clause disallows bundling within GPL.
> But i am a total licensing idiot.

Readline is licensed using GPL3. You may wish to check whether or not that
is compatible with dash's BSD licensing. That's something the dash folks
have to decide for themselves.

> 
>   |featureful as I have worked with both. I did poke around NetBSD's
> 
> It surely is.  (Much more so, but also fat.)
> 
>   |ash code and remember that it used an internal Libedit header
>   |"filecomplete.h" or something along those lines to implement
>   |filename completion. Not that porting or re-implementing such
>   |internal routines would be particularly hard. If I recall correctly
>   |there is a publicfunction in libedit named "_el_fn_complete"
>   |that implements something along those lines.
>   |
>   |If it's a licensing problem then there's no way around it, though
>   |I thought that GPL restrictions of this kind would only apply to
>   |redistributed binaries linked against readline and not to the
>   |source code itself.
> 
> Well it _could_ be possible to compile dash with any editing and
> simply use "rlwrap"[1] (cudo Stephen Isard) to hook readline into
> dash.  Then your effort has already ended.

If you use rlwrap, you don't have the insight into the internal state of
the application that allows you to do completion on anything more than
what readline understands natively (filenames, mostly).

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/

