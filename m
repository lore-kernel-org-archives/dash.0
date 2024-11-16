Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C72F29
	for <dash@vger.kernel.org>; Sat, 16 Nov 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756114; cv=none; b=qj0307SySbH1JwHBeHQ+CRq70wERhyugG7qjWxcRzsjVqUW+27ovb8BD9xZUtSCMeyQCYRQURDt1qyo+X42x2IlKlewyjcNc0AQs3KwVa2aylwPNDDf6YUnhMRpPgUYcjxZN6iat3uIqr+yNW1kZLhO2Cby3oHOLo2kSPtWy7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756114; c=relaxed/simple;
	bh=GHLOPdunf7zD+TKvhFPF4rd5zxd88lUZqq4florMznU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rREKj4pn6CP+H34IQWMp8u0bvMRvGLFlBVsTQpQw3nk81m+k7m/X0hIaP+b544ZM6qqMwUDNTyjP2ILmS+DsAxGAHkVe3RSTwWDkWLVhigTjz/9964GPxhz+f1T+Ac24OpIWxSWw0MxG2pjTXT0ZWSigxIQ89+98gjMShEqzoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=cPAbxwLT; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="cPAbxwLT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0PA/Xnx+vbxKk5Hy3wZ/tcJRYsOAm2MUZjESjoSHPZY=; b=cPAbxwLTK1bQk45eciTSdb2P+L
	OJtKRvxAUeNPF3pG+EPN/qgdpIQZXXaIQH5CBou6OcuqkCOXF0Vh09mtVTZ4jKZPZ0yYasjslcMsy
	u72OkKaR3n5iQTeBnODoakb5ZaladAt5wUWOF4Om4Jw3VkOEoUZ91yhFQuUgNIUp7w9JMltPV3RlB
	qkSF8+BitL9k1HvknqbYLXNjRGeVdJxDPbAQwyeZy9xFTAty4KuZcIgM7L8GPPzNqROGoL+ZVpoc4
	Kx0tGhPd5gKT4hfsC2kevkarUZXw6DjkVLe1RVOwuZFel9sULXx3KZtl6HXyqgUhOch69uED6e2OH
	lsf+aBfg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCGs6-00HGRJ-1x;
	Sat, 16 Nov 2024 19:21:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 16 Nov 2024 19:21:46 +0800
Date: Sat, 16 Nov 2024 19:21:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] builtin: Reduce size of conv_escape
Message-ID: <ZziAShiLhciUX_FJ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The jump table is unnecessarily large for a function that is
not performance-critical.  Move some of the cases out of the
switch statement to reduce its size.

Move the value = ch assignment to the common path.

Merge the code for '\a', '\b' and '\f'.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 46c6295..ff576ff 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -335,21 +335,29 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
 	int ch;
 
 	ch = *str;
+	value = ch;
 
 	switch (ch) {
 	default:
-		if (!isodigit(ch)) {
-			value = '\\';
-			str--;
+		if (ch == '"' || ch == '\'')
 			break;
+
+		if (ch == 'U') {
+			ch = 8;
+			goto hex;
+		}
+
+		value = '\\';
+
+		if (isodigit(ch)) {
+			ch = 3;
+			value = 0;
+			do {
+				value <<= 3;
+				value += octtobin(*str++);
+			} while (--ch && isodigit(*str));
 		}
 
-		ch = 3;
-		value = 0;
-		do {
-			value <<= 3;
-			value += octtobin(*str++);
-		} while (--ch && isodigit(*str));
 		str--;
 		break;
 
@@ -424,20 +432,17 @@ hex:
 		ch = 4;
 		goto hex;
 
-	case 'U':
-		ch = 8;
-		goto hex;
-
 	case '\\':
-	case '\"':
-	case '\'':
-		value = ch;
 		break;
 
-	case 'a':	value = '\a';	break;	/* alert */
-	case 'b':	value = '\b';	break;	/* backspace */
+	case 'a':				/* alert */
+	case 'b':				/* backspace */
+	case 'f':				/* form-feed */
+		value -= 'a';
+		value += '\a';
+		break;
+
 	case 'e':	value = '\033';	break;	/* <ESC> */
-	case 'f':	value = '\f';	break;	/* form-feed */
 	case 'n':	value = '\n';	break;	/* newline */
 	case 'r':	value = '\r';	break;	/* carriage-return */
 	case 't':	value = '\t';	break;	/* tab */
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
