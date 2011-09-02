From: nothink <nothink@shellmix.com>
Subject: build static with libedit
Date: Sat, 03 Sep 2011 03:30:25 +0600
Message-ID: <4E614AF1.7080802@shellmix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020708090406070707050803"
Return-path: <dash-owner@vger.kernel.org>
Received: from shellmix.com ([213.155.190.130]:47148 "EHLO shellmix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076Ab1IBVmU (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Sep 2011 17:42:20 -0400
Received: from shellmix.com (localhost [127.0.0.1])
	by shellmix.com (SPaj) with ESMTP id E528A17444
	for <dash@vger.kernel.org>; Fri,  2 Sep 2011 23:27:45 +0000 (UTC)
Received: from [10.64.234.51] (unknown [213.87.128.117])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: nothink)
	by shellmix.com (SPaj) with ESMTPSA id 7F22B17208
	for <dash@vger.kernel.org>; Fri,  2 Sep 2011 23:27:42 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------020708090406070707050803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Good time!
First of all, thank to everyone who develops dash.
Maybe I'm wrong, but I can't build 0.5.7-, git-version of dash with 
option: --enable-static --with-libedit.

gcc -Wall -g -O2  -static -Wl,--fatal-warnings -o dash alias.o arith_yacc.o arith_yylex.o cd.o error.o eval.o exec.o expand.o histedit.o input.o jobs.o mail.o main.o memalloc.o miscbltin.o mystring.o options.o parser.o redir.o show.o trap.o output.o printf.o system.o test.o times.o var.o builtins.o init.o nodes.o signames.o syntax.o -ledit
/usr/lib/libedit.a(terminal.o): In function `terminal_tputs':
/tmp/build/libedit-20110802-3.0/src/terminal.c:1223: undefined reference to `tputs'
/usr/lib/libedit.a(terminal.o): In function `terminal_deletechars':
/tmp/build/libedit-20110802-3.0/src/terminal.c:714: undefined reference to `tgoto'
/usr/lib/libedit.a(terminal.o): In function `terminal_set':
/tmp/build/libedit-20110802-3.0/src/terminal.c:881: undefined reference to `tgetent'
/tmp/build/libedit-20110802-3.0/src/terminal.c:899: undefined reference to `tgetflag'
/tmp/build/libedit-20110802-3.0/src/terminal.c:900: undefined reference to `tgetflag'
/tmp/build/libedit-20110802-3.0/src/terminal.c:902: undefined reference to `tgetflag'
/tmp/build/libedit-20110802-3.0/src/terminal.c:903: undefined reference to `tgetflag'
/tmp/build/libedit-20110802-3.0/src/terminal.c:905: undefined reference to `tgetflag'
/usr/lib/libedit.a(terminal.o):/tmp/build/libedit-20110802-3.0/src/terminal.c:906: more undefined references to `tgetflag' follow
/usr/lib/libedit.a(terminal.o): In function `terminal_set':
/tmp/build/libedit-20110802-3.0/src/terminal.c:908: undefined reference to `tgetnum'
/tmp/build/libedit-20110802-3.0/src/terminal.c:909: undefined reference to `tgetnum'
/tmp/build/libedit-20110802-3.0/src/terminal.c:912: undefined reference to `tgetstr'
/usr/lib/libedit.a(terminal.o): In function `terminal_insertwrite':
/tmp/build/libedit-20110802-3.0/src/terminal.c:755: undefined reference to `tgoto'
/usr/lib/libedit.a(terminal.o): In function `terminal_move_to_char':
/tmp/build/libedit-20110802-3.0/src/terminal.c:613: undefined reference to `tgoto'
/tmp/build/libedit-20110802-3.0/src/terminal.c:570: undefined reference to `tgoto'
/usr/lib/libedit.a(terminal.o): In function `terminal_move_to_line':
/tmp/build/libedit-20110802-3.0/src/terminal.c:517: undefined reference to `tgoto'
/tmp/build/libedit-20110802-3.0/src/terminal.c:530: undefined reference to `tgoto'
/usr/lib/libedit.a(terminal.o): In function `terminal_echotc':
/tmp/build/libedit-20110802-3.0/src/terminal.c:1522: undefined reference to `tgetstr'
/tmp/build/libedit-20110802-3.0/src/terminal.c:1658: undefined reference to `tgoto'
/tmp/build/libedit-20110802-3.0/src/terminal.c:1602: undefined reference to `tgoto'
collect2: ld returned 1 exit status

Obviously, need dependency lib - curses.
Somehow, builds system dash not use her.

diff -cr dash_np/configure.ac dash_mp/configure.ac
*** dash_np/configure.ac	Sat Sep  3 01:06:25 2011
--- dash_mp/configure.ac	Sat Sep  3 01:45:59 2011
***************
*** 129,135 ****
   if test "$use_libedit" != "yes"; then
   	AC_DEFINE([SMALL], 1, [Define if you build with -DSMALL])
   else
! 	export LIBS="$LIBS -ledit"
   fi
   AC_ARG_ENABLE(lineno, AS_HELP_STRING(--disable-lineno, \
   				     [Disable LINENO support]))
