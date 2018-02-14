From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash bug: double-quoted "\" breaks glob protection for next char
Date: Wed, 14 Feb 2018 22:44:09 +0100
Message-ID: <297b41c4-0e15-e0d8-f088-d68acfcc3c0f@gigawatt.nl>
References: <CAK1hOcPW_MZ5Nq-0z-aMMMgzZbOZYXD_9kkxz1w+U-HY+E4gbw@mail.gmail.com>
 <5e1ee06d-d1ca-6442-51de-786e2739d4df@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------48ECDB18B02A36D2928597F8"
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:34108 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031444AbeBNVnZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Feb 2018 16:43:25 -0500
In-Reply-To: <5e1ee06d-d1ca-6442-51de-786e2739d4df@gigawatt.nl>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------48ECDB18B02A36D2928597F8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/18 9:03 PM, Harald van Dijk wrote:
> On 13/02/2018 14:53, Denys Vlasenko wrote:
>> $ >'\zzzz'
>> $ >'\wwww'
>> $ dash -c 'echo "\*"'
>> \wwww \zzzz
> 
>[...]
> 
> Currently:
> 
> $ dash -c 'foo=a; echo "<${foo#[a\]]}>"'
> <>
> 
> This is what I expect, and also what bash, ksh and posh do.
> 
> With your patch:
> 
> $ dash -c 'foo=a; echo "<${foo#[a\]]}>"'
> <a>

Does the attached look right as an alternative? It treats a quoted 
backslash the same way as if it were preceded by CTLESC in _rmescapes. 
It passes your test case and mine, but I'll do more extensive testing.

Cheers,
Harald van Dijk

--------------48ECDB18B02A36D2928597F8
Content-Type: text/x-patch;
 name="dash-escape-backslash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-escape-backslash.patch"

diff --git a/src/expand.c b/src/expand.c
index 2a50830..af88a69 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1686,12 +1686,17 @@ _rmescapes(char *str, int flag)
 		}
 		if (*p == (char)CTLESC) {
 			p++;
-			if (notescaped)
-				*q++ = '\\';
-		} else if (*p == '\\' && !inquotes) {
-			/* naked back slash */
-			notescaped = 0;
-			goto copy;
+			goto escape;
+		} else if (*p == '\\') {
+			if (inquotes) {
+escape:
+				if (notescaped)
+					*q++ = '\\';
+			} else {
+				/* naked back slash */
+				notescaped = 0;
+				goto copy;
+			}
 		}
 		notescaped = globbing;
 copy:

--------------48ECDB18B02A36D2928597F8--
