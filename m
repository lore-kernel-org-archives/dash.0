From: Dan Muresan <danmbox@gmail.com>
Subject: shift "fatal error"
Date: Thu, 10 Mar 2011 19:40:03 +0100
Message-ID: <AANLkTik1TC3jv-imnbChRGqtHzRCvKCcB5_LnqEnDc9u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48594 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab1CJSlB (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 13:41:01 -0500
Received: by bwz15 with SMTP id 15so2070501bwz.19
        for <dash@vger.kernel.org>; Thu, 10 Mar 2011 10:41:00 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi, is there some consensus on whether shift should cause a "fatal
error" as reported by Herbert against bash:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=252378

# doesn't print anything
dash -c 'shift 2; echo hi'

My copy of SUSv3 doesn't seem to imply any "fatal error" handling
requirement for shift:

--- 8-X ---
EXIT STATUS

The exit status is >0 if n>$#; otherwise, it is zero.

CONSEQUENCES OF ERRORS

Default.
--- 8-X ---

-- Dan
