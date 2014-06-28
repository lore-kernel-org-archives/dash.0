From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] \e in "echo" and "printf" builtins
Date: Sat, 28 Jun 2014 19:27:22 +0200
Message-ID: <20140628172722.GA13451@angband.pl>
References: <20140628045653.GA5097@angband.pl>
 <53AEF2E3.5080205@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <dash-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:33867 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaF1R10 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 28 Jun 2014 13:27:26 -0400
Content-Disposition: inline
In-Reply-To: <53AEF2E3.5080205@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 28, 2014 at 06:52:51PM +0200, Harald van Dijk wrote:
> On 28/06/14 06:56, Adam Borowski wrote:
> > I'm not sure what's your policy towards extensions, but \e as \033 is
> > something ubiquitous in the Unix world.  C compilers (gcc, clang, icc and
> > tcc -- but not MSVC), perl, shells (bash and zsh -- but not dash), etc.
> 
> No comment on whether dash itself should accept \e, but you already
> found a compiler that doesn't support it at all, and many of the ones
> that do support it also (optionally) issue a warning for it. Should the
> C code perhaps be using \033 instead of \e?

I don't think anyone is going to ever port dash to MSVC, but you have a
point: some other new compiler can appear.

A version of the patch with \033 attached.

-- 
Gnome 3, Windows 8, Slashdot Beta, now Firefox Ribbon^WAustralis.  WTF is going
on with replacing usable interfaces with tabletized ones?

--fUYQa+Pmc3FrFX/N
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Support-e-in-echo-and-printf-builtins.patch"

From a6e6e7b6f3a725b4ca0514f22e9ee4cfe2c225e2 Mon Sep 17 00:00:00 2001
From: Adam Borowski <kilobyte@angband.pl>
Date: Sat, 28 Jun 2014 06:29:56 +0200
Subject: [PATCH] Support \e in "echo" and "printf" builtins.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 src/bltin/printf.c | 1 +
 src/dash.1         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 893295c..98d954c 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -300,6 +300,7 @@ conv_escape(char *str, int *conv_ch)
 	case '\\':	value = '\\';	break;	/* backslash */
 	case 'a':	value = '\a';	break;	/* alert */
 	case 'b':	value = '\b';	break;	/* backspace */
+	case 'e':	value = '\033';	break;  /* escape */
 	case 'f':	value = '\f';	break;	/* form-feed */
 	case 'n':	value = '\n';	break;	/* newline */
 	case 'r':	value = '\r';	break;	/* carriage-return */
diff --git a/src/dash.1 b/src/dash.1
index 3847d98..7107faa 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1199,6 +1199,8 @@ Subsequent output is suppressed.  This is normally used at the end of the
 last argument to suppress the trailing newline that
 .Ic echo
 would otherwise output.
+.It Li \ee
+Outputs an escape character (ESC).
 .It Li \ef
 Output a form feed.
 .It Li \en
@@ -1573,6 +1575,8 @@ The characters and their meanings are as follows:
 Write a \*[Lt]bell\*[Gt] character.
 .It Cm \eb
 Write a \*[Lt]backspace\*[Gt] character.
+.It Cm \ee
+Write an \*[Lt]escape\*[Gt] (ESC) character.
 .It Cm \ef
 Write a \*[Lt]form-feed\*[Gt] character.
 .It Cm \en
-- 
2.0.0


--fUYQa+Pmc3FrFX/N--
