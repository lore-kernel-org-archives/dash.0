Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D6C2E0
	for <dash@vger.kernel.org>; Mon, 22 Sep 2025 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573996; cv=none; b=hSjlnxnuWlo7VrTMztJd6caBVW8tvr8dFXmz2wtqMUkF+07KkW04+h9Upk5P8nI5w9PCJmqf7R2YBkQI8cWgxp/gjjKT/Amtb3ooOD7+8qybu4YRZRNNv6+s+6cCDc8eml2GRPdTWIIlkgTBWL9VPyJ7KJlA67nQfD8f45eZoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573996; c=relaxed/simple;
	bh=QOajEJ6rO9ah3ZHImHKwRO2s/a3riVoZ/wbRSmDj460=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWP1v3AjNm9N6fEICvRZEJ6pqx1/tYYf1u+K8+FmQBbH/Yx1g73itH6o+QC/9e+G82YzeuhLXvLbGKMwKl0Jgjwf6kaJrOg+dGcE/fjmDJfW9s1FQHXEIVPapmaacwwwcq75ojmiiHAuWnik65z1bH4bft9f6CBfku3gK0W7IqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHlotjxa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHlotjxa"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-631845b51e2so2901165a12.3
        for <dash@vger.kernel.org>; Mon, 22 Sep 2025 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758573989; x=1759178789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s3V62U3R8Wew1tGjc1uMP3R0Cg6jX3BNBw4sul1fas=;
        b=JHlotjxam/YPE1+8v45g8C5Mcq+waBTtlAJHDD83i9v2oYwFTbMRiSkl6HVSreZT8n
         CiaHEiOqmKHw6p+AcLqClXt7MNm7+RpyDI6hy5LJm2zSjRFcL9t3N9IKz7QdqWrBlMNR
         JXRfKcnj8HUvVI7blDyfjkG0BRkOSLWBy+ZbYjXU6OjGgOg+L5f+8kEepmSKPPQMbJmn
         BbgwqSfTOeHHqPWbtDqs5o4z3zRo4stByCTx8TO9qWj6eg94YqGQ9I4oSGMCvXP498KS
         zLMdejofASVsnTFgy9pbSV4WLHeSbLPTSnSIgzUDbNHKi2mhti2MnS7svljwmKnLoncu
         3E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573989; x=1759178789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s3V62U3R8Wew1tGjc1uMP3R0Cg6jX3BNBw4sul1fas=;
        b=pSLsMU/xW7Lepu1bn40gj63wkJZf3qqYZrPf4+blUp4w5kx2g1u/dTX+WBySWtzywh
         nNOl1gdWr0pKbuqkjYaoKO3ziUqgLBWEUcTFe13c7YLkoQteYD9Tl2CxpH9qwm9awvfh
         kewtlrtbL/F4bNXCCUicLt6zWjaC7KeeKEJV2aftx6wIqdEeMkuFTWio2J4PMG0dffzt
         IzuUMAkOd60xVNX/+/ZyQ/r/qzbbRC5ky7Le5MZW1FEWRlUrvPdWWBa1eGBFc7QchFUy
         VrgjA8gaDBQQ5ysnZabT1AuxstlzgEhGIc3nmbc82IP6VGdAfSqs7d483HwKVmH2LSWC
         HxWA==
X-Gm-Message-State: AOJu0YyCGoqEZYGmIkMU7R+lcQh5TMNtNR6bjt7gLi7VeprIVmlQiHmM
	Z5Xw2uM3d9lg/WKoF42Fop1nwHv1rKfYqXxD1xZ3rPa3xYvbbG257mP9
X-Gm-Gg: ASbGnctSNEhoe0Nfkzp6fV7n8pd2KHkDJnBfdoVn/4vXiVhEkBvb7MS+m2sLCziuuqn
	M1scceUDaNwHnM1BZQS29teHesdDDHY8rpqDq86lg5mSNPOHtJeGdxhDf+H1AlBoP9QGPOPR8eM
	LZ6MzPefl0geWg5e4y0zKbk0R/JpPV+Kg5q2a7+lIJE/MCsI3JNml2SH6C4dAMVMCQJmgYF2b9M
	JR3lUk31INcAbuEObuM+5Cw0RME86pL0t6rvi7vO1gh6GKeYcLcpnXyzX71aHPcb7i8dDes41Ig
	p/NSApYgBCJtByqKZLAKfrwfQ2Vr8c6S+AGQK91DNTktJY9j8iND0tM75XdQGpuycLXjONYr2a1
	LkzgFwojS2RJBb4UK3uSJ6gro/GyuOClzpOSQNWjzezn/d468g57L1KiP+H9571PI0AvO
X-Google-Smtp-Source: AGHT+IEvWm7/46j4IyqEDFgUfmIYMa9XGvJ+/8paIZKDETjwA96LaD3WGvXANU30WdgvgDds8SEefg==
X-Received: by 2002:a17:907:96ac:b0:b2e:e87e:ef2e with SMTP id a640c23a62f3a-b2ee87ef779mr193382766b.39.1758573988589;
        Mon, 22 Sep 2025 13:46:28 -0700 (PDT)
Received: from Al-T400 ([169.224.9.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88badsm1141888466b.52.2025.09.22.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 13:46:28 -0700 (PDT)
From: Abdullah <3bd3bdr@gmail.com>
To: reilly@reillybrogan.com
Cc: dash@vger.kernel.org
Subject: Re: bug: 0.5.13 regression in parsing
Date: Mon, 22 Sep 2025 23:40:02 +0300
Message-ID: <20250922204617.3648-1-3bd3bdr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <105f1d0e-f7c4-431b-b95d-efad442aaa34@reillybrogan.com>
References: <105f1d0e-f7c4-431b-b95d-efad442aaa34@reillybrogan.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same error also happened to me with dash 0.5.12.

But I assume the bug is not from dash but from libtool.

> archive_expsym_cmds="echo "{ global:" > $output_objdir/$libname.ver~
>              cat $export_symbols | $SED -e "s/\(.*\)/\1;/" >>
> $output_objdir/$libname.ver~
>              echo "local: *; };" >> $output_objdir/$libname.ver~
>              $CC -shared $pic_flag $libobjs $deplibs $compiler_flags
> $wl-soname $wl$soname $wl-version-script $wl$output_objdir/$libname.ver
> -o $lib"

That is a broken syntax, they should've used single quotes.
I.e.:

> archive_expsym_cmds="echo '{ global:' > $output_objdir/$libname.ver~
>              cat $export_symbols | $SED -e 's/\(.*\)/\1;/' >>
> $output_objdir/$libname.ver~
>              echo 'local: *; };' >> $output_objdir/$libname.ver~
>              $CC -shared $pic_flag $libobjs $deplibs $compiler_flags
> $wl-soname $wl$soname $wl-version-script $wl$output_objdir/$libname.ver
> -o $lib"
