From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 15:05:23 +0100
Message-ID: <20140128140523.GB17217@hal.lan>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
 <20140128144056.ac2c1804a662b66678acfdab@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([78.47.51.218]:33475 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbaA1OFa (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 09:05:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by multivac.heapoverflow.de (Postfix) with ESMTP id 4D21320628
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 15:05:29 +0100 (CET)
Received: from hal.lan (p5DC59457.dip0.t-ipconnect.de [93.197.148.87])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id 423DC201BB
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 15:05:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140128144056.ac2c1804a662b66678acfdab@tuxfamily.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

* Seb <sbb@tuxfamily.org> [2014-01-28 14:41]:
> Le Tue, 28 Jan 2014 18:16:23 +0600
> > So, I cannot test this operation without using $?
> 
> You can use the file tests:
> 
>  if [ -f no_such_file -a -r no_such_file ]; then
>    exec 9<no_such_file
>  else
>    echo TEST
>  fi
> 
> or a subshell:
> 
>  if ( exec 9<no_such_file ) 2>/dev/null; then
>    exec 9<no_such_file
>  else
>    echo TEST
>  fi

That's generally a bad idea since it is racy, if no_such_file is
removeded in between the test and actual exec your script will
still exit. Also, do no use test -a if you care about portability,
it's an XSI extension and marked obsolescent.
-- 
Guido Berhoerster
