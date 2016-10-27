From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: gotsigchild and onsigchild are unused
Date: Thu, 27 Oct 2016 19:54:14 +0200
Message-ID: <CAK1hOcM9XE-N2i6wWumd5bdu+yhOzTjVTxKY--vyEH3BTfcU6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35406 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935125AbcJ0Ryg (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Oct 2016 13:54:36 -0400
Received: by mail-qk0-f180.google.com with SMTP id z190so56283359qkc.2
        for <dash@vger.kernel.org>; Thu, 27 Oct 2016 10:54:35 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

This function and variable are not used anywhere:

#ifdef SYSV
STATIC int onsigchild(void);
#endif
...
...
#ifdef SYSV
STATIC int gotsigchild;

STATIC int onsigchild() {
        gotsigchild = 1;
}
#endif


Note that there is a very similarly named "gotsigchld"
(without "i" in "chld") variable.
That one *is not* unused.
