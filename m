From: Jack Bates <i72aoc@nottheoilrig.com>
Subject: glob pattern and redirected input file name
Date: Thu, 29 Aug 2013 16:49:12 -0700
Message-ID: <521FDDF8.5010200@nottheoilrig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.nottheoilrig.com ([50.16.249.74]:43843 "EHLO
	mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab3H2XzF (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 29 Aug 2013 19:55:05 -0400
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
	by mail.nottheoilrig.com (Postfix) with ESMTP id 1F6A540BBB
	for <dash@vger.kernel.org>; Thu, 29 Aug 2013 23:49:12 +0000 (UTC)
Received: from [192.168.0.11] (S0106c8fb26402908.ek.shawcable.net [24.66.136.12])
	by mail.nottheoilrig.com (Postfix) with ESMTPSA
	for <dash@vger.kernel.org>; Thu, 29 Aug 2013 23:49:11 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

What is DASH supposed to do when input is redirected from a file, and 
the file name is a glob pattern? e.g.

    tar xz < foo-*.tar.gz

Is it supposed to expand the glob pattern, or is that not supported?

The following both work, is there a better workaround?

    tar fxz foo-*.tar.gz

    tar xz < $(echo foo-*.tar.gz)
