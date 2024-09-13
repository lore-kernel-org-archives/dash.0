Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67F7F460
	for <dash@vger.kernel.org>; Fri, 13 Sep 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726265089; cv=none; b=je+p0bwJ1PJCF87cDVsEctN2y3sQwHwKmxnvTVaY2ajfwY5bX/S0iEeeiX2RvP2+7IUNxAWAAUMYPcVck5N2DhypRQ9Rk8X6QBkv2ahmA2W8cJkj9yZJB99F5/Ol4mtwV+B4eGWXNFh1jj3mflq7aYlQa+Ji6u2DsqaMUN/FKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726265089; c=relaxed/simple;
	bh=chlxTOhdB7YrI1EctbWPg1EhcYpIYA37+HN6mBbgow8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A62t8zLuwyq6fiRLaxPfLGAeALFL8HmUkzS15s+wYb/6JUxewk5s2qQIEuY0vCMvlbNAGhzIEdlQVrrIoBuHANNgi6vJiOhjYOULL0fkoYYcw/ubrbAma23H8yAN3nWb6BK4wEeE7Q5XGWxQw3jT9xRhc+SE6QFop3ZPp3/Pb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWuFUtR2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWuFUtR2"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53659867cbdso2227756e87.3
        for <dash@vger.kernel.org>; Fri, 13 Sep 2024 15:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726265086; x=1726869886; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHUIp9FECTmQYg1efrKSshZbHL8rlzV7QVP+VjLH7nE=;
        b=KWuFUtR2ZW+KIhqEFntPreaZZY6Sdd+TYum/o4+r5VYFty2JryzTE2oJ5zIVz+nSdS
         LOaZ50qP4lUQ3maC0JxkoQbR1dTFd6q2yYeJwWWO/lgHWKCbTOVMMJgsBP9ER0NO8wBZ
         2+I8YMacS8zgM9g3FDovc34AWIdtHebRtbtHAcRTf77OoAbNd9JEGs6BEMpcHYAXgPvc
         pIOYmx8ZeSi8JWeD8bZ0N1Uhnde7M0KEn+am19AkrSmIzilBhjy727D+jx7aTfz6tHW3
         1Lt8pV+v13RpJmCiRBt0oJKBrGZsTnjoFMHyjhXwr9/hvekoow9KLuEM+zQVQRcgO4Pj
         DBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726265086; x=1726869886;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHUIp9FECTmQYg1efrKSshZbHL8rlzV7QVP+VjLH7nE=;
        b=Y7QH/yWSQETE2VoPETv33OJ+nFnegipw3jcTULJPaKB1iVQQlqJ3Y+zjeHRjQv/ZGz
         VIAEiEWJSspX4R/IfeITSKpgoP8WFxBBEMV2Y5iNxGIHfECscJte872fqMPNvR3Jgs/i
         vE5plQLw+NngHv7mttJew1RZ+XIAwej3dlXIC7oIoLTVYH1VIWweYYO/YiJPe8o38/3U
         S2AewNdr7OSPYJkuPRFOvzp3t4BdkGfafgwcdGGXzfRJZNYE8jG2nXMjbLi+rsr0Iwzt
         is9w5f656hEI4KAg3+qh6Ug5wUjOmnJp1kJZ5qz0dglIqTf5YQYjsf+CXUv8jJs3U8wL
         7JQw==
X-Gm-Message-State: AOJu0YzcayWfG/+b2t+MGfYuwPvtpb5OV/6kxJgYsOPj1aQ+SMZa/L5S
	PRcQiE6RIhsnOajsfUBBGZU9G1Vj9gtC3PHea6hibjGQW2OrXWutjncGQg==
X-Google-Smtp-Source: AGHT+IGzWh5CQA3NffNYdOl2iJBcCy1Ck7RG6yTxvUdQolXaUlCvAGq5nkN3tOqcackOqeLN7hXj0g==
X-Received: by 2002:a05:6512:3f0f:b0:536:7d7d:c621 with SMTP id 2adb3069b0e04-5367feb9550mr3974428e87.8.1726265084791;
        Fri, 13 Sep 2024 15:04:44 -0700 (PDT)
Received: from gmail.com (178-189-136-154.adsl.highway.telekom.at. [178.189.136.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e1a1csm4323766b.156.2024.09.13.15.04.44
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 15:04:44 -0700 (PDT)
Date: Sat, 14 Sep 2024 00:05:48 +0200
From: Johannes Altmanninger <aclopte@gmail.com>
To: dash@vger.kernel.org
Subject: Crash in expandarg
Message-ID: <ZuS3PI7He-T7pugf@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm hitting an easily reproducible crash.
It bisects to c5bf970 (expand: Add multi-byte support to pmatch, 2024-06-02).

After bisecting I reduced it to this example (probably not minimal)

	echo \\ | dash -c 'foo=$(cat; printf .); foo=${foo%.}'

stacktrace from gdb:

	Program terminated with signal SIGSEGV, Segmentation fault.
	#0  0x000061d927e57bbd in expandarg (arg=arg@entry=0x61d927e6dce00000, arglist=arglist@entry=0x7fff2ea3bbe0, flag=flag@entry=4) at expand.c:228
	228		argbackq = arg->narg.backquote;
	(gdb) bt
	#0  0x000061d927e57bbd in expandarg (arg=arg@entry=0x61d927e6dce00000, arglist=arglist@entry=0x7fff2ea3bbe0, flag=flag@entry=4) at expand.c:228
	#1  0x000061d927e53168 in evalcommand (cmd=0x61d927e6dd10 <stackbase+400>, flags=1) at eval.c:865
	#2  0x000061d927e522e7 in evaltree (n=0x61d927e6dd10 <stackbase+400>, flags=1) at eval.c:305
	#3  0x000061d927e522e7 in evaltree (n=0x61d927e6dd10 <stackbase+400>, n@entry=0x61d927e6dd30 <stackbase+432>, flags=1) at eval.c:305
	#4  0x000061d927e52cf3 in evalstring (s=0x61d927e6db88 <stackbase+8> "foo=$(cat; printf .); foo=${foo%.}", flags=1) at eval.c:190
	#5  0x000061d927e506f5 in main (argc=3, argv=0x7fff2ea3bec8) at main.c:176
