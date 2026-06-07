Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C544071CB
	for <dash@vger.kernel.org>; Sun,  7 Jun 2026 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780791338; cv=none; b=dc5HAGSyIKvaztRFS3fgTYAiZC3Bo/M9jjxmz5X199b6EKAdXPCoBv01MScouNoGn88e+I/18DShyhUcRtTIw06aCznjMoFPibaLRCFKswTuqY9qeaOHiChC9FLN9R/B+ILA+LtqAdnU31p2WFExZfi3dDymAQJZ+4aqhQibZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780791338; c=relaxed/simple;
	bh=+dXXsF3uymA3xPVWMoTb4wtQFt4RtIagtyqEZHXaHMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY7uwSUDQfsJk7oVDLe0v6n9SirkFshnoWDpTHfBhtnwcYleRNhpzM2lq61sqS0dPi4TpPI4Mk4jWsIsTAhiXiZydrlXtkZVn6p2qbjHBmeeJF82lIXX50jJeYDlAru0aQZ1Wc63evGOoSNRseypuSTzwimqlEnrtXIYgJnOzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=hY6vx5lk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAXtmx4/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="hY6vx5lk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAXtmx4/"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B7269EC0101;
	Sat,  6 Jun 2026 20:15:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 06 Jun 2026 20:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780791334; x=
	1780877734; bh=slfyIp1N1cllzBrKw8QaNFzXrYl+FN3o3QbMfZyawzs=; b=h
	Y6vx5lkIDrZKG2eYWC+kVK12mzvop8N/jAC4sZ7XpNUjkJ7S8mn48NubeU3+WeHj
	j+odBuRokfyXK8HPXRLTrYVzKIThbB8SMqUOgyPEXzsouFEYgRX0iEXhtph3X067
	j11lJgt6wTtMNM5IiMjxkFvb87R+B1+8G8GK+dyynevu6kqWWfWFTE31hjQnB3UV
	9SlPJH+wVpdi4xaYp2w6dB9ZMX+KWPPVK/t44ebyvydA0jygQsicJNUkH+SW+juU
	HuOdLV+iq+15R32tkc8xv1fAJWSve695f1Pf8ZMMZlk4q9UXOv3KAvhIdKaBw2TM
	bawxpexEEVRgVzU7uddfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780791334; x=1780877734; bh=s
	lfyIp1N1cllzBrKw8QaNFzXrYl+FN3o3QbMfZyawzs=; b=bAXtmx4/6jp4IusWU
	ZAhhpbFyJzStl+DpEeK0G3q9ouKDlJ/43EknoNyjw8WYomb3BEyxF4Fj+Suh0p6d
	5wFIUCHXjjR9QDvgnEZuVV+81ZV1SAb6RbvAo1+xTX2t89M8Iw4sH7vOI05rOSYY
	t9yiJlSd08eDMHk94LPcloxM6oIfZIGIOmuXgFtqkYOa6VDhDfT0c+sa7ayOZQ3u
	ojiEjDLKfkBF94AA8fEH2O/sjP/m9EPW1qdBom6TIFl2KTZeszDaG4qKi8oxify1
	vCs+dV7N5opSjWX9VvbIB59EMX8fU9Hric61eqCuoV9yWZjPOwjUMlJVNZW/qDxB
	DFB/A==
X-ME-Sender: <xms:JrgkaplnfqdSPelPxFmcgVgx17sYrm-28kmr9v7_VLHEkNWdthAcpQ>
    <xme:Jrgkar1SIHT6OfCHNRtMn-UnX5eIOwXWrSiulV6m3DK4aIKE9Vovk5I6PU69QZQS3
    r_e7E2i_l7YTIIKF_Q6yRKIH9KajIgFyDNc2i-CEbA-8pVy82QrMg>
X-ME-Received: <xmr:JrgkakoWPxbtV3Kqc6gNww44NlthqGwie9O_dS4NWj4u6pEL3Gyi5pqzE5-LF3RAgQCYGsLgGeGPeg>
X-ME-Proxy-Cause: dmFkZTGEKJWlI7D4ObYej18LoN0R9Ll1VCabNHzsAmlOos/aX6QXey9rpvo/907RFapiZA
    jW9Y2Hi1ILfifIkhPj1Obe8bM+Cp/YE35abO7yxFlyuC74IhAMk2GaLDLVA4VGMdXvzDNS
    /+2/pZrX6btuOsl15gIl3JmBxwsAZITwGxeEdKbLWhzcUhqj7NESwpdPVvuH4pHUykopZx
    2pjmzdFGh79O53n7YfMuBKfsyXMh4lGqkJXnDlQsE5dl1Zuhg6jCHYWvwARIVZoSiBKdSV
    qZEfFaCw8YbvbQRhpaAkhDvUhx2x9wjnttqhsErDlLZnBjawXckgI5+6442sfgsrc82qEi
    fx0Jg0Ls50KyGJaO+JD/8LUfKb0X3X9ZVMbcFrX7+TNxRm2oIeGyq93MHL9zLY16jrmbuE
    TofI0NRSQ09EUy1BURhYyRkYSB/msL8vuvlbXyinRis7yKAHVEsq6tKelOzRE4qPsxlB6q
    dEjJt8lJvDafMlTAgQQS2pZmB1imPHMqgtUm5ZWs16GZReMgc7W6gDWRh8FNX93s6NJZVn
    vGyk74XAbqheNKQ59lQly0eEDZI1jxDYDfJu5JZXZ3b91jMUA+DKzR3DYpI+i85pDQGBV2
    M3eUP+rcGFergtziHLquhfGSWhFmtbPRDKdQ4jjUpGQDLgHdwHnaqPlYwyRQ
