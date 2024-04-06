Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C082557F
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712394364; cv=none; b=iJKnXLSpP0Nzb7ulmedzCsYK71xVE6wK1elsc3hO/lCWhKNkw9CnG0TMDxpRk0EpgnHacsRyeBbT3K5zZFfMPdDlM3BcU9op2unXY+zuYLv+jpH9hIjy4z7AD9qIcjW94luYWsfpYIgzKYEw1mJ71PgTcsLj92PaTj6rjjrPqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712394364; c=relaxed/simple;
	bh=QIpQvBplp1Um983fYqZdRCdKrzWP1pnGM6GaxIiegN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDJjT5hOVpHcVbq7rYx/WJOsDkRrR2V4nGRQ77gsNBJgLaRQzIA6/vuDK1tq/Wgz3ukFVlIvYZAJuoxxHtftNcDMkIfoB/FdKkE3lVo9SvsJnXtQNIpkkTUVXNo1OYXdZmDYboqQz7xe2u7hmdL+0YVj5grWNmj96JCnQ1bDYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt1zo-00FtYc-RT; Sat, 06 Apr 2024 17:05:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 17:06:13 +0800
Date: Sat, 6 Apr 2024 17:06:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH v3] Prototype all function definitions for C23 compat
Message-ID: <ZhEQhREkUrbEsJTl@gondor.apana.org.au>
References: <Y+WvR6PY6vmVtUHr@gondor.apana.org.au>
 <20230210112449.wctwfhmwwwg7c26h@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230210112449.wctwfhmwwwg7c26h@tarta.nabijaczleweli.xyz>

