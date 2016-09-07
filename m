From: Paul Smith <paul@mad-scientist.net>
Subject: Re: Tests [ 0 -eq $UID ] don't work as in bash
Date: Wed, 07 Sep 2016 11:55:00 -0400
Message-ID: <1473263700.7265.3.camel@mad-scientist.net>
References: <CAFOXTdceLsR_xBcs=B2QajQHW_UJyBKTr6R8fQvUNCxikYn77w@mail.gmail.com>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:51561 "HELO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753998AbcIGQXt (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 7 Sep 2016 12:23:49 -0400
In-Reply-To: <CAFOXTdceLsR_xBcs=B2QajQHW_UJyBKTr6R8fQvUNCxikYn77w@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Andrey Voropaev <voropaev.andrey@gmail.com>, dash@vger.kernel.org

On Wed, 2016-09-07 at 16:44 +0200, Andrey Voropaev wrote:
> if [ 0 -eq $UID ]

The variable UID is not defined to be automatically set by the shell in
POSIX; having it set is a bash extension.  dash doesn't set it
automatically for you.

You'll have to set it yourself:

  UID=$(id -u)

Also you should quote variable references, in general:

  if [ 0 -eq "$UID" ]

Be sure that if your scripts rely on bash-isms you start them with
#!/bin/bash and if you don't want them to rely on bash-isms, you start
them with #!/bin/sh.
