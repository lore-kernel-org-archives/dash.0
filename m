From: Craig Loomis <cploomis@gmail.com>
Subject: "command -p" does not correctly limit search to a safe PATH
Date: Wed, 10 Jul 2013 14:18:33 -0400
Message-ID: <CAL=-wemDL=2-7Rco761LTgGrFeAA_-zvz0ECpk4xZE7QJsGUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63038 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3GJSSz (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Jul 2013 14:18:55 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so11732612wib.10
        for <dash@vger.kernel.org>; Wed, 10 Jul 2013 11:18:54 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

  I needed to bootstrap a safe shell environment, assuming only a
minimal "POSIX system" and expecting some peculiar ones (embedded
systems with unusual paths, etc).

  One modern POSIX prescription to establish a safe PATH is fleshed
out in OpenGroup's IEEE 1003.1 at
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
(and so 'man 1p command' on some Linux versions).
  This boils down to (after setting IFS and cleaning out aliases and functions):

$ PATH="$(command -p getconf PATH):$PATH"

  Which works as a bootstrap because:
    - "command" is a shell builtin (per the standard)
    - "command -p" limits its search to system-defined locations.
    - "getconf PATH" uses confstr(3) to get the required
system-defined _CS_PATH.

  The Standard's definition of paths is a bit fuzzy; a paragraph from
the Rationale helps:

"The -p option is present because it is useful to be able to ensure a
safe path search that finds all the standard utilities. This search
might not be identical to the one that occurs through one of the exec
functions (as defined in the System Interfaces volume of POSIX.1-2008)
when PATH is unset. At the very least, this feature is required to
allow the script to access the correct version of getconf so that the
value of the default path can be accurately retrieved."


  Dash (0.5.7 and git master) does not implement 'command -p'
according to the standard, and opens an intriguing security hole to
anyone trying this scheme.

  When using 'command -v' to simply print the path to an executable,
'-p' has no effect:

# Assume that an executable /tmp/evilbin/getconf exists
$ PATH=/tmp/evilbin:$PATH

$ command -v getconf
/tmp/evilbin/getconf
$ command -p -v getconf
/tmp/evilbin/getconf

  Not good, but most people would call getconf directly. At first
glance that _appears_ to work better -- /tmp/evilbin/getconf is not
called:

$ command getconf PATH
/tmp/evilbin:/bin:/usr/bin
$ command -p getconf PATH
/usr/bin:/bin:/usr/sbin:/sbin

  but there are two surprises:
    a) the behavior of 'command -p cmd' and '$(command -p -v cmd)'
really should be the same, no?
    b) the path that 'command -p cmd' uses is a compiled-in constant
from dash's src/var.c:defpathvar, which starts with
"/usr/local/sbin:/usr/local/bin". To me, that is both completely
unexpected and pretty scary -- /usr/local/bin is (very) often less
well secured or checked than, say, /bin:

# somehow, sometime, 'sudo make install' or a g+w /usr/local/ might get you:
$ cp evil_getconf /usr/local/bin/getconf

  after which:

$ command -p getconf PATH
/tmp/evilbin:/bin:/usr/bin

  Ouch.

  src/exec.c and src/eval.c are a bit tricky (see the different
behavior between 'command cmd' and 'command -v cmd') and too
fundamental for me to stand behind a quick patch. Sorry.

  FWIW, bash 4.1+ (and maybe earlier) has a posix compliant 'command
-p'. Fixed sometime after 3.2, from trying that version on OS X 10.8
and RHEL 5.9.

 - craig
