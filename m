From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash-0.5.8 bug report
Date: Fri, 21 Nov 2014 18:38:10 +0100
Message-ID: <546F7882.8030309@gigawatt.nl>
References: <DUB128-W26B546CDE4201C1F19CEC39C770@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:51349 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750703AbaKURiO (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 21 Nov 2014 12:38:14 -0500
In-Reply-To: <DUB128-W26B546CDE4201C1F19CEC39C770@phx.gbl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>, "dash@vger.kernel.org" <dash@vger.kernel.org>

On 21/11/2014 14:55, David Binderman wrote:
> Hello there,
>
> eval.c:273:19: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]
>
>          if (!exitstatus == isor)
>
> Maybe
>
>          if (exitstatus != isor)
>
> was intended.

This looks correct to me. isor represents the type of command 
composition. It can be 0 (&&), 1 (||) or 2 (;). If isor == 0, the second 
command should not be executed if exitstatus != 0. If isor == 1, the 
second command should not be executed if exitstatus == 0. If isor == 2, 
the second command should be executed.

Cheers,
Harald van Dijk
