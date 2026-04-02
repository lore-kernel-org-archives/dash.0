Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E13BE63B
	for <dash@vger.kernel.org>; Thu,  2 Apr 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138351; cv=none; b=Btd9jzUGuRKMUWQjbvM5iXQb2/Q4VIF2lq+TgtdEEaljUxfHjNsNUyJJbVdl86LF5AljPRl4fH8FuMwOrj15lIEQ+w3VHhiQVCtVhnDx3CW3Y0hYvABHwN5MB+Q11Hg4F1F3rlkCjOFGGQawDeJbEjphrV4J/c/Xl3lJCNe5Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138351; c=relaxed/simple;
	bh=eCGbt4p9mTgAM5P6xFie0M4LvJosV1tNxgrCCToZIaE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QokZAl8Hx4Ox0dNsZcV+KfkidwNtgQGkx2fjGSX2m09fg/O20/ZCSIaLQEfUD0BDhCuBULCnhB8LKBlo3016RgDbsmHy97Ml2dr2m80RPVASDQicyaxjPlw9BTvMtPrrKAB9umh9gq4JcEX9bZyF6mnnu4xxrNISuGBIu4z+pzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1MGyl3-1wLAbZ3dFD-00EzFa for
 <dash@vger.kernel.org>; Thu, 02 Apr 2026 15:59:06 +0200
Received: from zenon.in.qult.net ([192.168.64.1] helo=zenon.qult.net)
	by mail.qult.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1w8IZe-0000000HOkP-1Qnc
	for dash@vger.kernel.org;
	Thu, 02 Apr 2026 15:59:06 +0200
Received: from ig by zenon.qult.net with local (Exim 4.98.2)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1w8IZb-00000002edq-147u
	for dash@vger.kernel.org;
	Thu, 02 Apr 2026 15:59:03 +0200
