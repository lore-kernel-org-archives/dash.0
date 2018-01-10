From: Joshua Nelson <jynelson@email.sc.edu>
Subject: Re: [BUG] $PATH not fully searched
Date: Wed, 10 Jan 2018 18:44:37 -0500
Message-ID: <1689301.2NH6bUEWrJ@debian-thinkpad>
References: <1997619.aMy8rkrhBo@debian-thinkpad> <20180110221815.GA44971@stack.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6318513.EnuWbZKSLc"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:9158
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751882AbeAJXoz (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 10 Jan 2018 18:44:55 -0500
In-Reply-To: <20180110221815.GA44971@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org, cdaniels@fastmail.com

--nextPart6318513.EnuWbZKSLc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

This was precisely the problem! Thanks so much for your help,
I changed the relevant parts of ~/.profile to "$HOME/<path>" instead.

On Wednesday, January 10, 2018 23:18:15 EST Jilles Tjoelker wrote:
> On Wed, Jan 10, 2018 at 01:36:18PM -0500, Joshua Nelson wrote:
> > I've come across an error with the PATH variable in `dash`. Instead of
> > fully searching PATH for commands, dash will respond 'command not
> > found' if `command -p <executable>` fails.  The same command works
> > fine in Bash.
> > 
> > The following example was performed in a live cd of Debian 9.1 Stretch
> > (run in a virtual machine), with dash version 0.5.8-2.4:
> > 
> > ```bash
> > user@debian:~$ PATH="~/my_bin:$PATH" dash
> > $ echo $PATH
> > ~/my_bin:/usr/local/bin:/usr/bin:/usr/local/games:/usr/games
> > $ ls -l ~/my_bin/list
> > -rwxr--r-- 1 user user 18 Jan 10 17:42 /home/user/my_bin/list
> > $ list
> > dash: 3: list: not found
> > $ exit
> > user@debian:~$ PATH="$PATH:~/my_bin" list
> > Desktop Documents Downloads Music my_bin Pictures Public Templates Videos
> > ```
> > 
> > I believe but am not certain that this is related to the following patch:
> > https://www.mail-archive.com/dash@vger.kernel.org/msg01329.html
> 
> In your example, the tilde is quoted and ends up literally in PATH.
> Then, in bash only, tilde expansion is attempted again during the
> search. In my testing, zsh, mksh, ksh93, dash and FreeBSD sh do not
> implement this feature. Enabling POSIX mode in bash also disables the
> feature.
> 
> What works more portably is
>   PATH=~/my_bin:$PATH dash
> or
>   PATH=$PATH:~/my_bin list
> which expands the tilde at the time of the assignment. This works pretty
> much everywhere except in old real Bourne shells, which do not implement
> tilde expansion at all.
> 
> If you want to quote the $PATH part, it is possible but not necessary
> since it is in a variable assignment which is not subject to pathname
> generation and word splitting anyway. However, if "export" is prepended,
> I strongly recommend quoting it since some shells such as dash do not
> implement the special rule for assignment utilities yet.
> 
> --
> Jilles Tjoelker

--nextPart6318513.EnuWbZKSLc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEqDOwG0S92h7oDiYc5lWCPY2LEIgFAlpWpWUACgkQ5lWCPY2L
EIj1XQ//cW0jJKBhfjfQPa7gL5Q+Vb9fNhL0wWn0ocX6qHgyiZSUeioY3tZUC9J2
YGQhZC4kJL5wDrCBgJt3QOKXLwffEMadbvOKoiX6ng9tJAba1QGiRVGjwleHZLuv
rsB6VdXrbLa8nn/p8IQPD/zQoEsuqkL8AKuzzNx9s7R/X49ysO5ps8LHkRqWEE3Z
Z4PR/iQlHu+GnMQuVwijzwNpwzyznaSyEZY8uKc+W1rgIFOH8eOfLLXKrNdd4I3x
3MVPwNRtgeYF0c1wo/r5QBHeKZ8gzoieyYLpBbb4ZCEPM4pPfx+tbUtn0TgPRIbE
MnIQPbiisBBn8mIPKaN/zzdKy52+B0b+nmLZNQmEreMZ/e6QEBkijR4jfN7SVxmR
BrN6t+OqnixHZKaaikASQVRpa+nzXZMkNsGxK4Six3tk+lmxgevqFY9FonQC77UJ
oQHTXcqFNAcTEeasseluF/fkCR9dEABH9jbSY6DtwVxj/dlAaEwxCbT1V2q/cGKV
JisJ0oLrhFKye+oaXvthwr5KDRap0b70ybKPkmCw2aqQIvFAuj3ZghgFr78ALOuf
6Vt5oPcFuuzugy29ix7COSsw5uU5nudsGSlAvvfKryZXPWs9YE6D9/x1BXPY8kmq
k5ie+5+WhdbMarnTSvL0cLP6TmdlUm/F8wPdxcKndmfI/skdCho=
=xZ7W
-----END PGP SIGNATURE-----

--nextPart6318513.EnuWbZKSLc--
