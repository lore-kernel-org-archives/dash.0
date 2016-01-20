From: Trek <trek00@inbox.ru>
Subject: echo do not print NUL byte
Date: Wed, 20 Jan 2016 22:38:50 +0100
Message-ID: <20160120223850.25cdf852@enterprise>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.181.253]:48982 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbcATVjF (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 20 Jan 2016 16:39:05 -0500
Received: from smtp17.mail.ru (smtp17.mail.ru [94.100.176.154])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id 92E62A23D57E
	for <dash@vger.kernel.org>; Thu, 21 Jan 2016 00:38:55 +0300 (MSK)
Received: from dynamic-adsl-84-220-78-39.clienti.tiscali.it ([84.220.78.39]:20448 helo=enterprise)
	by smtp17.mail.ru with esmtpa (envelope-from <trek00@inbox.ru>)
	id 1aM0Sq-0001ff-Oc
	for dash@vger.kernel.org; Thu, 21 Jan 2016 00:38:53 +0300
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

there is no way to print the NUL byte with the echo utility

with an XSI shell (mksh, posh, yash):

  $ sh -c 'echo \\0 | od -An -c'
    \0  \n

with a shell that requires echo -e (ksh, bash, busybox, mksh):

  $ sh -c 'echo -e \\0 | od -An -c'
    \0  \n

with dash (XSI, no -e argument):

  $ dash -c 'echo \\0 | od -An -c'
    \n

where others characters are correctly printed:

  $ dash -c 'echo \\0100 | od -An -c'
     @  \n

with dash it only works with printf:

  $ dash -c 'printf \\0\\n | od -An -c'
    \0  \n


I discovered this bug developing a small shell library, where you can
find an use case in the n_bytes_encode function of the lib/bytes.sh file
included in http://www.trek.eu.org/devel/naive/naive-0.0.2.tar.gz

c-ya!
