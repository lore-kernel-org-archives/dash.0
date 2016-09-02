From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 11:06:29 -0400
Message-ID: <4771ef64-20d7-6e99-5404-b75a03f5a5c4@case.edu>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902144646.GA13296@gondor.apana.org.au>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv1-2015.CWRU.Edu ([129.22.103.226]:13336 "EHLO
        mpv1-2015.case.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754191AbcIBPOD (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 11:14:03 -0400
In-Reply-To: <20160902144646.GA13296@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Eric Blake <eblake@redhat.com>
Cc: chet.ramey@case.edu, Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org

On 9/2/16 10:46 AM, Herbert Xu wrote:
> On Fri, Sep 02, 2016 at 09:25:15AM -0500, Eric Blake wrote:
>>
>> 2.13.1 Patterns Matching a Single Character
>>
>> [
>>     If an open bracket introduces a bracket expression as in XBD RE
>> Bracket Expression, except that the <exclamation-mark> character ( '!' )
>> shall replace the <circumflex> character ( '^' ) in its role in a
>> non-matching list in the regular expression notation, it shall introduce
>> a pattern bracket expression. A bracket expression starting with an
>> unquoted <circumflex> character produces unspecified results. Otherwise,
>> '[' shall match the character itself.
> 
> BTW, this last sentence is not present in
> 
> http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html#tag_02_13

That's pretty old; it's from 2004.

> So I presume it's a newer unreleased revision.

It's in the current revision, which dates from 2008.

> 
> Seriously, you guys are turning POSIX into a joke by introducing
> all these new requirements.  At this point I think we should
> pretty much give up on POSIX compliance the way it's headed.

Let's not go overboard here.  This was introduced to tighten up ambiguous
behavior: what happens when the open bracket *doesn't* introduce a
bracket expression.


-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
