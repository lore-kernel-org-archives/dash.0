From: Michael Greenberg <michael.greenberg@pomona.edu>
Subject: [PATCH] mktokens relative TMPDIR
Date: Mon, 17 Feb 2020 19:50:50 -0800
Message-ID: <m2k14k4kpx.fsf@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:23807
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgBRDuz (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 17 Feb 2020 22:50:55 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

The mktokens script fails when /tmp isn't writable (e.g., when building
in a sandbox with a different TMPDIR). Replace absolute references to
/tmp to relative references to TMPDIR. If TMPDIR is unset or null,
default to /tmp.

The mkbuiltins script was already hardened to work relative to TMPDIR,
also defaulting to /tmp.

Signed-off-by: Michael Greenberg <michael.greenberg@pomona.edu>

diff --git a/src/mktokens b/src/mktokens
index cd52241..3ab7bc5 100644
--- a/src/mktokens
+++ b/src/mktokens
@@ -37,7 +37,9 @@
 # token marks the end of a list.  The third column is the name to print in
 # error messages.
 
-cat > /tmp/ka$$ <<\!
+: ${TMPDIR:=/tmp}
+
+cat > $TMPDIR/ka$$ <<\!
 TEOF	1	end of file
 TNL	0	newline
 TSEMI	0	";"
@@ -68,28 +70,28 @@ TWHILE	0	"while"
 TBEGIN	0	"{"
 TEND	1	"}"
 !
-nl=`wc -l /tmp/ka$$`
+nl=`wc -l ${TMPDIR}/ka$$`
 exec > token.h
-awk '{print "#define " $1 " " NR-1}' /tmp/ka$$
+awk '{print "#define " $1 " " NR-1}' ${TMPDIR}/ka$$
 
 exec > token_vars.h
 
 echo '
 /* Array indicating which tokens mark the end of a list */
 static const char tokendlist[] = {'
-awk '{print "\t" $2 ","}' /tmp/ka$$
+awk '{print "\t" $2 ","}' ${TMPDIR}/ka$$
 echo '};
 
 static const char *const tokname[] = {'
 sed -e 's/"/\\"/g' \
     -e 's/[^	 ]*[	 ][	 ]*[^	 ]*[	 ][	 ]*\(.*\)/	"\1",/' \
-    /tmp/ka$$
+    ${TMPDIR}/ka$$
 echo '};
 '
-sed 's/"//g' /tmp/ka$$ | awk '
+sed 's/"//g' ${TMPDIR}/ka$$ | awk '
 /TNOT/{print "#define KWDOFFSET " NR-1; print ""; 
       print "static const char *const parsekwd[] = {"}
 /TNOT/,/neverfound/{if (last) print "	\"" last "\","; last = $3}
 END{print "	\"" last "\"\n};"}'
 
-rm /tmp/ka$$
+rm ${TMPDIR}/ka$$
