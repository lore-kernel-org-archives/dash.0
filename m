From: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
Subject: Inconsistent behaviour between 'jobs' and 'echo "$(jobs)"'
Date: Mon, 19 Jan 2015 19:01:53 +0100
Message-ID: <54BD4691.7050906@ertelnet.rybnik.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.ertel.com.pl ([62.182.231.178]:23438 "EHLO
	smtp.ertel.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbbASSLr (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 19 Jan 2015 13:11:47 -0500
Received: from wrobel.no-ip.org (public64144.xdsl.centertel.pl [79.163.250.144])
	(Authenticated sender: dwrobel@ertelnet.rybnik.pl)
	by smtp.ertel.com.pl (Postfix) with ESMTPSA id 7A0D840718ED0
	for <dash@vger.kernel.org>; Mon, 19 Jan 2015 19:10:07 +0100 (CET)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I'm observing an inconsistent behaviour between:
  jobs
and
  echo "$(jobs)"

Here is the short example:

$ rpm -qv dash
dash-0.5.8-1.fc21.i686
$ /bin/dash
$ sleep 1000 &
$ jobs
[1] + Running                    sleep 1000
$ echo "$(jobs)"

$ echo `jobs`

$ jobs 2>/dev/null
[1] + Running                    sleep 1000
$

-- 
Have a nice day,
Damian
