From: Harald van Dijk <harald@gigawatt.nl>
Subject: Quoted closing brace in variable default expansion
Date: Sat, 13 Nov 2010 17:27:15 +0059
Message-ID: <4CDEBC7B.5050805@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:35739 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755364Ab0KMQ0P (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 11:26:15 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi all,

It's probably best to start with the example:

   $ bash -c 'echo "${x:-"}"}"'
   }
   $ ksh -c 'echo "${x:-"}"}"'
   }
   $ dash -c 'echo "${x:-"}"}"'
   dash: 1: Syntax error: Unterminated quoted string
   $ busybox sh -c 'echo "${x:-"}"}"'
   sh: syntax error: unterminated quoted string

It looks like dash and other ash derivatives stop the expansion with the 
first }, instead of the first unquoted }. I'm getting confused trying to 
figure out whether this is a bug in dash or in the script relying on it.

A slightly modified example:

   $ dash -c 'echo "${x-"_{x}_"}"'
   dash: 1: Syntax error: Unterminated quoted string
   $ dash -c 'echo ${x-"_{x}_"}'
   _{x_}

I don't understand how the last line works. The } is printed after the 
_, so the } that is printed must be the final }, and the } directly 
following the x stops the variable default. But this would lead to two 
double quote characters which have no way of matching up, yet no syntax 
error is given.

Could you clarify?

Cheers,
Harald
