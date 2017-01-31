From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: why does dash save, dup, and restore redirected descriptor in the
 parent, rather than redirect in the child?
Date: Tue, 31 Jan 2017 21:30:54 +0100
Message-ID: <d9dc79a9-9276-991e-5d91-8c4de1eaf1f9@gigawatt.nl>
References: <2132582962.805179.1485892834849.ref@mail.yahoo.com>
 <2132582962.805179.1485892834849@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:36120 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751876AbdAaUhW (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 31 Jan 2017 15:37:22 -0500
In-Reply-To: <2132582962.805179.1485892834849@mail.yahoo.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mark Galeck <mark_galeck@pacbell.net>, "dash@vger.kernel.org" <dash@vger.kernel.org>

On 31/01/2017 21:00, Mark Galeck wrote:
> Why save, dup and dup again to restore, descriptors in the parent, when it would be much simpler to just dup in the child, and not have to save and restore.

This assumes there's a child in the first place. Depending on the 
command, that might not be the case, think of built-in commands such as 
echo for instance. Code is needed to handle that case, and I suspect 
that if that code is there anyway, then having one place to set up 
redirections is simpler than having two places to set up redirections.

Cheers,
Harald van Dijk
