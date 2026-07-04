Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07F268690
	for <dash@vger.kernel.org>; Sat,  4 Jul 2026 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783138687; cv=none; b=OzkYuiERuYg5Yco+iz5b7xT6+hEjTnuu4DXtsytJWJ9Y3BtF9A61UZjrkgQAH2AX1YMmo9l+NG2+h5Ir9o612iEzRjMaDkPKc+YnQP2tipBYPRYNRqCSdWkBPVjPnsytD7JNiJoKat9XSkAz6aywZ3N4v9eAAsT8P/QKy8OuMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783138687; c=relaxed/simple;
	bh=NQjXxy7VeSAbfKskO9iuP/Xs1m2WVax683ddCgavuzk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k3XicSzEp5zvGE31E7VXg+CTYg16EEmZZLLXYcSLhU3it6ftzzIhQYImGZLXcdEUA+c3TZEZa8iQ0+BY+BCzMgViZ4FpbWPU+tqG99pltP+65LsFWfF7Xz6KgEBxNRblQA5YWEoqxMPtnhwcCw4E51CNXqk3YzjyVFbPTnnmNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Qj7UTeAL; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Qj7UTeAL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=tRTcz3y9yc66lSByH1XN1VCcvMVff0C0SFshQG+LanA=; b=Qj7UTeAL7lrF4LaWjNr9ImTe7d
	sl9tMBu8kGDi8FSNB0MW2gTiAuDi9uUbaRK9OEZiIovSZjphmKxVpMGVx7dmfkLIu+igKasMwpDuj
	xNvaTQBW8r9yqazNp2hvprecyOAVdwTmMGkX/lYh+3PzZrwEK94Y1Ax6/3j8eLnkWzHM03EhxSkET
	4K9ZJEH+rUbbJyQ4DBbBc5/CbNXT2oTEt0yoL7DwtV8Y/gTSAXVTTsre58QEjRF3TwTPKT5GgGan1
	mJVPFQadGIE5k3lxr3Vx2VjaTOuGc8gDvbmWHVupWssghz7BsCJSWPWIgkPwz1UEWDXQ3QhI2xjjZ
	muS/rQmQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wfrp3-0000000AYAp-1Jmd;
	Sat, 04 Jul 2026 12:17:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 04 Jul 2026 12:17:45 +0800
Date: Sat, 4 Jul 2026 12:17:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org
Subject: [PATCH] builtin: Add CTLESC before all CCTLs in dollar single quote
Message-ID: <akiJaZ9FJZeO9DNZ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c125cdad-746f-4b21-a486-8df226c275b6@inlv.org>
X-Newsgroups: apana.lists.os.linux.dash

Martijn Dekker <martijn@inlv.org> wrote:
> The quoted strings '\\' and $'\\\\' are identical, but the 'case' statement in 
> the current git version of dash does not match them as such.
> 
> Reproducer:
> 
> case '\\' in
> ( $'\\\\' )     echo ok ;;
> ( * )           echo WRONG ;;
> esac

Thanks for the report.  This patch should fix the problem:

---8<---
If a backslash that comes from dollar-single quote escape sequence
is used as a pattern, it should be escaped automatically so that
it's interpreted as a literal backslash, rather than as a quoting
character.

Reported-by: Martijn Dekker <martijn@inlv.org>
Fixes: 776424a8f915 ("parser: Add dollar single quote")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index c2c3615..5355f5d 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -56,6 +56,7 @@ static char  **gargv;
 
 #include "bltin.h"
 #include "parser.h"
+#include "syntax.h"
 #include "system.h"
 
 #define PF(f, func) { \
@@ -350,7 +351,7 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
 
 		value = '\\';
 
-		if (isodigit(ch)) {
+		if (unlikely(isodigit(ch))) {
 			ch = 3;
 			value = 0;
 			do {
@@ -362,8 +363,12 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
 		str--;
 
 check_value:
-		if (mbchar && (signed char)value >= CTL_FIRST &&
-		    (signed char)value <= CTL_LAST)
+		if (SQSYNTAX[(signed char)value] != CCTL)
+			break;
+		/* fall through */
+
+	case '\\':
+		if (mbchar)
 			USTPUTC(CTLESC, out);
 		break;
 
@@ -395,12 +400,12 @@ hex:
 			value += d;
 		} while (--ch);
 
-		if (value < 0x80)
-			break;
-
 		if (och <= 2)
 			goto check_value;
 
+		if (value < 0x80)
+			goto check_value;
+
 		if (value < 0x110000) {
 			int mboff = (mbchar - 1) * 2;
 			unsigned uni = value;
@@ -442,9 +447,6 @@ hex:
 		ch = 4;
 		goto hex;
 
-	case '\\':
-		break;
-
 	case 'a':				/* alert */
 	case 'b':				/* backspace */
 	case 'f':				/* form-feed */
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