--- 129,139 ----
   if test "$use_libedit" != "yes"; then
   	AC_DEFINE([SMALL], 1, [Define if you build with -DSMALL])
   else
! 	if test "$enable_static" = "yes"; then
! 		PKG_CHECK_MODULES([LIBEDIT], [libedit>= 0])
! 	else
! 		export LIBS="$LIBS -ledit"
! 	fi
   fi
   AC_ARG_ENABLE(lineno, AS_HELP_STRING(--disable-lineno, \
   				     [Disable LINENO support]))
diff -cr dash_np/src/Makefile.am dash_mp/src/Makefile.am
*** dash_np/src/Makefile.am	Sat Sep  3 01:06:25 2011
--- dash_mp/src/Makefile.am	Sat Sep  3 01:47:39 2011
***************
*** 6,12 ****
   	-DBSD=1 -DSHELL \
   	-DIFS_BROKEN

! AM_CFLAGS = $(COMMON_CFLAGS)
   AM_CPPFLAGS = $(COMMON_CPPFLAGS)
   AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS)
   AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
--- 6,12 ----
   	-DBSD=1 -DSHELL \
   	-DIFS_BROKEN

! AM_CFLAGS = $(COMMON_CFLAGS) $(LIBEDIT_CFLAGS)
   AM_CPPFLAGS = $(COMMON_CPPFLAGS)
   AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS)
   AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
***************
*** 30,36 ****
   	init.h input.h jobs.h machdep.h mail.h main.h memalloc.h miscbltin.h \
   	myhistedit.h mystring.h options.h output.h parser.h redir.h shell.h \
   	show.h system.h trap.h var.h
! dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o

   HELPERS = mkinit mksyntax mknodes mksignames

--- 30,36 ----
   	init.h input.h jobs.h machdep.h mail.h main.h memalloc.h miscbltin.h \
   	myhistedit.h mystring.h options.h output.h parser.h redir.h shell.h \
   	show.h system.h trap.h var.h
! dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o $(LIBEDIT_LIBS)

   HELPERS = mkinit mksyntax mknodes mksignames


Thank for attention!
Good luck!

--------------020708090406070707050803
Content-Type: text/plain;
 name="dash_static_with_libedit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash_static_with_libedit.patch"

diff -cr dash_np/configure.ac dash_mp/configure.ac
*** dash_np/configure.ac	Sat Sep  3 01:06:25 2011
--- dash_mp/configure.ac	Sat Sep  3 01:45:59 2011
***************
*** 129,135 ****
  if test "$use_libedit" != "yes"; then
  	AC_DEFINE([SMALL], 1, [Define if you build with -DSMALL])
  else
! 	export LIBS="$LIBS -ledit"
  fi
  AC_ARG_ENABLE(lineno, AS_HELP_STRING(--disable-lineno, \
  				     [Disable LINENO support]))
--- 129,139 ----
  if test "$use_libedit" != "yes"; then
  	AC_DEFINE([SMALL], 1, [Define if you build with -DSMALL])
  else
! 	if test "$enable_static" = "yes"; then
! 		PKG_CHECK_MODULES([LIBEDIT], [libedit >= 0])
! 	else
! 		export LIBS="$LIBS -ledit"
! 	fi
  fi
  AC_ARG_ENABLE(lineno, AS_HELP_STRING(--disable-lineno, \
  				     [Disable LINENO support]))
diff -cr dash_np/src/Makefile.am dash_mp/src/Makefile.am
*** dash_np/src/Makefile.am	Sat Sep  3 01:06:25 2011
--- dash_mp/src/Makefile.am	Sat Sep  3 01:47:39 2011
***************
*** 6,12 ****
  	-DBSD=1 -DSHELL \
  	-DIFS_BROKEN
  
! AM_CFLAGS = $(COMMON_CFLAGS)
  AM_CPPFLAGS = $(COMMON_CPPFLAGS)
  AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS) 
  AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
--- 6,12 ----
  	-DBSD=1 -DSHELL \
  	-DIFS_BROKEN
  
! AM_CFLAGS = $(COMMON_CFLAGS) $(LIBEDIT_CFLAGS)
  AM_CPPFLAGS = $(COMMON_CPPFLAGS)
  AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS) 
  AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
***************
*** 30,36 ****
  	init.h input.h jobs.h machdep.h mail.h main.h memalloc.h miscbltin.h \
  	myhistedit.h mystring.h options.h output.h parser.h redir.h shell.h \
  	show.h system.h trap.h var.h
! dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o
  
  HELPERS = mkinit mksyntax mknodes mksignames
  
--- 30,36 ----
  	init.h input.h jobs.h machdep.h mail.h main.h memalloc.h miscbltin.h \
  	myhistedit.h mystring.h options.h output.h parser.h redir.h shell.h \
  	show.h system.h trap.h var.h
! dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o $(LIBEDIT_LIBS)
  
  HELPERS = mkinit mksyntax mknodes mksignames
  

--------------020708090406070707050803--
