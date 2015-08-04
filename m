From: John Marshall <john.marshall@sanger.ac.uk>
Subject: Re: builtin read -r and backslash-char escape sequences
Date: Tue, 4 Aug 2015 10:56:39 +0100
Message-ID: <A73736EB-F742-4F31-A48B-4C4816C5212B@sanger.ac.uk>
References: <EDC4419D-6669-4211-9005-8970B5499D9A@sanger.ac.uk> <55BF9EE6.8050407@gigawatt.nl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.sanger.ac.uk ([193.62.202.243]:19862 "EHLO
	smtp.sanger.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474AbbHDJ4o convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 4 Aug 2015 05:56:44 -0400
In-Reply-To: <55BF9EE6.8050407@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On 3 Aug 2015, at 18:03, Harald van Dijk wrote:
> On 03/08/2015 18:37, John Marshall wrote:
>> Problems with one of my scripts appear to have been caused by dash's read -r translating escape sequences (like \t) whereas several other shells read them literally.  For example:
>> 
>> $ printf '%s' '\a\t\x' > backslashes
>> $ dash -c 'read -r foo < backslashes; echo "$foo"' | cat -t
>> ^G^I\x
> 
> You're using echo to print what gets assigned to foo, but backslashes are not portable with echo. You probably noticed that already since you're using printf to determine what gets saved in the backslashes file.

D'oh!  Indeed I noticed that when the backslashes were right there, but to really internalise it I guess one has to find out the hard way -- which I have now done.  The real script eventually evals the line rather than echoing it, but there's a cmd=`echo $cmd | sed ...` along the way that does the damage.

Thanks to both of you,

    John

-- 
 The Wellcome Trust Sanger Institute is operated by Genome Research 
 Limited, a charity registered in England with number 1021457 and a 
 company registered in England with number 2742969, whose registered 
 office is 215 Euston Road, London, NW1 2BE. 
