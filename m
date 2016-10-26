From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: redir.h::clearredir() does not exist
Date: Wed, 26 Oct 2016 15:31:34 +0200
Message-ID: <CAK1hOcN=WPsUT-MXNL9sbO0hBL_uCs9-U8ZMkjjBjYaf=Tc=0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:40617 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934024AbcJZNbz (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 26 Oct 2016 09:31:55 -0400
Received: by mail-qk0-f173.google.com with SMTP id d23so6392771qke.7
        for <dash@vger.kernel.org>; Wed, 26 Oct 2016 06:31:55 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

There is a declaration:

void clearredir(void);

but the function is gone long ago.
