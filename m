From: Martijn Dekker <martijn@inlv.org>
Subject: Re: Alias/heredoc/cmdsubst regression
Date: Sat, 25 Jan 2020 17:26:20 +0100
Message-ID: <1484376d-fec8-cb48-9de0-13301273a560@inlv.org>
References: <40db0aa1-195b-f29e-5068-01fa101affd9@inlv.org>
 <8b48cd04-b85f-1086-55c8-8e17800f5693@gigawatt.nl>
 <f40ce455-afd8-05f4-e594-4395bb2a8ed0@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:54694 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYQ0Y (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 25 Jan 2020 11:26:24 -0500
In-Reply-To: <f40ce455-afd8-05f4-e594-4395bb2a8ed0@gigawatt.nl>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, DASH shell mailing list <dash@vger.kernel.org>

Op 25-01-20 om 02:38 schreef Harald van Dijk:
[...]
>> Nice find.

Thanks, but I can't take credit for being particularly astute here. The 
modernish loop construct (including the 'find' utility being fully 
integrated into the shell as 'LOOP find <var> [ in <path> ... ] [ 
<find-expression> ]; DO ... DONE' -- check it out!) is based on a 
triplet of aliases that define a block using { ... }, so it was only a 
matter of time before this bug simply bit me.

Thanks for the analysis. It made it trivial to patch. I hope Herbert agrees.

> There is another place that parseheredoc() can be called from where 
> checkkwd was not being corrected afterwards:
> 
>    alias BEGIN='{' END='}'
>    : <<EOF &&
>    $(echo hi)
>    EOF
>    BEGIN
>    echo ok
>    END
> 
> This has been failing for longer. This prints "Syntax error: "(" 
> unexpected" since at least 0.5.1.

Interesting. For me, this one prints (on dash 0.5.7 until current):
testalias2.sh: 5: testalias2.sh: {: not found
ok
testalias2.sh: 7: testalias2.sh: Syntax error: "}" unexpected

But anyway, thank you for this second test case. Time to add a bug 
detection ID (BUG_ALIASHDOC) and couple of regression tests with these 
two test cases to modernish -- and document that here-docs containing 
command substitutions that are lexically within modernish loops won't be 
portable for another five years or so. :/

It's unfortunate dash still doesn't have a regression test suite 
(Herbert never responded to my question, just over a year ago, if he 
would consider a patch to add one), but modernish regress-tests all the 
shells it will run on, so 'dash bin/modernish --test' can fulfil that 
function.

- M.

-- 
modernish -- harness the shell
https://github.com/modernish/modernish
