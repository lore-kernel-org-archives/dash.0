From: "Oleg Verych" <olecom@gmail.com>
Subject: Re: fail to expand/assigned subshell output into a local variable
Date: Thu, 8 Nov 2007 23:27:20 +0100
Message-ID: <8499950a0711081427u7782ace2udd6708c50dcd711b@mail.gmail.com>
References: <200711081707.17944.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:46065 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758937AbXKHW1W (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Nov 2007 17:27:22 -0500
Received: by nf-out-0910.google.com with SMTP id g13so286688nfb
        for <dash@vger.kernel.org>; Thu, 08 Nov 2007 14:27:20 -0800 (PST)
In-Reply-To: <200711081707.17944.vapier@gentoo.org>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: dash@vger.kernel.org

== 11/8/07, Mike Frysinger ==
> this code snippet incorrectly

Why incorrectly? There's no assignments in the `local`. It's a built-in,
thus word splitting  does its job, and incorrect names, that start with
digits and have other than alpha-numeric symbols, are syntax
errors.

> fails under dash: $ { local f=$(date); } local: 5: 8: bad variable name
____
