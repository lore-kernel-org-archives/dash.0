From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Bug? "fstat64(f, &sb) < 0 && S_ISREG(sb.st_mode)"
Date: Tue, 25 Oct 2016 17:33:20 +0200
Message-ID: <CAK1hOcMV9YoUNDC_spEawpfFf9hcYdOd-BiF_7rm0CFJ0ZyLaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37962 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbcJYPdl (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 25 Oct 2016 11:33:41 -0400
Received: by mail-qk0-f178.google.com with SMTP id v138so22798653qka.5
        for <dash@vger.kernel.org>; Tue, 25 Oct 2016 08:33:41 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

                /* Take care of noclobber mode. */
                if (Cflag) {
                        fname = redir->nfile.expfname;
                        if (stat64(fname, &sb) < 0) {
                                if ((f = open64(fname,
O_WRONLY|O_CREAT|O_EXCL, 0666)) < 0)
                                        goto ecreate;
                        } else if (!S_ISREG(sb.st_mode)) {
                                if ((f = open64(fname, O_WRONLY, 0666)) < 0)
                                        goto ecreate;
                                if (fstat64(f, &sb) < 0 &&
S_ISREG(sb.st_mode)) {
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
was it meant to be "fstat64(f, &sb) < 0 || S_ISREG(sb.st_mode)" ?

                                        close(f);
                                        errno = EEXIST;
                                        goto ecreate;
                                }
                        } else {
                                errno = EEXIST;
                                goto ecreate;
                        }
                        break;
                }
