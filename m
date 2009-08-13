From: Oleg Verych <olecom@gmail.com>
Subject: script for login shell .profile (Re: Feature request: set -o
	pipefail)
Date: Fri, 14 Aug 2009 02:36:15 +0300
Message-ID: <8499950a0908131636h7e26a3a5t99d810efd282c470@mail.gmail.com>
References: <8499950a0908131634r66123c6au59d10e8e27eecbe6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:35549 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZHMXgO (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 13 Aug 2009 19:36:14 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1064102fga.17
        for <dash@vger.kernel.org>; Thu, 13 Aug 2009 16:36:15 -0700 (PDT)
In-Reply-To: <8499950a0908131634r66123c6au59d10e8e27eecbe6@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> * ssh+ to have multiple sshd servers as simple as creating
> sshd_config+$reason files. E.g. to have some loginless dummies for
> those dudes, who like to f*ck ssh on the Internet.

But even login ssh (on some random port actually) have no regular
system's account(s), but some random obscure names, where
$HOME/dot.profile is like below. PAM is a baby :), just plain
`/bin/sh`.

#!/bin/sh
# "$HOME/.profile" for secured, nice and wise re-login (f*ck PAMela!)

# all signals from controlling tty can kill commands and leave
# user with an interactive shell; purpose of this script to force
# authentication of the real user from this "for login" one

# thus, setting off interactivity (off controlling tty) and setting on
# error checking (any errors -- logout, works only with `+i')

# "/etc/passwd" can have this file as login shell, $HOME can have only
# this file, thus making things easier

# BEWARE, that NO login/password information can be written
# here, because exec-only (no read permission) scripts are not supported.
# Also make sure, that any other login shell for this account must source
# this file, thus making all working securely.

set +i -e
sleep 02
umask 027
cd /
U=`
T=50
P="Enter user name, please ("
G=$((${#P}+1))

exec 9<&0
( read U && echo "$U" ) <&9&
PID=$!
exec 9<&- 1>&2

echo -n "$P$T): "
trap 'kill -KILL "$PID" 2>&-' 0 INT QUIT
P=5
while sleep "0.$P" && test -e "/proc/$PID/exe"
do
  T=$(($T-$P))
    if test "$T" -gt 0
  then printf "\0337\033[${G}G$T): \0338"
  else printf "\033[${G}Gtime is out). Bye.
"
       exit 73
    fi
done`
echo "Wait, please..."
sleep 2
[ "$SSH_ORIGINAL_COMMAND" ] || case "${U:=}" in
   root|'')
       exec sleep $((1<<30));;
   *)  # check and `su` to the supplied login
       test -d "/home/$U" && chmod 660 `tty` && exec su "$U";;
esac
echo "Only interactive shell access is available. No commands, please."
exit 73 # temporal (obscure) failure, not reached
-- 
sed 'sed && sh + olecom = love'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