On Fri, Feb 10, 2023 at 12:24:49PM +0100, наб wrote:
> Current compilers just produce warnings about unprototyped definitions,
> noting that they've been deprecated for decades now, but in C23 mode
> they're rejected, because they got removed, cf. draft and paper:
>   https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
>   https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2841.htm
> 
> In short, int whatever(a, b, c) is illegal, and int whatever() is now
> finally equivalent to int whatever(void); or, to put it another way,
> when building in C23 mode (which is not /yet/ the default), you get
> -- >8 --
> $ make -j25
> make  all-recursive
> make[1]: Entering directory '/home/nabijaczleweli/code/dash'
> Making all in src
> make[2]: Entering directory '/home/nabijaczleweli/code/dash/src'
>   CC       builtins.def
>   CC       mknodes
>   GEN      token.h
>   GEN      token_vars.h
>   CC       mksyntax
>   GEN      builtins.h
>   GEN      syntax.h
>   GEN      nodes.h
> make  all-am
> make[3]: Entering directory '/home/nabijaczleweli/code/dash/src'
>   CC       alias.o
>   CC       arith_yacc.o
>   CC       arith_yylex.o
>   CC       cd.o
>   CC       error.o
>   CC       eval.o
>   CC       exec.o
>   CC       expand.o
>   CC       histedit.o
>   CC       input.o
>   CC       jobs.o
>   CC       mail.o
>   CC       main.o
>   CC       memalloc.o
>   CC       miscbltin.o
>   CC       mystring.o
>   CC       options.o
>   CC       parser.o
>   CC       redir.o
>   CC       show.o
>   CC       trap.o
>   CC       output.o
>   CC       system.o
>   CC       bltin/printf.o
>   CC       bltin/test.o
>   CC       bltin/times.o
>   CC       var.o
>   CC       builtins.o
> histedit.c:376:16: warning: passing 'const char *' to parameter of type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
>                                 evalstring(s, 0);
>                                            ^
> ./eval.h:54:22: note: passing argument to parameter here
> int evalstring(char *, int);
>                      ^
>   CC       mkinit
> exec.c:779:18: error: unknown type name 'out'
> describe_command(out, command, path, verbose)
>                  ^
> exec.c:779:23: error: unknown type name 'command'
> describe_command(out, command, path, verbose)
>                       ^
> exec.c:779:32: error: unknown type name 'path'
> describe_command(out, command, path, verbose)
>                                ^
> exec.c:779:38: error: unknown type name 'verbose'
> describe_command(out, command, path, verbose)
>                                      ^
> exec.c:779:46: error: expected ';' after top level declarator
> describe_command(out, command, path, verbose)
>                                              ^
>                                              ;
> exec.c:784:1: error: expected identifier or '('
> {
> ^
> exec.c:885:12: error: unknown type name 'argc'
> commandcmd(argc, argv)
>            ^
> exec.c:885:18:options.c error: :unknown type name 'argv'393
> :commandcmd(argc, argv)14:
>                  ^
> error: unknown type name 'value'
> getoptsreset(value)
>              ^
> exec.c:885:23: error: expected ';' after top level declarator
> commandcmd(argc, argv)
>                       ^
>                       ;
> options.c:393:20: exec.c:888:1: error: error: expected identifier or '('
> {expected ';' after top level declarator
> 
> ^
> getoptsreset(value)
>                    ^
>                    ;
> options.c:395:1: error: expected identifier or '('
> {
> ^
> 10 errors generated.
>   CC       nodes.o
> make[3]: *** [Makefile:478: exec.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 3 errors generated.
> jobs.c:247:9: error: unknown type name 'argc'
> killcmd(argc, argv)
>         ^
> jobs.c:247:15: error: unknown type name 'argv'
> killcmd(argc, argv)
>               ^
> jobs.c:247:20: error: expected ';' after top level declarator
> killcmd(argc, argv)
>                    ^
>                    ;
> jobs.c:250:1: error: expected identifier or '('
> {
> ^
> make[3]: *** [Makefile:478: options.o] Error 1
> redir.c:288:13: error: unknown type name 'redir'
> dupredirect(redir, f)
>             ^
> redir.c:288:20: error: unknown type name 'f'
> dupredirect(redir, f)
>                    ^
> redir.c:288:22: error: expected ';' after top level declarator
> dupredirect(redir, f)
>                      ^
>                      ;
> redir.c:295:2: error: expected identifier or '('
>         {
>         ^
> 4 errors generated.
> make[3]: *** [Makefile:478: redir.o] Error 1
> 4 errors generated.
> make[3]: *** [Makefile:478: jobs.o] Error 1
> nodes.c:122:10: error: unknown type name 'n'
> calcsize(n)
>          ^
> nodes.c:122:12: error: expected ';' after top level declarator
> calcsize(n)
>            ^
>            ;
> nodes.c:124:1: error: expected identifier or '('
> {
> ^
> nodes.c:206:14: error: unknown type name 'lp'
> sizenodelist(lp)
>              ^
> nodes.c:206:17: error: expected ';' after top level declarator
> sizenodelist(lp)
>                 ^
>                 ;
> nodes.c:208:1: error: expected identifier or '('
> {
> ^
> nodes.c:219:10: error: unknown type name 'n'
> copynode(n)
>          ^
> nodes.c:219:12: error: expected ';' after top level declarator
> copynode(n)
>            ^
>            ;
> nodes.c:221:1: error: expected identifier or '('
> {
> ^
> nodes.c:317:14: error: unknown type name 'lp'
> copynodelist(lp)
>              ^
> nodes.c:317:17: error: expected ';' after top level declarator
> copynodelist(lp)
>                 ^
>                 ;
> nodes.c:319:1: error: expected identifier or '('
> {
> ^
> nodes.c:339:13: error: unknown type name 's'
> nodesavestr(s)
>             ^
> nodes.c:339:15: error: expected ';' after top level declarator
> nodesavestr(s)
>               ^
>               ;
> nodes.c:341:1: error: expected identifier or '('
> {
> ^
> 15 errors generated.
> make[3]: *** [Makefile:478: nodes.o] Error 1
> 1 warning generated.
> make[3]: Leaving directory '/home/nabijaczleweli/code/dash/src'
> -- >8 --
> 
> With this patch, you're just left with the histedit.c warning.
> ---
> Yeah, Harald's right, I completely missed that the type and linkage
> layout changed, I only saw the arguments move
> 
>  src/exec.c       | 12 +++---------
>  src/jobs.c       |  4 +---
>  src/mksignames.c |  3 +--
>  src/nodes.c.pat  | 15 +++++----------
>  src/options.c    |  3 +--
>  src/redir.c      | 11 +++--------
>  6 files changed, 14 insertions(+), 34 deletions(-)

Patch applied with additional changes to ensure the return type
is on the same line as the rest of the function declaration.

Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
