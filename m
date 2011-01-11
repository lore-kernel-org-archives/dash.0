From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: dash 0.5.6.1-1, setting IFS to tab, bug?
Date: Tue, 11 Jan 2011 16:25:38 -0600
Message-ID: <20110111222538.GA29788@burratino>
References: <AANLkTimH4dj4x12T1j5d4hd1Xeq2nMwev8ZLegbgCMT-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53425 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab1AKWZw (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Jan 2011 17:25:52 -0500
Received: by qyj19 with SMTP id 19so3452265qyj.19
        for <dash@vger.kernel.org>; Tue, 11 Jan 2011 14:25:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimH4dj4x12T1j5d4hd1Xeq2nMwev8ZLegbgCMT-@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: peter kvillegard <peterkvillegard@gmail.com>
Cc: dash@vger.kernel.org

Hi Peter,

peter kvillegard wrote:

> test1(space)test2(tab)test3
> 
> (where the "(space)" is an actual space etc)
> then:
> 
> #!/bin/dash
> 
> cat testfile |
> while IFS='  	' read col1 col2; do    #an actual tab

In my mailreader, this shows as

	"while" SP "IFS='" SP SP HT "'" SP "read" ...

In particular, IFS contains a space and a tab.  So I would expect
"$col1" to be "test1" and "$col2" to be "test2	test3".

> echo $col1
> echo $col2

Because unquoted, $col2 is subject to word splitting.  So echo
receives arguments "test2" "test3" and separates them with a space.

> done
>
> exit 0
>
> it gives the output:
>
> test1
> test2 test3

Looks good to me. ;-)

See http://unix.org/2008edition/ for details.

Hope that helps,
Jonathan
