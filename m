From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC dash 0/4] Avoid a fork before running last command given
 to -c
Date: Sun, 10 Apr 2011 02:18:17 -0500
Message-ID: <20110410071734.GA16736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37553 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab1DJHS2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Apr 2011 03:18:28 -0400
Received: by iyb14 with SMTP id 14so4667197iyb.19
        for <dash@vger.kernel.org>; Sun, 10 Apr 2011 00:18:28 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

Hi,

Jilles Tjoelker wrote[0]:

> Regarding sh -c optimization, I am in favour of this. Uselessly waiting
> 'sh -c' processes annoy me. I made the change for FreeBSD 8.0 sh, which
> is very similar to dash. The SVN changeset is r194128.

So I grabbed that changeset with

	svn log -v svn://svn.freebsd.org/base/head/bin/sh -r 194128
	svn diff -r 194127:194128 svn://svn.freebsd.org/base/head/bin/sh

and made it a tiny bit smaller.   Here's the result.

   text    data     bss     dec     hex filename
  83994    1784   11128   96906   17a8a dash.before-O2
  83994    1784   11128   96906   17a8a dash.before-Os
  84146    1784   11128   97058   17b22 dash.after-O2
  84146    1784   11128   97058   17b22 dash.after-Os

On this amd64 the cost is 152 bytes of text.  Thoughts?

[0] http://bugs.debian.org/436466

Jilles Tjoelker (4):
  [INPUT] Introduce preadateof predicate to check for end of input
  [EVAL] Make eval flags public
  [EVAL] Take advantage of EV_EXIT in evalstring
  [MAIN] Optimize dash -c "command" to avoid a fork

 src/eval.c  |   11 +++++------
 src/eval.h  |    5 +++++
 src/input.c |   17 +++++++++++++++++
 src/input.h |    1 +
 src/main.c  |    2 +-
 5 files changed, 29 insertions(+), 7 deletions(-)
