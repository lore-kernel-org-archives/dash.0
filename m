From: Oleg Verych <olecom@flower.upol.cz>
Subject: funny `dash` build, `sed` + BRE (Re: shell and glibc)
Date: Mon, 19 May 2008 12:48:10 +0200
Message-ID: <20080519104809.GJ21428@flower.upol.cz>
References: <20080519033047.GI21428@flower.upol.cz> <E1Jxwig-0007sq-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:47788 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYESKcL (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 19 May 2008 06:32:11 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 56D941472B6
	for <dash@vger.kernel.org>; Mon, 19 May 2008 12:26:22 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id RJQULHQGaAECu3RF for <dash@vger.kernel.org>; Mon, 19 May 2008 12:26:22 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Jy2uY-00064E-19
	for dash@vger.kernel.org; Mon, 19 May 2008 12:48:10 +0200
Content-Disposition: inline
In-Reply-To: <E1Jxwig-0007sq-00@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> > It seems, small glibc team cannot do much in areas without interest.
> 
> Unfortunately all the cool kids want to work on the kernel instead :)

Without good basic userspace, they cannot prove, they are "cool", just
big "code-monkeys" :)

While kernel is done somehow, klibc seems to be one-Man-project. When
Linux will be built by use of klibc and its tools and this will not be
slow, buggy and ugly, then we can talk about "cool kids" there/here.

Anyway, personally i'm looking into klibc and step-by-step learn
everything from ground-up. Proposed `minised` for inclusion, because
it's next to shell tool to have anything going on.


Time for promised size optimization, because this relates to my work on
"another kconfig/kbuild"/any-konfig-build (preliminary names are `kid`
and `bit`: configure it, build it).

To make use of (supposedly) cool work of GCC guys on optimizations
(why GCC is slower every release, then?), i did something like this:


cat *.h | sed 'rm "#include"' | uniq -u '<#includes>' >src.c
cat *.c | sed 'save <#include>;remove "#include ; remove extern"' >>src.c

while ! gcc -include ../config.h -DSHELL -Os -Wall src.c
do manual fix of src.c
done

It builds and runs. Don't know how buggy, because of heavy use of global
variables -- test suit is needed. Why? RAM is cheap, optimizing `gcc`
cult.


NOTE: two CPUS, thus -j2 -- `make` time is halved. But with -Os && -O2
it is more than one `gcc` on whole source anyway.

== optimizing '-Os' ==

$time make >/dev/null 2>&1

real    0m4.905s
user    0m4.276s
sys     0m0.576s
$
$time make clean >/dev/null 2>&1

real    0m0.037s
user    0m0.024s
sys     0m0.016s

$time make -j2 >/dev/null 2>&1

real    0m2.613s
user    0m4.312s
sys     0m0.608s
$cd _build/
$time gcc -DHAVE_CONFIG_H -include ../config.h -DSHELL -Os -Wall -c ../_src.c -o _out.o

real    0m2.542s
user    0m2.468s
sys     0m0.068s
$time gcc -DHAVE_CONFIG_H -include ../config.h -DSHELL -Os -Wall _out.o ../src/arith_y*o

real    0m0.025s
user    0m0.016s
sys     0m0.004s
$./a.out -c 'echo "hi"'
hi
$

I've gave up on arithmetic sources, thus linking it from original build.
And the size diff is...

$stat -c %s src/dash
108821
$stat -c %s _build/a.out
105721
$strip src/dash _build/a.out
$src/dash -c 'stat -c %s src/dash _build/a.out | { read d && read c && echo $((d-c)); }'
2072
$_build/a.out -c 'stat -c %s src/dash _build/a.out | { read d && read c && echo $((d-c)); }'
_build/a.out: stat: not found
$

Oh, well... I'd blame C -- soup of ugly config (#if/#define/#include),
link info (extern) and auto* -- tools (ugly ways of doing basic things,
that after many years of hard use show their failed design).

Otherwise, i just don't know why "GCC optimizing" cult exists at all. It
was OK doing that decade ago, but "new features/crutches" of C again
makes it difficult to compare optimizing performance itself.

Anyway 2k, if will be saved when bugs with globals/#ifdefs will be
fixed, isn't that bad.

== optimizing '-O2' ==

$time make -j2 >/dev/null 2>&1

real    0m2.913s
user    0m4.744s
sys     0m0.684s
$cd _build/
$time gcc -DHAVE_CONFIG_H -include ../config.h -DSHELL -O2 -Wall -c ../_src.c -o _out.o

real    0m2.803s
user    0m2.720s
sys     0m0.076s
$time gcc -DHAVE_CONFIG_H -include ../config.h -DSHELL -O2 -Wall _out.o ../src/arith_y*o

