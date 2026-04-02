Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D953B19CC
	for <dash@vger.kernel.org>; Thu,  2 Apr 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133726; cv=none; b=nPblctBY9TALZZYA2PD/FT+m8d5iqMkm4p9XcQWHr8aFTLXbQt+k1CnFqMIDJv2uysNAjTEWe7SacIUXXLn4U2YnVkA4i7zjB17HIpUY8jn8x3xVztj+ugyIXucqgi53Coapw9eUbvw6qEiqixTVtDZTfSt2gEYTiA8tw7ssg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133726; c=relaxed/simple;
	bh=lnXg0OHG3/nVpbJ5yQD+1CypKh3VrVygkswXLOBQYcY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ipw9J0QMQokR2Eh2EgYbi3UzzGdUQ/3G1rqRWBGglE9A9BoN22gGUVYePeKe9Z1y+yW70NRV/Zx3cfGnT3kuAoVCOng/AYlGpf6Pjm+g+Z5AHCwrjX0uKVPnSq2vdMoL70h8aR7YSs/eJgSkzKy4czSbioZ3OAf/glFmqlup6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.153]) with ESMTPSA (Nemesis) id 1M4JiJ-1w8YTy0Su1-001ahU for
 <dash@vger.kernel.org>; Thu, 02 Apr 2026 14:41:47 +0200
Received: from zenon.in.qult.net ([192.168.64.1] helo=zenon.qult.net)
	by mail.qult.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1w8HMo-0000000HHLz-2JWO
	for dash@vger.kernel.org;
	Thu, 02 Apr 2026 14:41:46 +0200
Received: from ig by zenon.qult.net with local (Exim 4.98.2)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1w8HMh-00000002LEK-0ibW
	for dash@vger.kernel.org;
	Thu, 02 Apr 2026 14:41:39 +0200
Date: Thu, 2 Apr 2026 14:41:39 +0200
From: Ignacy =?utf-8?B?R2F3xJlkemtp?= <ignacy.gawedzki@green-communications.fr>
To: dash@vger.kernel.org
Subject: [PATCH] Fix EINTR handling when reading from a pipe.
Message-ID: <4k2hzdcp5gi5vgio3njtxttm6lshkzfyl3iz3246yqvx3bdbck@7wb4dopuoxhg>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XLioEgXEYE1i8MuaA7F9VlVaUxXt00TIqYIIkoOhtRyTxBtdvug
 2Jm1GB/3KhBcheMlp67wzg6nb+9zNP7pG/pnulL86c0zFzbJYOH4EHmanecJgxSKfMBiYyw
 fbKHej2Lke1gCpO97hurQRdMbOWUI6oh//rfdzm6psr7cI4UBuxOVGaeIv6kgFyfhI+Tmll
 0ntJ6I2Z3r3is1F1hjY5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p77z15kbi8Y=;eLC0pLdvibX7hcQ5DsfppLp3eer
 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

When using tee to peek at stdin pipe, consider forwarding EINTR
without attempting to read, otherwise signals don't get handled
properly.

Signed-off-by: Ignacy Gawêdzki <ignacy.gawedzki@green-communications.fr>
---
 src/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/input.c b/src/input.c
index 71282fb..8287b95 100644
--- a/src/input.c
+++ b/src/input.c
@@ -324,7 +324,7 @@ retry:
 	if (!fd && !stdin_bufferable()) {
 		nr = stdin_tee(buf, nr);
 		fd = stdin_state.pip[0];
-		if (nr <= 0) {
+		if (nr <= 0 && errno != EINTR) {
 			fd = 0;
 			nr = 1;
 		}
-- 
2.51.0
