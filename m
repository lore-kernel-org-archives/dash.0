From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [Partial patch] IFS and read builtin
Date: Tue, 24 Aug 2010 00:51:47 +0200
Message-ID: <4C72FB83.5070206@gigawatt.nl>
References: <4C71A29C.1080609@gigawatt.nl> <20100822230003.GB49760@stack.nl> <4C71BAB5.1030504@gigawatt.nl> <20100823193510.GA67671@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from cp1107341-a.dbsch1.nb.home.nl ([84.31.115.1]:51284 "EHLO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752215Ab0HWWt5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Aug 2010 18:49:57 -0400
In-Reply-To: <20100823193510.GA67671@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On 23/08/10 21:35, Jilles Tjoelker wrote:
> I think you should do what you think is best for the stability of your
> product. Because dash releases are not extensively tested, I'd recommend
> a trial build of at least a minimal base system with the new version you
> choose. A particular feature to be wary of is LINENO support, as it will
> cause most configure scripts to accept dash as a usable shell.

Thanks, I'm aware of that. I already locally exported CONFIG_SHELL, so
that even without LINENO support the configure scripts were already run
from dash.

That reminds me: the LINENO support is useful, but the tracking of line
numbers has some issues:

$ src/dash -c 'f() { echo $LINENO; }
f
f
'
2
3

But this is not new, and not limited to LINENO:

$ cat >foo.sh
if :; then
foo
:
:
:
:
:
fi
$ src/dash foo.sh
foo.sh: 8: foo: not found
$ bash foo.sh
foo.sh: line 2: foo: command not found

I have a patch that improves this by storing the line numbers in the
command nodes, if you're interested, but it needs polishing before I
plan on sending it here or anywhere, and there are probably some corner
cases that it mishandles.

> Right, but it seems better to fix the bugs rather than entangle things
> with expand.c and still leave bugs.

Agreed, unless there's an easy way to ensure the command-line processing
has finished and cleaned up completely by the time read starts.

[IFS=", "]
> I think the important thing is that IFS characters are supposed to be
> field terminators (see POSIX XCU 2.6.5 Field Splitting).
>
> Therefore, in the example " 1 ,2 3," there are three fields, each
> containing one digit, and each variable is assigned one of them.

The more I read it, the more I'm actually becoming convinced that zsh is
doing the right thing, and dash is almost doing the right thing.

2.6.5 uses the term "delimiter", not "terminator". They don't mean the
same thing. A delimiter can mark the start of a field as well as the
end. And if you compare susv2 with susv3, you may see susv2 is a lot
clearer than v3 on one point, because it ends the "Field Splitting"
section with a note.

"The last rule can be summarised as a pseudo-ERE:

    (s*ns*|s+)

 where s is an white-space character and n is a character in the
 that is not white space. Any string matching that ERE delimits a
 field, except that the s+ form does not delimit fields at the
 beginning or the end of a line." (followed by an example)

This says the s+ form does not delimit fields at the end of a line,
which strongly implies that the s*ns* form does. The wording is wrong no
matter how you look at it (splitting "a  " results in one field "a", not
one field "a  "), and the note has been removed in susv3. Still, it
manages to somewhat clarify the rest of text.

> In the example " 1 ,2 3,," there are four fields, the last being empty.
> Then c is assigned the third field plus the delimiter character and the
> remaining fields and their delimiters except trailing whitespace that is
> in IFS. Hence, both commas end up in c.

The read command description states:

"If there are fewer var operands specified than there are fields, the
 leftover fields and their intervening separators shall be assigned to
 the last var."

If " 1 ,2 3,," forms four fields, where the fourth field is the empty
string between the two trailing commas, then the final comma is not an
"intervening separator", so it should be excluded from c.

Cheers,
Harald