X-ME-Proxy: <xmx:JrgkaocHO7gU74JZSuhnm-j8oysoMcHg8LLpzuHR-FJXrQd9KFPVnw>
    <xmx:Jrgkajq0milrLlChMYfvlVgxRFQiR0RsyCy4gLzWKr6FL570q0ivwg>
    <xmx:JrgkapEm2XSCB1uTD6u63KqYofYuQLoys6MxF5kGqN_eYgMWwNGDXw>
    <xmx:JrgkajvFsqzIs7sOmjawQuu5-fUyfr7mQF-qw-8wh32uyUDzvvbybQ>
    <xmx:JrgkannrIqN6DcLfFX13d6hT5CSt7TxFe-Qhzi1cwawhqN-PQdP-5y_n>
Feedback-ID: i2431475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 20:15:33 -0400 (EDT)
From: Kerin Millar <kfm@plushkava.net>
To: harald@gigawatt.nl
Cc: calestyo@scientia.org,
	dash@vger.kernel.org,
	kfm@plushkava.net
Subject: [PATCH v2] exec: Print absolute paths for command location queries
Date: Sun,  7 Jun 2026 01:13:26 +0100
Message-ID: <20260607001326.8561-1-kfm@plushkava.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1ae76552-1f2b-4d21-8fe5-f632ac0f7ba8@gigawatt.nl>
References: <1ae76552-1f2b-4d21-8fe5-f632ac0f7ba8@gigawatt.nl>
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
prefixing relative pathnames with the logical current working directory,
provided that it still resolves to the current directory, and with the
physical current working directory otherwise. If the current working
directory cannot be determined, print the relative pathname instead.

Link: https://lore.kernel.org/dash/2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org/
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Suggested-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Kerin Millar <kfm@plushkava.net>
---
 src/cd.c   | 40 ++++++++++++++++++++++++++++++++++++----
 src/cd.h   |  1 +
 src/exec.c | 30 ++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/src/cd.c b/src/cd.c
index bcd1484..9766cfb 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -261,12 +261,11 @@ updatepwd(const char *dir)
 
 
 /*
- * Find out what the current directory is. If we already know the current
- * directory, this routine returns immediately.
+ * Find out what the physical current directory is.
  */
-inline
+
 STATIC char *
-getpwd()
+getphyscwd()
 {
 #ifdef __GLIBC__
 	char *dir = getcwd(0, 0);
@@ -280,6 +279,39 @@ getpwd()
 		return savestr(buf);
 #endif
 
+	return NULL;
+}
+
+/*
+ * Return the logical current directory if it still resolves to the physical
+ * current directory.  Otherwise, return the physical current directory, or
+ * NULL if it cannot be determined.
+ */
+
+char *
+getlogcwd()
+{
+	struct stat64 st1, st2;
+
+	if (*curdir == '/' && !stat64(curdir, &st1) && !stat64(dotdir, &st2) &&
+	    st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino)
+		return savestr(curdir);
+
+	return getphyscwd();
+}
+
+/*
+ * Find out what the current directory is.
+ */
+
+STATIC char *
+getpwd()
+{
+	char *dir = getphyscwd();
+
+	if (dir)
+		return dir;
+
 	sh_warnx("getcwd() failed: %s", strerror(errno));
 	return nullstr;
 }
diff --git a/src/cd.h b/src/cd.h
index 8763161..d22bf84 100644
--- a/src/cd.h
+++ b/src/cd.h
@@ -32,4 +32,5 @@
 
 int	cdcmd(int, char **);
 int	pwdcmd(int, char **);
+char	*getlogcwd(void);
 void	setpwd(const char *, int);
diff --git a/src/exec.c b/src/exec.c
index 6fe0fed..903b63d 100644
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
@@ -779,6 +780,28 @@ typecmd(int argc, char **argv)
 	return err;
 }
 
+/*
+ * Print the location of a command, as reported by type, command -v and
+ * command -V.
+ */
+
+static void printpath(struct output *out, const char *p)
+{
+	char *pwd;
+
+	if (*p != '/') {
+		pwd = getlogcwd();
+		if (pwd) {
+			outstr(pwd, out);
+			/* Do not append another slash to / or //. */
+			if (pwd[strlen(pwd) - 1] != '/')
+				outc('/', out);
+			free(pwd);
+		}
+	}
+	outstr(p, out);
+}
+
 static int describe_command(struct output *out, char *command,
                             const char *path, int verbose)
 {
@@ -840,12 +863,11 @@ static int describe_command(struct output *out, char *command,
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

