From: peter kvillegard <peterkvillegard@gmail.com>
Subject: dash 0.5.6.1-1, setting IFS to tab, bug?
Date: Tue, 11 Jan 2011 23:08:01 +0100
Message-ID: <AANLkTimH4dj4x12T1j5d4hd1Xeq2nMwev8ZLegbgCMT-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44636 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab1AKWIC (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Jan 2011 17:08:02 -0500
Received: by bwz15 with SMTP id 15so7787bwz.19
        for <dash@vger.kernel.org>; Tue, 11 Jan 2011 14:08:01 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello, i'm new to all this but was encouraged to bring up an issue to
the dash mailing list.
It seems like setting the IFS for read to a tab does not work as it should.
For example: consider a testfile with the following content:

test1(space)test2(tab)test3

(where the "(space)" is an actual space etc)
then:

#!/bin/dash

cat testfile |
while IFS='  	' read col1 col2; do    #an actual tab
echo $col1
echo $col2
done

exit 0

it gives the output:

test1
test2 test3

because it seems to interpret the space as part of IFS?

i might be wrong though, but some other people reproduced the error on
various systems for the later versions of dash, so that's why im
writing to you.

regards

peter
