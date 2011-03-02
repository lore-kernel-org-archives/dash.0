From: Tim Allen <screwtape@froup.com>
Subject: [PATCH] Reset exit status before sourcing a file.
Date: Wed,  2 Mar 2011 23:22:53 +1100
Message-ID: <1299068573-581-1-git-send-email-screwtape@froup.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from poplet3.per.eftel.com ([203.24.100.44]:48386 "EHLO
	poplet3.per.eftel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab1CBMaV (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 2 Mar 2011 07:30:21 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: 615922@bugs.debian.org, Tim Allen <screwtape@froup.com>

The POSIX specification for the dot command[1] states:

    EXIT STATUS
        Returns the value of the last command executed, or a zero exit
        status if no command is executed.

If an empty file is sourced, then "no command is executed", and hence
the exit status should be zero. If the exit status is not reset before
sourcing an empty file, the exit status of the previous command "leaks"
through. Here's a simple test case:

    false
    . /dev/null
    [ $? = 0 ] && echo "Success" || echo "Failure"

This behaviour becomes more problematic when combined with "set -e". Consider the following snippet:

    if [ "$FILETYPE" != "shell" ]; then
	run_external_script "$FILEPATH"
    else
	. "$FILEPATH"
    fi

Assume "set -e", that FILETYPE is set to "shell" and that FILEPATH points to
an empty file. Since the condition returns a non-zero exit status (which is
protected from "set -e" by the if statement), the shell runs the "else" branch
of the code, sources the empty file, and then checks the last exit status
again. Because the exit status from the condition hasn't been cleared, "set -e" causes the shell to exit even though no un-handled error has occurred.

[1] http://pubs.opengroup.org/onlinepubs/009695399/utilities/dot.html

Signed-off-by: Timothy Allen <screwtape@froup.com>
---
 src/main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/main.c b/src/main.c
index 1735c67..b4c07e9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -318,6 +318,7 @@ int
 dotcmd(int argc, char **argv)
 {
 	int status = 0;
+	exitstatus = 0;
 
 	if (argc >= 2) {		/* That's what SVR2 does */
 		char *fullname;
-- 
1.7.1

