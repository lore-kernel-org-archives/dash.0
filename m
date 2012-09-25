From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: How to pass parameters containig options from variables
Date: Tue, 25 Sep 2012 20:55:32 +0200
Message-ID: <5061FE24.3000300@gigawatt.nl>
References: <20120925084729.GG17149@bc-bd.org> <20120925132102.GG10707@brutus.ethup.se> <20120925162813.GI17149@bc-bd.org> <1C74D9CF-5354-4197-BBF1-F7E9FC1AE681@aim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:48619 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753784Ab2IYTdN (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 25 Sep 2012 15:33:13 -0400
Received: from hosting12.csv-networks.nl ([84.244.151.141])
	by mailfilter.csv-networks.nl with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <harald@gigawatt.nl>)
	id 1TGaID-0004Q2-Iy
	for dash@vger.kernel.org; Tue, 25 Sep 2012 20:55:37 +0200
Received: from 541f324a.cm-5-8a.dynamic.ziggo.nl ([84.31.50.74] helo=[10.0.1.132])
	by hosting12.csv-networks.nl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1TGaJd-0001Tf-5x
	for dash@vger.kernel.org; Tue, 25 Sep 2012 20:57:05 +0200
In-Reply-To: <1C74D9CF-5354-4197-BBF1-F7E9FC1AE681@aim.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

On 25-9-2012 18:48, Paul Gilmartin wrote:
 > On Sep 25, 2012, at 10:28, bd@bc-bd.org wrote:
 >>> eval $DAEMON $ARGS should work.
 >> That did it, thank you.
 > ... but always beware of "eval" if you don't absolutely
 > control the argument string.  A single semicolon and
 > someone owns your process.
For a configuration file that gets sourced, the person creating the 
configuration file already owns the process, so there is no added 
security by avoiding eval here.
