From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: Re: command lookup and POSIX
Date: Sat, 8 Mar 2014 10:22:20 -0700
Message-ID: <218BD73A-C9EA-4444-80FB-822617CC53AB@aim.com>
References: <20140307194318.GA2317@home.jasonmmiller.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from omr-m04.mx.aol.com ([64.12.143.78]:38003 "EHLO
	omr-m04.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaCHR77 convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 8 Mar 2014 12:59:59 -0500
Received: from mtaout-maa01.mx.aol.com (mtaout-maa01.mx.aol.com [172.26.222.141])
	by omr-m04.mx.aol.com (Outbound Mail Relay) with ESMTP id 3815470001D4B
	for <dash@vger.kernel.org>; Sat,  8 Mar 2014 12:59:58 -0500 (EST)
Received: from [192.168.0.3] (75-166-242-117.hlrn.qwest.net [75.166.242.117])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-maa01.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id 9FF6438000094
	for <dash@vger.kernel.org>; Sat,  8 Mar 2014 12:59:57 -0500 (EST)
In-Reply-To: <20140307194318.GA2317@home.jasonmmiller.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jason Miller <jason@milr.com>

On 2014-03-07, at 12:43, Jason Miller wrote:

> Reading this:
> 
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_09_01_01
> 
> Any built-in other than the special built-ins, or listed in the table
> there should not be run unless it is present in the PATH.
>    ...
> Of course I can't find a single shell that follows this, even when
> enabling its respective strict POSIX mode.
> 
z/OS: http://pic.dhe.ibm.com/infocenter/zos/v2r1/topic/com.ibm.zos.v2r1.bpxa500/toc.htm

user@HOST: uname -a                                                                                                                    
OS/390 MVS3 23.00 03 2818
user@HOST: type echo                                                                                                                  
echo is a built-in command
user@HOST: PATH=/bin echo Hello                                                                                                        
Hello
user@HOST: PATH=/foo echo Hello                                                                                                        
echo: FSUM7351 not found

> ... I'm guessing it was added to
> prevent changes in behaviors of existing scripts as shells add more
> builtins.
> 
I would agree.

-- gil

