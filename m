From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] printf: use %ll instead of %j
Date: Mon, 3 Dec 2012 06:32:58 -0800
Message-ID: <20121203143258.GA992@elie.Belkin>
References: <op.woqc1kj2dyj81a@2fprep>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab2LCOdI (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 3 Dec 2012 09:33:08 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1949292pad.19
        for <dash@vger.kernel.org>; Mon, 03 Dec 2012 06:33:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <op.woqc1kj2dyj81a@2fprep>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Roy <roytam@gmail.com>
Cc: dash@vger.kernel.org, Brian Koropoff <bkoropoff@gmail.com>

Hi Roy,

Roy wrote:

> MSYS libc does not support %j[dXx] format, only %ll[dXx] is supported.

Are you sure that using the 'll' modifier here is more portable
than 'j'?

FWIW there was a patch posted to use PRIdMAX before, which would be a
more conservative thing to do and I think should work well.

  http://thread.gmane.org/gmane.comp.shells.dash/564/focus=605

Hope that helps,
Jonathan
