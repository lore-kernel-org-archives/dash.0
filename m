From: Olof Johansson <olof@ethup.se>
Subject: Re: How to pass parameters containig options from variables
Date: Tue, 25 Sep 2012 15:21:02 +0200
Message-ID: <20120925132102.GG10707@brutus.ethup.se>
References: <20120925084729.GG17149@bc-bd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from brutus.ethup.se ([85.17.45.102]:59067 "EHLO brutus.ethup.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889Ab2IYN3f (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 25 Sep 2012 09:29:35 -0400
Content-Disposition: inline
In-Reply-To: <20120925084729.GG17149@bc-bd.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: bd@bc-bd.org
Cc: dash@vger.kernel.org

Hi,

On 2012-09-25 10:47 +0200, bd@bc-bd.org wrote:
> I am trying to pass these arguments
> 
> 	-N -p -F "not host foo"
> 
> to a binary, but
> 
> 	ARGS="-N -p -F 'not host foo'"
> 	$DAEMON $ARGS
> 
> get's passed as 6 arguments and not 4.

eval $DAEMON $ARGS should work.

-- 
 --------------------------------------------------------------- 
| Olof Johansson                              http://stdlib.se/ |
|  irc: zibri                           https://github.com/olof |
 --------------------------------------------------------------- 
