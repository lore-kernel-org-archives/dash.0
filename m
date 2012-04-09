From: Jim Pryor <dubiousjim@gmail.com>
Subject: Re: local var=$(cat) only reads one line
Date: Sun, 08 Apr 2012 21:12:43 -0400
Message-ID: <1333933963.12672.140661059876041.485D9C2C@webmail.messagingengine.com>
References: <1333922946.15345.140661059835993.31129B93@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48272 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab2DIBMo (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 8 Apr 2012 21:12:44 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0ADA420863
	for <dash@vger.kernel.org>; Sun,  8 Apr 2012 21:12:44 -0400 (EDT)
In-Reply-To: <1333922946.15345.140661059835993.31129B93@webmail.messagingengine.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Sun, Apr 8, 2012, at 06:09 PM, Jim Pryor wrote:
> test3() {
>     IN=$(cat)
>     printf "test3 <%s>\n" "$IN"
> }
> 
> test4() {
>     IN=$(cat)
>     printf "test4 <%s>\n" "$IN"
> }

test4 was supposed to use quotes: "$(cat)". It works fine either way.
This also works fine:

test1a() {
    local IN
    IN=$(cat)
    printf "test1a <%s>\n" "$IN"
}

It's only this which fails:

test1a() {
    local IN=$(cat)
    printf "test1 <%s>\n" "$IN"
}

I've also reported to FreeBSD:
<http://www.freebsd.org/cgi/query-pr.cgi?pr=166771>
-- 
dubiousjim@gmail.com

