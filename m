From: Bosco <jbosco.gg@gmail.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 15:32:48 +0000
Message-ID: <CAC4gepeSgK9DmnouEjssrRxfFVnk2ozpCD-7+4cSPX-TKLRzSw@mail.gmail.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com> <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com> <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
 <bf53bb8a-a967-023f-a83b-c0245702c1a4@redhat.com> <CAC4gepdMmWSdheZbfw44fn3eexJ4Wg3gSkj7pMChLNodB3UyTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33810 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdG0PdJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 11:33:09 -0400
Received: by mail-qk0-f177.google.com with SMTP id u139so43055376qka.1
        for <dash@vger.kernel.org>; Thu, 27 Jul 2017 08:33:09 -0700 (PDT)
In-Reply-To: <CAC4gepdMmWSdheZbfw44fn3eexJ4Wg3gSkj7pMChLNodB3UyTw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

Ahh, now I understood.
In command
  echo \\\\
first dash interprets the command line (and the arguments), then
internally echo interprets the arguments. But echo is part of dash, so
dash interprets twice the same argument. Sorry I didn't know that.

Thank you for your help and your time.
Bosco.
