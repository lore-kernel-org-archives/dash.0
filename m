From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] don't read-uninitialized for \177 in a here-doc
Date: Mon, 28 Sep 2009 11:32:32 +0200
Message-ID: <87ljjzbej3.fsf@meyering.net>
References: <87r5trbezu.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:54493 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbZI1Jcf (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Sep 2009 05:32:35 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 25FEC81816C
	for <dash@vger.kernel.org>; Mon, 28 Sep 2009 11:32:34 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 428EA818054
	for <dash@vger.kernel.org>; Mon, 28 Sep 2009 11:32:32 +0200 (CEST)
In-Reply-To: <87r5trbezu.fsf@meyering.net> (Jim Meyering's message of "Mon, 28
	Sep 2009 11:22:29 +0200")
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: 548493@bugs.debian.org

Jim Meyering wrote:

> It was indeed a bug in dash.
> I tracked it down and wrote the patch below:
>
>>From 53924ce6da7fece91e57b7238e6aa81a4df636a5 Mon Sep 17 00:00:00 2001
> From: Jim Meyering <meyering@redhat.com>
> Date: Mon, 28 Sep 2009 11:00:05 +0200
> Subject: [PATCH] don't read-uninitialized for \177 in a here-doc
>
> A DEL (0177, dec 127) byte in a here-document would cause dash to
> access uninitialized memory at the end of one of the syntax.c tables,
> since those tables are sized to accommodate a maximum index of
> BASESYNTAX + 126.  Make the generated tables one byte larger.
> printf ':<<\\E\n\200y\nE'|./dash

More details:

The above command fails as follows on certain systems, but not on others:

    albeniz/sid$ printf ':<<\\E\n\177y\nE'|dash
    dash: y: not found
    dash: E: not found

If you want to simulate the failure consistently, simply enlarge
the sqsyntax table by one and make the last entry anything other
than CWORD.  Use "11" (CEOF) and it'll evoke the symptoms shown above.
