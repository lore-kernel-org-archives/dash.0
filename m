From: Martijn Dekker <martijn@inlv.org>
Subject: [BUG] Interactive (d)ash exits on assigning to readonly from 'command
 eval'
Date: Thu, 27 Oct 2016 22:40:52 +0100
Message-ID: <177dba07-fb53-4958-3455-e047c7f32ee6@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <busybox-bounces@busybox.net>
List-Unsubscribe: <http://lists.busybox.net/mailman/options/busybox>,
 <mailto:busybox-request@busybox.net?subject=unsubscribe>
List-Archive: <http://lists.busybox.net/pipermail/busybox/>
List-Post: <mailto:busybox@busybox.net>
List-Help: <mailto:busybox-request@busybox.net?subject=help>
List-Subscribe: <http://lists.busybox.net/mailman/listinfo/busybox>,
 <mailto:busybox-request@busybox.net?subject=subscribe>
Errors-To: busybox-bounces@busybox.net
Sender: "busybox" <busybox-bounces@busybox.net>
To: dash@vger.kernel.org, busybox@busybox.net
List-Id: dash@vger.kernel.org

This bug is on both dash and busybox ash.

The "command" builtin is supposed to stop special builtins (such as
"eval") from exiting the shell on error. So doing something like

   isreadonly() {
      ! command eval "$1=" 2>/dev/null
   }

ought to be a way to test if a variable is read-only without the
performance hit of forking a subshell.

Using this function works fine in scripts, but it immediately makes an
interactive dash or ash exit. The same happens if you try a similar
command manually.

bash$ dash
$ readonly bla=123
$ command eval bla=457
dash: 1: eval: bla: is read only
$
bash$

After the "is read only" error, dash prints a prompt, but does not wait
for input and exits instead. Busybox ash does not even print the prompt
before exiting.

The funny part is that the interactive shell does not exit if you leave
out the 'command'. The very thing that is supposed to stop a
non-interactive shell from exiting makes an interactive shell exit.

HTH,

- M.
