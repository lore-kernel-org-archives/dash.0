From: Peter Jakobi <jakobi@acm.org>
Subject: Feature request: set -o pipefail
Date: Fri, 7 Aug 2009 15:18:33 +0200
Message-ID: <20090807131833.GA30733@anuurn.compact>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rs3.shuttle.de ([194.95.249.5]:44249 "EHLO rs3.shuttle.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079AbZHGNga (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 7 Aug 2009 09:36:30 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

[Note:  I'm not on the list, so put jakobi@acm.org in cc: if I need to
reply. thanx, Peter]

Feature request:

implement  set  -o pipefail. This will allow the user to  request  the
return  code  to be the one of the first pipe command with a  non-zero
error. 

The  lack  of  which  can be quite painful in  scripting,  even  if  a
bourne-shell/posix subset would otherwise be quite sufficient.


Advantages:

This  allows use of pipes with proper error detection, which is  quite
helpful  for  init  scripts / cron or  generally  administration-style
scripts which exec shell commands from shell/perl/python/... scripts.


Usage case: 

have  a  command  like mv -i act on user input, while  keeping  output
(stdout+err) in a log AND returning mv's error code (or tee's if mv is
ok). in a perl script, this would be something like:

   system "set -o pipefail; mv -i foo bar </dev/tty 2>&1 | tee -a LOG";

Part  of  the problem is that the shell used for open/system is  often
hard-coded in the interpreter to be /bin/sh.


Work aound:

   1. as root: 

   restore /bin/sh to point to a more complete shell of bourne-ancestry.
   With the subsequent larger set of library dependencies, ...

   or

   2. non-root:

   first detect a suitable shell:
   # detect likely shells in path and /etc/shells
   # for each shell, try $tmp=`set -o pipefail 2>&1`
   # choose one that doesn't set a non-zero errror in $?.
   # if all else fails, try defaulting to bash or ksh

   system $shell, "-c", 
          'set -o pipefail; mv -i "$@" </dev/tty 2>&1 | tee -a LOG', 
          "world's most painful trivial system command",
          "foo", "bar";

btw,  wrappers  like script might help, besides being a pain  wrt  LOG
management.  But there's the slight of script -c false returning true.
Which makes e.g. script impossible to use.

-- 
cu
Peter
jakobi@acm.org
