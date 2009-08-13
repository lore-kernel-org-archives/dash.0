From: Oleg Verych <olecom@gmail.com>
Subject: Re: Feature request: set -o pipefail
Date: Fri, 14 Aug 2009 02:15:29 +0300
Message-ID: <8499950a0908131615x6b0d2c87we8846b1880360b1d@mail.gmail.com>
References: <20090807131833.GA30733@anuurn.compact> <4A82BAC9.9040808@byu.net>
	 <20090813143522.GB21918@anuurn.compact>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:64248 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbZHMXPb (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 13 Aug 2009 19:15:31 -0400
Received: by fg-out-1718.google.com with SMTP id e21so264180fga.17
        for <dash@vger.kernel.org>; Thu, 13 Aug 2009 16:15:31 -0700 (PDT)
In-Reply-To: <20090813143522.GB21918@anuurn.compact>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Peter Jakobi <jakobi@acm.org>
Cc: Eric Blake <ebb9@byu.net>, dash@vger.kernel.org

>> system "exec 3>&1; s=$(exec 4>&1 >&3; { mv -i foo bar </dev/tty 2>&1; echo
>> $? >&4; } | tee -a LOG) && exit $s"
>
> Yes.  Oleg pointed me to the even more complete sample of  pipestatus,
> which made for an interesting read (thanx Oleg!).

You are welcome. Links were:

* comp.unix.shell FAQ - Answers to Frequently Asked Questions Part 2.
http://groups.google.com/group/comp.unix.shell/browse_thread/thread/5075fe6c19ddabb9/7a08dffe06316a29?pli=1

* UNIX Power Tools (47.2.1.4 More Elaborate Combinations)
http://unix.org.ua/orelly/unix/upt/ch47_02.htm

[...]
> Consider  larger  system-level  scripts,  init.d-scripts,  daemons  or
> scripts e.g. in perl using system().

Just for ref, some of my pipeless, undebianaized, small, reliable,
informative init.d scripts:

* `pure-ftpd+` replacement for #1 overbloated deb package
* `bind9+` using multiple configs and chroot (hope stuff like
CVE-2009-0696 https://www.isc.org/node/474 does nothing serious,
written before 2009-07-28 btw)
* ssh+ to have multiple sshd servers as simple as creating
sshd_config+$reason files. E.g. to have some loginless dummies for
those dudes, who like to f*ck ssh on the Internet.

== /etc/init.d/pure-ftpd+
#!/bin/sh

set -e

