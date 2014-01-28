From: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?=
	<socketpair@gmail.com>
Subject: exec command and error checking
Date: Tue, 28 Jan 2014 18:16:23 +0600
Message-ID: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:38297 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaA1MQY (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 07:16:24 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so366065qcx.37
        for <dash@vger.kernel.org>; Tue, 28 Jan 2014 04:16:23 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

$ dpkg -l | fgrep dash
ii  dash                                   0.5.7-2ubuntu2
                POSIX-compliant shell

$ exec 9<no_such_file && echo TEST
dash: 1: cannot open no_such_file: No such file

$ exec 9<no_such_file || echo TEST
dash: 2: cannot open no_such_file: No such file

So, I cannot test this operation without using $?

in BASH this works as expected (even in sh mode)

-- 
Segmentation fault
