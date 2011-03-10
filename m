From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: shift "fatal error"
Date: Thu, 10 Mar 2011 20:23:33 +0100
Message-ID: <20110310192333.GE3948@wopr.local.invalid>
References: <AANLkTik1TC3jv-imnbChRGqtHzRCvKCcB5_LnqEnDc9u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:42402 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab1CJTXi (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 14:23:38 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik1TC3jv-imnbChRGqtHzRCvKCcB5_LnqEnDc9u@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: dash@vger.kernel.org

* Dan Muresan <danmbox@gmail.com> [2011-03-10 19:41]:
> Hi, is there some consensus on whether shift should cause a "fatal
> error" as reported by Herbert against bash:
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=252378
> 
> # doesn't print anything
> dash -c 'shift 2; echo hi'
> 
> My copy of SUSv3 doesn't seem to imply any "fatal error" handling
> requirement for shift:
> 
> --- 8-X ---
> EXIT STATUS
> 
> The exit status is >0 if n>$#; otherwise, it is zero.
> 
> CONSEQUENCES OF ERRORS
> 
> Default.
> --- 8-X ---

For IEEE Std 1003.1-2008 see section 2.8.1 "Consequences of
Shell Errors": a "utility syntax error (option or operand error)"
with special built-ins shall cause the shell to exit. That's what
dash, ksh93, and pdksh do.

-- 
Guido Berhoerster
