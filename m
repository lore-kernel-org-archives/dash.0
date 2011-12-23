From: Geir Hauge <geir.hauge@gmail.com>
Subject: Re: '>;' redirection operator [was: [1003.1(2008)/Issue 7 0000530]:
	Support in-place editing in sed (-iEXTENSION)]
Date: Fri, 23 Dec 2011 01:14:03 +0100
Message-ID: <CAO-BiTJXqLgMJSxoow8HTurLEGDk84x0=jv=UJJJZwByY_nTmA@mail.gmail.com>
References: <201112221539.pBMFdlaj011933@penguin.research.att.com>
	<4EF39B1E.80709@redhat.com> <4EF3AA9A.9070009@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <bug-bash-bounces+gnu-bug-bash-2=m.gmane.org@gnu.org>
In-Reply-To: <4EF3AA9A.9070009@gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
	<mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
	<mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-2=m.gmane.org@gnu.org
Sender: bug-bash-bounces+gnu-bug-bash-2=m.gmane.org@gnu.org
To: Bruce Korb <bkorb@gnu.org>
Cc: David Korn <dgk@research.att.com>, dash <dash@vger.kernel.org>, austin-group-l@opengroup.org, zsh-workers@zsh.org, Bash - Bug <bug-bash@gnu.org>, miros-discuss@mirbsd.org, Eric Blake <eblake@redhat.com>
List-Id: dash@vger.kernel.org

2011/12/22 Bruce Korb <bkorb@gnu.org>
>
> When the exact opposite is the useful variation?  I.e. keep-on-failure.
> "-i" for sed is simple, understandable and implemented a lot.
>

As far as I know, -i is only implemented with GNU sed and BSD sed, and they
are incompatible, BSD sed's -i takes a mandatory argument, while GNU sed's
-i takes an optional string which must be provided in the same argument.
E.g.

gnused -i.bak sed-script file
bsdsed -i .bak sed-script file

So the only portable way of using sed to "edit" (read: overwrite) a file is
with

sed sed-script file > file.tmp && mv file.tmp file

I'd welcome this >; syntax.

-- 
Geir Hauge
