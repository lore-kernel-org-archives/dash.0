From: "Oleg Verych" <olecom@gmail.com>
Subject: Re: fail to expand/assigned subshell output into a local variable
Date: Fri, 9 Nov 2007 00:01:49 +0100
Message-ID: <8499950a0711081501m337c8b4ei364dd166c1d96965@mail.gmail.com>
References: <200711081707.17944.vapier@gentoo.org>
	 <8499950a0711081427u7782ace2udd6708c50dcd711b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:42617 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXKIBkM (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Nov 2007 20:40:12 -0500
Received: by nf-out-0910.google.com with SMTP id g13so334308nfb
        for <dash@vger.kernel.org>; Thu, 08 Nov 2007 17:40:10 -0800 (PST)
In-Reply-To: <8499950a0711081427u7782ace2udd6708c50dcd711b@mail.gmail.com>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: dash@vger.kernel.org

== 11/8/07, Oleg Verych ==
> == 11/8/07, Mike Frysinger ==
> > this code snippet incorrectly
>
> Why incorrectly? There's no assignments in the `local`.

... in the man page (and i didn't used that `feature' myself);

> It's a built-in, thus word splitting does its job,

thus, double quotes will prevent this...

> and incorrect names, that start with digits and have other than
> alpha-numeric symbols, are syntax errors.
>
> > fails under dash: $ { local f=$(date); } local: 5: 8: bad variable name
____