real    0m0.025s
user    0m0.012s
sys     0m0.016s
$cd .. ; strip src/dash _build/a.out
$src/dash -c 'stat -c %s src/dash _build/a.out | { read d && read c && echo $((d-c)); }'
2872
^^^^

== optimizing '-O3' ==

$time make -j2 >/dev/null 2>&1

real    0m4.065s
user    0m6.920s
sys     0m0.624s
$cd _build/
$time gcc -DHAVE_CONFIG_H -include ../config.h -DSHELL -O3 -Wall -c ../_src.c -o _out.o

real    0m5.566s
user    0m5.448s
sys     0m0.112s
$time gcc -DHAVE_CONFIG_H -include ../config.h -DSHELL -O3 -Wall _out.o ../src/arith_y*o

real    0m0.026s
user    0m0.020s
sys     0m0.004s
$cd ..
$strip src/dash _build/a.out
$src/dash -c 'stat -c %s src/dash _build/a.out | { read d && read c && echo $((d-c)); }'
-16040
^^^^^^

OOPS!!!


> > Very surprising for me was recent discovery of big performance penalty of
> > the most simple '^$' regexp; it turned to be glibc RE library problem:
> > 
> > http://bugs.debian.org/475474
> > (bonus: 4 ways of doing one thing with `sed`, not with `perl`:)
> 
> Have you seen http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=65458 ?

Heh. `gsed` (ssed->gsed, another maintainer -- `ssed` author) and glibc
(NFA->DFA[0]) went big path from that. While i was told, that current RE
library is extremely complex, Paolo (sed maintainer) did the patch for
this (very long actually). It's about simplest thing...

[0] Before 2002 glibc used a NFA based regex, since it then it uses a
    DFA based one (completely rewrite was checked in end of February 2002).
    <http://mid.gmane.org/20070507062037.GE355@devserv.devel.redhat.com>


Alright. I'm a BRE+sed ninja[1], you know.

[1] http://kerneltrap.org/node/16028

So, this one is doing something, like concat version header with pkg
name (sometimes strange).

== Original input: ==

$time sed -n 's%.*/\(.*\):Version: \([[:digit:]]\+:\)\?%\1_%p' <sed.input >/dev/null

real    0m0.078s
user    0m0.076s
sys     0m0.000s
$time sed -n 's%.*/\(.*\):Version: \([[:digit:]]\+:\)\?%\1_%p' <sed.input >/dev/null

real    0m0.079s
user    0m0.080s
sys     0m0.000s

== New input: ==

$cat sed.input sed.input sed.input sed.input >sed2.input
$cat sed2.input sed2.input sed2.input sed2.input >>sed.input
$time sed -n 's%.*/\(.*\):Version: \([[:digit:]]\+:\)\?%\1_%p' <sed.input >/dev/null

real    0m2.373s
user    0m2.356s
sys     0m0.016s
$time sed -n 's%.*/\(.*\):Version: \([[:digit:]]\+:\)\?%\1_%p' <sed.input >/dev/null

real    0m2.408s
user    0m2.388s
sys     0m0.016s
$

== Let's go! ==

$time sed -n 's%.*/\(.*\):Version: \([[:digit:]]\+:\)\?%\1_%p' <sed.input >here

real    0m2.416s
user    0m2.416s
sys     0m0.000s
$time sed -n '/:Version: /s`.*/\(.*\):Version: `\1_`p' <sed.input >here2

real    0m0.281s
user    0m0.260s
sys     0m0.024s
$diff -u here here2 | head
--- here        2008-05-19 12:33:51.618096000 +0200
+++ here2       2008-05-19 12:34:01.722727500 +0200
@@ -1,7 +1,7 @@
 bug_3.2.10
 console-data_1999.08.29-11.2
-cpp-doc_2.95.2-10
-cvsweb_1.79-3
+cpp-doc_1:2.95.2-10
+cvsweb_3:1.79-3
 debconf_0.2.80.14

== Let strange quark decay ==

$time sed -n '/:Version: /s`.*/\(.*\):Version: \([^:]*:\)*`\1_`p' <sed.input >here2

real    0m0.284s
user    0m0.268s
sys     0m0.020s
$diff -u here here2 | head
$

So, nearly one order of magnitude?


I welcome everybody to see my kerneltrap about RE and my standpoint
about "BRE + `sed`" vs "ERE + perl + others":

   GCC, kernel development?
   Brainy text processing of plain open source text first!

TIA for feedback!
-- 
sed 'sed && sh + olecom = love' << ''
-o--=O`C
 #oo'L O
<___=E M
