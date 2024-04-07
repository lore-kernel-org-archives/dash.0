Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766538DC7
	for <dash@vger.kernel.org>; Sun,  7 Apr 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480676; cv=none; b=gmM7hTXHL8cGXsd5L5FU34IOasUWFJRrLU8BNlnfuSzfktj6HupkyI5N7j7rF/rmOstaDk7Hc8CGYjrOEs4hfvp7VEQaeIihbj+/3eiy1a8AiOukZPk5aXZKOYBz9ZmuqS31wh9WLIB0X4JBNrGipIL0kXZZnw31NjVJ5mZg5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480676; c=relaxed/simple;
	bh=CWOmT117mu0DW10UubKyLnGaMxk3t14hMZZQ+7rVT1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc3Dym0Uj4YCz3ro8lfrXJlm1z7Rsv6ZJ2mB4NdX6JMmo8vI/YB6/Wns4kdTpQstYfeQ1yXYOHWs2bqRm2moWtvKrB7A1aK1ljldgrboWCsZqfw1sbfdIkvCztKNER1VBZ2KIJssXfeoSIrRH1FElZOWtTw9aYHsPSqE87XwgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rtORo-00GC1s-LO; Sun, 07 Apr 2024 17:04:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Apr 2024 17:04:37 +0800
Date: Sun, 7 Apr 2024 17:04:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: dash@vger.kernel.org, Ganael LAPLANCHE <ganael.laplanche@martymac.org>,
	Jilles Tjoelker <jilles@stack.nl>
Subject: [v2 PATCH] jobs: Allow monitor mode without a tty in non-interactive
 mode
Message-ID: <ZhJhpbIEe1RyBfk0@gondor.apana.org.au>
References: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>

On Mon, Jan 30, 2023 at 10:15:40PM +0100, Steffen Nurpmeso wrote:
> This is a take-over of the FreeBSD bin/sh
> 
>   commit cd60e2c67d52e1f957841af19128c7227880743a
>   Author:     Jilles Tjoelker <jilles@FreeBSD.org>
>   AuthorDate: 2014-09-04 21:48:33 +0000
>   Commit:     Jilles Tjoelker <jilles@FreeBSD.org>
>   CommitDate: 2014-09-04 21:48:33 +0000
> 
>       sh: Allow enabling job control without a tty in non-interactive mode.
> 
>       If no tty is available, 'set -m' is still useful to put jobs in their own
>       process groups.
> ---
> 
> Dear Ganael, it seems it requires an inline patch?
> Let me try this -- thanks!!
> Ciao.
> 
>  src/jobs.c | 114 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 67 insertions(+), 47 deletions(-)

Thanks for the patch.  I've rewritten it to minimise the impact.
However, the end result should be fairly similar.

Please test this and let me know if there are any issues.

---8<---
When a tty is unavailable, or the shell is in the background,
job control could still be used for the purpose of setting
process groups.

This is based on work by Jilles Tjoelker from FreeBSD and Steffen
Nurpmeso.

Reported-by: Steffen Nurpmeso <steffen@sdaoden.eu>
Reported-by: Ganael Laplanche <ganael.laplanche@martymac.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index a0f4d47..2a2fe22 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -187,11 +187,21 @@ set_curjob(struct job *jp, unsigned mode)
 
 int jobctl;
 
+static void xxtcsetpgrp(pid_t pgrp)
+{
+	int fd = ttyfd;
+
+	if (fd < 0)
+		return;
+
+	xtcsetpgrp(fd, pgrp);
+}
+
 void
 setjobctl(int on)
 {
+	int pgrp = -1;
 	int fd;
-	int pgrp;
 
 	if (on == jobctl || rootshell == 0)
 		return;
@@ -207,36 +217,43 @@ setjobctl(int on)
 		fd = savefd(fd, ofd);
 		do { /* while we are in the background */
 			if ((pgrp = tcgetpgrp(fd)) < 0) {
+close:
+				close(fd);
+				fd = -1;
 out:
+				if (!iflag)
+					break;
 				sh_warnx("can't access tty; job control turned off");
 				mflag = on = 0;
-				goto close;
+				return;
 			}
 			if (pgrp == getpgrp())
 				break;
+			if (!iflag)
+				goto close;
 			killpg(0, SIGTTIN);
 		} while (1);
 		initialpgrp = pgrp;
-
-		setsignal(SIGTSTP);
-		setsignal(SIGTTOU);
-		setsignal(SIGTTIN);
 		pgrp = rootpid;
-		setpgid(0, pgrp);
-		xtcsetpgrp(fd, pgrp);
 	} else {
 		/* turning job control off */
 		fd = ttyfd;
 		pgrp = initialpgrp;
-		xtcsetpgrp(fd, pgrp);
-		setpgid(0, pgrp);
-		setsignal(SIGTSTP);
-		setsignal(SIGTTOU);
-		setsignal(SIGTTIN);
-close:
-		close(fd);
-		fd = -1;
 	}
+
+	setsignal(SIGTSTP);
+	setsignal(SIGTTOU);
+	setsignal(SIGTTIN);
+	if (fd >= 0) {
+		setpgid(0, pgrp);
+		xtcsetpgrp(fd, pgrp);
+
+		if (!on) {
+			close(fd);
+			fd = -1;
+		}
+	}
+
 	ttyfd = fd;
 	jobctl = on;
 }
@@ -391,7 +408,7 @@ restartjob(struct job *jp, int mode)
 	jp->state = JOBRUNNING;
 	pgid = jp->ps->pid;
 	if (mode == FORK_FG)
-		xtcsetpgrp(ttyfd, pgid);
+		xxtcsetpgrp(pgid);
 	killpg(pgid, SIGCONT);
 	ps = jp->ps;
 	i = jp->nprocs;
@@ -874,7 +891,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 		/* This can fail because we are doing it in the parent also */
 		(void)setpgid(0, pgrp);
 		if (mode == FORK_FG)
-			xtcsetpgrp(ttyfd, pgrp);
+			xxtcsetpgrp(pgrp);
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 	} else
@@ -1014,7 +1031,7 @@ waitforjob(struct job *jp)
 	st = getstatus(jp);
 #if JOBS
 	if (jp->jobctl) {
-		xtcsetpgrp(ttyfd, rootpid);
+		xxtcsetpgrp(rootpid);
 		/*
 		 * This is truly gross.
 		 * If we're doing job control, then we did a TIOCSPGRP which
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