[ "$*" ] || exec echo "
Usage: $0 [&|] {start, stop, who}
"
trap "echo '
Unexpected Script Error! Use \`/bin/sh -x $0\` to trace it.
'" 0

for p in "$@"
do case "$p" in
start)
PFD_AUTH='/var/run/pure-ftpd-auth'
env -i "LANG=$LANG" /bin/sh <<__
pure-authd "-s$PFD_AUTH" "-r/srv/.ftp/pure-ftpd-auth"&
# tls, ports, no dot files read, no dns, extauth, broken clients fixes
pure-ftpd --tls=1 -U 337:007 -p 2010:65535 -X -x -H "-lextauth:$PFD_AUTH" -b&
__
echo 'Waiting for FTP server.'
while sleep 1
do ps h -C pure-ftpd,pure-authd -ouid,pid,cmd && break
done >/dev/null 2>&1
# show daemons
ps -C pure-ftpd,pure-authd -ouid,pid,cmd
;;
stop)
# stop all daemons, ignoring errors
while ps h -C pure-ftpd,pure-authd -opid
do kill -TERM `ps h -C pure-ftpd,pure-authd -opid`
   sleep 1
done >/dev/null 2>&1 || :
;;
who)
# show who's running
ps -C pure-ftpd,pure-authd -f || :
;;
esac
echo "$p"
done
trap "" 0

== /etc/init.d/bind9+
#!/bin/sh

# config directory: '/etc/bind/'
#                   every directory here is a config setup for every
#                   network interface (or IP address) on a server
# chroot directory: '/var/cache/bind-chroot/'
#                   this script will copy all config directories for all
#                   network interfaces here, and will run named daemon
#                   chroot()ed here in a config directory
##
## send comments to <olecom@gmail.com> ##

set -e

[ "$*" ] || exec echo "Usage: $0 [&|] {start, stop, reload, who}"
trap "echo '
Unexpected Script Error!. Use \`/bin/sh -x $0\` to trace it.
'" 0

for p in "$@"
do case "$p" in
start)

# set up file creation mask for 'bind:root' as '|r--|rw-|---|'
# we are root, and we will create config files there, so we
# must have write access (for while)

umask 0217
# create working directory, where `bind` will chroot() to
[ -d '/var/cache/bind-chroot' ] || mkdir -m 770 -p '/var/cache/bind-chroot'

# going into config directory
cd /etc/bind
# for every directory (with per network interface config)
# copy config files into chroot, exec a daemon
for d in *
do [ -d "$d" ] && (
    # go into a config
    cd "$d"
    # create chroot for it
    d="/var/cache/bind-chroot/$d"
    mkdir -m 770 -p "$d"
    chown bind:root "$d"
    # copy config files there
    for f in *
    do  dd <"$f">"$d/$f"
    done
    # go there
    cd "$d"
    # secure files
    chown bind:root *
    # drop write permission for root group for newly created files
    umask 0117
    # run `named` here as user 'bind'; it will chroot() here (in "$d").
    exec env -i /usr/sbin/named -4 -c named.conf -d0 -t"$d" -ubind
)
done >/dev/null 2>&1
echo 'Waiting for BIND9 server(s).'
while sleep 1
do ps h -C named -ouid,pid,cmd && break
done >/dev/null 2>&1
# show daemons
ps -C named -ouid,pid,cmd
;;
stop)
# stop all named daemons, ignoring errors
while ps h -C named -opid
do kill -TERM `ps h -C named -opid`
   sleep 1
done >/dev/null 2>&1 || :
;;
reload)
# NOTE: config files are being re-read from the chroot directory
#       in the cache /var/cache/bind-chroot/$config
kill -HUP `ps h -C named -opid`
;;
who)
# show who's running
ps -C named -f || :
;;
esac
echo "$p"
done
trap "" 0

== /etc/init.d/ssh+
#!/bin/sh

set -e

[ "$*" ] || exec echo "
Usage: $0 [&|] {start, stop, reload, who, rr (remote-restart; uses at(1))}"
trap "echo '
Unexpected Script Error! Use \`/bin/sh -x $0\` to trace it.
'" 0
for p in "$@"
do case "$p" in
start)
# Create the PrivSep empty dir if necessary
[ -d /var/run/sshd ] || {
	mkdir /var/run/sshd
	chmod 0750 /var/run/sshd
}
# dummy
env -i "LANG=$LANG" SSHD_OOM_ADJUST=0 /usr/sbin/sshd
# special
cd /etc/ssh
for c in sshd_config+*
do env -i "LANG=$LANG" SSHD_OOM_ADJUST=-17 /usr/sbin/sshd -f "/etc/ssh/$c"
done
echo 'Waiting for SSH servers.'
while sleep 1
do ps h -C sshd -ouid,pid,cmd && break
done >/dev/null 2>&1
# show daemons
ps -C sshd -ouid,pid,cmd
;;
reload)
kill -HUP `ps h -C sshd -opid`
;;
stop)
# kill daemons, ignoring errors
while ps h -C sshd -opid
do kill -TERM `ps h -C sshd -opid`
   sleep 1
done >/dev/null 2>&1 || :
;;
who)
# show who's running
ps -C sshd -f || :
;;
rr)
hash at && {
p='remote-restart within one minute'
at now + 1 minute <<'_'
/etc/init.d/ssh+ stop start
_
} || p="remote-restart doesn't work"
;;
esac
echo "$p"
done
trap "" 0
