From: Zdenek Kaspar <zkaspar82@gmail.com>
Subject: dash 0.5.9: break and continue bug
Date: Tue, 23 Aug 2016 22:23:19 +0200
Message-ID: <c8a328b0-1ed7-cb35-5a9c-95b7f592cb9e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36766 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755331AbcHWUXX (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 23 Aug 2016 16:23:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so177048983wma.1
        for <dash@vger.kernel.org>; Tue, 23 Aug 2016 13:23:22 -0700 (PDT)
Received: from vm1.localdomain (ip-78-45-7-86.net.upcbroadband.cz. [78.45.7.86])
        by smtp.googlemail.com with ESMTPSA id a194sm29363660wmd.24.2016.08.23.13.23.20
        for <dash@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2016 13:23:21 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi, I've noticed 0.5.9 does ignore break and continue statements, here
is simple reproducer:


one() {
    echo "  one"
    break
}

two() {
    echo "  two"
}

for i in 1 2
do
    echo "loop $i:"
    one
    two
done


dash-0.5.9:
$ dash dash-break-test
loop 1:
  one
  two
loop 2:
  one
  two

dash-0.5.8-4.fc24.x86_64:
$ dash dash-break-test
loop 1:
  one

HTH, Z.
