From: Richard H Lee <ricardohenrylee@gmail.com>
Subject: Command parsing problem and tracefile
Date: Fri, 08 Jun 2012 17:58:03 +0100
Message-ID: <4FD22F1B.3090208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52545 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762119Ab2FHQ6F (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jun 2012 12:58:05 -0400
Received: by eaak11 with SMTP id k11so1220437eaa.19
        for <dash@vger.kernel.org>; Fri, 08 Jun 2012 09:58:04 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Dash mailing list,

I have one issue with dash and one question regarding debugging.

First up, when I run a configure script and it hits the following line:
if $_pkg_config --exists --print-errors $all_libav_libs ; then

with $_pkg_config being 'pkg-config --static', dash throws the following 
error:
./configure: 6012: ./configure: pkg-config --static: not found

I've tried adding brackets around the condition, but with no avail. Is 
there anything wrong with the syntax.

Secondly, I decided to delve deeper with gdb and I can see dash calling:
find_command('pkg-config --static')

I would like to get some more info as to what in going on. IIRC, I saw 
in show.c, there was some sort for tracefile that dash to dump to. How 
do I enable this?


Richard
