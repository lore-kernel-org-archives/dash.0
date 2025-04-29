Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5126D4D5
	for <dash@vger.kernel.org>; Tue, 29 Apr 2025 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963283; cv=none; b=ixFNJAmK8DRe2TIiN/gVV9KJJj9fYG4/1lry49tH1X/6ickN2TQdsi+YoorGBkPyPfDGEJa1bSRySHm/lFW5gx5CwwJ2t5ZYeCAk4rmA8oAEObxlv60VwVTha/48JN2PbtV3NUE3mBcAj2O4blaEogvNwjB/0CpG1b8+llLtLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963283; c=relaxed/simple;
	bh=dbDo+Al471qI+zBH7J1yDbXalVPJMJw7D5GG27x8LFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws/V9ddxzMJlZ8jb21BOSjiss1XHSasHENhdU0kabroXXhbwlAzg593jTLB6Hd22l4Nzxls/ekEnp37deK+JoooclDJBbODE+AhtFCT6Exr7iUBX5ZguShTfw174yPzRusJDH5ZN17xAKbedKdKdSXfTyjxYeF1AsWA4w7z9avM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD1NV1hz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD1NV1hz"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25520a289so1042922366b.3
        for <dash@vger.kernel.org>; Tue, 29 Apr 2025 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745963280; x=1746568080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDiSKGFbVDMTyD7eh1AmrmrnJI6+1+msmpBaJ6afHkI=;
        b=GD1NV1hzls/PAUAJgkUy9CHHl9MCGzZfOBGjdSk3ZGutbDsG4W6BHc5ehlfXrzRrH9
         G9+xpyYuWv92riMjtko0KQuHMun56jeNzx+04V6ZRZ1VYsebEISeKwLRjM+0rDcx2Yqj
         RPQ53lp7OI5a4Br6GDZEzJJgBZhsvOpWabRLgetINq+klCj5JKYNt41ot+Qss3dSlhRH
         tze3iqPHJF9SF/uOkUAzCBm6D8vNt4uniSbf6tY++GBMJ9tvbCHcFWDP2RH9ag8PQFOf
         68fe9hAaU896vCbOlwtKyea1DGVT9EUTDPU9FLbn066UUl4cSExaXr2NumzBNaftkakJ
         a/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745963280; x=1746568080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDiSKGFbVDMTyD7eh1AmrmrnJI6+1+msmpBaJ6afHkI=;
        b=qJTIp5h5mUWK9MfB882elgHYc1vmi+V7ZGOwwIDyPFeHnDVruz86X+8aWs1KzkGXxb
         oZuiqjAgFK/NLbD+d3c6ERnrTHvyY5YiJIKMXYaq1OPbuymqPGi53VF+2YY5nLbUmkXo
         BaYA4mGoeTHFdaWDRe+DQz++Iy/VCLSnyeXbgAHNV5ZtE//Q9k8+9ECkpKECG8ljaFRN
         qwpDGb+LI0m/Ekq4SweXyW1TUnlJWW3whhEgRWQVwXYPB4CVRw/j8E7109vTBabTUsaf
         gtn1DdArPaDLcKgzQtrtrq5Uk6CCyWQEXq35y3jzzSclxnAhcTeukM+2ESYWtgaisKdP
         9AkA==
X-Gm-Message-State: AOJu0YxM3mFxkYkE1VgU63w1in1hDGVxJbSHuGs6NgWSZEP09y/p/AEo
	W5FJ63tdw2fPzRkpbKdGdiDVl9cW7Bc96y0h89X5aSInHLiULe2DhRCxUQ==
