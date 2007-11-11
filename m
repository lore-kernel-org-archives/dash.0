From: "Oleg Verych" <olecom@gmail.com>
Subject: Features.
Date: Sun, 11 Nov 2007 23:59:40 +0100
Message-ID: <8499950a0711111459h33921caaxde3111fb2b719fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:56955 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbXKKW7m (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 11 Nov 2007 17:59:42 -0500
Received: by nf-out-0910.google.com with SMTP id g13so953742nfb
        for <dash@vger.kernel.org>; Sun, 11 Nov 2007 14:59:41 -0800 (PST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dAsh <dash@vger.kernel.org>

0. Introduce versioning and feature check.

1. Patterns.

  1.1 Restore original ash idea about negative pattern matching
      (DIFFERENCES .9), but with only one `!', as it can be enables in
      bash.

  1.2 Make patterns to distinguish files and directories, because
      searching algorithm already doing this as result of `*/*'
      expansions, for example.

      Sometimes it's better to have a list of files only, without
      additional `find`. I don't know what syntax to propose,
      especially if socket/fifo/devnode matching will be requested
      later. Maybe

      mplayer &F*/*         # play files
      cat !&P*              # output content of not fifos(pipes)
      ls -l /dev/&Dhd*      # show a bit more info devnodes /dev/hd*

  1.3 To sort output only on request.
      I see no value in sorting it.

  1.4 To do not output patterns in case of empty match.
      Quoting is meant to be done for anything, shell can screw up.
      Thus, i also see no value in saving pattern for programs, that
      don't expect such ``file names'' anyway.

2. Restore `setvar variable value`. It is better, than to use `eval` to
   artificially construct and perform assignments of variables with names,
   which a generated or passed as parameters.

3. Yet again to kill aliases and all traces of history introduced to ash
   by BSD guys.

4. Here-doc with quoted empty delimiter (`<<""') to be ended with EOF.

5. File descriptors.

   5.1 Opening file descriptors at position (seeking)

   # skip 1k while opening
   read A B C <@"$((1<<10))"/tmp/file.txt

   # seek while copying and closing file descriptor 4
   cat <&4@4096 4<&-

   # seek in the very beginning, while copying read-only file descriptor 4
   cat <&4@

   # seek in the very end beginning, while copying write-only $WO_A (see 5.2)
   cat >&$WO_A@


   5.2 IMHO making user accessible file descriptors in range of [3-9] is
       kind of silly, when open() returns lowest available fd number,
       and shell have no semantics of saying "no, this fd is used already".

       Making them in higher and wider region, say in [100-255] is
       quite reasonable. Making them as special variables, like
       parameters `$1' are, makes even more sense, thus preventing any
       potential problems.

   # open /tmp/file.txt and place fd in $RO_A
   exec RO_A</tmp/file.txt
   # open, seek /tmp/file.bin and place fd in $RO_B
   exec RO_B<@1024/tmp/file.bin

   cd /tmp
   # same, with making clear border in file name
   exec RO_B<@"1024"file.bin

6. Binary generator. To build more speed and size optimized complete
   functions, loops, forking daemons etc. With clear and simple
   shell<->"basic systems programming C language" relation it
   shouldn't be that hard.

It's not fscking perl. It's how shell have to evolve, instead of ~20
years of complete crap. There is The Kernel, here we are
@vger.kernel.org. Now it's time for userspace to do not silently suck
under the table!

And BTW, i didn't see anything like proposed in pdksh or bash. They
seem to do other perl stuff instead.


== Political/religious ==


To restore original AGPL license in sources. Place reference to the
LICENSE file to all files with small notice, not BSD junk. That BSD
(and other pieces) must be added in LICENSE file.

To rename back to ash. Mainly because i didn't see that much changes
since original release by Kenneth Almquist. Quite reverse. Original
built-in `test` and `expr` were removed, crap, like aliases and
history, editing was added. Ah, Debian. Debian.....................

--
_crazy:
-o--=O`C
 #oo'L O
<___=E M

_crazy-,
-o--=O`C
 #oo'L O
<___=E M
