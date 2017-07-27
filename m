From: Bosco <jbosco.gg@gmail.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 14:44:23 +0000
Message-ID: <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com> <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33934 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdG0Oop (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 10:44:45 -0400
Received: by mail-qt0-f176.google.com with SMTP id s6so73860609qtc.1
        for <dash@vger.kernel.org>; Thu, 27 Jul 2017 07:44:44 -0700 (PDT)
In-Reply-To: <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

I don't have any problem, I only show you one case where I had to fix
an script in order to work a compilation in dash.

I'm using dash because of simplicity, unfortunately I don't understand
how things work.

I think the problem is of dash, I only want to report that dash fails
at parse scape sequence.
For instance, the command

  echo \\\\

prints

  \

I think it should print
\\

I don't have to decided how dash should understand things because it
isn't my project. I only advise of a bad behavior, of course from my
point of view.

Bosco.
