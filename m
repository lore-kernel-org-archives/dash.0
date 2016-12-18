From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] builtin: Fix 'echo --' handling
Date: Sun, 18 Dec 2016 21:28:52 +0100
Message-ID: <a558fca9-1a50-8258-aa37-f1eee0b96f66@gigawatt.nl>
References: <20161218201606.GA19607@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:38386 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753376AbcLRUgZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 18 Dec 2016 15:36:25 -0500
In-Reply-To: <20161218201606.GA19607@localhost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mihail Konev <k.mvc@ya.ru>, dash@vger.kernel.org

On 18/12/2016 21:16, Mihail Konev wrote:
> Ignore first "--", as the end of options.

echo -- is required by POSIX to print --. To quote:

 > The echo utility shall not recognize the "--" argument in the manner 
specified by Guideline 10 of XBD Utility Syntax Guidelines; "--" shall 
be recognized as a string operand.

Scripts wishing to print the text "-n" without anything else must find 
some other way, for example using the printf command.

Cheers,
Harald van Dijk
