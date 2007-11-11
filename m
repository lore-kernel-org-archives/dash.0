From: "Oleg Verych" <olecom@gmail.com>
Subject: Here-document with quoted delimiter.
Date: Sun, 11 Nov 2007 21:36:49 +0100
Message-ID: <8499950a0711111236t54d337d8ld0582795d1d2e4c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:19896 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbXKKUgv (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 11 Nov 2007 15:36:51 -0500
Received: by nf-out-0910.google.com with SMTP id g13so932354nfb
        for <dash@vger.kernel.org>; Sun, 11 Nov 2007 12:36:49 -0800 (PST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dAsh <dash@vger.kernel.org>

== 11/11/07, Herbert Xu ==
> On Tue, Oct 30, 2007 at 04:23:35AM +0000, Oleg Verych wrote:
> >
> > } 8<<""
> > ======================
>
> Actually this (the empty delim) only works with dash by accident.
> I've tried bash and pdksh and they both terminate on the first
> empty line which is what you would expect rather than EOF.  The
> real Korn shell does something completely different.
>
> I've fixed this in dash to conform to bash/pdksh.

[]
> > Placing binary stuff safely with optimized reading/writing by big
> > blocks without parsing, if delimiter is "", are things, that i'd like
> > to propose and possibly fix/implement soon.
>
> Sorry but I can't see how we can get this to work in a meaningful
> way.

I hope you know what `makeself` is. There is to much scripting and
external tools used to achieve basic thing: to copying binary data after
script in the script file to a separate file and to do something with it
(mainly gunzip/bunzip + run another script). Also it all is written is
quoted form, which is very unreadable and ugly.

After making that very simple shell stub (in prev mail), i realized, that
things can be done very easily.

1) here-doc data is started after first new line of the command, that
   has `<<' syntax.

There are may be multiple chunks, but let's concentrate on that with
empty delimiter.

2) As stated in shell description "2.3 Token Recognition", there are
   two major modes, here-doc and not. It is described, that quoted
   delimiter yields whole here-data to be a word, that ends with a
   *line*, consisting with delimiter and `\n'.

   This means `\n\n', if delimiter is `""'.

   But what is special about `""'? It is, that there is no intention from
   the user to limit data, isn't it? Even `\n\n' is just a side effect of
   the written standard.

   So, what i propose is basically:

here_doc() {

if delim = ""
then
     io_setup()
     if fork_shell()
     then
          while ! ( eof || fatal_error )
          do read  in
             write out
          done

          exit
     fi
     io_reset()
     return error
fi

# other delim handling
....

}

I.e. just a plain copy of data, thus no problems with `\0' or any other
parsing/memory management. I don't know even if the Linux VFS can strip
head of the file, thus preventing stupid copying.

(Linux, because it doesn't seem a problem to configure and implement
kernel-dependent features, so many fancy kernel developers spending much
more time designing, testing and applying into the kernel mainline.)

#--
{ dd bs=65536 0<&8 1>"$F" 8<&- 2>&-
  exec 8<&-
  chmod u+x "$F"
  echo 1>&2 "Running binary \`$F'...
"
  (exec "$F")
} 8<<''
#!/usr/bin/printf $$Running from file: %s\n
not used and ran
#--

How `<<-' was described, i see no problem what so ever to implement this
very simple idea. What is/was so special about leading tabs in 70s-80s?

Why useful, small and fast functionality must be prevented just because
it's "not like historical shell was"?

==

OTOH, fixing dash to prevent binary data from being parsed and broken is
another issue. (2) says, that there's second mode of handling input, and
that input supposedly not a text (i.e. without `\0'). Dash seem to apply
same "tokenization" even for here-doc with quoted delimiter.

BTW, "ash silently discards null characters" the original ash man page
states.
____
