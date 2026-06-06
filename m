Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB404175A69
	for <dash@vger.kernel.org>; Sat,  6 Jun 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760258; cv=none; b=JNKo5zV97C4/bACUIpKPOFRdE/+s7aXXVE5nII83unde2ZdrHFXdUQ6bTOZPT06Iatz9mo4rm9PiXxig7iWfyA7NWw78QE0SSydQ+D1x54obi96qaPyKQQOgwvnQ8Leu7jjyfxKLpGQ+uh2/upeerQdCz4Xqno9pl69DnqYp3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760258; c=relaxed/simple;
	bh=9gTaUz4fZvnhLoOwJs6yCmwBQ4wUZVesrCunYZMRGFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhRFiRwjG3HtzbOyRDJ9EL9+VkFu82umaJyNGJSNOTzQBHk5MW1BD5MFmVAuAnKDwQ8jSw/PwcAN28Rzyc+nfhDiQh0fUSAqDj+q4LCFgYL8OlTXEHmFY9muP2drdBRrbvpABMCg5nNYZHwko6FGgMXg+gdrlwi68tFMJplvRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=VdlKbMGF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fg5BwEEy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="VdlKbMGF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fg5BwEEy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E4009EC00DA;
	Sat,  6 Jun 2026 11:37:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 06 Jun 2026 11:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780760254; x=
	1780846654; bh=iiIsnjnQngXbpm0jOSh+5lKpxQgyzt8ah4Ytfeddz4s=; b=V
	dlKbMGF22U8KmVSyazk9eGI5RSsQ16UJ5LHgPpk3857U/N+mraGFu0d/maEDXa7p
	6y+i5QoeLQtY0wwoPPMk8feD6YTpX2SQUNgDEQGBSfma6e2+wvU5vCP8uaUdu4IV
	/3xy27mLIXu8olJmkJsxY0vb7ZJ5LZ8ffDcvr5us9Ka1zQsAhb4uzZM1VdaSxYw7
	kydK6P+DhR+HtaqoA6E9Df6aXz5v6ufAB7YZbuP+IibQnNyMyAEtj7KNYpAxC9Pb
	j1//Mu+u9R5dR0q2JwbWrhCWrywvogOOpqYjri1Wiw4qk2woKuPeltRHiZziNAB6
	0CcKtUrR+fdtKvw9tXc8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780760254; x=1780846654; bh=i
	iIsnjnQngXbpm0jOSh+5lKpxQgyzt8ah4Ytfeddz4s=; b=Fg5BwEEy25ChxgIgr
	+gN59QpCRHoATq/2/h/jEF6dVq80Lnu+iEaxPUJKsJD+x6z/M62/Gts3+TSE9j9Y
	Cd8U3U+o/r3eeAWi+pTr2kWm+7sXuFD/FcKfhby4o9KFAqeNvyJFrkApyC1KGylA
	NorvPraUjY8UN8+qRsF77ri9qdSxzhka3z3qWtRMbvnlqVZIIbWzdPgUO6ff0N3P
	r3kCkFu9qgOGl+Bk/bWAAloF974jsq8wjgaRGbbl9vgoBW+skYdGhQll1NgrRpE7
	LX3QL8LijA/abFxwBE9hB8FYUJxREPgZGGdi9mnXV21J3Xh6emZJH0axJ6QhHmkV
	K52Og==
X-ME-Sender: <xms:vj4kasOeGbuVTM7b7FI2u6dU01zxwnyhLmPWg7PCejxIkAJ1RbLtNQ>
    <xme:vj4kaqbCIdbqVF2R4MALEyB5ULACtAgeGPKW1Sq-_5wX6VTOcYQORbKwbO1KIpmtW
    bRj9YFx-Z8nKy_Do38wKphfs4blb37VPEoXDVJbUXGQB_AexhegJw>
X-ME-Received: <xmr:vj4kagoNxxqT1l3UIdn2vcirfilMtokon1Etufjx2V0tPJBrec1SDcYGVggKbT4vTnFuW3qPUiitEA>
X-ME-Proxy-Cause: dmFkZTEob3nrqFfV0Ung+Xagq6MXz3wF6/C3dgcx0wOBvcNS+HM2ngxUqFvqFZvHTsnALw
    ifNr3yjvremYwI8wUjpboWAc1mXJlYT6/+6UxEmNQYQe7toh+x6TqZrXpMJYkRzrXdD6iW
    lD+r1slbNRiLIzhfAiJaii3r9ck6akAVicLSWIhfgaaPsjcKorrzQVLltB9HqXim/DPROX
    3rTXiBAe1JOOnP4+9hVZz+2wKVOWVQDN+WuiVat3cT2ue5ysifCPZeBd6nN2dMRCugcwg9
    +OP0HqvbidyTiHY/ppFNJ5/i1CSknCUbwdXmIJBMRcNkborkWvL3GeyyZqvnekAM3jLjTM
    NJtcTtIRFkBqDA7wenKcAteWVQWCfHSf3oajNk2Qfzj4c4X98ko7wpBHTpt+bs5lEHsOHB
    3SP/BTL0zDaJk8cRdxnCR9fIKu2kbVr3GnSriYr/n5Y85J5yZo3hnZI3Js4vP8LwmiAbJt
    l1zqy5qR+tJytXAIgLmPVV01hLvVjJrk//K4Uv42NfhrbD/px6zvYm38fSIdUQ/5Q1n7Kn
    uBpdoMkuAq+KkoRactlTh59YQncAsxnXXUVM0PlW/98engFqsjCQkInjFLR389A2Vf7Ilr
    SKf1iaZ9IlnpmBAWual33yg6cOhZ4C4zFy27BbHLUX4aJBBkspiMmsQe4IMQ
