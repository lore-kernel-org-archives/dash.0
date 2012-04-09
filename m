From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: local var=$(cat) only reads one line
Date: Mon, 9 Apr 2012 17:34:24 +0200
Message-ID: <20120409153423.GA57239@stack.nl>
References: <1333922946.15345.140661059835993.31129B93@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:49283 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932090Ab2DIPly (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 9 Apr 2012 11:41:54 -0400
Content-Disposition: inline
In-Reply-To: <1333922946.15345.140661059835993.31129B93@webmail.messagingengine.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Pryor <dubiousjim@gmail.com>
Cc: dash@vger.kernel.org

On Sun, Apr 08, 2012 at 06:09:06PM -0400, Jim Pryor wrote:
> Hi, I'm not a subscriber to this list and am not sure where's the best
> place to report this bug. A cursory search didn't find other reports
> of the same issue; but I can imagine there may well be such. If so,
> excuse the noise. I'm just trying to help.

> I notice the following issue in the version of dash that's bundled in
> a recent release of finnix (not sure which one, but the kernel version
> is 3.0.6, so it's probably finnix 103, released 23 October 2011). I
> also see it in the FreeBSD sh, from a FreeBSD-9 release candidate I
> compiled in January. I know that's not dash, but I understand the
> codebases are closely related. Neither of these are my active systems;
> hence the fuzzy details.

> Here is a testcase:

> test1() {
>     local IN=$(cat)
>     printf "test1 <%s>\n" "$IN"
> }

> MSG=$(printf "abc\ndef\nghi")

> printf "%s" "$MSG" | test1

> The weird bit only shows up in test1: IN will only be assigned the first
> line of stdin.

The cause is that the local command expands to
  local IN=abc def ghi
and therefore it sets IN to less than what you expect and also makes two
more variables local.

Now, local is not in POSIX, but export and readonly are and have exactly
the same issue.

Reading POSIX.1-2008 (and also older versions) literally, this way of
splitting is correct. However, ksh93, bash and pdksh think differently,
doing what your script expects. Also, the examples section of export has
  export PATH=/local/bin:$PATH
which assumes that either the value will not contain IFS characters or
metacharacters or it will not be split regardless.

Dash had this behaviour for some time but it was dropped again because
of inconsistencies between implementations.

However, there appears to be some sort of agreement on how it should
work now:
http://austingroupbugs.net/view.php?id=351
(scroll down to note 0000943).

-- 
Jilles Tjoelker
