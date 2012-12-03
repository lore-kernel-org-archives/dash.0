From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] printf: use %ll instead of %j
Date: Mon, 03 Dec 2012 18:58:17 +0100
Message-ID: <50BCE839.1060606@gigawatt.nl>
References: <op.woqc1kj2dyj81a@2fprep> <50BCDA80.8000705@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040107050809090105050806"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:33381 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098Ab2LCR6Q (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 3 Dec 2012 12:58:16 -0500
In-Reply-To: <50BCDA80.8000705@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Roy <roytam@gmail.com>
Cc: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------040107050809090105050806
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2012 05:59 PM, Harald van Dijk wrote:
> On 12/03/2012 08:42 AM, Roy wrote:
>> MSYS libc does not support %j[dXx] format, only %ll[dXx] is supported.
>>
>> diff --git a/src/bltin/printf.c b/src/bltin/printf.c
>> index 893295c..12ce660 100644
>> --- a/src/bltin/printf.c
>> +++ b/src/bltin/printf.c
>> @@ -319,11 +319,12 @@ mklong(const char *str, const char *ch)
>>         char *copy;
>>         size_t len;
>>
>> -       len = ch - str + 3;
>> +       len = ch - str + 4;
>>         STARTSTACKSTR(copy);
>>         copy = makestrspace(len, copy);
>> -       memcpy(copy, str, len - 3);
>> -       copy[len - 3] = 'j';
>> +       memcpy(copy, str, len - 4);
>> +       copy[len - 4] = 'l';
>> +       copy[len - 3] = 'l';
>>         copy[len - 2] = *ch;
>>         copy[len - 1] = '\0';
>>         return (copy);
> 
> The calling code uses the result to print intmax_t and uintmax_t values.
> Printing intmax_t values with %lld is wrong, this will only work if
> intmax_t is really a typedef for long long (which may be true on your
> system, but is not required by the standard).
> 
> The other patch that Jonathan linked to should work just fine.

Here's a slightly tweaked version of that patch. Regardless of whether
PRIdMAX is defined as "jd" or as "lld", the use of memcpy here, first
copying "jd"/"lld" and the null byte, and only changing the 'd' after
that, surprisingly results in slightly shorter object code than the
original byte-by-byte approach, even though memcpy is fully inlined.
Perhaps that could be a reason for applying this, even if the original
reason for it, making the code work on not-quite-conforming systems,
isn't good enough to get it in dash.

Tested with normal glibc, and with glibc hacked to not provide PRIdMAX.

Cheers,
Harald

--------------040107050809090105050806
Content-Type: text/x-patch;
 name="printf-PRIdMAX.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="printf-PRIdMAX.patch"

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 893295c..5f9e81c 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -316,16 +316,24 @@ out:
 static char *
 mklong(const char *str, const char *ch)
 {
+	/*
+	 * Replace a string like "%92.3u" with "%92.3"PRIuMAX.
+	 *
+	 * Although C99 does not guarantee it, we assume PRIiMAX,
+	 * PRIoMAX, PRIuMAX, PRIxMAX, and PRIXMAX are all the same
+	 * as PRIdMAX with the final 'd' replaced by the corresponding
+	 * character.
+	 */
+
 	char *copy;
 	size_t len;	
 
-	len = ch - str + 3;
+	len = ch - str + sizeof(PRIdMAX);
 	STARTSTACKSTR(copy);
 	copy = makestrspace(len, copy);
-	memcpy(copy, str, len - 3);
-	copy[len - 3] = 'j';
+	memcpy(copy, str, len - sizeof(PRIdMAX));
+	memcpy(copy + len - sizeof(PRIdMAX), PRIdMAX, sizeof(PRIdMAX));
 	copy[len - 2] = *ch;
-	copy[len - 1] = '\0';
 	return (copy);	
 }
 

--------------040107050809090105050806--
