From: Eitan Adler <eitanadlerlist@gmail.com>
Subject: dash build errors
Date: Fri, 22 May 2009 10:06:54 -0400
Message-ID: <4A16B17E.3080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:44773 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbZEVOFt (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 May 2009 10:05:49 -0400
Received: by gxk10 with SMTP id 10so3194243gxk.13
        for <dash@vger.kernel.org>; Fri, 22 May 2009 07:05:50 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

When I try to compile dash on FreeBSD 7.2-STABLE i386
I get the following:

$gmake
gmake  all-recursive
gmake[1]: Entering directory `/home/variable/dash-0.5.1'
Making all in src
gmake[2]: Entering directory `/home/variable/dash-0.5.1/src'
gmake  all-am
gmake[3]: Entering directory `/home/variable/dash-0.5.1/src'
if gcc -DBSD=1 -DSMALL -DSHELL -DGLOB_BROKEN -DFNMATCH_BROKEN
-DIFS_BROKEN -D__COPYRIGHT\(x\)= -D__RCSID\(x\)= -D_DIAGASSERT\(x\)= -I.
-I. -I..  -include ../config.h   -g -O2 -Wall -MT exec.o -MD -MP -MF
".deps/exec.Tpo" \
          -c -o exec.o `test -f 'exec.c' || echo './'`exec.c; \
        then mv -f ".deps/exec.Tpo" ".deps/exec.Po"; \
        else rm -f ".deps/exec.Tpo"; exit 1; \
        fi
exec.c: In function 'find_command':
exec.c:317: error: storage size of 'statb' isn't known
exec.c:326: warning: implicit declaration of function 'stat64'
exec.c:317: warning: unused variable 'statb'
gmake[3]: *** [exec.o] Error 1
gmake[3]: Leaving directory `/home/variable/dash-0.5.1/src'
gmake[2]: *** [all] Error 2
gmake[2]: Leaving directory `/home/variable/dash-0.5.1/src'
gmake[1]: *** [all-recursive] Error 1
gmake[1]: Leaving directory `/home/variable/dash-0.5.1'
gmake: *** [all] Error 2


-- 
Eitan Adler
"Security is increased by designing for the way humans actually behave."
-Jakob Nielsen
