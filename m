From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: dash bug: double-quoted "\" breaks glob protection for next char
Date: Tue, 13 Feb 2018 14:53:42 +0100
Message-ID: <CAK1hOcPW_MZ5Nq-0z-aMMMgzZbOZYXD_9kkxz1w+U-HY+E4gbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52735 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964859AbeBMNyE (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Feb 2018 08:54:04 -0500
Received: by mail-wm0-f43.google.com with SMTP id j199so4056533wmj.2
        for <dash@vger.kernel.org>; Tue, 13 Feb 2018 05:54:03 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

$ >'\zzzz'
$ >'\wwww'
$ dash -c 'echo "\*"'
\wwww \zzzz

The cause: uses "\\*" pattern instead of "\\\*".
The fix:

                        /* backslash */
                        case CBACK:
                                c = pgetc2();
                                if (c == PEOF) {
                                        USTPUTC(CTLESC, out);
                                        USTPUTC('\\', out);
                                        pungetc();
                                } else if (c == '\n') {
                                        nlprompt();
                                } else {
                                        if (
                                                dblquote &&
                                                c != '\\' && c != '`' &&
                                                c != '$' && (
                                                        c != '"' ||
                                                        eofmark != NULL
                                                )
                                        ) {
USTPUTC(CTLESC, out); // add this line
                                                USTPUTC('\\', out);
                                        }
                                        USTPUTC(CTLESC, out);
                                        USTPUTC(c, out);
                                        quotef++;
                                }
