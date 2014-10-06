From: Paul Smith <paul@mad-scientist.net>
Subject: Failure of nested substring processing inside double-quotes
Date: Mon, 06 Oct 2014 16:03:13 -0400
Message-ID: <1412625793.29340.94.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:43980 "HELO
	gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750720AbaJFUKJ (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 6 Oct 2014 16:10:09 -0400
Received: from [173.9.45.73] (port=51809 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XbEVB-0000LG-WE
	for dash@vger.kernel.org; Mon, 06 Oct 2014 14:03:26 -0600
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi all.  I recently found a bug in dash's handling of substring
processing, when the variable is contained within quotes.

In bash, this works:

  bash$ echo $PWD
  /home/psmith

  bash$ echo ${PWD%${PWD##*/}}.
  /home/.

  bash$ echo "${PWD%${PWD##*/}}."
  /home/.

which is what I expect.  However, in dash we get:

  dash$ echo $PWD
  /home/psmith

  dash$ echo ${PWD%${PWD##*/}}.
  /home/.

  dash$ echo "${PWD%${PWD##*/}}."
  .

Whoops!  Inside double-quotes dash is mishandling the nested string
substitution.  If I break it up into two steps it works OK, regardless
of whether or not it's quoted.

This is dash 0.5.7-4ubuntu1 (from Ubuntu GNOME 14.04).

