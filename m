From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Sourcing an empty files does not reset exit status
Date: Sat, 5 Dec 2015 16:40:59 +0100
Message-ID: <5663058B.1030809@gigawatt.nl>
References: <n2e2qe$voq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040404060600080405010304"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:53640
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753352AbbLEPlI (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 5 Dec 2015 10:41:08 -0500
In-Reply-To: <n2e2qe$voq$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
Cc: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404060600080405010304
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2015 03:18, Gioele Barabucci wrote:
> Hello,
>
> a bug has been filed in the Debian BTS about dash not resetting the exit
> status after sourcing an empty file with the dot command. [1]
>
> The following test echoes "OK" with bash and "fail" with dash
>
>      #!/bin/sh
>
>      echo > ./empty
>      false
>
>      . ./empty && echo "OK" || echo "fail"
 >
> A similar bug in dash has been discussed and addressed in 2011 [2], but
> it looks like the solution has been only partial.
>
> The version of dash I tested is the current git master branch, commit
> 2e58422.
>
> [1] https://bugs.debian.org/777262
> [2] http://article.gmane.org/gmane.comp.shells.dash/531

The bug described there was about empty files. While the fix has been 
applied and does make dash handle empty files properly, your test 
doesn't use an empty file, it uses a file containing a single blank 
line. Unfortunately, the single blank line gets parsed by dash as a null 
command, null commands don't (and shouldn't) reset the exit status, and 
the fix you link to doesn't handle this because it sees a command has 
been executed and saves the exit status after executing that command as 
the exit status to be used by ".".

I think the easiest way to fix this is to prevent null commands from 
affecting status in cmdloop, as attached.

An alternative could be to change the outer if condition to exclude
n == NULL, but I didn't do that because the change of job_warning and 
clearing of numeof make sense to me even for null commands. Besides, 
when debug tracing is enabled, null commands have a visible effect that 
should remain.

Note that this fixes the problem with . but the same problem can be 
present in other locations. For example,

     false
     eval "
     " && echo OK || echo Fail

used to print Fail, and needed the same modification in the evalstring 
function to make that print OK (included in the attached patch). There 
may be other similar bugs lurking.

Cheers,
Harald van Dijk

--------------040404060600080405010304
Content-Type: text/plain; charset=UTF-8;
 name="dash-dot-status.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dash-dot-status.patch"

ZGlmZiAtLWdpdCBhL3NyYy9ldmFsLmMgYi9zcmMvZXZhbC5jCmluZGV4IDA3MWZiMWIuLjQ2
Njg5ZWYgMTAwNjQ0Ci0tLSBhL3NyYy9ldmFsLmMKKysrIGIvc3JjL2V2YWwuYwpAQCAtMTcy
LDcgKzE3Miw3IEBAIGV2YWxzdHJpbmcoY2hhciAqcywgaW50IGZsYWdzKQogCXN0YXR1cyA9
IDA7CiAJd2hpbGUgKChuID0gcGFyc2VjbWQoMCkpICE9IE5FT0YpIHsKIAkJZXZhbHRyZWUo
biwgZmxhZ3MgJiB+KHBhcnNlcl9lb2YoKSA/IDAgOiBFVl9FWElUKSk7Ci0JCXN0YXR1cyA9
IGV4aXRzdGF0dXM7CisJCWlmIChuKSBzdGF0dXMgPSBleGl0c3RhdHVzOwogCQlwb3BzdGFj
a21hcmsoJnNtYXJrKTsKIAkJaWYgKGV2YWxza2lwKQogCQkJYnJlYWs7CmRpZmYgLS1naXQg
YS9zcmMvbWFpbi5jIGIvc3JjL21haW4uYwppbmRleCBiZWRiNjYzLi4xYjMwMWZhIDEwMDY0
NAotLS0gYS9zcmMvbWFpbi5jCisrKyBiL3NyYy9tYWluLmMKQEAgLTIyOCw3ICsyMjgsNyBA
QCBjbWRsb29wKGludCB0b3ApCiAJCQlqb2Jfd2FybmluZyA9IChqb2Jfd2FybmluZyA9PSAy
KSA/IDEgOiAwOwogCQkJbnVtZW9mID0gMDsKIAkJCWV2YWx0cmVlKG4sIDApOwotCQkJc3Rh
dHVzID0gZXhpdHN0YXR1czsKKwkJCWlmIChuKSBzdGF0dXMgPSBleGl0c3RhdHVzOwogCQl9
CiAJCXBvcHN0YWNrbWFyaygmc21hcmspOwogCg==
--------------040404060600080405010304--
