From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: Rergession in readcmd (commit 55c46b7)
Date: Wed, 11 Nov 2009 04:19:17 +0300
Message-ID: <4AFA1115.6000000@gmail.com>
References: <20090831101232.GA894@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:28331 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbZKKA0A (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 10 Nov 2009 19:26:00 -0500
In-Reply-To: <20090831101232.GA894@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

31.08.2009 14:12, Herbert Xu wrote:
>> $ dash /tmp/z.sh
>> [Include] [common.conf]
>> [FullSpeedCPU] [yesFnf]
> 
> Thanks for the report.  It's an off-by-one error causing the
> NUL termination to disappear.

I found another example:

$ tr -d '[:print:]' < /etc/passwd |tr -d '\t\n' |wc -c
0

$ dash -c 'while read o p; do printf "[%s] [%s]\n" "$o" "$p"; done <
/etc/passwd' |tr -d '[:print:]' |tr -d '[:space:]' |wc -c
61

bug is not fixed yet :(

-- 
Rgrds, legion

