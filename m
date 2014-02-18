From: Steffen (Daode) Nurpmeso <sdaoden@gmail.com>
Subject: Re: dash and ANSI escape sequences
Date: Tue, 18 Feb 2014 14:22:17 +0100
Message-ID: <20140218132217.w8K4gtmLHCuLOEN1H+Ney6Yg@dietcurd.local>
References: <ldvhl7$ns2$1@ger.gmane.org>
 <20140218131132.GA30525@hal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:33274 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020AbaBRNW1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 18 Feb 2014 08:22:27 -0500
Received: by mail-ee0-f47.google.com with SMTP id d49so7761297eek.34
        for <dash@vger.kernel.org>; Tue, 18 Feb 2014 05:22:26 -0800 (PST)
In-Reply-To: <20140218131132.GA30525@hal.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Guido Berhoerster <gber@opensuse.org>
Cc: dash@vger.kernel.org

Guido Berhoerster <gber@opensuse.org> wrote:
 |You can print arbitrary bytes in a portable way (i.e. as
 |specified by POSIX) by using octal notation, e.g. escape is 033
 |in octal:
 |
 |printf "\033[1;32mpassed\033[0m\n"

That is of course even better.

--steffen
