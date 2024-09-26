Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7922318
	for <dash@vger.kernel.org>; Thu, 26 Sep 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340518; cv=none; b=dI7K+NZlXoq5xNMq/XIkEUC8UziWn2Dk+Hou22FnARKQ9kcRYSSmZh4SWs7YrYCIknHTVU1OtpXRjb1kFk8D3Tp5x0glmsLru/rBWsNVHrvO1b8wayOISQFrdVyeGqbWLH3YB1bjVacpnVGzi+vlahQ7V84ANPVY7FXS1xTZPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340518; c=relaxed/simple;
	bh=ArkMiIyrinmDhbAgcdA8QuIG9nRfkWBQJU0KyzQ/1jU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WyLuGDLopG2oLKaCUBhr0SxrT0OccaPsIvJgbtS4xDaXu+hnLF1hlqcP3FDGckWZOcbAyxfC3yiclMbNt+/MIpdQYAkMhEzWS0o4km1qU0cMo8Ohk+K47z6b8rMwQ39I8PshZgM2U8P+CM3eWQVIJ5uxvB7Kza2duYwh18dxTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMMkFh4b; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMMkFh4b"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53568ffc525so900449e87.0
        for <dash@vger.kernel.org>; Thu, 26 Sep 2024 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727340515; x=1727945315; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVoOm5bE2Bn1wAC38BjNcQHMtj3VaUx7PkauUqE9Fp4=;
        b=lMMkFh4bm2imnefqEOXYhtsGtu0+NAzpdsT1e647nuY20SuB+wQMIAXP8iCbaaHjV6
         LDhqv/KIoYVE5r8y5EfqKTVtt3tiLs57drX+z6aoLpKh7ekcNBugDGFW3pRiizJazyr8
         6Ih9H/BOB7nl8tFZ1sunCV2mcQfahQS0PbyLoIQMu3Gi2IFU6XTqG1oJNDH0q3CC3Yx9
         zmRfv8PVJ9TbDqcvZNi5Vqza8LMBAvNHbMQCRT6xC7/DLL/cdXBvLaUJs+ZZIjGu13I6
         CAV+9CIdQd6M/VB/aI+xaYHRW/9DjEKmAO+8NGU8Wm5d24yvy7x9C1fRLo8CaB2oh0pm
         XGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340515; x=1727945315;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVoOm5bE2Bn1wAC38BjNcQHMtj3VaUx7PkauUqE9Fp4=;
        b=GAcpak1msLtvQaGGwRD+9k0bcKvtwbiZbqx/EBnVMY0CuDCP4wQvJfyBznc2KoMGI4
         DZ35Y9ze1d1FiKSjZDlf78ai256rU9sDsn096vA5TKBoYbCEZCoSTvV7ddZLwcFMXYuO
         RhUa56BGChimLihYR83mZH5CXSRBdBDVwDuXJu/LT816zv02ug28x2fXnH8cFqMRpflQ
         UTVNE61HP5n/tSCRAoT2tWwbBDXFPtmL3DLgGBxQWjva1K/2oe8KaqvRR06tyoAFlkgw
         Ae5N1lpAmfpErWwUzfbL/cLqEdh9flzFhwjVlKH+1yx9UKGjgzCJ3AIkyvrv9Zys2IQW
         S+2g==
X-Gm-Message-State: AOJu0Yx8uTc9UsEaZY22NQJAfArFCRr8+NFMXg57XpDeICjOZrk3Kqu5
	DSh7/zojxguSUZdu/UiWs0yyfcVidYnkcvj3BiF5eGpL2FLWr/9Z9vT5TQ==
X-Google-Smtp-Source: AGHT+IF6x/Qej0tDxL5BuiJc5jxvxb6adWlJd3+Efb+/n6c4NlVn4I6Hlwj0WdYV5j2kkqTjuzi9rw==
X-Received: by 2002:a05:6512:3083:b0:530:ea60:7e07 with SMTP id 2adb3069b0e04-53877568f5cmr2974787e87.58.1727340514371;
        Thu, 26 Sep 2024 01:48:34 -0700 (PDT)
Received: from gmail.com (178-189-136-154.adsl.highway.telekom.at. [178.189.136.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c286sm2901921a12.17.2024.09.26.01.48.33
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:48:33 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:49:36 +0200
From: Johannes Altmanninger <aclopte@gmail.com>
To: dash@vger.kernel.org
Subject: Signal handler not called when trying to open fifo
Message-ID: <ZvUgIAOfG-TXB_Wf@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm trying to recover from the state where a fifo reader is
unexpectedly unavailable.  My idea is to signal the writer process
after timeout, to avoid it hanging forever:

	mkfifo fifo
	timeout 1 sh -c 'trap "echo cleanup...; exit" TERM; exec 3>fifo'

This works when using bash or zsh but with dash my signal handler is never called.
Instead I get

	sh: 1: cannot create fifo: Interrupted system call

Is this supposed to work?
