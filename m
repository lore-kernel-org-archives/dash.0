From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Command parsing problem and tracefile
Date: Fri, 8 Jun 2012 12:17:30 -0500
Message-ID: <20120608171730.GG10380@burratino>
References: <4FD22F1B.3090208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39139 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab2FHRRi (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jun 2012 13:17:38 -0400
Received: by yenm10 with SMTP id m10so1436444yen.19
        for <dash@vger.kernel.org>; Fri, 08 Jun 2012 10:17:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FD22F1B.3090208@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Richard H Lee <ricardohenrylee@gmail.com>
Cc: dash@vger.kernel.org

Hi Richard,

Richard H Lee wrote:

> First up, when I run a configure script and it hits the following line:
> if $_pkg_config --exists --print-errors $all_libav_libs ; then
>
> with $_pkg_config being 'pkg-config --static', dash throws the
> following error:
> ./configure: 6012: ./configure: pkg-config --static: not found

Thanks for writing.  Who is setting _pkg_config to 'pkg-config
--static', what are they trying to do, and can it be done another way?

This doesn't look like a dash-specific phenomenon.  I get the same
result with

	$ "pkg-config --static" foo bar
	dash: 1: pkg-config --static: not found

which looks right to me.  (You can test with 'CONFIG_SHELL=/bin/ksh
ksh ./configure'.)

[...]
> I would like to get some more info as to what in going on. IIRC, I
> saw in show.c, there was some sort for tracefile that dash to dump
> to. How do I enable this?

"dash -o debug" after a compile with DEBUG enabled.  Though "dash -x"
tends to be more helpful if you are debugging a shell script rather
than trying to find a bug in dash itself.

Hope that helps,
Jonathan