Date: Thu, 2 Apr 2026 15:59:03 +0200
From: Ignacy =?utf-8?B?R2F3xJlkemtp?= <ignacy.gawedzki@green-communications.fr>
To: dash@vger.kernel.org
Subject: [PATCH v2] Fix EINTR handling when reading from a pipe.
Message-ID: <4e543oogxlemxnvt7kfbk3s7bugimyiza34kgbq7srofw7qu5i@b6atfz2nfkht>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QKBYdqoEDObXYJDnbAodapcU6d46ssuyo/DJ5cLiG/QxkhMjGTF
 UPpvDZBOYFhdFOx/tUS71GrlY6YHJEBCnz6ZgAaOsZ4PIdaqYEgkS3B5fV4ngtXVPs3yPmy
 NfJLYSvdDqlcXQJO0JouxCh2K9u2TOURDWQuSMsKZw15ID3ghtHb+yzMJWpU10GGd9JWKIg
 NYjViysVp4Kg0p+ErQsJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HKnvKY7avD8=;LbEE6XZHSy+Y4azgc80+lsuxsFn
 IsMDC6F/tQATEEluF0VBADf26ECWBYkJEpsPlHNPOEBT/GHm+ROp3kJlkLAyUgNtTF+pJzuYC
 qUjZJ9+Lr/iVbuGuo16JIcxUZO9yVf2/wbOAhIGHyWFbhTDboeje9Qaut8Ndg+wlgUIv6oNM4
 QtH+Hf1WcO1nMjM732OPrjzYRpGzZhUnE3SY3l637mKgBvsmbmTtH8ebPRJX10WBWdA+jJa2c
 j03wDWflbW0x1o6NgIwtMyigGCXXXXgFQWRIj0fsGnzUSEAsHmnPuryrt7+KuY6viIT+U+0MX
 oJc5HRaiJCcnnZVy1MZnXQ5aKX1zxr15bC2cpS51ah1sa25CKowxCYU3WG4OPeb/P4AM6KVUp
 l2987XbHTmb06qqyfJl8mY+VyPuwD9aCXsSoT6qqrVvau7vEtnfEKRVrhfOCYU1aCCMJKG4kW
 Yc+aZ40Sfeioz3SeKTXQ/qmOBLZ3oGaTHn8voA3dTydDUotPjV8LUUM/kM6L88OHPNCq6LnbQ
 DSBQGPW8hBo4VgA30ljDMATwJiL79wtMEeD7ZAt0gQ7KQ3PM4PHO1ZdeUnlvcS9zEyPybfAO5
 eR8ZFhj1nxPbLLXCqJpbODZP2tdj3sHQkLUIRHgIq6UYaRQjq2t3gpueGy0VD9pQKe4BAZ4sU
 qU06l04IxrO4Oq6UvarpNjON2kNae9WvpbGaD/tpdxkuvqb5n42gmIKQ+Dklh4BJAWDFnljEb
 98abO8u+iZJRflwZtkcLgrcXB85oohB4IOh8alc3guc6pppcQuT6ojSqfNnau/6i1E+MINJ1y
 8F+iztJCItiMSULuMIAOB+eY+kd+BIm2FQQXIYkb+wFvp5HiJf4TPvOL7+yvJexRuJCs+loSC
 gvPkcRLXiB9ybPKqp49a40mdjQkvHLk5QclMtMHkpWV2iBClzCEkx7CpVJ6Q9tH8xpcGhXbBn
 9+lU9ivX4he8jtwdyRwy+Jh16dYslHVDnkWthF0YcswOlmhn61ODTIjdYJ/kTCRlANe0IAtJX
 0akw9BT4B3JHtIRFJPDEMEZZXq2YxTNdtQncKZjzBQdvFRIoe+LRx8oKbgE4m99AyMoWHqPl8
 WtREbX0lkj31otmEy81eSzzOuMQ6ZJMApnXNmnk1fV1YNDe97+V+fESRlJsZOiI8rv9fehtZx
 S5uzEzLNza4GkaEDffd8ZZtPnYtfB+YY1pGs2PNxwL1y2mqIqk98+hSrtY3srg9jQBGWaTNWM
 QNAZmHsyPY9d+Di2HG4d1Oltax8GLISrY3w5i3VXFjAiULBX8FZhzvTRpuNVEAxYjtRsGdeeu
 aPwPcVdgFDLYRKB7UYlCwbATUrGFgEnnAY6S/eg4P8Mtq1TLI6U4I7iy1ZSHbk37mw+MQz/D+
 bctOzRD4lNzVIOBjYHfJdXTFDJPz2gxqtmsDQkULwuvPfUsGBd+kci8xGt4g/7ANZfW9cuIsh
 i4R/HRFgS30A95hjyWiBbnPWsmcQUi4aeNh2VJzWT5VRQbEi4ur+ZjuFP/nYA/9mdOA7Umjks
 1ZFsz7kgBdJ0nbf7OEghEkG5Lp36Tmub1QVJBC85jpvWIPue30qJQdSMhY9/iSpEpovpy5t1u
 8EiM9YwVBy4eh2zQsklLIz/G7Y7eMVQ1Xag8kW+fE9OJTqzN/lsjkjlJbWYT1Zd5VhHAgFQ6M
 qh6ZgFg7TJctEyJ/UVGWVu9hF2XbhbXwCfVZh/TwXy/Kne31waj31O9jWIv3u49i1SJkUVtfV
 /ooyOmZA96Vs3vWhfFFB4UEd/xMvwuGF9g9vmmoTzsP4Etgzy5cwo7s52wqExJU0T+6OycmYQ
 tAZ30Hf0fguAm94zQYhq6uBHbDk+pE1g6fYMy7criQ68y4DtBLQcNVSfhi/a6wqO1oVPwMjr6
 BzUjrBCJmH8oBSBeflFp09ckVzZq2Hco0yrU36SPsqj0IFIHsJr7izlp8DI

When using tee to peek at stdin pipe, consider forwarding EINTR
without attempting to read, otherwise pending signals don't get
handled properly.

Signed-off-by: Ignacy Gawêdzki <ignacy.gawedzki@green-communications.fr>
---
 src/input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/input.c b/src/input.c
index 71282fb..fd5c36f 100644
--- a/src/input.c
+++ b/src/input.c
@@ -323,11 +323,11 @@ retry:
 
 	if (!fd && !stdin_bufferable()) {
 		nr = stdin_tee(buf, nr);
-		fd = stdin_state.pip[0];
-		if (nr <= 0) {
+		if (nr == 0 || (nr < 0 && errno != EINTR)) {
 			fd = 0;
 			nr = 1;
-		}
+		} else
+			fd = stdin_state.pip[0];
 	}
 
 	if (nr >= 0)
-- 
2.51.0
