From: "Oleg Verych" <olecom@gmail.com>
Subject: Re: dash race
Date: Fri, 25 Apr 2008 15:45:37 +0200
Message-ID: <8499950a0804250645s51ac0ffal9eef8152007facb0@mail.gmail.com>
References: <4811D0F1.20801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:16534 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbYDYNpj (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 25 Apr 2008 09:45:39 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1441274nfb.21
        for <dash@vger.kernel.org>; Fri, 25 Apr 2008 06:45:37 -0700 (PDT)
In-Reply-To: <4811D0F1.20801@gmail.com>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: dash list <dash@vger.kernel.org>

Alexey Gladkov:

>  Sometimes following script is get 99% CPU and will be never
>  finished. This happens with dash from git. I can't bisect
>  this because 05c1076 has this problem.

Sometimes?

If not in monitor mode (-m and/or -i), then IMHO jobs are not
under control at all.
-- 
sed 'sed && sh + olecom = love'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
