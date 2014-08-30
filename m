From: Gerrit Pape <pape@smarden.org>
Subject: Debian jessy freeze
Date: Sat, 30 Aug 2014 21:23:15 +0000
Message-ID: <20140830212315.3450.qmail@2d0634a0e38d6b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smarden.org ([176.74.58.109]:60739 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752016AbaH3V35 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 30 Aug 2014 17:29:57 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi Herbert, current Debian testing 'jessy' is about to be frozen on
2014-11-05.  Currently I have version 0.5.7-4 in jessy, which is a bit
derived from your v0.5.7 and current master branch, see below.

My repository is available through http://smarden.org/git/dash.git
(branch release+patches)

Do you have any plans to release a version v0.5.8 soon?  I'd be happy t=
o
sync with it and give it broader testing in Debian unstable.

Regards, Gerrit.


$ git shortlog origin/master..release+patches
Gerrit Pape (10):
      import contents of upstream dash-0.5.3.tar.gz archive.
      import contents of upstream dash-0.5.4.tar.gz archive.
      Merge commit 'v0.5.4' into upstream
      import contents of upstream dash-0.5.5.1.tar.gz archive.
      Merge commit '6045fe25078345074f027312d106d3fc19df56e5' into rele=
ase
      Merge commit 'v0.5.6.1' into candidate
      import contents of upstream dash-0.5.6.1.tar.gz archive
      [SHELL] print \n upon EOF (CTRL-D) when run interactively
      [JOBS] address format-security build error
      [EVAL] Report I/O error on stdout

Herbert Xu (5):
      [EVAL] Fix command -- crash
      [EXPAND] Fix corruption of redirections with byte 0x81
      [JOBS] Fix wait regression where it does not wait for all jobs
      [BUILTIN] Continue after EINTR in read(1) with no pending signals
      Release 0.5.6.1.

Jilles Tjoelker (1):
      [PARSER] Remove backslash before } in double-quotes in variable

Jonathan Nieder (3):
      import contents of upstream dash-0.5.7.tar.gz archive
      [VAR] Disable LINENO support
      [BUILTIN] Fix "test -x" as root on platforms with old-fashioned f=
accessat()

St=E9phane Glondu (1):
      [SHELL] Disable sh -c "command" -> sh -c "exec command" optimizat=
ion

$ git shortlog v0.5.7..origin/master
David S. Miller (2):
      [SHELL] Allow building without LINEO support
      [SHELL] Add top-level autogen.sh

Harald van Dijk (1):
      [ARITH] Avoid imaxdiv when only one of the results is wanted

Herbert Xu (1):
      [BUILTIN] Merge SKIPFUNC/SKIPFILE and only clear SKIPFUNC when le=
aving dotcmd

maximilian attems (1):
      [SHELL] Fix klibc DEBUG compilation

$=20
