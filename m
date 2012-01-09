From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Question about job control in non-interactive shells
Date: Mon, 9 Jan 2012 10:37:45 -0600
Message-ID: <20120109163745.GA23825@burratino>
References: <tntr4z8j1fk.fsf@waterbuck.yellow.cert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52564 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170Ab2AIQcq (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 9 Jan 2012 11:32:46 -0500
Received: by yenm10 with SMTP id m10so252087yen.19
        for <dash@vger.kernel.org>; Mon, 09 Jan 2012 08:32:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <tntr4z8j1fk.fsf@waterbuck.yellow.cert.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Welsh Duggan <mwd@cert.org>
Cc: dash@vger.kernel.org

Hi Michael,

Michael Welsh Duggan wrote:

> I am trying to determine why:
>
>   dash -c "sleep 5 & kill %1"
>
> results in:
>
>   dash: 1: kill: No such process

You are probably looking for the -m option.

Thanks for writing, and hope that helps,
Jonathan
