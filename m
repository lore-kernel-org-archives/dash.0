From: Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH] Fix variable assignments in function invocations
Date: Fri, 09 Jan 2015 18:17:42 +0100
Message-ID: <54B00D36.7070707@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090506020800010008010100"
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:48294 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752002AbbAIRRq (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 9 Jan 2015 12:17:46 -0500
Received: from home.gigawatt.nl ([83.163.3.213] helo=[192.168.178.26])
	by hosting12.csv-networks.nl with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <harald@gigawatt.nl>)
	id 1Y9dBs-0005lv-Bp
	for dash@vger.kernel.org; Fri, 09 Jan 2015 18:17:40 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090506020800010008010100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

A long-standing problem with dash has been how it deals with variable 
assignments in function invocations, and several packages are affected 
by it, two I've come across recently being autogen and pkg-config (only 
their test suites, luckily).

A short test script:

   f() {
     echo inside f, VAR is $VAR
     sh -c 'echo inside sh called from f, VAR is $VAR'
   }

   VAR=value f
   echo after returning from f, VAR is $VAR

Assuming VAR was not already set, this should print (and does with bash):

   inside f, VAR is value
   inside sh called from f, VAR is value
   after returning from f, VAR is

With dash, this actually prints:

   inside f, VAR is value
   inside sh called from f, VAR is
   after returning from f, VAR is value

The first problem with that is that VAR does not get exported, the 
second is that VAR's assigned value is kept after the function has returned.

Quoting SUSv4 Shell Command Language 2.9.1 Simple Commands:

   If no command name results, variable assignments shall affect the
   current execution environment. Otherwise, the variable assignments
   shall be exported for the execution environment of the command and
   shall not affect the current execution environment (except for
   special built-ins).

In `VAR=value f`, f is found as the command name. No exception is made 
for function invocations, so I believe this disallows dash's current 
behaviour, and requires it to print the same thing bash does.

Fixing this seems trivial, see the attachment, and the test suites of 
both autogen and pkg-config pass with this change. Does this look correct?

Cheers,
Harald van Dijk

--------------090506020800010008010100
Content-Type: text/plain; charset=windows-1252;
 name="funcvars.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="funcvars.patch"

LS0tIGEvc3JjL2V2YWwuYworKysgYi9zcmMvZXZhbC5jCkBAIC04NzUsNyArODc1LDcgQEAg
cmFpc2U6CiAJCWJyZWFrOwogCiAJY2FzZSBDTURGVU5DVElPTjoKLQkJcG9wbG9jYWx2YXJz
KDEpOworCQlsaXN0c2V0dmFyKHZhcmxpc3QubGlzdCwgVkVYUE9SVHxWU1RBQ0spOwogCQlp
ZiAoZXZhbGZ1bihjbWRlbnRyeS51LmZ1bmMsIGFyZ2MsIGFyZ3YsIGZsYWdzKSkKIAkJCWdv
dG8gcmFpc2U7CiAJCWJyZWFrOwo=
--------------090506020800010008010100--
