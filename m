From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug: temporary assignments vs shell function
Date: Thu, 14 Jul 2011 05:25:14 -0500
Message-ID: <20110714102514.GA12904@elie>
References: <20110714083455.GA25362@div0.qc.to>
 <20110714092615.GA15476@elie>
 <20110714100915.GA18946@div0.qc.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43574 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab1GNKZ2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 14 Jul 2011 06:25:28 -0400
Received: by iwn6 with SMTP id 6so68204iwn.19
        for <dash@vger.kernel.org>; Thu, 14 Jul 2011 03:25:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110714100915.GA18946@div0.qc.to>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Rudolf Polzer <divverent@xonotic.org>
Cc: dash@vger.kernel.org

Rudolf Polzer wrote:

> So basically - when using an assignment for the duration of a shell command
> execution, an explicit subshell must be used in portable scripts, as
> interpretation of this construct differs among shells and thus cannot be relied
> on.

If "shell command execution" means "function call", then yes.

[...]
> exported() { :; }
>
> foo=bar exported
> sh -c 'echo $foo'

Ah, yuck.  On this machine:

 - dash does not export
 - zsh with "emulate sh" exports
 - ksh93 does not export
 - pdksh does not export
 - posh does not export
 - mksh exports
 - "bash -o posix" exports
 - busybox sh does not export

Fun.
