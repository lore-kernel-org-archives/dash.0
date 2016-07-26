From: Vladimir Didenko <vladimir.didenko@gmail.com>
Subject: Declaring local variables inside while loop leads to memory leak
Date: Tue, 26 Jul 2016 13:35:53 +0300
Message-ID: <CAHRK1yP1GyUJEPNLSicUatRJPOJg=Oeac1daJkuJs6eDD+xi9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35931 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcGZKfz (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 26 Jul 2016 06:35:55 -0400
Received: by mail-wm0-f48.google.com with SMTP id q128so167546615wma.1
        for <dash@vger.kernel.org>; Tue, 26 Jul 2016 03:35:55 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi.

I found that declaring local variables inside while loop leads to
memory leak. Code sample:

test()
{
   while [ true ]; do
      local a=
   done
}

test

-- 
Regards,
Vladimir.
