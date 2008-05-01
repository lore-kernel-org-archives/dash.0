From: Oleg Verych <olecom@flower.upol.cz>
Subject: Changes with provided user's source code transform (Size and performance efficient rewriting of the `dash.test` built-in)
Date: Thu, 1 May 2008 02:22:50 +0200
Message-ID: <20080501002250.GA18601@flower.upol.cz>
References: <20071019083742.GH22435@flower.upol.cz> <E1Iio7y-0003DS-00@gondolin.me.apana.org.au> <20071019193104.GI22435@flower.upol.cz> <20071019195121.GJ22435@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:52213 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761020AbYEAACC (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Apr 2008 20:02:02 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 991E1E852A
	for <dash@vger.kernel.org>; Thu,  1 May 2008 02:01:46 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id SmRQDxZtWUinAl3T for <dash@vger.kernel.org>; Thu, 01 May 2008 02:01:46 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JrMZW-0005sv-2J
	for dash@vger.kernel.org; Thu, 01 May 2008 02:22:50 +0200
Content-Disposition: inline
In-Reply-To: <20071019195121.GJ22435@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

In light of my last LKML posts about text processing of
(still plain text and open) source http://kernelnewbies.org/olecom
i'd like to propose slightly improved maintaining of changes.

In this particular case, it is providing `sed` transformation of

' -a ' , ' -o '
to
' ] && [ ' , ' ] || [ '


along with change in built-in `test`. Note again, that -a -o are optional
(due to problems) in POSIX.

# http://www.opengroup.org/onlinepubs/009695399/utilities/test.html :

test "$1" -a "$2"

     should be written as:
test "$1" && test "$2"

     to avoid problems if a user supplied values such as $1 set to '!'
     and $2 set to the null string. That is, in cases where maximal
     portability is of concern, replace:
test expr1 -a expr2

     with:
test expr1 && test expr2

     and replace:
test expr1 -o expr2

     with:
test expr1 || test expr2
----
As usual, there is an unnoticeable "but":
----
     but note that, in test, -a has higher precedence than -o while "&&"
     and "||" have equal precedence in the shell.
#end

I wonder if any user of those operands knew this, also i can't
understand those "precedence" rules here. It's just even more confusing.


== original proposition for -nt -ot (specifying lists of files to check) ==

Fri, Oct 19, 2007 at 09:51:21PM +0200:

> > _Optimization_, i.e. to do not call stat() on the same file on and on.
> > This is just silly.
> 
> This is called "userspace sucks" by kernel people, isn't it?

Some of those got knocked out (having nothing technical to say) by regexp
ninja, i am. http://kerneltrap.org/node/16091


Here's error, however.

> Square braces [' && ]' proposed, because they not require escaping
> from the shell.

Unquoted '[' is the file-name pattern class introduction character.
____
