From: Harald van Dijk <harald@gigawatt.nl>
Subject: Another alias substitution bug, now involving case statements
Date: Sat, 25 Jan 2020 17:29:20 +0000
Message-ID: <f35c1096-18b2-f438-f6d7-19c9d5e335ab@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:48838 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgAYRaV (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 25 Jan 2020 12:30:21 -0500
Received: from [192.168.1.8] (hvdijk.plus.com [81.174.157.28])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id B6461750
        for <dash@vger.kernel.org>; Sat, 25 Jan 2020 18:30:18 +0100 (CET)
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: DASH shell mailing list <dash@vger.kernel.org>

Hi,

Checking alias substitution handling in more detail after Martijn 
Dekker's report, I found another case where I believe dash's behaviour 
is incorrect. First, please consider this test:

   alias a="case x in " b=x
   a b) echo hi ;; esac

bash, ksh and pdksh never check whether a case pattern is a valid alias 
name, so they print nothing.

bosh, dash, mksh, yash and zsh do allow the space at the end of a's 
definition to cause b to be considered as an alias name.

Based on the literal text of the current standard, I believe 
bash/ksh/pdksh's behaviour is correct. Based on accepted new wording for 
the standard, new wording that was drafted without considering this 
special case, I believe the bosh/dash/mksh/yash/zsh behaviour is 
correct. I would not at this time consider this a bug in any of the shells.

Now, consider this modified version:

   alias a="case x in " b=x
   a
   b) echo hi ;; esac

Here, the next token after "a" is a newline token, not b. Here, b must 
definitely not be considered as an alias name. bosh, dash, mksh and zsh 
do perform alias substitution anyway, yash does not.

The problem here is in the "eat newlines" behaviour of readtoken(). 
There are two reasons why CHKALIAS might be set. It might be set because 
the parser is in a state where the next token could be the start of a 
simple command, or it might be set because the parser processed a blank 
at the end of a prior alias definition. In the first case, after eating 
a newline, the parser is still in a state where the next token could be 
the start of a simple command, so CHKALIAS should not be dropped. In the 
second case, the blank should only affect a single token, and upon 
eating a newline CHKALIAS should be dropped. readtoken() has no way of 
distinguishing between these two cases with just a single CHKALIAS flag, 
so this will require a bit more complicated work to fix.

Cheers,
Harald van Dijk
