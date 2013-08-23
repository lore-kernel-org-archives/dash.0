From: Tavis Ormandy <taviso@google.com>
Subject: Re: [oss-security] [PATCH] implement privmode support in dash
Date: Fri, 23 Aug 2013 01:36:52 -0700
Message-ID: <CAJ_zFk+RrhBr4oHJmbQSxwdeMnvD66XY8qvtVGvdxR7fDk8M_g@mail.gmail.com>
References: <20130822175936.GA1260@google.com> <5216D777.6060601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51363 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab3HWIhN (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 04:37:13 -0400
Received: by mail-wi0-f177.google.com with SMTP id hq12so276635wib.10
        for <dash@vger.kernel.org>; Fri, 23 Aug 2013 01:37:12 -0700 (PDT)
In-Reply-To: <5216D777.6060601@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: kseifried@redhat.com
Cc: oss-security@lists.openwall.com, dash@vger.kernel.org

On Thu, Aug 22, 2013 at 8:31 PM, Kurt Seifried <kseifried@redhat.com> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 08/22/2013 11:59 AM, Tavis Ormandy wrote:
> > Here is a related blog post on the topic
> > http://blog.cmpxchg8b.com/2013/08/security-debianisms.html
> >
> > If you care about tracking vulnerabilities, the vmware issue is
> > called CVE-2013-1662.
>
> Do we need one for Debian as well? Seems like a strong maybe.
>

I think it would be a good idea, it seems similar to something like
CVE-2009-2695 which was a mitigation being disabled.

Tavis.
