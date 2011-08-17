From: David Miller <davem@davemloft.net>
Subject: [PATCH 2/2] [SHELL] Add top-level autogen.sh
Date: Tue, 16 Aug 2011 17:45:22 -0700 (PDT)
Message-ID: <20110816.174522.285622493440427234.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:53256 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1HQAp0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Aug 2011 20:45:26 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: herbert@gondor.hengli.com.au


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 autogen.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100755 autogen.sh

diff --git a/autogen.sh b/autogen.sh
new file mode 100755
index 0000000..9879c53
--- /dev/null
+++ b/autogen.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+aclocal \
+&& autoheader \
+&& automake --add-missing \
+&& autoconf
-- 
1.7.6.401.g6a319

