From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] 'trap' is not quite POSIX compliant
Date: Sat, 13 Feb 2016 17:08:05 +0100
Message-ID: <56BF54E5.7020006@gigawatt.nl>
References: <56BF4F91.7080105@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:55459
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751000AbcBMQIH (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 13 Feb 2016 11:08:07 -0500
In-Reply-To: <56BF4F91.7080105@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, dash@vger.kernel.org

On 13/02/2016 16:45, Martijn Dekker wrote:
> The 'trap' command in dash is not compliant with POSIX. According to the
> spec, both '-' and any unsigned decimal integer should be accepted as an
> argument meaning 'unset this trap'; dash only accepts '-'.

Indeed. This was reported early December at
<http://www.spinics.net/lists/dash/msg01109.html> along with a patch. 
The patch got rejected in its initial form, which would treat any 
unsigned decimal integer as a signal number. Its later update treats 
unsigned decimal integers as signal numbers only up to NSIG (which is an 
OS-dependent value). bash uses a dynamic limit based on NSIG too, except 
it adds some specific special numbers for bash-specific traps. I 
wouldn't be surprised if it's dynamic in the other shells you tested as 
well, and that the shell-specific traps are the reason for the slight 
variations in limits you found.

Cheers,
Harald van Dijk
