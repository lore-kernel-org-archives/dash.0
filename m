From: Stephane Chazelas <stephane@chazelas.org>
Subject: Re: 'return' from subshell in function doesn't
Date: Mon, 9 Mar 2020 07:44:17 +0000
Message-ID: <20200309074417.bsvfxjh4e32tv2va@chazelas.org>
References: <S1726267AbgCHLof/20200308114435Z+1505@vger.kernel.org>
 <9b3a55fb-df00-8ac3-7a1e-b60e24aa2970@gmx.net>
 <98ce2d03-e647-48b2-e4dd-3ceb810f2b24@gigawatt.nl>
 <4d8123c9-33e4-a525-930f-37bce1cb9d77@gmx.net>
 <71fc6831-8193-e977-3437-6181dc79842b@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46395 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHoU (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 9 Mar 2020 03:44:20 -0400
Content-Disposition: inline
In-Reply-To: <71fc6831-8193-e977-3437-6181dc79842b@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Dirk Fieldhouse <fieldhouse@gmx.net>, DASH mailing list <dash@vger.kernel.org>

2020-03-08 15:19:01 +0000, Harald van Dijk:
[...]
> The same problem applies to the 'break' and 'continue' statements too:
> 
>   for var in x y z
>   do
>     echo $var
>     (break)
>   done
> 
> This prints x, y, and z in all shells, the 'break' statement in the subshell
> does not cause the loop to terminate. Some shells additionally print a
> warning or error message such as "break: not in a loop". Here again,
> presumably the intent of the standard is not that the 'break' statement
> should cause the loop to terminate. It is not something that shells do, and
> it is not something that is reasonable for shells to implement.
> 
> This is looking like a giant can of worms I'm not sure I'm ready to see
> opened. :)
[...]

See https://www.austingroupbugs.net/view.php?id=842 and its
resolution
(https://www.austingroupbugs.net/view.php?id=842#c2257) about that.

-- 
Stephane
