From: Dan Kegel <dank@kegel.com>
Subject: circumflex in character ranges in filename expansion and case statements?
Date: Wed, 18 Dec 2013 11:49:33 -0800
Message-ID: <CAPF-yOZSDep=Rii2jU3mxnzRqjSQF13BAvMsfR9GYiuu-ER0jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:65450 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab3LRTtf (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 18 Dec 2013 14:49:35 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm19so1173081wib.13
        for <dash@vger.kernel.org>; Wed, 18 Dec 2013 11:49:34 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I just ran into this in a real script.

http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_13
says that character ranges in filename expansion and case statements
use ! instead of ^, but bash and zsh accept either ! or ^ equally,
whereas dash and ash accept only what the standard demands, !.

e.g.

case x in
[^x]) echo "bug: x is not recognized as being in character range";;
esac

outputs "bug..." on dash (both as shipped in ubuntu 12.04, and from git)
and ash (ubuntu 12.04),
and does not output anything on bash or zsh from ubuntu 12.04.

The conforming script

case x in
[!x]) echo "bug: x is not recognized as being in character range";;
esac

behaves properly in all four shells.

So... I'll fix my script.  But jeez.
