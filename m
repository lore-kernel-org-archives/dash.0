From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: Re: How to pass parameters containig options from variables
Date: Tue, 25 Sep 2012 10:48:49 -0600
Message-ID: <1C74D9CF-5354-4197-BBF1-F7E9FC1AE681@aim.com>
References: <20120925084729.GG17149@bc-bd.org> <20120925132102.GG10707@brutus.ethup.se> <20120925162813.GI17149@bc-bd.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from imr-db02.mx.aol.com ([205.188.91.96]:41693 "EHLO
	imr-db02.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab2IYQ4H (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 25 Sep 2012 12:56:07 -0400
Received: from mtaout-ma06.r1000.mx.aol.com (mtaout-ma06.r1000.mx.aol.com [172.29.41.6])
	by imr-db02.mx.aol.com (Outbound Mail Relay) with ESMTP id 108EE1C00005D
	for <dash@vger.kernel.org>; Tue, 25 Sep 2012 12:49:35 -0400 (EDT)
Received: from [192.168.0.49] (97-118-118-31.hlrn.qwest.net [97.118.118.31])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-ma06.r1000.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id 8CA79E000440
	for <dash@vger.kernel.org>; Tue, 25 Sep 2012 12:49:34 -0400 (EDT)
In-Reply-To: <20120925162813.GI17149@bc-bd.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

On Sep 25, 2012, at 10:28, bd@bc-bd.org wrote:
> 
>> eval $DAEMON $ARGS should work.
> 
> That did it, thank you.
>  
... but always beware of "eval" if you don't absolutely
control the argument string.  A single semicolon and
someone owns your process.

-- gil

