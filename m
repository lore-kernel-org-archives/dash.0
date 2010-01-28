From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Output redirection to block-defined filehandle
Date: Thu, 28 Jan 2010 23:10:34 +0100
Message-ID: <46a038f91001281410g54a000darc5b7c87e9012d53e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33912 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142Ab0A1WKg (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 28 Jan 2010 17:10:36 -0500
Received: by ewy19 with SMTP id 19so1281781ewy.21
        for <dash@vger.kernel.org>; Thu, 28 Jan 2010 14:10:34 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The flock binary in modern linuxes (from util-linux-ng) supports
flocking a filehandle that is handled by the shell. Combining this
with per-code-block filehandles / io redirection, it is an incredibly
useful construct to protect a code block with a lock.

The resulting code looks like this (from man flock on Fedora 11):

      (
         flock -s 200
         # ... commands executed under lock ...
       ) 200>/var/lock/mylockfile

I am now discovering that this works in bash, but not in dash.

Is there a posixly correct way to do this? Can dash handle it? Is
there a syntax for this that is both dash and bash friendly?

If the answer is not -- this codepath is conditional. Is there a way
for me to test for which shell is running (and only attempt it under
bash)?

thanks!


martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
