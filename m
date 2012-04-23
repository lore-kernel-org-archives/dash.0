From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [BUG] dash doesn't report syntax error when it should on stray "fi"
Date: Mon, 23 Apr 2012 18:53:27 +0200
Message-ID: <4F958907.9030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39216 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab2DWQxe (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 12:53:34 -0400
Received: by eekc41 with SMTP id c41so3314710eek.19
        for <dash@vger.kernel.org>; Mon, 23 Apr 2012 09:53:33 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

How to reproduce:

  $ dash -c ':; fi'; echo stat = $?
  stat = 0

Behaviour of other shells:

  $ bash-4.1 -c ':; fi'; echo stat = $?  # Bash 4.1.5
  bash-4.1: -c: line 0: syntax error near unexpected token `fi'
  bash-4.1: -c: line 0: `:; fi'
  stat = 1

  $ bash-3.2 -c ':; fi'; echo stat = $? # Bash 3.2.0
  bash-3.2: -c: line 0: syntax error near unexpected token `fi'
  bash-3.2: -c: line 0: `:; fi'
  stat = 2

  $ ksh -c ':; fi'; echo stat = $? # AT&T Ksh
  ksh: syntax error at line 1: `fi' unexpected
  stat = 3

  $ pdksh -c ':; fi'; echo stat = $? # Public Domain Ksh, version 5.2.14
  pdksh: syntax error: `fi' unexpected
  stat = 1

  $ zsh -c ':; fi'; echo stat = $?  # Zsh 4.3.12
  zsh:1: parse error near `fi'
  stat = 1


Version information:

  $ dpkg -l dash
  ii   dash   0.5.5.1-7.4   POSIX-compliant shell

Regards,
  Stefano
