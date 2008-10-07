From: Marcin Owsiany <marcin@owsiany.pl>
Subject: errexit and pipelines
Date: Tue, 7 Oct 2008 11:44:00 +0100
Message-ID: <20081007104400.GA3219@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail0.vicoop.com ([85.17.210.107]:34399 "EHLO mail.vicoop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbYJGLMW (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Oct 2008 07:12:22 -0400
Received: from localhost (213-155-151-233.customer.teliacarrier.com [213.155.151.233])
	(Authenticated sender: porridge@sl.owsiany.pl)
	by mail.vicoop.com (Postfix) with ESMTP id AF1E01E8D5
	for <dash@vger.kernel.org>; Tue,  7 Oct 2008 12:36:58 +0200 (CEST)
Received: from mowsiany by localhost with local (Exim 4.67)
	(envelope-from <marcin@owsiany.pl>)
	id 1KnA2q-0002JR-GM
	for dash@vger.kernel.org; Tue, 07 Oct 2008 11:44:00 +0100
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I have recently found a problem with _bash_ that is described in the
following thread in bash-bug mailing list:
http://groups.google.com/group/gnu.bash.bug/browse_thread/thread/e37f5c7ddcc55eeb/57474f8d2f8efa59

In short, it's about the fact that the following lines make a "set -e"
script abort:
 true | false
 for a in 1; do false; done
but the following does not:
 true | for a in 1; do false; done

I thought that this inconsistency was a bug in bash, but as you can find
out in the thread, it is the first type of statements that behaves
incorrectly, according to SUS.

Dash's manpage defines 'errexit' sematics differently: more like I would
like it to work. It also works consistently in the above examples.

Since I like dash behavior more (makes it easier to write reliable
scripts), I'm considering switching my program (cruft) to dash. But
before I do it, can someone please confirm that what is written in the
manpage and how dash behaves right now is indeed the intended behaviour,
and will not in forseeable future be changed to match bash's behaviour?

regards,
-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
 
"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
