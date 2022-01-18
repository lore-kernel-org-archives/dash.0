Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B46FC433F5
	for <linux-dash@archiver.kernel.org>; Tue, 18 Jan 2022 15:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346066AbiARPCN (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:02:13 -0500
Received: from mpv1-2015.CWRU.Edu ([129.22.103.226]:29054 "EHLO
        mpv1-2015.case.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbiARPBb (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:31 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 10:01:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=case.edu;
        s=smtp-primary; t=1642518091;
        bh=nMCTaoIxRgNzG6GhOlL5G5nXgrOW7nYx3sxuNdeNLOk=;
        h=Message-ID:Date:MIME-Version:Reply-To:Cc:Subject:To:References:
         From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=ujRiLkzLVMpCeSAOwJFFrO4UwJrqt7RCnG4cnBn2UYkYlqrBcS6gR/1atTIwfODFpt
         ywHBuO6YZpioimvE+CX6MGzl5fZoc6uvIKkBSPTqX4jjtHPN+o0hpvPcLFerLsC+AtN
         IhpDZymriDOpQrSgmt3hHr40YtYeD2IB9NSeidxzFRpst859j0G7jTe6v1B4ljHZgG6
         0QiwdDhRqgF+nUejfZrqB4BrOvHgJbsBU2FlEVPGeyHYlGzwqPUdZ6NyehugulCJeae
         Rale6Zu1mmoL45mMmrOrFcficbH0bWPDAHubWFtoVMhBrETP0Em8x5LXDwdb0mEqcwF
         M3FEzcfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=case.edu;
        s=smtp-primary; t=1642517677;
        bh=nMCTaoIxRgNzG6GhOlL5G5nXgrOW7nYx3sxuNdeNLOk=;
        h=Message-ID:Date:MIME-Version:Reply-To:Cc:Subject:To:References:
         From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=1A0VVNclUHQPsQGL2p5WNwc9yr3WPfofDLxeOEFMLNxERvQEn6kRr2UV6zfLacN020
         3b27C8rd0y/nESUu3kfPDUpFB3SdtC32z8T7mc2k2Tk1NxBhI4Wpg82EJ1u/KcstsJI
         Kr6HY/MAUnnkjvBa+NT5Cfmj/Ai7qhfndOn4Z71OJ8HkYm6BEisp9Y5h/4SV1D7KPGK
         D7wE7ZxC1VTwGdHCwozvjbY1PxNiAgSFvCWgssn2U183f4cXtBh5+9yJKM9GnsAQ1p7
         +buEVzv77DxaOEGULaBzTDJL9r0IeWgDJpxjzpmPSiY103u39y3OWZ96cLbE3MED8bM
         EsqHXoqQ==
Received: from mpv5-2015.CWRU.Edu (EHLO mpv5-2015.case.edu) ([129.22.103.234])
        by mpv1-2015.case.edu (MOS 4.4.8-GA FastPath queued)
        with ESMTP id CEN15335;
        Tue, 18 Jan 2022 09:54:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=case.edu;
        s=smtp-primary; t=1642517648;
        bh=nMCTaoIxRgNzG6GhOlL5G5nXgrOW7nYx3sxuNdeNLOk=;
        h=Message-ID:Date:MIME-Version:Reply-To:Cc:Subject:To:References:
         From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=FlHmKfoR/MB5/+PNG++BZsteghb3qgZICiYtkPdxTe6q2zEhgE6Zfa9A+JDuMHbIkp
         PuZEHHL0VKiwhEeZG0D5VwQDg0fduLn9NpeNHJvyHfiQva52XdN3vSoSy7vuusfcD2G
         cbDQyem3Fv7Y7c44xyhHkK1tYtfYkBJ387Gmfkv9pMqruLhhzqnF+RkrEr/d6qcMIML
         rfLYT8V2U2MCyiz2JPNNeNP4TAMC6y6UfajSGDaoMbmRrgOwn4uwU18F+LTfsm/OQT3
         rGiXrUsoGiswcTJnuaA63qJeKEoZPTN/JdUsHBdTrXLcakomNUsPwkDYo0UqYyUaosp
         9slP/U+A==
Received: from caleb.INS.CWRU.Edu (EHLO _129.22.8.211_) ([129.22.8.211])
        by mpv5-2015.case.edu (MOS 4.4.8-GA FastPath queued)
        with ESMTP id HJF58105 (AUTH cpr);
        Tue, 18 Jan 2022 09:54:07 -0500 (EST)
Message-ID: <2830d34a-b4e2-c869-becc-2240dbc5c238@case.edu>
Date:   Tue, 18 Jan 2022 09:54:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Reply-To: chet.ramey@case.edu
Cc:     chet.ramey@case.edu, dash@vger.kernel.org
Subject: Re: [PATCH] expand: Always quote caret when using fnmatch
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald van Dijk <harald@gigawatt.nl>
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
 <00db46ee5ab57e1282f4808e2103e74699083db3.camel@scientia.org>
From:   Chet Ramey <chet.ramey@case.edu>
In-Reply-To: <00db46ee5ab57e1282f4808e2103e74699083db3.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mirapoint-IP-Reputation: reputation=Neutral-1,
        source=Queried,
        refid=tid=0001.0A742F8F.61E6D48F.003B,
        actions=tag
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A742F29.61E6D48F.007B,ss=1,re=0.000,fgs=0,
        ip=0.0.0.0,
        so=2016-11-06 16:00:04,
        dmn=2011-05-27 18:58:46
X-Mirapoint-Loop-Id: 1b5dec38eeb2c900e68f5d3c000ff918
X-Mirapoint-IP-Reputation: reputation=good-1,
        source=Fixed,
        refid=n/a,
        actions=tag
X-Junkmail-Status: score=8/90, host=mpv1-2015.case.edu
X-Junkmail-PrAS-Raw: score=8/90,
        refid=2.7.2:2022.1.18.144515:17:8.317,
        ip=,
        rules=DKIM_SIGNATURE,
                __HAS_MSGID,
                __SANE_MSGID,
                DATE_TZ_NA,
                __MIME_VERSION,
                __USER_AGENT,
                __MOZILLA_USER_AGENT,
                __HAS_REPLYTO,
                __HAS_CC_HDR,
                __MULTIPLE_RCPTS_CC_X2,
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
                CT_TEXT_PLAIN_UTF8_CAPS,
                __CTE,
                __REPLYTO_SAMEAS_FROM_ADDY,
                __REPLYTO_SAMEAS_FROM_ACC,
                __FROM_DOMAIN_IN_ANY_CC2,
                __HEADER_ORDER_FROM,
                __REPLYTO_SAMEAS_FROM_DOMAIN,
                __DKIM_ALIGNS_1,
                __DKIM_ALIGNS_2,
                __FUR_HEADER,
                __ANY_URI,
                __URI_MAILTO,
                __URI_WITH_PATH,
                __URI_ENDS_IN_SLASH,
                __URI_NO_WWW,
                __CP_URI_IN_BODY,
                __INVOICE_MULTILINGUAL,
                __SUBJ_ALPHA_NEGATE,
                __URI_IN_BODY,
                __URI_NOT_IMG,
                __MAIL_CHAIN,
                __FORWARDED_MSG,
                __BODY_NO_MAILTO,
                __NO_HTML_TAG_RAW,
                [TRUNCATED],
        so=2010-03-03 19:42:08,
        dmn=2016-08-03-0138
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 1/18/22 9:29 AM, Christoph Anton Mitterer wrote:
> Hey.
> 
> Just for confirmation:
> 
> Would that also be an issue in fnmatch() (i.e. should it be forwarded?)
> or really just something in dash?

The behavior of an unquoted carat as the first character in a bracket
expression is unspecified. Dash can't count on any particular behavior.


-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/
