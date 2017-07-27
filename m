From: Bosco <jbosco.gg@gmail.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 13:13:06 +0000
Message-ID: <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:38528 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdG0NN1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 09:13:27 -0400
Received: by mail-qk0-f171.google.com with SMTP id x191so35850016qka.5
        for <dash@vger.kernel.org>; Thu, 27 Jul 2017 06:13:27 -0700 (PDT)
In-Reply-To: <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, dash@vger.kernel.org

On 27 July 2017 at 12:54, Eric Blake <eblake@redhat.com> wrote:
> Which man pages?  Echo is one of those programs that varies widely, and
> you are MUCH better off using printf(1) instead of echo(1) if you are
> trying to get newline suppression, trying to print something that might
> begin with -, or trying to print something that might contain \.

Sorry, maybe I did't explain it correctly, I mean the man pages of the
dash source:
https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/dash.1#n1202

And because of this, I got an error compiling zziplib, you may see
https://github.com/gdraheim/zziplib/blob/v0.13.67/configure#L17542

>
>> for echo command, "\\" should print '\'
>> character, and \0digits should print the byte in octal base.
>> But the command
>>
>> echo "\\1"
>
> This is the same as
> echo '\1'
>
> which is NOT defined by POSIX as being a valid escape sequence that echo
> must recognize.
>
> (Did you mean to test
> echo '\\1'
> instead?)
>

I refer the following commands

echo "\\1"

or

echo \\1



> Here's the POSIX list of required escape sequences:
>
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
>

There, it says the same as the man page of dash.

I understand that \\ is converted to '\' character.

> Arguably, since it is not required by POSIX, we don't have to do it. But
> I also can't argue that POSIX forbids us to support \1 as an extension
> (it says nothing about whether implementations can have additional
> escape sequences).  So I'll argue that it is intentional as a dash
> extension.  But if you can make dash smaller by getting rid of the
> extension, that might be an acceptable patch.

In that case, I think, the man page of dash should be modified with
that extension.

Thank you.
Bosco.