X-Gm-Gg: ASbGncsDJzd9RRZfCHLMqnpXoF3Mer9tHPwKict7Htu1DDPDKc88GSrqtHmYqnsa0YV
	lnGyxLRqkfZmSTQxIQn4Q+QX0aD1kC+zAUei5RIkZ0bcYpfi8d59A4QNecL0bvDdSsVDBAW+Zic
	Y3+hj5yOupAOR1K0vkjNS+WAeVbNWUMWJgCN2EVH97NU+754X1lU1RkBBb2te57wLdUfz9tvFBi
	UgJbOgukR8XGmtDMLgEbGDL90ICC91r3tipi8aELYtu4PCnxAXM/CHyVXwkeSymkzBGlTzsfxbJ
	HUKUHQtqcZS6YFJWJfumkvcnslipNtEijx1EDfM5b+cpxddzynPTzEHAHcgnwzbWoTFvbzsnYW6
	fk22SK4y1wbmHmA==
X-Google-Smtp-Source: AGHT+IGfjYPyv3BTHEC2rrdihqmyLXcIQSDaST9L5xUeJQvqtUSSW/UWCDu0UNO8cx4Qpo3nFk6FMQ==
X-Received: by 2002:a17:907:97d1:b0:aca:cac7:28e2 with SMTP id a640c23a62f3a-acedc7001a6mr78765066b.40.1745963280038;
        Tue, 29 Apr 2025 14:48:00 -0700 (PDT)
Received: from localhost.localdomain (92-70-146-242.biz.kpn.net. [92.70.146.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1abdsm850984266b.177.2025.04.29.14.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:47:59 -0700 (PDT)
From: Zurab Kvachadze <zurabid2016@gmail.com>
To: dash@vger.kernel.org
Cc: Zurab Kvachadze <zurabid2016@gmail.com>
Subject: [PATCH 1/2] expand: Fix negative size parameter to memmove in subevalvar()
Date: Tue, 29 Apr 2025 23:47:31 +0200
Message-ID: <20250429214732.22390-2-zurabid2016@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250429214732.22390-1-zurabid2016@gmail.com>
References: <20250429214732.22390-1-zurabid2016@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bug was reported on the mailing list that causes dash to segfault on
the following cmdline:

        dash -c 'echo test > "${1%.in}"' sh /tmp/META.in

This is caused by a memory corruption resulting from a bug in
scanright(). The function returns a pointer to string A, but later in
subevalvar() that pointer is subtracted from the base of string B (which
address is less than the address of A's substring). This produces a
negative integer which is later happily passed as a parameter to
memmove. The correct behaviour for the function is to return a pointer
to a substring of string B.

This erroneous behaviour is caused by the fact that under certain
conditions (FNMATCH_IS_ENABLED being undefined) scanright() iterates
over the pattern string (that the string A in the example above - startp
in the function), when it is meant to iterate over the string with
removed escapes (string B - rmesc in the function).

Due to the fact that if FNMATCH_IS_ENABLED is undefined, each for loop
iteration sets loc2 (initially pointing to str. B's end - rmescend) to
loc (initially pointing to str. A's end - endp), which is not the
desired behaviour.

This commit slightly changes the for loop header to make its behaviour
correct for any value of FNMATCH_IS_ENABLED, thus fixing the root issue.

Fixes: https://lore.kernel.org/dash/CWLP265MB4157446AD56C013BB88575CFBCA82@CWLP265MB4157.GBRP265.PROD.OUTLOOK.COM/
Reported-by: Kate Deplaix
Signed-off-by: Zurab Kvachadze <zurabid2016@gmail.com>
---
 src/expand.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index d73f29c..171c135 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -645,8 +645,7 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 	char *loc;
 	char *loc2;
 
-	for (loc = endp, loc2 = rmescend;;
-	     FNMATCH_IS_ENABLED ? loc2-- : (loc2 = loc)) {
+	for (loc = endp, loc2 = rmescend;; loc--, loc2--) {
 		char *s = FNMATCH_IS_ENABLED ? loc2 : loc;
 		char c = *s;
 		unsigned ml;
@@ -660,7 +659,7 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 		*(FNMATCH_IS_ENABLED ? loc2 : loc) = c;
 		if (match)
 			return FNMATCH_IS_ENABLED && quotes ? loc : loc2;
-		if (--loc < startp)
+		if (loc == startp || loc2 == rmesc)
 			break;
 		if (!esc--)
 			esc = esclen(startp, loc);
-- 
2.45.3

