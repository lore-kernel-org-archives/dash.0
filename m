From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Tue, 9 Aug 2016 23:39:13 +0200
Message-ID: <0ce0bca2-3bdd-a1f5-169e-0291a49cd6c7@gigawatt.nl>
References: <20160809092832.GB23983@brutus.ethup.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------187111F89DB4C917F53A830C"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:38734
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932338AbcHIVjY (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 9 Aug 2016 17:39:24 -0400
In-Reply-To: <20160809092832.GB23983@brutus.ethup.se>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Olof Johansson <olof@ethup.se>, dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------187111F89DB4C917F53A830C
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/16 11:28, Olof Johansson wrote:
> Hello,
>
> I'm seeing some discrepancies between dash built with --enable-fnmatch
> and dash built without that got me curious. Maybe you could help shed
> some light?
>
>  foo='[abc]'
>  echo ${foo#[}
>  echo ${foo#\[}
>
> With dash built with --enable-fnmatch:
>
>  abc]
>  abc]
>
> With dash built without --enable-fnmatch:
>
>  [abc]
>  abc]

Nice find.

> I was able to reproduce this behavior on latest git master
> (17a5f24e0). The dash manual states:
>
>> The end of the character class is indicated by a ]; if the ] is
>> missing then the [ matches a [ rather than introducing a character
>> class.
>
> Which to me suggests that the non-fnmatch case is not the expected
> behavior. Is this interpretation correct?

Yes, this looks like a bug in dash. With the default --disable-fnmatch 
code, when dash encounters [ in a pattern, it immediately treats the 
following characters as part of the set. If it then encounters the end 
of the pattern without having seen a matching ], it attempts to reset 
the state and continue as if [ was treated as a literal character right 
from the start. The attempt to reset the state doesn't look right, and 
has been like this since at least the initial Git commit in 2005.

This also affects

     case [a in [?) echo ok ;; *) echo bad ;; esac

which should print ok.

Attached is a patch that attempts to reset the state correctly. It 
passes your test and mine, but I have not yet tested it extensively.

> Thanks,
>

Cheers,
Harald van Dijk

--------------187111F89DB4C917F53A830C
Content-Type: text/x-patch;
 name="lit-lbrack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lit-lbrack.patch"

--- a/src/expand.c
+++ b/src/expand.c
@@ -1594,7 +1594,8 @@ pmatch(const char *pattern, const char *string)
 			do {
 				if (!c) {
 					p = startp;
-					c = *p;
+					q--;
+					c = '[';
 					goto dft;
 				}
 				if (c == '[') {

--------------187111F89DB4C917F53A830C--
