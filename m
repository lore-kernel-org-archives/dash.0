From: harald@redhat.com
Subject: [PATCH] var.c: check for valid variable name before printing in "export -p"
Date: Tue, 14 Feb 2012 11:48:48 +0100
Message-ID: <1329216528-8462-1-git-send-email-harald@redhat.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab2BNKsv (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 14 Feb 2012 05:48:51 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1EAmpWH000708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 14 Feb 2012 05:48:51 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Harald Hoyer <harald@redhat.com>

From: Harald Hoyer <harald@redhat.com>

"export -p" prints all environment variables, without checking if the
environment variable is a valid dash variable name.

IMHO, the only valid usecase for "export -p" is to eval the output.

$ eval $(export -p); echo OK
OK

Without this patch the following test does error out with:

test.py:
import os
os.environ["test-test"]="test"
os.environ["test_test"]="test"
os.execv("./dash", [ './dash', '-c', 'eval $(export -p); echo OK' ])

$ python test.py
./dash: 1: export: test-test: bad variable name

Of course the results can be more evil, if the environment variable
name is crafted, that it injects valid shell code.
---
 src/var.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/var.c b/src/var.c
index 027beff..06771d3 100644
--- a/src/var.c
+++ b/src/var.c
@@ -409,12 +409,15 @@ showvars(const char *prefix, int on, int off)
 	for (; ep < epend; ep++) {
 		const char *p;
 		const char *q;
-
+		const char *r;
+		r = endofname(*ep);
 		p = strchrnul(*ep, '=');
 		q = nullstr;
-		if (*p)
+		if (*p) {
+			if (p != r)
+				continue;
 			q = single_quote(++p);
