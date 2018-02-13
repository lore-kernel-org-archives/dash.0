From: Martijn Dekker <martijn@inlv.org>
Subject: Re: dash bug: double-quoted "\" breaks glob protection for next char
Date: Tue, 13 Feb 2018 23:45:35 +0100
Message-ID: <6ee2b1b1-ccea-8bcf-374d-968e4ce61f02@inlv.org>
References: <CAK1hOcPW_MZ5Nq-0z-aMMMgzZbOZYXD_9kkxz1w+U-HY+E4gbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:54448 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965783AbeBMXJu (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Feb 2018 18:09:50 -0500
In-Reply-To: <CAK1hOcPW_MZ5Nq-0z-aMMMgzZbOZYXD_9kkxz1w+U-HY+E4gbw@mail.gmail.com>
Content-Language: nl
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

Op 13-02-18 om 14:53 schreef Denys Vlasenko:
> $ >'\zzzz'
> $ >'\wwww'
> $ dash -c 'echo "\*"'
> \wwww \zzzz
> 
> The cause: uses "\\*" pattern instead of "\\\*".

Also:

$ dash -c 'case \\ab in "\*") echo BUG;; esac'
BUG
$ dash -c 'case \\a in "\?") echo BUG;; esac'
BUG

Yup. Full globbing within double quotes after a backslash.

- M.
