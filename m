From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [BUG?] here documents, command substitution, and the { keyword
Date: Sat, 6 Nov 2010 21:21:21 -0500
Message-ID: <20101107022121.GA22719@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52415 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab0KGCVd (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 6 Nov 2010 22:21:33 -0400
Received: by gyh4 with SMTP id 4so2838804gyh.19
        for <dash@vger.kernel.org>; Sat, 06 Nov 2010 19:21:32 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

Just ran into some strange behavior:

$ cat test.sh
#!/bin/sh
echo hello >greeting
cat <<EOF &&
$(cat greeting)
EOF
{
	echo $?
	cat greeting
} >/dev/null


$ sh test.sh
hello
test.sh: 7: {: not found
127
hello
test.sh: 10: Syntax error: "}" unexpected

bash, mksh, pdksh, and ksh93 all print hello as expected.  The problem
is reproducible with all versions of dash in the git repo.

Ideas?
Jonathan
