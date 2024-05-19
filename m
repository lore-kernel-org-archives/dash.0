Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272731A89
	for <dash@vger.kernel.org>; Sun, 19 May 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716117597; cv=none; b=DTt9BSzoB2odQjSrEfT4yppNJSAcr/H+9IylxgR2De+L0ctZq0O6/D1uvs3D12XDLI8pNYsw0lWfLWodBozRhVCKpCOEbGmG1j5Inm+QQlpE3JNINVbUBMA3WgJDvxsfGPI2i0YX3nUWA9QwFrhFh1hxcoOjH1hEge1agBOa3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716117597; c=relaxed/simple;
	bh=VFb/d/LYEQ3n5pvhyXNhA3aRVH4WE1LnhEFakOvlJ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTT7BUMy5RfCWKONJVVTv4+FigCU75am7JBVwKhHgbw6qtoeZI453bSws8ImpgccgVBec8QuffBJGXWPK2qkWJotQyzMr9HuIZWa4yB3S+PTtIHpUldwe2ingvfx/ZYgtGY3S4I0Lnv4Hts/EAIzPZKLeuUsYWRbpo7taa+fBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8eZg-00HJWT-0K;
	Sun, 19 May 2024 19:19:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 19:19:33 +0800
Date: Sun, 19 May 2024 19:19:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
	dash@vger.kernel.org, 985478@bugs.debian.org
Subject: [PATCH] options: Always reset OPTIND in getoptsreset
Message-ID: <ZkngRVxkiUil_9aG@gondor.apana.org.au>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
 <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
 <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
 <20230104160526.7vuq3s2ivqaaot4l@tarta.nabijaczleweli.xyz>
 <b00cdaa5-0072-392c-3cf7-184aa8e45ae3@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b00cdaa5-0072-392c-3cf7-184aa8e45ae3@gigawatt.nl>

On Wed, Jan 04, 2023 at 04:50:34PM +0000, Harald van Dijk wrote:
>
> Personally, I do think it is better if shells allow assigning arbitrary
> values to OPTIND, including unsetting it, and only have the getopts command
> raise an error if the value is non-numeric, but that is my personal opinion
> and I don't see much of a problem if dash decides to go the other way,
> unless POSIX makes it explicit that it is not permitted for shells to do
> this. FWIW, I did make that change for my version, <https://github.com/hvdijk/gwsh/commit/0df0ba33748eb3881b07cb724fd4fa54422ef2bc>,
> if that change is desired for dash it is easy to apply.

I've decided to make getoptsreset always do the reset, regardless
of the value of OPTIND.  Why else would you assign it anyway?

---8<---
Always reset OPTIND if it is modified by the user, regardless of
its value.

Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/options.c b/src/options.c
index 4d0a53a..c74e4fe 100644
--- a/src/options.c
+++ b/src/options.c
@@ -393,7 +393,7 @@ setcmd(int argc, char **argv)
 
 void getoptsreset(const char *value)
 {
-	shellparam.optind = number(value) ?: 1;
+	shellparam.optind = 1;
 	shellparam.optoff = -1;
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
