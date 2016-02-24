From: Joerg Schilling <Joerg.Schilling-8LS2qeF34IpklNlQbfROjRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: heredoc and subshell
Date: Wed, 24 Feb 2016 11:58:25 +0100
Message-ID: <56cd8cd1.LdVYbpfe+0tQMm8I%Joerg.Schilling@fokus.fraunhofer.de>
References: <2978711456265264@web9h.yandex.ru>
 <56CCE1E3.1060805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <austin-group-l-request-7882/jkIBncuagvECLh61g@public.gmane.org>
In-Reply-To: <56CCE1E3.1060805-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Resent-Message-ID: <"kzQylC.A.61C.fzYzWB"@Phoebe.vpn.opengroup.org>
Resent-To: austin-group-l-7882/jkIBncuagvECLh61g@public.gmane.org
To: oleg-BA2faJl1U0pBDLzU/O5InQ@public.gmane.org, eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dash-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, austin-group-l-7882/jkIBncuagvECLh61g@public.gmane.org
List-Id: dash@vger.kernel.org

Eric Blake <eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> > --- code
> > prefix() { sed -e "s/^/$1:/"; }
> > DASH_CODE() { :; }
> > 
> > prefix A <<XXX && echo "$(prefix B <<XXX
> > echo line 1
> > XXX
> > echo line 2)" && prefix DASH_CODE <<DASH_CODE
> > echo line 3
> > XXX
> > echo line 4)"
> > echo line 5
> > DASH_CODE
> > 
> > --- bash 4.3.42 output:
> > A:echo line 3
> > B:echo line 1
> > line 2
> > DASH_CODE:echo line 4)"
> > DASH_CODE:echo line 5
>
> So, it looks like bash is interpreting this as "first newline that is
> not in the middle of another shell word), and parses the entire $(...)

I would like to get an explanation on what I should understand by:

	"first newline that is not in the middle of another shell word)


BTW: If I replace $(..) by `..` and feed the code to the original SVr4 Bourne 
Shell, I get the same output as you got from bash. I would guess that the bash 
output you added above is correct.

Note that the command substitution is part of a " quoted string and even 
without that, it would need to be parsed first.

The POSIX version from ksh88 (seen on Solaris) behaves the same with $(..) and 
the `..` variant and the same as bash.

The fact that ksh93 behaves different with $(..) and the `..` variant makes it 
obvious that ksh93 has a bug.

Jörg

-- 
 EMail:joerg-lSlhzV3CM+2sTnJN9+BGXg@public.gmane.org                    (home) Jörg Schilling D-13353 Berlin
       joerg.schilling-8LS2qeF34IpklNlQbfROjRvVK+yQ3ZXh@public.gmane.org (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.org/private/ http://sourceforge.net/projects/schilytools/files/'
