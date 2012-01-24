From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: /bin/dash -c != /bin/bash -c with pgrep
Date: Tue, 24 Jan 2012 15:03:56 -0600
Message-ID: <20120124210356.GB8222@burratino>
References: <4F1ED38A.1050401@ruggedcom.com>
 <20120124194342.GC2956@burratino>
 <4F1F11C8.9000200@ruggedcom.com>
 <4F1F1A2E.5020103@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47878 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543Ab2AXVEK (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Jan 2012 16:04:10 -0500
Received: by ghrr11 with SMTP id r11so1068430ghr.19
        for <dash@vger.kernel.org>; Tue, 24 Jan 2012 13:04:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F1F1A2E.5020103@ruggedcom.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Richard Retanubun <richardretanubun@ruggedcom.com>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

Richard Retanubun wrote:

> Sorry, one more question to clarify, which "recent dash versions"
> have the optimization?

Upstream versions, or you can grab Debian packaging from the
proposed-experimental branch at [1].

Cheers,
Jonathan

[1] git://repo.or.cz/dash/debian/jrn.git
