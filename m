From: Michael Greenberg <michael.greenberg@pomona.edu>
Subject: [v3 PATCH] mktokens relative TMPDIR
Date: Wed, 29 Apr 2020 20:04:21 -0700
Message-ID: <m27dxxr7wq.fsf@pomona.edu>
References: <m2k14k4kpx.fsf@pomona.edu> <20200429055923.GA17016@gondor.apana.org.au> <m21ro6w576.fsf@pomona.edu> <20200430025705.GA12900@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:6078
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbgD3DEc (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 29 Apr 2020 23:04:32 -0400
In-Reply-To: <20200430025705.GA12900@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "dash@vger.kernel.org" <dash@vger.kernel.org>

The mktokens script fails when /tmp isn't writable (e.g., when building
in a sandbox with a different TMPDIR). Replace absolute references to
/tmp to relative references to TMPDIR. If TMPDIR is unset or null,
default to /tmp.

The mkbuiltins script was already hardened to work relative to TMPDIR,
also defaulting to /tmp.

v2 ensures that TMPDIR is quoted.
v3 adds an extra quotation that prevents extra pathname expansions.

Signed-off-by: Michael Greenberg <michael.greenberg@pomona.edu>

diff --git a/src/mktokens b/src/mktokens
index cd52241..3ab7bc5 100644
--- a/src/mktokens
+++ b/src/mktokens
@@ -37,7 +37,9 @@
 # token marks the end of a list.  The third column is the name to print in
 # error messages.

-cat > /tmp/ka$$ <<\!
+: "${TMPDIR:=/tmp}"
+
+cat > "${TMPDIR}"/ka$$ <<\!
 TEOF	1	end of file
 TNL	0	newline
 TSEMI	0	";"
@@ -68,28 +70,28 @@ TWHILE	0	"while"
 TBEGIN	0	"{"
 TEND	1	"}"
 !
-nl=`wc -l /tmp/ka$$`
+nl=`wc -l "${TMPDIR}"/ka$$`
 exec > token.h
-awk '{print "#define " $1 " " NR-1}' /tmp/ka$$
+awk '{print "#define " $1 " " NR-1}' "${TMPDIR}"/ka$$

 exec > token_vars.h

 echo '
 /* Array indicating which tokens mark the end of a list */
 static const char tokendlist[] = {'
-awk '{print "\t" $2 ","}' /tmp/ka$$
+awk '{print "\t" $2 ","}' "${TMPDIR}"/ka$$
 echo '};

 static const char *const tokname[] = {'
 sed -e 's/"/\\"/g' \
     -e 's/[^	 ]*[	 ][	 ]*[^	 ]*[	 ][	 ]*\(.*\)/	"\1",/' \
-    /tmp/ka$$
+    "${TMPDIR}"/ka$$
 echo '};
 '
-sed 's/"//g' /tmp/ka$$ | awk '
+sed 's/"//g' "${TMPDIR}"/ka$$ | awk '
 /TNOT/{print "#define KWDOFFSET " NR-1; print ""; 
       print "static const char *const parsekwd[] = {"}
 /TNOT/,/neverfound/{if (last) print "	\"" last "\","; last = $3}
 END{print "	\"" last "\"\n};"}'

-rm /tmp/ka$$
+rm "${TMPDIR}"/ka$$