X-ME-Proxy: <xmx:vj4kauYMetYNxs0P9hNrf9w1bj4zevyYUjXdfzww2mch5-7DKgDb_w>
    <xmx:vj4kaoSd97u4yuODSZEs4d-Q6R7t4q-qJ-vWI9wTVQNsbsivc1fWZQ>
    <xmx:vj4kal4qNDjaxzR6qjcvb33E9xHXmHG7Kvtxlai2H-w5mI4V699THg>
    <xmx:vj4katyHwcx1c98sgR1djU7JFDZp2en6TC_Gs7ynmH2OevvQgT43fQ>
    <xmx:vj4kajHgtPHJJc5ddQKDtGJqbfY2QHwrqs4d3yWjBmsT5ZF6LaDwOErL>
Feedback-ID: i2431475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 11:37:33 -0400 (EDT)
From: Kerin Millar <kfm@plushkava.net>
To: calestyo@scientia.org
Cc: dash@vger.kernel.org,
	Kerin Millar <kfm@plushkava.net>
Subject: [PATCH] exec: Print absolute paths for command location queries
Date: Sat,  6 Jun 2026 16:36:34 +0100
Message-ID: <20260606153634.119074-1-kfm@plushkava.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org>
References: <2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

POSIX requires that, when reporting the location of a utility found by
searching PATH (or one named with a slash), the pathname written by
type, command -v and command -V be absolute:

    Executable utilities, regular built-in utilities, command_names
    including a <slash> character, and any implementation-provided
    functions that are found using the PATH variable [...] shall be
    written as absolute pathnames.

Presently, dash fails to conform in this regard. Address this issue by
incorporating a helper function that prefixes relative pathnames with
the shell's cached current working directory.

Link: https://lore.kernel.org/dash/2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org/
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Signed-off-by: Kerin Millar <kfm@plushkava.net>
---
 src/cd.c   | 11 +++++++++++
 src/cd.h   |  1 +
 src/exec.c | 26 ++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/src/cd.c b/src/cd.c
index bcd1484..c044c3f 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -330,3 +330,14 @@ setpwd(const char *val, int setold)
 	INTON;
 	setvar("PWD", dir, VEXPORT);
 }
+
+/*
+ * Return the shell's notion of the current working directory.  Unlike the PWD
+ * variable, this cannot be altered by the user.
+ */
+
+const char *
+curpwd(void)
+{
+	return curdir;
+}
diff --git a/src/cd.h b/src/cd.h
index 8763161..2457e9c 100644
--- a/src/cd.h
+++ b/src/cd.h
@@ -33,3 +33,4 @@
 int	cdcmd(int, char **);
 int	pwdcmd(int, char **);
 void	setpwd(const char *, int);
+const char *curpwd(void);
diff --git a/src/exec.c b/src/exec.c
index 6fe0fed..006a241 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -58,6 +58,7 @@
 #include "redir.h"
 #include "eval.h"
 #include "exec.h"
+#include "cd.h"
 #include "builtins.h"
 #include "var.h"
 #include "options.h"
@@ -779,6 +780,24 @@ typecmd(int argc, char **argv)
 	return err;
 }
 
+/*
+ * Print the location of a command, as reported by type, command -v and
+ * command -V.  POSIX requires such pathnames to be absolute.
+ */
+
+static void printpath(struct output *out, const char *p)
+{
+	const char *pwd;
+
+	if (*p != '/' && *(pwd = curpwd()) == '/') {
+		outstr(pwd, out);
+		/* Do not append another slash to / or //. */
+		if (pwd[strlen(pwd) - 1] != '/')
+			outc('/', out);
+	}
+	outstr(p, out);
+}
+
 static int describe_command(struct output *out, char *command,
                             const char *path, int verbose)
 {
@@ -840,12 +859,11 @@ static int describe_command(struct output *out, char *command,
 		}
 		if (verbose) {
 			outfmt(
-				out, " is%s %s",
-				cmdp ? " a tracked alias for" : nullstr, p
+				out, " is%s ",
+				cmdp ? " a tracked alias for" : nullstr
 			);
-		} else {
-			outstr(p, out);
 		}
+		printpath(out, p);
 		break;
 	}
 
-- 
2.53.0

