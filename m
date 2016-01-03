From: Gioele Barabucci <gioele@svario.it>
Subject: Re: Inheriting IFS from environment
Date: Sun, 3 Jan 2016 19:46:45 +0100
Message-ID: <n6bqam$fk2$1@ger.gmane.org>
References: <56840F22.6040302@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35516 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbcACSrD (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 3 Jan 2016 13:47:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1aFngC-0003qM-2H
	for dash@vger.kernel.org; Sun, 03 Jan 2016 19:47:00 +0100
Received: from 84.222.249.202 ([84.222.249.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Sun, 03 Jan 2016 19:47:00 +0100
Received: from gioele by 84.222.249.202 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Sun, 03 Jan 2016 19:47:00 +0100
In-Reply-To: <56840F22.6040302@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On 30/12/2015 18:06, Martijn Dekker wrote:
> Unlike bash, *ksh and zsh, dash allows inheriting IFS from the environment:
> 
> $ IFS=bla dash -c "x='hela hola'; echo \$x"
> he  ho
> 
> This seems a bit dodgy from a security point of view.

Hi,

The Debian BTS contains a similar report:
<https://bugs.debian.org/541642>. One suggestion from that thread:

> POSIX says (IEEE Std 1003.1, 2004 Edition; 2.5.3 Shell Variables):
>
>> Implementations may ignore the value of IFS in the environment at the
>> time the shell is invoked, treating IFS as if it were not set.

Regards,

--
Gioele Barabucci <gioele@svario.it>


