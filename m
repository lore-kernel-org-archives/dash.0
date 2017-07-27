From: Bosco <jbosco.gg@gmail.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 15:10:22 +0000
Message-ID: <CAC4gepdMmWSdheZbfw44fn3eexJ4Wg3gSkj7pMChLNodB3UyTw@mail.gmail.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com> <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com> <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
 <bf53bb8a-a967-023f-a83b-c0245702c1a4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35576 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdG0PKn (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 11:10:43 -0400
Received: by mail-qk0-f178.google.com with SMTP id d145so98046434qkc.2
        for <dash@vger.kernel.org>; Thu, 27 Jul 2017 08:10:43 -0700 (PDT)
In-Reply-To: <bf53bb8a-a967-023f-a83b-c0245702c1a4@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

That script of zziplib isn't mine, I only had to compile it once
because it was necessary for compile other program (TeX Live).

I'm not talking about POSIX, and I don't mind what it said. I'm
talking about the man page of dash, that said:

>  echo [-n] args...
>            Print the arguments on the standard output, separated by spaces.
>            Unless the -n  option is present, a newline is output following the
>            arguments.
>

According to

>            If any of the following sequences of characters is encountered
>            during output, the sequence is not output.  Instead, the specified
>            action is performed:

when \\ is reached is replaced by \.

>
>            \b      A backspace character is output.
>
>            \c      Subsequent output is suppressed.  This is normally used at
>                    the end of the last argument to suppress the trailing
>                    newline that e ec ch ho o would otherwise output.
>
>            \f      Output a form feed.
>
>            \n      Output a newline character.
>
>            \r      Output a carriage return.
>
>            \t      Output a (horizontal) tab character.
>
>            \v      Output a vertical tab.
>
>            \0digits
>                    Output the character whose value is given by zero to three
>                    octal digits.  If there are zero digits, a nul character
>                    is output.
>
>            \\      Output a backslash.
>
>            All other backslash sequences elicit undefined behaviour.
>

Then, in the command
  echo \\\\
because \\ is reached first, then it will be replaced by '\'
character, immediately after that another \\ is reached, then it will
be replaced by another '\' character. It turns out the ouput '\\'.

Bosco.
