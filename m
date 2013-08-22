From: Tavis Ormandy <taviso@google.com>
Subject: Re: [PATCH] implement privmode support in dash
Date: Thu, 22 Aug 2013 13:05:11 -0700
Message-ID: <CAJ_zFk+2r5EjTFqRUoiD4DFgKfvr415V+3Pekh63c2_qKAGoQg@mail.gmail.com>
References: <20130822175936.GA1260@google.com> <52166DA8.1000201@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52206 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005Ab3HVUFc (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 22 Aug 2013 16:05:32 -0400
Received: by mail-wg0-f44.google.com with SMTP id x12so2043299wgg.23
        for <dash@vger.kernel.org>; Thu, 22 Aug 2013 13:05:31 -0700 (PDT)
In-Reply-To: <52166DA8.1000201@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, oss-security@lists.openwall.com

On Thu, Aug 22, 2013 at 12:59 PM, Harald van Dijk <harald@gigawatt.nl> wrote:
> On 22/08/13 19:59, Tavis Ormandy wrote:
>> Hello, this is a patch to add privmode support to dash. privmode attempts to
>> drop privileges by default if the effective uid does not match the uid. This
>> can be disabled with -p, or -o nopriv.
>
> Hi Tavis,
>
> Your approach definitely has my support (FWTW), but there are two
> aspects that surprised me, and are different from bash and FreeBSD's sh:
>
> You named the option nopriv, while bash and FBSD use the name
> privileged. I think it is likely to confuse people if "bash -o
> privileged" and "dash -o nopriv" do the same thing, and that it would be
> better to match bash and give the option a positive name, such as
> "priv", or perhaps even match them exactly and use "privileged".
>
> In bash and FBSD, after starting with -p, set +p can be used to drop
> privileges. With your patch, dash accepts set +p, but silently ignores it.
>
> How does something like the attached, to be applied on top of your
> patch, look?

Thanks Harald, those changes make sense to me.

Tavis.
