From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Mon, 23 Apr 2012 12:03:39 -0500
Message-ID: <20120423170339.GA9635@burratino>
References: <4F958907.9030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46715 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab2DWRDx (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 13:03:53 -0400
Received: by obbta14 with SMTP id ta14so12915982obb.19
        for <dash@vger.kernel.org>; Mon, 23 Apr 2012 10:03:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F958907.9030508@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
Cc: dash@vger.kernel.org

Hi Stefano,

Stefano Lattarini wrote:

> How to reproduce:
>
>   $ dash -c ':; fi'; echo stat = $?
>   stat = 0

Since this doesn't affect conforming scripts, I suspect it falls
squarely within the "patches welcome as long as they don't make dash
bigger" category.

Thanks for finding it.

Sincerely,
Jonathan
