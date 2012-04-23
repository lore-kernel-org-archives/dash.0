From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Mon, 23 Apr 2012 14:44:53 -0500
Message-ID: <20120423194453.GA13576@burratino>
References: <4F958907.9030508@gmail.com>
 <20120423170339.GA9635@burratino>
 <4F95AD25.3060200@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55775 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab2DWTpK (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 15:45:10 -0400
Received: by ghrr11 with SMTP id r11so6423381ghr.19
        for <dash@vger.kernel.org>; Mon, 23 Apr 2012 12:45:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F95AD25.3060200@case.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Chet Ramey <chet.ramey@case.edu>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>, dash@vger.kernel.org

Chet Ramey wrote:

> What are `conforming scripts'?  Scripts without syntax errors?

I meant "conforming POSIX applications".

A patch for this might even be welcome if it makes dash bigger, if
that's what you're wondering.
