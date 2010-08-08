From: "Taylan Ulrich B." <taylanbayirli@gmail.com>
Subject: IFS and read (builtin)
Date: Mon, 9 Aug 2010 01:13:38 +0200
Message-ID: <AANLkTi=+AcK+tChFqwbgbE-BOJvzhZMLsOCN-wVNKQGK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39851 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab0HHXNl (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 8 Aug 2010 19:13:41 -0400
Received: by wwj40 with SMTP id 40so10986342wwj.1
        for <dash@vger.kernel.org>; Sun, 08 Aug 2010 16:13:40 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

dash 0.5.6.1

Try this:
echo foo:bar | ( IFS=: read foo bar; echo "$foo, $bar" )

It should print "foo, bar", but the IFS setting is ignored and we get
"foo:bar, ".

It works if you set the IFS globally before using read.

It does NOT seem to be a general issue about builtins not recognizing
leading name=value settings; for example the following works:
OLDPWD=foo cd -


On an unrelated note to prevent distraction, the command-grouping in
my first example is required because:
http://mywiki.wooledge.org/BashFAQ/024
