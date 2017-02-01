From: Parke <parke.nexus@gmail.com>
Subject: Re: why does dash save, dup, and restore redirected descriptor in the
 parent, rather than redirect in the child?
Date: Tue, 31 Jan 2017 18:27:00 -0800
Message-ID: <CAPxz1+au53RAak7Goisz7QKrzUSvtZidLFZ4b7sgV1QR_JeK5Q@mail.gmail.com>
References: <2132582962.805179.1485892834849.ref@mail.yahoo.com> <2132582962.805179.1485892834849@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:32902 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdBAC1m (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 31 Jan 2017 21:27:42 -0500
Received: by mail-qt0-f182.google.com with SMTP id v23so252145119qtb.0
        for <dash@vger.kernel.org>; Tue, 31 Jan 2017 18:27:41 -0800 (PST)
In-Reply-To: <2132582962.805179.1485892834849@mail.yahoo.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Tue, Jan 31, 2017 at 12:00 PM, Mark Galeck <mark_galeck@pacbell.net> wrote:
> This is strange. Why save, dup and dup again to restore, descriptors in the parent, when it would be much simpler to just dup in the child, and not have to save and restore. This is simpler and I checked it works the same:

> I am sure there must be a good reason and I am not understanding something deeper. What is it?

I am not a dash developer, but one reason to make system calls in the
parent is that it is much simpler to handle errors in the parent.

In your example:

> if (!fork()) {
>     fd = open64("foobar.txt", O_WRONLY|O_CREAT);
>     dup2(fd, 1);
>     execl("/bin/date", "date", (char *)NULL);
> }

What happens if open64 fails?  How should the child inform the parent
of this specific error?

-Parke
