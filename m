Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD1C4361B
	for <linux-dash@archiver.kernel.org>; Sat, 19 Dec 2020 22:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C9623A53
	for <linux-dash@archiver.kernel.org>; Sat, 19 Dec 2020 22:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgLSWWG (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 19 Dec 2020 17:22:06 -0500
Received: from sdaoden.eu ([217.144.132.164]:35240 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgLSWWF (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 19 Dec 2020 17:22:05 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 8160216058; Sat, 19 Dec 2020 23:21:22 +0100 (CET)
Date:   Sat, 19 Dec 2020 23:21:22 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     DASH shell mailing list <dash@vger.kernel.org>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Jilles Tjoelker <jilles@stack.nl>
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh:
 spring TTOU but should not i think
Message-ID: <20201219222122.p9UYT%steffen@sdaoden.eu>
In-Reply-To: <20201219172838.1B-WB%steffen@sdaoden.eu>
References: <20201219172838.1B-WB%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.20-84-g7268a84d
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=-=MIvaqxZxjRYOPTY0zY_f_oxkpp5drCBX3zp7=-="
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.

--=-=MIvaqxZxjRYOPTY0zY_f_oxkpp5drCBX3zp7=-=
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-ID: <20201219222122.KxU0u%steffen@sdaoden.eu>

Steffen Nurpmeso wrote in
 <20201219172838.1B-WB%steffen@sdaoden.eu>:
 |Long story short, after falsely accusing BSD make of not working

After dinner i shortened it a bit more, and attach it again, ok?
It is terrible, but now less redundant than before.
Sorry for being so terse, that problem crosses my head for about
a week, and i was totally mislead and if you bang your head
against the wall so many hours bugs or misbehaviours in a handful
of other programs is not the expected outcome.

  #?0|kent:tmp$ SHELL=/bin/bash make -f jobo.mk
  ./mx-test.sh
  Starting job reaper (timeout of 2 seconds)
  .. waiting for job reaper to come up
  PRE T1 CHEK
  PREWAIT
  CHECK 10
  ls: cannot access '/NONEXISTENT': No such file or directory
  CHECK /bin/bash 50
  allexport       off
  braceexpand     on
  emacs           off
  errexit         off
  errtrace        off
  functrace       off
  hashall         on
  histexpand      off
  history         off
  ignoreeof       off
  interactive-comments    on
  keyword         off
  monitor         on
  noclobber       off
  noexec          off
  noglob          off
  nolog           off
  notify          off
  nounset         off
  onecmd          off
  physical        off
  pipefail        off
  posix           off
  privileged      off
  verbose         off
  vi              off
  xtrace          off
  CHECK 23
  CHECK 100
  AFTER T1 CHEK
  Stopping job reaper
  make: *** [jobo.mk:2: test] Error 1

That is how it "should look" ;), monitor is on in there. 

  #?2|kent:tmp$ SHELL=/bin/dash make -f jobo.mk
  ./mx-test.sh
  Starting job reaper (timeout of 2 seconds)
  .. waiting for job reaper to come up
  TTOU
  Cleaning up running jobs
  Stopping job reaper
  make: *** [jobo.mk:2: test] Error 2

Somehow refuses to work when supervised by (any) make (i tried).
Works as desired when ridden directly.

  #?2|kent:tmp$ SHELL=/bin/mksh make -f jobo.mk
  ./mx-test.sh
  Starting job reaper (timeout of 2 seconds)
  .. waiting for job reaper to come up
  PRE T1 CHEK
  CHECK 10
  PREWAIT
  ls: cannot access '/NONEXISTENT': No such file or directory
  PREWAIT
  PREWAIT
  PREWAIT
  PREWAIT
  PREWAIT
  PREWAIT
  PREWAIT
  TIMEOUT IN PARENT
  
  !! Timeout: reaped job 1 [X_errexit]
  Stopping job reaper

And that condition is very strange, with or without supervision.

Ciao!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

--=-=MIvaqxZxjRYOPTY0zY_f_oxkpp5drCBX3zp7=-=
Content-Type: application/x-sh; charset=us-ascii
Content-Disposition: attachment; filename="mx-test.sh"
Content-ID: <20201219222122.K-TPL%steffen@sdaoden.eu>

#!/bin/sh -

OBJDIR='/tmp/jobo';export OBJDIR # MANAGED!!

: ${SHELL:=/bin/sh};export SHELL

: ${JOBNO:=1}
: ${JOBWAIT:=2}
: ${JOBMON:=y}

export \
   OBJDIR SHELL JOBNO JOBWAIT JOBMON

LC_ALL=C LANG=C TZ=UTC
export LC_ALL LANG TZ

if [ -z "${MAILX__CC_TEST_RUNNING}" ]; then
      CHECK=1 RUN_TEST= MAILX=
   export CHECK RUN_TEST MAILX
fi

mkdir='/bin/mkdir';export mkdir
rm='/bin/rm';export rm

if [ -z "${MAILX__CC_TEST_RUNNING}" ]; then
   MAILX__CC_TEST_RUNNING=y
   export MAILX__CC_TEST_RUNNING
rm -rf $OBJDIR
mkdir -p $OBJDIR
   exec "${SHELL}" "${0}" "${@}"
fi
cd $OBJDIR || exit 100

DEVELDIFF= DUMPERR=
TESTS_PERFORMED=0 TESTS_OK=0 TESTS_FAILED=0 TESTS_SKIPPED=0
JOBS=0 JOBLIST= JOBDESC= JOBREAPER= JOBSYNC=
SUBSECOND_SLEEP=
   ( sleep .1 ) >/dev/null 2>&1 && SUBSECOND_SLEEP=y

   TESTS_NET_TEST=
   [ "${OPT_NET_TEST}" = 1 ] && [ -x ./net-test ] && TESTS_NET_TEST=1
   export TESTS_NET_TEST

COLOR_ERR_ON= COLOR_ERR_OFF=  COLOR_DBGERR_ON= COLOR_DBGERR_OFF=
COLOR_WARN_ON= COLOR_WARN_OFF=
COLOR_OK_ON= COLOR_OK_OFF=
ESTAT=0
TEST_NAME=

trap "
   jobreaper_stop
" EXIT
trap "exit 1" HUP INT QUIT TERM
trap 'echo TTIN' TTIN
trap 'echo TTOU' TTOU
trap 'echo TSTP' TSTP
trap : CHLD

jobreaper_start() {
   printf 'Starting job reaper (timeout of %s seconds)\n' ${JOBWAIT}

   i=
   trap 'i=1' USR1 # "reaper (actually a notify timer only) is up"
   (
      parent=${$}
      sleeper= int=0 hot=0
      trap '' EXIT HUP QUIT CHLD
      trap 'exit 0' INT
      trap '
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
         int=1 hot=1
      ' USR1
      trap '
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
         int=1 hot=0
      ' USR2
      trap '
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
         echo "Stopping job reaper"
         exit 0
      ' TERM

      # traps are setup, notify parent that we are up and running
      kill -USR1 ${parent} >/dev/null 2>&1

      while :; do
         int=0
         sleep ${JOBWAIT} &
         sleeper=${!}
         wait ${!}
         sleeper=
         [ "${int}${hot}" = 01 ] && kill -USR1 ${parent} >/dev/null 2>&1
      done
   ) </dev/null & #>/dev/null 2>&1 &
   JOBREAPER=${!}

   j=
   if [ ${?} -eq 0 ]; then
      while :; do
         if [ -n "${i}" ]; then
            trap '' USR1
            return
         fi
         printf '..%s waiting for job reaper to come up\n' "${j}"
         j=' still'
         sleep 1 &
         wait ${!}
      done
   fi

   JOBREAPER=
   printf '%s!! Cannot start the wild job reaper!%s\n' \
      "${COLOR_ERR_ON}" "${COLOR_ERR_OFF}"
}

jobreaper_stop() {
   [ -n "${JOBREAPER}" ] && kill -TERM ${JOBREAPER} >/dev/null 2>&1
   JOBREAPER=
   if [ ${JOBS} -gt 0 ]; then
      echo 'Cleaning up running jobs'
      jtimeout
      wait ${JOBLIST}
      JOBLIST=
   fi
}

jspawn() {
   if [ ${JOBNO} -gt 1 ]; then
      # We are spawning multiple jobs..
      [ ${JOBS} -eq 0 ] && printf '...'
      JOBS=`add ${JOBS} 1`
      printf ' [%s=%s]' ${JOBS} "${1}"
   else
      JOBS=1
      # Assume problems exist, do not let user keep hanging on terminal
      if [ -n "${RUN_TEST}" ]; then
         printf '... [%s]\n' "${1}"
      fi
   fi

   [ -n "${JOBMON}" ] && set -m >/dev/null 2>&1
   (  # Place the job in its own directory to ease file management
      trap '' EXIT HUP INT QUIT TERM USR1 USR2
      #${mkdir} t.${JOBS}.d && cd t.${JOBS}.d &&
         eval t_${1} ${JOBS} ${1} &&
         ${rm} -f t.${JOBS}.id
   ) > t.${JOBS}.io </dev/null & # 2>&1 </dev/null &
   i=${!}
   [ -n "${JOBMON}" ] && set +m >/dev/null 2>&1
   JOBLIST="${JOBLIST} ${i}"
   printf '%s\n%s\n' ${i} ${1} > t.${JOBS}.id

   # ..until we should sync or reach the maximum concurrent number
   [ ${JOBS} -lt ${JOBNO} ] && return

   jsync 1
}

jsync() {
   if [ ${JOBS} -eq 0 ]; then
      [ -n "${TEST_ANY}" ] && printf '\n'
      TEST_ANY=
      return
   fi
   [ -z "${JOBSYNC}" ] && [ ${#} -eq 0 ] && return

   [ ${JOBNO} -ne 1 ] && printf ' .. waiting\n'

   if [ -n "${JOBREAPER}" ]; then
      timeout= alldone=

      trap 'echo TIMEOUT IN PARENT;timeout=1' USR1
      kill -USR1 ${JOBREAPER} >/dev/null 2>&1

      loops=0
      while [ -z "${timeout}" ]; do
         alldone=1
         i=0
         while [ ${i} -lt ${JOBS} ]; do
            i=`add ${i} 1`
            [ -f t.${i}.id ] || continue
            alldone=
            break
         done
         [ -n "${alldone}" ] && break

         if [ -z "${SUBSECOND_SLEEP}" ]; then
            loops=`add ${loops} 1`
            [ ${loops} -lt 111 ] && continue
            sleep 1 &
         else
            sleep .5 &
         fi
echo >&2 PREWAIT
         wait ${!}
      done

      kill -USR2 ${JOBREAPER} >/dev/null 2>&1
      trap '' USR1

      [ -n "${timeout}" ] && jtimeout
   fi

   # Now collect the zombies
   wait ${JOBLIST}
   JOBLIST=

   # Update global counters
   i=0
   while [ ${i} -lt ${JOBS} ]; do
      i=`add ${i} 1`

      if [ -f t.${i}.id ]; then
         { read pid; read desc; } < t.${i}.id
         desc=${desc#${desc%%[! ]*}}
         desc=${desc%${desc##*[! ]}}
         [ -s t.${i}.io ] && printf >&2 '\n'
         printf >&2 '%s!! Timeout: reaped job %s [%s]%s\n' \
            "${COLOR_ERR_ON}" ${i} "${desc}" "${COLOR_ERR_OFF}"
         TESTS_FAILED=`add ${TESTS_FAILED} 1`
      else
         TESTS_FAILED=`add ${TESTS_FAILED} 1`
         ESTAT=1
      fi
   done

   JOBS=0
}

jtimeout() {
   i=0
   while [ ${i} -lt ${JOBS} ]; do
      i=`add ${i} 1`
      if [ -f t.${i}.id ] &&
            read pid < t.${i}.id >/dev/null 2>&1 &&
            kill -0 ${pid} >/dev/null 2>&1; then
         j=${pid}
         [ -n "${JOBMON}" ] && j=-${j}
         kill -KILL ${j} >/dev/null 2>&1
      else
         ${rm} -f t.${i}.id
      fi
   done
}

t_prolog() {
   shift

   ESTAT=0 TESTS_PERFORMED=0 TESTS_OK=0 TESTS_FAILED=0 TESTS_SKIPPED=0 \
      TEST_NAME=${1} TEST_ANY=

   printf '%s[%s]%s\n' "" "${TEST_NAME}" ""
}

t_epilog() {
   [ -n "${TEST_ANY}" ] && printf '\n'

   printf '%s %s %s %s %s\n' \
      ${ESTAT} \
         ${TESTS_PERFORMED} ${TESTS_OK} ${TESTS_FAILED} ${TESTS_SKIPPED} \
      > ../t.${1}.result
}

t_echoerr() {
   ESTAT=1
   t_echo0err "${@}"
}

t_echo0err() {
   [ -n "${TEST_ANY}" ] && __i__="\n" || __i__=
   printf "${__i__}"'%sERROR: %s%s\n' \
      "${COLOR_ERR_ON}" "${*}" "${COLOR_ERR_OFF}"
   TEST_ANY=
}

check() {
   restat=${?} tid=${1} eestat=${2} f=${3} s=${4} optmode=${5}

   TESTS_PERFORMED=`add ${TESTS_PERFORMED} 1`

   if [ -n "${CHECK}${RUN_TEST}" ]; then
      x="t.${TEST_NAME}-${tid}"
      if :; then
         y=test-out
         if [ -n "${y}" ]; then
            if : ; then
echo >&2 CHECK $TID 10
# NOTE: REMOVE THIS (or use true(1)) AND WORKS directly and via bmake (mksh)
# (env -i regardless, "false" also is not it, whatever)
env -i ls -latr /NONEXISTENT
echo >&2 CHECK $SHELL $TID 50
# NOTE: monitor should be "on" here
set -o >&2
echo >&2 CHECK $TID 23
            fi
         fi
      fi
   fi
echo >&2 CHECK $TID 100
}

   add() {
      echo "$((${1} + ${2}))"
   }

t_X_errexit() {
   t_prolog "${@}"

echo >&2 PRE T1 CHEK
   check 1 0 ./t1 '2700500141 51'
echo >&2 AFTER T1 CHEK
t_epilog "$@"
return
}

ssec=$SECONDS
      jobreaper_start
   jspawn X_errexit
jsync 1
      jobreaper_stop
esec=$SECONDS

exit ${ESTAT}
# s-sh-mode

--=-=MIvaqxZxjRYOPTY0zY_f_oxkpp5drCBX3zp7=-=
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jobo.mk"
Content-ID: <20201219222122.Lx89x%steffen@sdaoden.eu>

test:
	./mx-test.sh

--=-=MIvaqxZxjRYOPTY0zY_f_oxkpp5drCBX3zp7=-=--
