From: "Dan McGee" <dan@archlinux.org>
Subject: dash regression against klibc
Date: Thu, 1 May 2008 12:25:58 -0500
Message-ID: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:21814 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134AbYEAR0A (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 1 May 2008 13:26:00 -0400
Received: by rn-out-0910.google.com with SMTP id e11so530994rng.17
        for <dash@vger.kernel.org>; Thu, 01 May 2008 10:25:59 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: herbert@gondor.apana.org.au, dash@vger.kernel.org

I wanted to let you know of an issue one of our users discovered with
dash compiled against klibc- working directory lookups appear to be an
issue in a clean environment:
http://bugs.archlinux.org/task/10327

What is interesting is it works fine if you just run dash from within
bash- it only fails as seen there if you run using the 'env -'
wrapper.

If you want me to look into this and/or help out with a fix, let me
know. Thanks!

-Dan
