From: Vitaly Sinilin <vs@kp4.ru>
Subject: [BUG] Redirection bug in subshell's EXIT trap
Date: Thu, 19 Oct 2017 20:44:10 +0300
Message-ID: <20171019174410.GA22649@ghost.hq.kp4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ghost.kp4.ru ([188.143.137.101]:64235 "EHLO ghost.kp4.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753131AbdJSSKr (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 19 Oct 2017 14:10:47 -0400
Received: from vs by ghost.kp4.ru with local (Exim 4.84)
        (envelope-from <vs@ghost.kp4.ru>)
        id 1e5Era-0006PD-U3
        for dash@vger.kernel.org; Thu, 19 Oct 2017 20:44:10 +0300
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I've recently written a quite unusual script and faced a strange dash
behavior that seems not POSIX-ly correct to me.

Here is the script with a lot of debugging extra output.

(I am sorry about posting a pretty lengthy script, but I feel like a
shorten version will look just insane without the context.)

#!/bin/dash
#
# This helper script takes a terminal from stdin to interact with user
# and prints uuid of the selected entity to stdout that is not
# necessarily connected to the same terminal.
#
# It's meant to be run as part of command substitution, e.g.
#
#     uuid=$(pickthing "$@")
#

die() {
	echo "$@" >&2
	exit 2
}

getch() ( # need a subshell here, so round braces instead of curly ones
	dump_self_fds
	trap 'dump_self_fds; stty -cbreak echo' EXIT
	stty cbreak -echo
	head -c 1
	dump_self_fds
)

dump_self_fds() {
	{ read void; read void; read header pid; } < /proc/self/status
	printf "%d:" $pid
	for fd in 0 1 2; do
		printf " %s" "$(readlink /proc/$pid/fd/$fd)"
	done
	echo
} >&2

test -t 0 || die "Standard input is not a terminal"

exec 3>&1 # 3 will be initial stdout
exec 1>$(tty) # switch stdout to terminal
exec 4<&0 # 4 will be initial stdin (for use in pipelines)
exec 0<&-

# Even when run as sh, bash doesn't interrupt script execution if SIGINT
# is received during execution of a foreground pipeline (dash does). So
# we need to explicitly instruct it to do so.
# https://www.cons.org/cracauer/sigint.html
trap 'trap - INT; kill -INT $$' INT

ask() {
	echo "Take $2? (y/n)"
	while :; do
		#key=$(exec 0<&4; dump_self_fds; getch) # works in dash
		key=$(dump_self_fds; getch <&4) # looks better but
		                                # doesn't work in dash
		case $key in
			[yY]) echo $1 >&3; return 0;;
			[nN]) break;;
		esac
	done
	return 1
}

lsthings() { # just a stub instead of a real command
	cat <<-"EOF"
	df66e01c-1dcf-487c-aedc-a8b1c1859b49 item a
	fff43fed-7560-48f7-9b38-c5509d74693f item b
	EOF
}

dump_self_fds
lsthings "$@" | { while read uuid info; do
	dump_self_fds
	ask "$uuid" "$info" && exit 0
done; exit 1; } || ask "$*" "$* (initial literal value)"

# End of script

N.B. dump_self_fds() dumps PID and file descriptors 0, 1 and 2. It is very
Linux-specific. So there is no point in trying this script in other
environments.

N.B. This script will mess up your terminal settings. Use 'reset' or
'stty echo' after run to fix the terminal.

This script involves 3 levels of subshells.
[1] pipeline with a while loop.
 `--[2] command substitution in ask() key=$(...)
     `--[3] getch() body

Let's see what happens when the script is run (my comments inlined):

$ ./pickthing test
18406: pipe:[4898025] /dev/pts/1 /dev/pts/1 # toplevel shell
18412: pipe:[4898032] /dev/pts/1 /dev/pts/1 # [1]
Take item a? (y/n)
18417: pipe:[4898032] /dev/pts/1 /dev/pts/1 # [2] got stdin from [1]
18421: /dev/pts/1 /dev/pts/1 /dev/pts/1     # [3] got FD#4 as stdin
# I answered n here
18421: /dev/pts/1 /dev/pts/1 /dev/pts/1     # [3] last line
18421: pipe:[4898032] /dev/pts/1 /dev/pts/1 # [3] EXIT trap. WTF???
stty: standard input: Inappropriate ioctl for device

# Since I answered no, second iteration happened.

18412: pipe:[4898032] /dev/pts/1 /dev/pts/1 # [1]
Take item b? (y/n)
18439: pipe:[4898032] /dev/pts/1 /dev/pts/1 # [2]
18443: /dev/pts/1 /dev/pts/1 /dev/pts/1     # [3]
# I answered n here
18443: /dev/pts/1 /dev/pts/1 /dev/pts/1     # [3]
18443: pipe:[4898032] /dev/pts/1 /dev/pts/1 # [3] WTF???
stty: standard input: Inappropriate ioctl for device
Take test (initial literal value)? (y/n)

# It's the last line ask, so no pipeline here anymore.

18461: pipe:[4898099] /dev/pts/1 /dev/pts/1 # [2]
18465: /dev/pts/1 /dev/pts/1 /dev/pts/1     # [3]
18465: /dev/pts/1 /dev/pts/1 /dev/pts/1     # [3]
18465: pipe:[4898118] /dev/pts/1 /dev/pts/1 # [3] WTF???
stty: standard input: Bad file descriptor   # WTF?!?!?

The problem here is that although getch is run in a subshell and it
got FD#4 as stdin it somehow has parent's stdin in its EXIT trap.

POSIX says: "The environment in which the shell executes a trap on
EXIT shall be identical to the environment immediately after the
last command executed before the trap on EXIT was taken."

As you can see the last command of getch is dump_self_fds and stdin
is OK at that time.

In bash this script works as expected. For dash I had to invent
a workaround (commented out line key=$(...)).

-- 
Thanks,
Vitaly Sinilin
(I am not subscribed to the list, so please CC me.)
