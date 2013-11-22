From: Tormen <quickhelp@gmail.com>
Subject: sed script fails to run in dash
Date: Fri, 22 Nov 2013 19:11:42 +0100
Message-ID: <528F9E5E.4020807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57524 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KVSLp (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Nov 2013 13:11:45 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so439877wgh.2
        for <dash@vger.kernel.org>; Fri, 22 Nov 2013 10:11:44 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I am puzzled and don't know why this command does not work with dash (I
am currently using the debian stable (v7.2) version of dash (v0.5.7-3)):

echo 1>/tmp/x; reponse=$( sed -e $(wc -l </tmp/x)$'{w/dev/stdout\n;d}'
-i /tmp/x ); echo "reponse='$reponse'"

but also just this line:

    sed -e 1$'{w/dev/stdout\n;d}' -i /tmp/x

in a dash script will yield the error message:

    sed: -e expression #1, char 2: unknown command: `$'

But why ? :(

I would be really grateful for any explanation.
Thanks a lot in advance for any hint!


Tormen


P.S.: The source for the above line is:
http://stackoverflow.com/questions/13804967/bash-pop-lines-in-a-file
