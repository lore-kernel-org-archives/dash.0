From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] fifo: Do not restart open() if it already found a partner
Date: Tue, 26 Jun 2012 08:04:58 -0400
Message-ID: <1340712298-4583-1-git-send-email-andersk@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:58913 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754432Ab2FZMF3 (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 26 Jun 2012 08:05:29 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>, dash@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>

If a parent and child process open the two ends of a fifo, and the
child immediately exits, the parent may receive a SIGCHLD before its
open() returns.  In that case, we need to make sure that open() will
return successfully after the SIGCHLD handler returns, instead of
throwing EINTR or being restarted.  Otherwise, the restarted open()
would incorrectly wait for a second partner on the other end.

The following test demonstrates the EINTR that was wrongly thrown from
the parent=E2=80=99s open().  Change .sa_flags =3D 0 to .sa_flags =3D S=
A_RESTART
to see a deadlock instead, in which the restarted open() waits for a
second reader that will never come.

  #include <sys/stat.h>
  #include <sys/types.h>
  #include <sys/wait.h>
  #include <fcntl.h>
  #include <signal.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>

  #define CHECK(x) do {if ((x) =3D=3D -1) {perror(#x); abort();}} while=
(0)

  void handler(int signum) {}

  int main()
  {
      struct sigaction act =3D {.sa_handler =3D handler, .sa_flags =3D =
0};
      CHECK(sigaction(SIGCHLD, &act, NULL));
      CHECK(mknod("fifo", S_IFIFO | S_IRWXU, 0));
      for (;;) {
          int fd;
          pid_t pid;
          putc('.', stderr);
          CHECK(pid =3D fork());
          if (pid =3D=3D 0) {
              CHECK(fd =3D open("fifo", O_RDONLY));
              _exit(0);
          }
          CHECK(fd =3D open("fifo", O_WRONLY));
          CHECK(close(fd));
          CHECK(waitpid(pid, NULL, 0));
      }
  }

This is what I suspect was causing the Git test suite to fail in
t9010-svn-fe.sh:
http://bugs.debian.org/678852

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 fs/fifo.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/fifo.c b/fs/fifo.c
index b1a524d..0d2b53e 100644
--- a/fs/fifo.c
+++ b/fs/fifo.c
@@ -14,7 +14,7 @@
 #include <linux/sched.h>
 #include <linux/pipe_fs_i.h>
=20
-static void wait_for_partner(struct inode* inode, unsigned int *cnt)
+static bool wait_for_partner(struct inode* inode, unsigned int *cnt)
 {
 	int cur =3D *cnt;=09
=20
@@ -23,6 +23,7 @@ static void wait_for_partner(struct inode* inode, uns=
igned int *cnt)
 		if (signal_pending(current))
 			break;
 	}
+	return cur !=3D *cnt;
 }
=20
 static void wake_up_partner(struct inode* inode)
@@ -67,8 +68,7 @@ static int fifo_open(struct inode *inode, struct file=
 *filp)
 				 * seen a writer */
 				filp->f_version =3D pipe->w_counter;
 			} else {
-				wait_for_partner(inode, &pipe->w_counter);
-				if(signal_pending(current))
+				if (!wait_for_partner(inode, &pipe->w_counter))
 					goto err_rd;
 			}
 		}
@@ -90,8 +90,7 @@ static int fifo_open(struct inode *inode, struct file=
 *filp)
 			wake_up_partner(inode);
=20
 		if (!pipe->readers) {
-			wait_for_partner(inode, &pipe->r_counter);
-			if (signal_pending(current))
+			if (!wait_for_partner(inode, &pipe->r_counter))
 				goto err_wr;
 		}
 		break;
--=20
1.7.11.1

