From: Sven Mascheck <mascheck@in-ulm.de>
Subject: Re: Dash problem with IFS
Date: Mon, 11 May 2009 15:48:26 +0200
Message-ID: <20090511134826.GA13308@lisa.in-ulm.de>
References: <822b241f0905011133l3bcbf9dci4799abc80ec9de99@mail.gmail.com> <20090502020131.GA19531@gondor.apana.org.au> <8499950a0905070901o7337acbex451810a8091e81c9@mail.gmail.com>
Reply-To: mascheck@in-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.in-ulm.de ([217.10.8.10]:47618 "HELO mail.in-ulm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754220AbZEKNzI (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 11 May 2009 09:55:08 -0400
Content-Disposition: inline
In-Reply-To: <8499950a0905070901o7337acbex451810a8091e81c9@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Thu, May 07, 2009 at 07:01:56PM +0300, Oleg Verych wrote:

> # just newline
> IFS=`printf '\n+'`; IFS=${IFS%+}

> last example is POSIXly correct ugliness. Bashizm looks better (:
> 
> IFS=$'\n'

PS: I see the problem distinguishing a tab from a space,
but everything but a literal newline is bloat

IFS='
'
