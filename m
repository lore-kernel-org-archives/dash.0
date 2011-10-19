From: Dima Sorkin <dima@minignu.minidns.net>
Subject: evaluation of env variables in DASH
Date: Wed, 19 Oct 2011 23:24:50 +0200
Message-ID: <87aa8woesd.fsf@minignu.minidns.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from mxout1.netvision.net.il ([194.90.9.20]:36758 "EHLO
	mxout1.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab1JSVjz (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 Oct 2011 17:39:55 -0400
Received: from minignu.minidns.net ([46.117.200.72]) by mxout1.netvision.net.il
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTPA id <0LTC00E6E0TEERA0@mxout1.netvision.net.il> for
 dash@vger.kernel.org; Wed, 19 Oct 2011 23:24:51 +0200 (IST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, herbert@gondor.apana.org.au

Hi.
  The following DASH behaviour seems buggy to me

-----------------
$ export A='\n'
$ echo $A

$
-----------------

whereas using BASH would result in printing literally \n .

I.e. presumingly DASH does secondary interpolation of escaped
symols in values of environment variables. 

Please CC me with replies, I am not in the list.

Thanks, regards,
  Dima.

P.S.
  Wrom the other hand

$ export B=1
$ export A='$B'
$ echo $A
PRINTS $B
$
