From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: builtin read -r and backslash-char escape sequences
Date: Mon, 3 Aug 2015 19:03:34 +0200
Message-ID: <55BF9EE6.8050407@gigawatt.nl>
References: <EDC4419D-6669-4211-9005-8970B5499D9A@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:45008
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751709AbbHCR5h (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 3 Aug 2015 13:57:37 -0400
In-Reply-To: <EDC4419D-6669-4211-9005-8970B5499D9A@sanger.ac.uk>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: John Marshall <john.marshall@sanger.ac.uk>
Cc: dash@vger.kernel.org

On 03/08/2015 18:37, John Marshall wrote:
> Problems with one of my scripts appear to have been caused by dash's read -r translating escape sequences (like \t) whereas several other shells read them literally.  For example:
>
> $ printf '%s' '\a\t\x' > backslashes
> $ dash -c 'read -r foo < backslashes; echo "$foo"' | cat -t
> ^G^I\x
> $ bash -c 'read -r foo < backslashes; echo "$foo"' | cat -t
> \a\t\x
> $ ksh -c 'read -r foo < backslashes; echo "$foo"' | cat -t
> \a\t\x

You're using echo to print what gets assigned to foo, but backslashes 
are not portable with echo. You probably noticed that already since 
you're using printf to determine what gets saved in the backslashes 
file. If you also use printf "%s\n" "$foo", you'll see that read works 
as you expect.

Cheers,
Harald van Dijk
