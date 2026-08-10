Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F3331EBA
	for <dash@vger.kernel.org>; Mon, 10 Aug 2026 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398480; cv=none; b=OCjLPhFaPxyYtyvciZNzjpPRiPwKbb7l88dSdy6hoinKHGmrxylzIUZEoAnVJ5Kq3I7Hd51XOptw/uLC7B6NrI7rPV7aIeettxBUpBl2YEyjZ8ZsfyaZaNaW0ZujURMSh/9gEU4dNmm7s+xPVNK5c2dvWgvsl38bfJfzcZdzono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398480; c=relaxed/simple;
	bh=Nl82c7CMZoUq8uLeSBQDyBYHlVc2vY5WXP7SnX43PaM=;
	h=Date:From:To:Subject:Message-ID; b=h8NDE8RAL8/ELt4yN8VmyyTe153jdeq0FILsvBphQZ+fAK/py8w25sR6w78Vm0dzRfGcEFE4SmK+zXo3n10qAMVyWr3ocO67cadSHc+OL1WHvzu1r7qLol2bCMCLeoeaanDfiUK0sCVCrw1YwlnExT8jhSrfnR+aOr9rmVC8IDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=X/E5B7C3; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="X/E5B7C3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1786398026; x=1787064692; h=date:author:from:to:subject:
  message-id:openpgp:blahblahblah:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=y3xGOnS3HRmQUJN8Y2JfOJ8h2SCDCyhXG926/PTfjJA=;
 b=X/E5B7C3dMLhn/8Y661PHavX065id7kbEYVI9wgNf+NV/3pDGPdlZ1UJ3O2bKEDuiVCS74VO
  8O1oEHsieEnPcR6E3pAK4GY3o+eYyZoJ4+e9GzRsE71i666r787S2m7u7V8u0mmI7FkXwyCAPB
  ASPlqZFMy9RfhPUOXc4Qq3LD+u7e+LIRnVXLI0FhX4nLgpCnJJG2J7wLo5kpkB7stWVIdQiHCE
  cagosYSfnI6fCNikWbWeveNs/tW/EM9Sclg9tDVhdZpX3aThLQb/+jmRn1tQOhxfIB9HnQYVMY
  jrLXB0JyR8HAI7QzREXZvmEqRhxQSqpYAQ0rQqRRmMLwthDw==
Date: Mon, 10 Aug 2026 23:40:25 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org
Subject: 0.5.13.5: unwanted alias expansions
Message-ID: <20260810214025.uEv9z5qG@steffen%sdaoden.eu>
User-Agent: s-nail v14.10.0-alpha-51-g0f7aa93363
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Hello.

I have a quite clumsy script environment with ~/.profile, ~/.shrc,
~/.bash_logout etc that i try to use for all shells.  Tried at
least, for many years, now for some time have only bash, dash via
Linux distribution.  Anyhow.  Imagine ~/.shrc doing among others

        [ -f "$HOME/.shared.alias" ] && . "$HOME/.shared.alias"

and that doing

  ___aa l '\command ls ${LS_COLOUR_FLAG} -aFtr'

where that comes from .shrc again and is

        if [ -n "$___SHTYPE" ] || ( type alias | grep 'builtin\|built-in\|intrinsic') >/dev/null 2>&1; then
                ___a() { alias "$1"="$2"; }
                ___aa() { alias "$1"="$2"; }
                ___ua() { unalias "$1"; }
        else
                echo
                echo '  *No alias support, aliases will be shell functions!*'
[skip]
        fi

so that.  Now after

  ___aa l '\command ls ${LS_COLOUR_FLAG} -aFtr'

again, with debug instrumentation:

  echo ALI-0
  i= j= k= l=
  echo ALI-1
          if (ps -o user,pid,ppid,ni,%cpu,sz:6,rss:6,stat,time,stime,tty,cmd) >/dev/null 2>&1; then
                  k='-o user,pid,ppid,ni,%cpu,sz:6,rss:6,stat,time,stime,tty,cmd'
  echo ALI-2
          elif ( ps -F ) >/dev/null 2>&1; then
                  k=-F
          elif ( ps -f ) >/dev/null 2>&1; then
                  k=-f
          else
                  k='-o user,pid,pcpu -o args'
          fi
  echo ALI-3
          (ps -e $k) >/dev/null 2>&1 && l=-e || l=-A
  echo ALI-4

So in dash context:

  #?0|lecce:tmp$ dash -i
  shrc
  0 is dash
  JA
  ALI-0
  ../  .system-hook-1  .ICE-unix/  .X11-unix/  .X0-lock  tmux-1000/  .pkgmk/  .nail/  cron.MXurmD/  ./  s-nail-edbaseuR2PSP
  ALI-1
  ALI-2
  ALI-3
  ../  .system-hook-1  .ICE-unix/  .X11-unix/  .X0-lock  tmux-1000/  .pkgmk/  .nail/  cron.MXurmD/  ./  s-nail-edbaseuR2PSP
  ALI-4

what we see is actually two times the expansion of the l alias.
Which for completeness sake is reported as

  #?0|lecce:tmp$ alias l
  'l=\command ls ${LS_COLOUR_FLAG} -aFtr'

whereas in bash it is

  alias l='\command ls ${LS_COLOUR_FLAG} -aFtr'


By the way i also see from the ~/.bash_logout which is called via

        ___on_exit() {
  echo on exit
                [ -f "$HOME/.bash_logout" ] && . "$HOME/.bash_logout"
        }
        trap ___on_exit EXIT

  #?0|lecce:tmp$
  on exit
  Logging out ... and:
          (a)  Cleanup.
            (*)  Do nothing but logging out.
  Three seconds to go, choose or loose ...
  Ttwo
  Ciao and out

that i cannot input anything in the above that really is

  if (echo|read -t 1) >/dev/null 2>&1; then
  echo ein
          read -t 3 input
  else
  echo Ttwo
          PROCID=$$
          export PROCID
          trap "echo 'Timeout expired'; exit 0" QUIT
          /bin/sh -c '/bin/sleep 3 && kill -QUIT $PROCID' </dev/null >/dev/null 2>&1 &
          killer=$!
          read input
          kill -TERM $killer
  fi

whereas bash let's me input something.
Like i said this shell environment is way over two decades old,
with rewrites, sure, but it used to work with quite some shells
say before Corona or so.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
