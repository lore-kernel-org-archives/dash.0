From: "Mark Mentovai" <mmentovai@gmail.com>
Subject: Re: Mac OS X support patch
Date: Sat, 12 Jul 2008 10:51:27 -0400
Message-ID: <4faa0b8b0807120751t4aa5d58do48e86a303828d90d@mail.gmail.com>
References: <4faa0b8b0807111420o36da862ahd17a4a7d06a781e7@mail.gmail.com>
	 <48782307.8020900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:32404 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbYGLOv2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 12 Jul 2008 10:51:28 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4831044rvb.1
        for <dash@vger.kernel.org>; Sat, 12 Jul 2008 07:51:28 -0700 (PDT)
In-Reply-To: <48782307.8020900@zytor.com>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dash@vger.kernel.org

H. Peter Anvin wrote:
> Mark Mentovai wrote:
>> - open64 is not present although the stat64 family is, separate the
>>  autoconf checks
>
> This seems like the Wrong Thing anyway; the right thing should be to add
> whatever option (like -D_FILE_OFFSET_BITS=64 on Linux) to do *everything*
> using the full-sized offsets.

autoconf provides AC_SYS_LARGEFILE for this, but I don't think it
should be part of this patch.  Does dash have a bug tracker where this
can be filed?

Mark
