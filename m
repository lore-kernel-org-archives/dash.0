From: Oleg Verych <olecom@flower.upol.cz>
Subject: Here-document...
Date: Tue, 30 Oct 2007 05:23:35 +0100
Message-ID: <20071030042335.GH22435@flower.upol.cz>
Reply-To: dAsh <dash@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:34473 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbXJ3EIo (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Oct 2007 00:08:44 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id D84B4DC7F3
	for <dash@vger.kernel.org>; Tue, 30 Oct 2007 05:08:40 +0100 (CET)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id HdHDmRhPM7oqTnCx for <dash@vger.kernel.org>; Tue, 30 Oct 2007 05:08:40 +0100 (CET)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Imidb-0007KY-BR
	for dash@vger.kernel.org; Tue, 30 Oct 2007 05:23:35 +0100
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dAsh <dash@vger.kernel.org>

Wanted to make simple `makeself` analog......

____________
#!/bin/sh -e
set  -e
trap 'echo "${0##*/}: Unexpected abort, exiting..."' 0
umask 377

F="./bina$$"

{ dd bs=65536 0<&8 1>"$F" 8<&- 2>&-
  exec 8<&-
  chmod u+x "$F"
  echo 1>&2 "Running binary \`$F'...
"
  (exec "$F")
  trap "{
echo '
Exit status: '$?
test  $? -eq 2 && \
echo '(Possibly kernel and fallback \`/bin/sh\` couldn'\''t execute this file,
because it is a broken binary or unspecified/unsupported script.
File not removed.)
' # disabled for show || rm -f "$F"
} 1>&2" 0
  exit  0
} 8<<""
======================

If works with payload like:
_________________
#!/usr/bin/printf $$Running from file: %s\n
not used and ran
=================
olecom@flower:/tmp$ sh bixelf
Running binary `./bina13936'...

$$Running from file: ./bina13936

Exit status: 0
olecom@flower:/tmp$
=================

It fails with binaries due to NUL (and maybe something more) removal.

== Another issues ==

Looking at parser, this piece of code:

#
    TRACE(("Here document %d\n", n->type));
    if (! noexpand(wordtext) || (i = strlen(wordtext)) == 0 || i > EOFMARKLEN)
            synerror("Illegal eof marker for << redirection");
#

[0] google.com/search?q=here-document+opengroup+2004

In [0] it's stated, that delimiter isn't evaluated (expanded), only
quoiting must be checked. That if() seems to be completely bogus.

* strlen() == 0 isn't triggered -- empty delimiter is handled by syntax;

* check for max line isn't needed, i think;

* noexpand() checks for special symbols, while [0] says, that `word'
  must be used as is (with escaping/quotes removed).
  
pdksh seems to do so, i.e $WHATEVER can be used and it is not expanded.
Bash doesn't care also, but i don't know if it expands that.

pdksh doesn't like no delimiter in the end of file with, thus no
expansion is obvious (but such behavior is bad, i.e. no possibility to
leave whatever stuff until the EOF):

#
olecom@flower:/tmp$ pdksh bixelf
bixelf[27]: here document `$NULL' unclosed
bixelf: Unexpected abort, exiting...
olecom@flower:/tmp$
olecom@flower:/tmp$ bash bixelf
Running binary `./bina26446'...

$$Running from file: /tmp/bina26446

Exit status: 0
olecom@flower:/tmp$ sh bixelf
bixelf: 23: Syntax error: Illegal eof marker for << redirection
bixelf: Unexpected abort, exiting...
olecom@flower:/tmp$
#
== * ==

Placing binary stuff safely with optimized reading/writing by big
blocks without parsing, if delimiter is "", are things, that i'd like
to propose and possibly fix/implement soon.
--
-o--=O`C
 #oo'L O
<___=E M
