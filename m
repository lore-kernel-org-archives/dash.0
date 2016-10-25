From: Eduardo Bustamante <dualbus@gmail.com>
Subject: Re: Bug? "fstat64(f, &sb) < 0 && S_ISREG(sb.st_mode)"
Date: Tue, 25 Oct 2016 12:19:59 -0500
Message-ID: <CAOSMAusn7mg-Ss846BBZmC=j4mU3L=1duX=2zgc9UP=YBORnsQ@mail.gmail.com>
References: <CAK1hOcMV9YoUNDC_spEawpfFf9hcYdOd-BiF_7rm0CFJ0ZyLaQ@mail.gmail.com>
 <CAOSMAutbPNXKy_GVHDWiJv8=LRDnMPNBrsN1RgwYGVL4gJTwmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35950 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbcJYRUU (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 25 Oct 2016 13:20:20 -0400
Received: by mail-ua0-f178.google.com with SMTP id m11so60548740uab.3
        for <dash@vger.kernel.org>; Tue, 25 Oct 2016 10:20:19 -0700 (PDT)
In-Reply-To: <CAOSMAutbPNXKy_GVHDWiJv8=LRDnMPNBrsN1RgwYGVL4gJTwmg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

Also, inspecting bash code, this seems to be code to figure out if the
file was changed from a non-regular file to a regular file between the
stat and the open, so I'd say it's indeed a bug, but the problem is
not the &&, but testing the wrong return code.

From bash redir.c

 631   /* OK, the open succeeded, but the file may have been changed from a
 632      non-regular file to a regular file between the stat and the open.
 633      We are assuming that the O_EXCL open handles the case where FILENAME
 634      did not exist and is symlinked to an existing file between the stat
 635      and open. */
 636
 637   /* If we can open it and fstat the file descriptor, and neither check
 638      revealed that it was a regular file, and the file has not
been replaced,
 639      return the file descriptor. */
 640   if ((fstat (fd, &finfo2) == 0) && (S_ISREG (finfo2.st_mode) == 0) &&
 641       r == 0 && (S_ISREG (finfo.st_mode) == 0) &&
 642       same_file (filename, filename, &finfo, &finfo2))
 643     return fd;
 644
 645   /* The file has been replaced.  badness. */
 646   close (fd);
 647   errno = EEXIST;
 648   return (NOCLOBBER_REDIRECT);
