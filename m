Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FAEC433F5
	for <linux-dash@archiver.kernel.org>; Sat,  2 Apr 2022 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358026AbiDBQ23 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbiDBQ21 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 2 Apr 2022 12:28:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A8158D9D
        for <dash@vger.kernel.org>; Sat,  2 Apr 2022 09:26:35 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a5so4310051qvx.1
        for <dash@vger.kernel.org>; Sat, 02 Apr 2022 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KYtoNs++NpOEQvS5b13gJOUHc4pgnn+yxEUd77+AeoQ=;
        b=bOeN5oMLT4v8JT2h9vX+09pKX9y0xBGQTIdfioJd2dv+151ye+Gd7gHOBXcRBYwJ7C
         Ahkw9Oxn5bVgDXHg+Ek1+wymuf+Lz1FiXQUdlXkln5/eY47f89HW/zQ8NUp0Ci+0dUAZ
         wfn8RJjNEHgiL4BmgU6gr+Pb+XOEwJz0npVXpXnRjSI7CE5M5FZyPkl8Qf3uoS+BaVVt
         CGJ/lMIhsd8XSlOZ1MiNQHL25lN7bvMyK2xORLABOQ9PpmBGqRCbKqeaXdlNHNhY1qLv
         RfJRhTmVSOdopFvdE9SweRRHFmK85UWQeawuR8CrvmGg3MguTPK3yXNvShnufyIpIMJu
         6t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KYtoNs++NpOEQvS5b13gJOUHc4pgnn+yxEUd77+AeoQ=;
        b=3mx5/a8NEdowvuXp3JXv6iM/7wGP6KueS25+ZRIeae0YIKZFUpBK3lyhKs89L30fj5
         98ObkhB8GZh8whtDS84t2O31O0ohxwOQ9vwoJUecWAu/toUCquGpIvCfpxcdF5tNUjmU
         wOHUL33Pp6hvdqcVFn7KaBUDb/rlDvrh5LJMeDM2v0B9fKkQENXYjZcujV9RZv40foA/
         wjQvwLynZvPTq5XHiNtbTapuxbQzfpbBx7IWnOQDPziAzlG+0fSjS5Ed9wb7AZmJ2B9m
         8MEXYANCmNoh0T6CMn6geqQ6Guf+jEv5OSZtOgzaLPlWlHpaT8ZUUTGOepq2h+tKEGVj
         h5eA==
X-Gm-Message-State: AOAM531o3UbHofV/SwrkJsMpdffnjSbk8MZN7qAHhT4Bqzvy8WiZoOqT
        mbODCD1rSXMfvl9+NnW97VS8uLhcMPxJzRPY6tANLhHw5yUg8A==
X-Google-Smtp-Source: ABdhPJxcjwfnSfIxmvbyvPKEc0ME9F2SDbV0mJcvLDgzvg17O5DDp+KY6QS/z6iNTgNWymSP545XA2yLjHYoyJahYPw=
X-Received: by 2002:ad4:5bae:0:b0:441:2132:cf92 with SMTP id
 14-20020ad45bae000000b004412132cf92mr11716806qvq.117.1648916794806; Sat, 02
 Apr 2022 09:26:34 -0700 (PDT)
MIME-Version: 1.0
From:   Al g <algore3698@gmail.com>
Date:   Sat, 2 Apr 2022 12:26:24 -0400
Message-ID: <CAOKKkHe6b_aT7bR1bKNksAqEZ5BQajAuTGtoSL-A3vLUV+i6ZA@mail.gmail.com>
Subject: Preferred method for disclosure of vulnerability
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,
Does the dash dev team have a preferred method for bug/vulnerability
disclosures? I have tried looking online but I have been unable to
find one definitive answer.

Thanks,
Alex G
