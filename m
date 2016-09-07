From: Andrey Voropaev <voropaev.andrey@gmail.com>
Subject: Tests [ 0 -eq $UID ] don't work as in bash
Date: Wed, 7 Sep 2016 16:44:03 +0200
Message-ID: <CAFOXTdceLsR_xBcs=B2QajQHW_UJyBKTr6R8fQvUNCxikYn77w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:35255 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbcIGOoE (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 7 Sep 2016 10:44:04 -0400
Received: by mail-it0-f47.google.com with SMTP id e124so200616360ith.0
        for <dash@vger.kernel.org>; Wed, 07 Sep 2016 07:44:04 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello!

I'm sorry if this is FAQ question, but googling didn't report it, so
I'm asking here.

In our scripts we often use constructs like

##############
if [ 0 -eq $UID ]
then
        echo "This script must not be run by root user!"
        exit 1
fi
#################

This works fine in bash, but dash fails with warning " [: -ne:
argument expected". Is this intended feature? How to work around it in
dash then?

Best regards
Andrei Voropaev
