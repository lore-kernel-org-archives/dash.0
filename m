From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: where to obtain dash 0.5.9.1?
Date: Wed, 15 Feb 2017 22:44:53 +0100
Message-ID: <5960b69e-211f-443d-8269-6b754288cfaf@gigawatt.nl>
References: <24cd7280-3c78-f612-34b6-ac66c4240134@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:55142 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdBOVoz (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Feb 2017 16:44:55 -0500
In-Reply-To: <24cd7280-3c78-f612-34b6-ac66c4240134@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, dash <dash@vger.kernel.org>

Hi,

On 15/02/2017 22:07, Eric Blake wrote:
> I see in dash.git checked out from
> git://git.kernel.org/pub/scm/utils/dash/dash.git that dash 0.5.9.1 was
> released several months ago.  But all my attempts to connect to
> http://gondor.apana.org.au/~herbert/dash/files/ (as recommended by
> google) to obtain the official tarball are timing out. Is there another
> location that mirrors the official dash tarballs?

A quick search brings up sites which happen to include copies of 
dash-0.5.9.1.tar.gz:

<http://ftp.lfs-matrix.net/pub/blfs/svn/d/dash-0.5.9.1.tar.gz>
<https://sources.voidlinux.eu/dash-0.5.9.1/dash-0.5.9.1.tar.gz>

Both of those, today, are the exact same file I had previously 
downloaded from Herbert Xu's site and still have locally. Its sha256 
hash is 
5ecd5bea72a93ed10eb15a1be9951dd51b52e5da1d4a7ae020efd9826b49e659, you 
can verify that it matches.

> Has the project
> website moved somewhere, and google just not caught up to the new
> location?  Or is it a transient failure that will be fixed soon now that
> I've called attention to it?

There has not been any announcement on this mailing list, so I suspect 
simply the latter.

> Or am I expected to build from git rather
> than from tarball these days?

No, that shouldn't be necessary, at least not for 0.5.9.1.

> Thanks in advance for any answers you can give.
