Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6302AC433E0
	for <linux-dash@archiver.kernel.org>; Wed, 10 Feb 2021 09:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F8E64E40
	for <linux-dash@archiver.kernel.org>; Wed, 10 Feb 2021 09:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBJJen (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 10 Feb 2021 04:34:43 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:40142 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBJJcK (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 10 Feb 2021 04:32:10 -0500
Received: from [94.25.26.27] (IDENT:1000@dzo.simtreas.ru [94.25.26.27])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 11A9VC5k009990
        for <dash@vger.kernel.org>; Wed, 10 Feb 2021 13:31:12 +0400
Subject: Re: ${#a#a} bug?
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
To:     dash@vger.kernel.org
References: <7d15a038-2dc1-ae08-3091-97e3d356fdc3@simtreas.ru>
Organization: Ulyanovsk Treasury
Message-ID: <313e78ef-747a-2582-6cad-bdc2c9decd92@simtreas.ru>
Date:   Wed, 10 Feb 2021 13:31:13 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <7d15a038-2dc1-ae08-3091-97e3d356fdc3@simtreas.ru>
Content-Type: multipart/mixed;
 boundary="------------7539C1A0A1A6A3BCBE5FCA03"
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [10.68.0.1]); Wed, 10 Feb 2021 13:31:12 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------7539C1A0A1A6A3BCBE5FCA03
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Vladimir N. Oleynik wrote:

> $ a=abc
> $ echo ${#a#a}
> 
> dash-0.5.11.3 produce:
> 3a
> bash:
> ${#a#a}: bad substitution

Ok. I rewrote the var substitutions parser.
Its now:
* strong find bad substitution
* support indirections ${!var}
* may be good skip unsupport syntax: ${v/p/x} ${v//p/x} ${v:offs:l} ${v@trans}
   ${!prev*} ${!prev@} and mark as "bad substitution".
   my variant of parser.c ready for parse this syntax,
   but expand.c very knotty for me for realize this syntax.
* also small simplify for expand $- :)

--w
vodz

--------------7539C1A0A1A6A3BCBE5FCA03
Content-Type: text/x-patch;
 name="substitute.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="substitute.diff"

--- expand.c.orig	2021-02-08 23:23:54.000000000 +0400
+++ expand.c	2021-02-10 12:58:11.508816065 +0400
@@ -854,6 +854,9 @@
 		      (flags & EXP_DISCARD);
 	ssize_t len = 0;
 	char c;
+	char str_opts[NOPTS + 1];
+	int len_for_num = max_int_length(sizeof(int));
+	char str_num[len_for_num];
 
 	if (!subtype) {
 		if (discard)
@@ -866,6 +869,7 @@
 	flags &= discard ? ~QUOTES_ESC : ~0;
 	sep = (flags & EXP_FULL) << CHAR_BIT;
 
+again:
 	switch (*name) {
 	case '$':
 		num = rootpid;
@@ -881,18 +885,16 @@
 		if (num == 0)
 			return -1;
 numvar:
-		len = cvtnum(num, flags);
-		break;
+		fmtstr(p = str_num, len_for_num, "%d", num);
+		goto value;
 	case '-':
-		p = makestrspace(NOPTS, expdest);
 		for (i = NOPTS - 1; i >= 0; i--) {
-			if (optlist[i] && optletters[i]) {
-				USTPUTC(optletters[i], p);
-				len++;
-			}
+			if (optlist[i] && optletters[i])
+				str_opts[len++] = optletters[i];
 		}
-		expdest = p;
-		break;
+		str_opts[len] = 0;
+		p = str_opts;
+		goto value;
 	case '@':
 		if (quoted && sep)
 			goto param;
@@ -945,9 +947,37 @@
 		goto value;
 	default:
 		p = lookupvar(name);
-value:
 		if (!p)
 			return -1;
+value:
+		if (subtype == VSINDIRECT) {
+			char *v;
+			int ok = 0, alpha = 0;
+
+			for (v = p; *v; v++) {
+				if (is_name(*v)) {
+					if (alpha < 0)
+						goto errv;
+					 else
+						alpha = 1;
+				} else if (isdigit(*v)) {
+					if (!alpha) alpha = -1;
+					else if (alpha == -2) goto errv;
+				} else if (ok == 0 && is_special(*v)) {
+					alpha = -2;
+				} else {
+			errv:
+					ok = 0; break;
+				}
+				ok = 1;
+			}
+
+			if (!ok)
+				sh_error("Bad variable name for indirect");
+			name = p;
+			subtype = 0;
+			goto again;
+		}
 
 		len = strtodest(p, flags);
 		break;
--- parser.h.orig	2021-02-10 01:47:34.000000000 +0400
+++ parser.h	2021-02-10 13:13:59.276818541 +0400
@@ -48,20 +48,25 @@
 #define CTL_LAST -120           /* last 'special' character */
 
 /* variable substitution byte (follows CTLVAR) */
-#define VSTYPE  0x0f            /* type of variable substitution */
-#define VSNUL   0x10            /* colon--treat the empty string as unset */
-
+#define VSTYPE          0x0f    /* type of variable substitution */
+#define VSNUL           0x10    /* colon+VSTYPE -- treat the empty string as unset,
+				   or unrealized ${var:offset[:lenght]} */
+#define VSBADSUB        0       /* bad substitunion */
 /* values of VSTYPE field */
-#define VSNORMAL        0x1             /* normal variable:  $var or ${var} */
-#define VSMINUS         0x2             /* ${var-text} */
-#define VSPLUS          0x3             /* ${var+text} */
-#define VSQUESTION      0x4             /* ${var?message} */
-#define VSASSIGN        0x5             /* ${var=text} */
-#define VSTRIMRIGHT     0x6             /* ${var%pattern} */
-#define VSTRIMRIGHTMAX  0x7             /* ${var%%pattern} */
-#define VSTRIMLEFT      0x8             /* ${var#pattern} */
-#define VSTRIMLEFTMAX   0x9             /* ${var##pattern} */
-#define VSLENGTH        0xa             /* ${#var} */
+#define VSNORMAL        0x1     /* normal variable:  $var or ${var} */
+#define VSMINUS         0x2     /* ${var-text} */
+#define VSPLUS          0x3     /* ${var+text} */
+#define VSQUESTION      0x4     /* ${var?message} */
+#define VSASSIGN        0x5     /* ${var=text} */
+#define VSTRIMRIGHT     0x6     /* ${var%pattern} */
+#define VSTRIMRIGHTMAX  0x7     /* ${var%%pattern} */
+#define VSTRIMLEFT      0x8     /* ${var#pattern} */
+#define VSTRIMLEFTMAX   0x9     /* ${var##pattern} */
+#define VSLENGTH        0xa     /* ${#var} */
+#define VSINDIRECT      0xb     /* ${!var} */
+#define VSPATERN        0xc     /* ${var/pattern/string}  unrealized */
+#define VSPATERNALL     0xd     /* ${var//pattern/string} unrealized */
+#define VSTRANS         0xe     /* ${var@transformation}  unrealized */
 
 /* values of checkkwd variable */
 #define CHKALIAS        0x1
--- parser.c.orig	2021-02-10 01:47:50.000000000 +0400
+++ parser.c	2021-02-10 12:47:27.609814383 +0400
@@ -1235,8 +1235,9 @@
 parsesub: {
 	int subtype;
 	int typeloc;
-	char *p;
-	static const char types[] = "}-+?=";
+	const char *newsyn;
+	int lenght;
+	int alpha;
 
 	c = pgetc_eatbnl();
 	if (
@@ -1246,6 +1247,7 @@
 	) {
 		USTPUTC('$', out);
 		pungetc();
+		goto parsesub_return;
 	} else if (c == '(') {  /* $(command) or $((arith)) */
 		if (pgetc_eatbnl() == '(') {
 			PARSEARITH();
@@ -1253,113 +1255,176 @@
 			pungetc();
 			PARSEBACKQNEW();
 		}
-	} else {
-		const char *newsyn = synstack->syntax;
+		goto parsesub_return;
+	}
+
+	newsyn = synstack->syntax;
+	USTPUTC(CTLVAR, out);
+	typeloc = out - (char *)stackblock();
+	STADJUST(1, out);
 
-		USTPUTC(CTLVAR, out);
-		typeloc = out - (char *)stackblock();
-		STADJUST(1, out);
+	if (c != '{') {
 		subtype = VSNORMAL;
-		if (likely(c == '{')) {
-			c = pgetc_eatbnl();
-			subtype = 0;
-		}
-varname:
-		if (is_name(c)) {
-			do {
-				STPUTC(c, out);
-				c = pgetc_eatbnl();
-			} while (is_in_name(c));
-		} else if (is_digit(c)) {
+		if(is_special(c)) {
+			/* $[!#$*-0123456789?@] */
+			STPUTC(c, out);
+		} else {
+			/* found simple $var */
 			do {
 				STPUTC(c, out);
 				c = pgetc_eatbnl();
-			} while (!subtype && is_digit(c));
-		} else if (c != '}') {
-			int cc = c;
+			} while(is_in_name(c));
+			pungetc ();
+		}
+		goto eov;
+	}
 
+	subtype = lenght = alpha = 0;
+	c = pgetc_eatbnl();
+	if (c == '#') {
+		/* very special */
+		c = pgetc_eatbnl();
+		if (is_in_name(c) || (is_special(c) && c != '#')) {
+			/* lenght($var) */
+			subtype = VSLENGTH;
+			goto varc;
+		}
+		if (c != '#') {
+			/* $# and may be mods */
+  var_is_num_arg:
+			pungetc ();
+			c = '#';
+			goto var_spec;
+		}
+		/* ${##... */
+		c = pgetc_eatbnl();
+		if (c == '}') {
+			/* ${##} as lenght($#) */
+			subtype = VSLENGTH;
+			goto var_is_num_arg;
+		}
+		/* ${##(#)[#]*...} as (max)stripleft($#, [#]*...) */
+		pungetc ();
+		STPUTC('#', out);
+		c = '#';
+		goto var_num_sub;
+	} else if (c == '!') {
+		c = pgetc_eatbnl();
+		if ((is_special(c) && c != '@' && c != '*') || is_in_name(c)) {
+			/* ${!var} */
+			subtype = VSINDIRECT;
+			goto varc;
+		} else {
+			/* $! and may be mods */
+			pungetc ();
+			c = '!';
+			goto var_spec;
+		}
+	}
+	while (1) {
+		if (c == '}') {
+			if (!lenght)
+				subtype = VSBADSUB; /* bad: ${} */
+			if (subtype)
+				pungetc ();
+			else
+				subtype = VSNORMAL;
+			goto eov;
+		}
+	  varc:
+		if (is_name(c)) {
+			if (alpha < 0)
+				subtype = VSBADSUB;     /* bad: ${ [!#]? [0-9]*|specvar and _alpha* */
+			else
+				alpha = 1;
+		} else if (isdigit(c)) {
+			if (!alpha) alpha = -1; /* ${ [!#]? [0-9]* and _alpha* -> bad */
+			else if (alpha == -2) subtype = VSBADSUB; /* bad: ${ [!#]? and specvar and [0-9]* */
+		} else if(!lenght && is_special(c)) {
+	  var_spec:
+			alpha = -2;     /* ${ [!#]? and specvar and is_in_name* -> bad */
+		} else
+			break;
+		STPUTC(c, out);
+		lenght = 1;
+		c = pgetc_eatbnl();
+	}
+	if (!subtype) {
+  var_num_sub:
+		lenght = 0;
+		switch (c) {
+		case '#': subtype = VSTRIMLEFT;  lenght = 2; break;
+		case '%': subtype = VSTRIMRIGHT; lenght = 2; break;
+		case '/': subtype = VSPATERN;    lenght = 2; break;
+		case '@': subtype = VSTRANS;     lenght = 1; break;
+		}
+		if (lenght) {
+			if (lenght == 2) {
+				if (c == pgetc_eatbnl())
+					subtype |= 1;
+				 else
+					pungetc ();
+			}
+			newsyn = BASESYNTAX;
+			goto eov;
+		}
+		if (c == ':') {
 			c = pgetc_eatbnl();
-
-			if (!subtype && cc == '#') {
-				subtype = VSLENGTH;
-
-				if (c == '_' || isalnum(c))
-					goto varname;
-
-				cc = c;
-				c = pgetc_eatbnl();
-				if (cc == '}' || c != '}') {
-					pungetc();
-					subtype = 0;
-					c = cc;
-					cc = '#';
-				}
+			if (c == '}') {
+				/* ${var:} bad: empty expr syntax eq 0,
+				   but for ${@}/${*} default is 1
+				   its a conflict, simple - set as error */
+				subtype = VSBADSUB;
+				pungetc ();
+				goto eov;
 			}
-
-			if (!is_special(cc)) {
-				if (subtype == VSLENGTH)
-					subtype = 0;
-				goto badsub;
+			subtype = VSNUL;
+		}
+		{
+			static const char types[] = "-+?=";
+			const char *p = strchr(types, c);
+
+			if (p != NULL) {
+				subtype |= VSMINUS + (p - types);
+				goto eov;
 			}
+		}
 
-			USTPUTC(cc, out);
-		} else
-			goto badsub;
-
-		if (subtype == 0) {
-			int cc = c;
-
-			switch (c) {
-			case ':':
-				subtype = VSNUL;
-				c = pgetc_eatbnl();
-				/*FALLTHROUGH*/
-			default:
-				p = strchr(types, c);
-				if (p == NULL)
-					break;
-				subtype |= p - types + VSNORMAL;
-				break;
-			case '%':
-			case '#':
-				subtype = c == '#' ? VSTRIMLEFT :
-						     VSTRIMRIGHT;
-				c = pgetc_eatbnl();
-				if (c == cc)
-					subtype++;
-				else
-					pungetc();
-
-				newsyn = BASESYNTAX;
-				break;
-			}
+		pungetc ();
+		if (subtype == VSNUL) {
+			newsyn = ARISYNTAX;     /* ${var:offset[:lenght]} */
 		} else {
-badsub:
-			pungetc();
+			/* unknown char for subtype==VSNORMAL */
+			subtype = VSBADSUB;
 		}
+	} else {
+		/* expected '}' but unknown char for subtype==lenght|indirect */
+		subtype = VSBADSUB;
+		pungetc ();
+	}
 
-		if (newsyn == ARISYNTAX)
-			newsyn = DQSYNTAX;
+ eov:
+	if (subtype == VSBADSUB)
+		newsyn = BASESYNTAX;
 
-		if ((newsyn != synstack->syntax || synstack->innerdq) &&
-		    subtype != VSNORMAL) {
-			synstack_push(&synstack,
-				      synstack->prev ?:
-				      alloca(sizeof(*synstack)),
-				      newsyn);
-
-			synstack->varpushed++;
-			synstack->dblquote = newsyn != BASESYNTAX;
-		}
-
-		*((char *)stackblock() + typeloc) = subtype;
-		if (subtype != VSNORMAL) {
-			synstack->varnest++;
-			if (synstack->dblquote)
-				synstack->dqvarnest++;
-		}
-		STPUTC('=', out);
+	if ((newsyn != synstack->syntax || synstack->innerdq) && subtype != VSNORMAL) {
+		synstack_push(&synstack, synstack->prev ?: alloca(sizeof(*synstack)), newsyn);
+
+		synstack->varpushed++;
+		synstack->dblquote = newsyn != BASESYNTAX;
+	}
+
+	/* unrealized -> to VSBADSUB */
+	if (subtype == VSNUL || subtype == VSPATERN || subtype == VSPATERNALL || subtype == VSTRANS) {
+		subtype = VSBADSUB;
+	}
+	*((char *)stackblock() + typeloc) = subtype;
+	if (subtype != VSNORMAL) {
+		synstack->varnest++;
+		if (synstack->dblquote)
+			synstack->dqvarnest++;
 	}
+	STPUTC('=', out);
 	goto parsesub_return;
 }
 

--------------7539C1A0A1A6A3BCBE5FCA03--
