Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C7BC32793
	for <linux-dash@archiver.kernel.org>; Wed, 18 Jan 2023 12:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjARMkW (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjARMiO (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 18 Jan 2023 07:38:14 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FA8456C
        for <dash@vger.kernel.org>; Wed, 18 Jan 2023 04:03:15 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id C624C100013;
        Wed, 18 Jan 2023 12:03:13 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Wed, 18 Jan 2023 13:03:10 +0100
Message-ID: <1905942.HooOsH5gt4@dmc12.centralesupelec.fr>
In-Reply-To: <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <20230117210401.wrEtj%steffen@sdaoden.eu>
 <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wednesday, January 18, 2023 12:40:12 PM CET Ganael Laplanche wrote:

Hello again,

Oops, my previous example was missing the final ampersand.

For the recall, here is what actually works (on FreeBSD, including the set +m 
fix):

$ cat ./test.sh
#!/usr/local/bin/dash
/usr/local/bin/dash -c '
    set -m
    (
      sleep 1
    ) &
    i=$!
    set +m
    echo >&2 "inner Main shell has: $(ps -o pid,pgid $$)"
    echo >&2 "inner Sub-shell has: $(ps -o pid,pgid $i)"
    wait $i
' &
echo "outer Main shell has: $(ps -o pid,pgid $$)"

$ ./test.sh
outer Main shell has:   PID  PGID
47919 47919
inner Main shell has:   PID  PGID                                                                                                                                                                                  
47920 47919
inner Sub-shell has:   PID  PGID
47922 47922

Cheers,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


