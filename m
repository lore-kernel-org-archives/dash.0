From: Wez Furlong <kingwez@gmail.com>
Subject: "fc -l" broken between v0.5.5.1 and v0.5.6
Date: Mon, 26 Jul 2010 10:17:43 -0700
Message-ID: <AANLkTi=7L7EC0xuBF4fqBksFAMAmjEiCc5VgAj75Hg=h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43619 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab0GZRRo (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 26 Jul 2010 13:17:44 -0400
Received: by vws3 with SMTP id 3so2599889vws.19
        for <dash@vger.kernel.org>; Mon, 26 Jul 2010 10:17:43 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

When building with libedit, I get the following behavior:

% ./src/dash -E
$ fc -l
fc: 1: history number -16 not found (internal error)
$

dialling back to v0.5.5.1:

% ./src/dash -E
$ fc -l
    1 fc -l
$

It's totally invisible to me the cause of this regression, otherwise I
would have also included a patch!

This occurs on both darwin and centos 5.3.

Let me know if I can provide more information,

--Wez.
