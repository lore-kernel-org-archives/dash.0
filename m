From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] [BUILTIN] describe_command: fix incorrect path
Date: Fri, 26 May 2017 09:59:44 +0200
Message-ID: <e4514426-2098-72b9-d1bb-eb5364607aef@gigawatt.nl>
References: <20170526070412.19254-1-zhangyoufu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:33758 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163984AbdEZIIa (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 26 May 2017 04:08:30 -0400
In-Reply-To: <20170526070412.19254-1-zhangyoufu@gmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Youfu Zhang <zhangyoufu@gmail.com>, dash@vger.kernel.org

Hi,

On 26/05/17 09:04, Youfu Zhang wrote:
> $ PATH=/extra/path:/usr/sbin:/usr/bin:/sbin:/bin \
>> sh -xc 'command -V ls; command -V ls; command -Vp ls; command -vp ls'
> + command -V ls
> ls is /bin/ls
> + command -V ls
> ls is a tracked alias for /bin/ls
> + command -Vp ls
> ls is a tracked alias for (null)
> + command -vp ls
> Segmentation fault (core dumped)
> 
> describe_command should respect `path' argument. Looking up in the hash table
> may gives incorrect index in entry.u.index and finally causes incorrect output
> or SIGSEGV.

True, but only when a path is passed in. If the default path is used, 
looking up in the hash table is correct, and printing tracked aliases is 
intentional.

If it's desirable to drop that feature, then it should be dropped 
completely, code shouldn't be left in that can no longer be used. But 
it's possible to keep it working: how about this instead?

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>
---
  src/exec.c | 13 +++++++++----
  1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/exec.c b/src/exec.c
index ec0eadd..1350da3 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -743,8 +743,6 @@ describe_command(out, command, path, verbose)
  	struct tblentry *cmdp;
  	const struct alias *ap;

-	path = path ?: pathval();
-
  	if (verbose) {
  		outstr(command, out);
  	}
@@ -767,8 +765,15 @@ describe_command(out, command, path, verbose)
  		goto out;
  	}

-	/* Then check if it is a tracked alias */
-	if ((cmdp = cmdlookup(command, 0)) != NULL) {
+	/* Then if the standard search path is used, check if it is a tracked 
alias.  */
+	if (path == NULL) {
+		path = pathval();
+		cmdp = cmdlookup(command, 0);
+	} else {
+		cmdp = NULL;
+	}
+
+	if (cmdp != NULL) {
  		entry.cmdtype = cmdp->cmdtype;
  		entry.u = cmdp->param;
  	} else {
