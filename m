From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] eval: Return status in eval functions
Date: Mon, 6 Jun 2016 23:14:40 +0200
Message-ID: <5755E7C0.8010309@gigawatt.nl>
References: <5663058B.1030809@gigawatt.nl>
 <20160606101337.GA21441@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:49827
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751702AbcFFVOw (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 6 Jun 2016 17:14:52 -0400
In-Reply-To: <20160606101337.GA21441@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Gioele Barabucci <gioele@svario.it>

On 06/06/16 12:13, Herbert Xu wrote:
> On Sat, Dec 05, 2015 at 04:40:59PM +0100, Harald van Dijk wrote:
>>
>> used to print Fail, and needed the same modification in the evalstring
>> function to make that print OK (included in the attached patch). There
>> may be other similar bugs lurking.
>
> Not exactly similar but there are a bunch of bugs caused by setting
> exitstatus too early (i.e., before $? has been expanded).
>
> This patch should fix those problems plus the one that you fixed.

Nice! It does indeed fix additional problems. It also introduces a few 
new bugs though (modified from the FreeBSD testsuite):

src/dash -c 'eval "false

"'; echo $?

This should print 1 and used to print 1, but with this patch applied, it 
prints 0. The parsing here adds a null commands, which shouldn't affect 
the exit status.

Unfortunately, attempting to fix this by simply setting
status = exitstatus for null commands breaks other things: given

src/dash -c 'false; case x in *) esac'; echo $?

the correct output is 0, dash used to print 0, and your patch doesn't 
change that, but attempting to fix the earlier problem by setting status 
= exitstatus for null commands makes this print 1.

Another one modified from the FreeBSD testsuite:

src/dash -xc 'f() {
   trap "return 1" USR1
   kill -USR1 $$
}
f'; echo $?

This should print 1 and used to print 1, but with this patch applied, it 
prints 0.

> @@ -588,10 +588,12 @@ evalpipe(union node *n, int flags)
>   		close(pip[1]);
>   	}
>   	if (n->npipe.backgnd == 0) {
> -		exitstatus = waitforjob(jp);
> +		status = waitforjob(jp);
>   		TRACE(("evalpipe:  job done exit status %d\n", exitstatus));

This line looks like it should be updated to print status rather than 
exitstatus when tracing is enabled. :)

Cheers,
Harald van Dijk
