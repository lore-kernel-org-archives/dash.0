Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A83C433E6
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD2D64E12
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 18:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhA2S5g (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:57:36 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:52022 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhA2S5V (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 29 Jan 2021 13:57:21 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 10TIuZHx019236
        for <dash@vger.kernel.org>; Fri, 29 Jan 2021 22:56:35 +0400
To:     dash@vger.kernel.org
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: single_quote patch
Organization: Ulyanovsk Treasury
Message-ID: <695d664f-98dc-17be-9bec-55250391e296@simtreas.ru>
Date:   Fri, 29 Jan 2021 22:56:37 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Fri, 29 Jan 2021 22:56:35 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.



I rewrote (next version vs send to Herbert) single_quote()

for do not confusing in debug mode, more funny

showvars and showalias and allow the printf "%q" directive.



Before patch

$ ./dash-0.5.11.3 -x



$ foo () { local a=" b"; ls "$1"; [ -z "$1" ]; }

$ c=" x" foo

+ c= x foo

+ local a= b

+ ls

ls: cannot access '': No such file or directory

+ [ -z  ]



After patch

$ ./dash-0.5.11.3.my -x



$ foo () { local a=" b"; ls "$1"; [ -z "$1" ]; }

$ c=" x" foo

+ c=' x' foo

+ local a=' b'

+ ls ''

ls: cannot access '': No such file or directory

+ '[' -z '' ']'




Before patch
:
$ a= b="a'b" c=a/b

+ a= b=a'b c=a/b

$ set +x; set | grep '^[abc]='

a=''

b='a'"'"'b'

c='a/b'


$ printf "%q\n" "a'b"

dash: 32: printf: %q: invalid directive



After patch

$ a= b="a'b" c=a/b

+ a= b="a'b" c=a/b

$ set +x; set | grep '^[abc]='

a=

b="a'b"

c=a/b


$ printf "%q\n" "a.b" "a'b"

a.b

"a'b"





The patch placed: ftp://simtreas.ru/pub/my/dash/single_quote_diff.txt.gz
(I can not send this patch to maillist - message dropped)


--w

vodz

