From: Malcolm Kay <malcolm.kay@internode.on.net>
Subject: Re: if then elif then else fi -- Problem report
Date: Tue, 29 Jun 2010 10:38:31 +0930
Message-ID: <201006291038.31206.malcolm.kay@internode.on.net>
References: <201006282226.22001.malcolm.kay@internode.on.net> <4C28A1FA.1090306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:24963 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131Ab0F2BIf (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 28 Jun 2010 21:08:35 -0400
In-Reply-To: <4C28A1FA.1090306@redhat.com>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

Eric,
Thanks for the clarification.

I had assumed that 'dash' aimed to be a faster replacement for 
the classical Bourne shell 'sh' as implemented in BSD systems,
and this seemed to be confirmed when all the man pages I've been 
able to find were more or less direct copies of BSD 'sh' pages.

As it is I feel the man pages should not only be fixed in this 
respect, but also such differences to classical 'sh' 
implementations should be high lighted.

On Mon, 28 Jun 2010 10:52 pm, Eric Blake wrote:
> . . .
>
> Therefore, the bug is in the man page.  Per POSIX,
> http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_ch
>ap02.html#tag_18_09_03 "A list is a sequence of one or more
> AND-OR lists separated by the operators ';' and '&' and
> optionally terminated by ';' , '&' , or <newline>."

While I agree with your conclusions, I would note that POSIX
defines "if ... else etc." in terms of 'compound_list' rather 
than 'list' so the above definition of 'list' is not really 
relevant. By my reading of your reference it seems POSIX defines 
'list' and 'compound_list' independently but fails to clarify
the difference if any.

Malcolm
