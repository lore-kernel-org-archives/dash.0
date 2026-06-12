Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA639B497
	for <dash@vger.kernel.org>; Fri, 12 Jun 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301412; cv=none; b=XRu0Tcr1K6npqaxPMrZavG4lKlFXXLHuRcSDePha7s2REkXIBYzyHWHpRsG3TGDIDVR9Pg4zhfUqG37FzNri639f478QltIWVz7ca5i8HkCSPUGpxvg3n6FFxVIuH5FS3SRLo/7AbnTCChY4FdXDMl4FWxsLR5fz//37bEF0N2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301412; c=relaxed/simple;
	bh=YDiBAJmqRGgybCjvMXr3ChMZnDtbi7dZ1Om0FC2UY4o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ukkIyAc1SwAU0CRTs9IqrebCYlO3kMfcb1Vam+ONM0x6kr5++tRAwUGo3CpaiV0EHzGkJglyFiMdbY/+n2GFGiamofHzj0abzhIQ13uT3ePYR393lUjC8fSs9IuuNhBb+f8MrswN+CmHqJclNrlxCTz1kw1Gddf6Qx9gNUBgmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvL274vC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvL274vC"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so1403579e87.0
        for <dash@vger.kernel.org>; Fri, 12 Jun 2026 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781301409; x=1781906209; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA0PPxPMqnJBg45l7NYPW6xspHRCJeIfGYMlEJKyaOU=;
        b=bvL274vCYDaUPI4fBu/5mnCH1h4nnxydID+t6R7Pmb2/LvIP5zT+UOAJ6k56jbY7Ub
         FQADFECDfmB/slubZTgu41nUe6DhuDSAdPNTL6szdOnNMmOLKjwBaEtB6bMhGioN0yaP
         H/Svbh7N9K7Sl0jq44v9GeMjboPXRIZpNkf7LIxIpFV/RdYnrMlbZSgf0kKRZF7hV76i
         7gvgAhFJFXozFVTPFOLkdSNTsjsPFCrSXRdegurxf1Xe9iiasMxaoRZgVMfPI14gnKdR
         gAN2f6alJ5jGVzOnXPrj7NAzTuRGEYY0lOxpVgHFpBWRJ5QdsVOfimMqnBivHJqg06dQ
         gDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781301409; x=1781906209;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tA0PPxPMqnJBg45l7NYPW6xspHRCJeIfGYMlEJKyaOU=;
        b=QIKNvRwV/UrjTRdpBcIY+ollfB0SvRr+GqQYfnYOWL/W2Z939s/NR+86JqzprC0K1/
         ohklfvp6r0zAPauITNTne9DQx0VLFQmndmoOymoheyVuYTAb67eL3GER0vCFkY837d3t
         czYtWlTil0F5fW1V0nRyCQ7lxOyq8oBTC2m2Bs3y66PE8vy6OytkZ7QOZUGCTrNLmi/F
         FYMd3rF2KBvhU5EEScMfTfUpiIjs425Q+NIsYpvXedb9qdCx5tcKAnuxAIgoCTjvF1+6
         w5Ay0hUr5NLiJkRI/IUdS+CaGoXUCsFEXmrav6SWW/L0vq+UKJJjCdRt5/582YmhrPL9
         2aCQ==
X-Gm-Message-State: AOJu0YzOWJcDheSF/IdlhZQ29JwJLKKTJjmfYh5LDzsb/mzCAQTxj9kB
	LqrDuQ+YHkKIhzK7tKQq8CHlwJRK6zUXBEqNVFWyIaCn9pZgEu3rG3/5rhWpSA==
X-Gm-Gg: Acq92OFuWPF0yxzmjkjTcuBn3gmpYuJddeBZEU0aaN2Q2J3DJidE82btwZ7F6/nIkaF
	FmMqY4vR1N/DqE/wxgfPKjGUXPEK0KcFfR51lH1u6fpazI8zCJfBf64QP7EtLjjvDoGxDFeGI3s
	18PDgAMsWeK3V0I6gtkKuZ/eGsWWOEu71yNxhp/8nCtOukBKav5Sz7UMNKJteRX53GcMCQaqy5z
	oHeNpIDHrWj4GSgmt/zdZRj9LL2Tuj2weIUg5TWyzsLnqUIDEnaJISqhAVuwZafVhQLfRA6MUMK
	mmLz924GBuRXkRg6a6J36bSz598MxStArqvETK4XhkisnXChgwXcPJl2IgKKVwzKGlQ/QH1pUQy
	niQuWXGeY5kHQPHGHN7nU2wyWFIQ9cvoDVxeXTa5cDnpjoCcsaCdtiGGSDD5LKIwtBqRyLJdoxV
	Xhe2V9DJfI6xoi1Ry2XTs8UDCunVgTHYiv
X-Received: by 2002:ac2:53b9:0:b0:5a8:8222:7fc9 with SMTP id 2adb3069b0e04-5ad30da28d2mr202356e87.13.1781301409173;
        Fri, 12 Jun 2026 14:56:49 -0700 (PDT)
Received: from [192.168.42.30] ([92.243.181.142])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a730esm827587e87.41.2026.06.12.14.56.46
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 14:56:47 -0700 (PDT)
Message-ID: <b5b51fec-6647-4c61-9986-5fc539c438d5@gmail.com>
Date: Sat, 13 Jun 2026 00:56:46 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru-RU
To: dash@vger.kernel.org
From: Vladimir Kudrya <vladimir.csp@gmail.com>
Subject: Single-byte operations on vars broken
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!
It seems that this commit c5bf9702 changed behavior of ${var#?} under 
LC_ALL=C, which should consider characters to be one byte long and cut 
accordingly.

This code:

	var=联;
	LC_ALL=C
	while [ -n "$var" ]; do
		cut_var=${var#?}
		byte=${var%"$cut_var"}
		printf '>%02x<\n' "'$byte"
		var=$cut_var
	done
	unset LC_ALL

should output:

 >e8<
 >81<
 >94<

It works reliably in sh 0.5.12, also ash, bash, zsh (both in POSIX and 
native modes), but is broken in dash 0.5.13.

More context can be found at:
https://github.com/Vladimir-csp/app2unit/issues/17
