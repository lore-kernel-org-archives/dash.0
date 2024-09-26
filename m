Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007E1A4F2E
	for <dash@vger.kernel.org>; Thu, 26 Sep 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340992; cv=none; b=VrWrwGM4RvZ4XsghWBTTI+KIZkWi3t4ChCq8ONO+dF7CJv/w7VlhrOw1yodHzEVzbKIC8xeNWWFkR6xERDvWfOopE2ImgRJMc/RkJdjn3VQdtkhM+wVpEoUup2+hbMm0t8d3Cr699ery1fH+7UoIKLoBdLlW3okFKtu+n4p3RN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340992; c=relaxed/simple;
	bh=E/9ydzgMwbDXmo7za/aEoZDmuTI0P3euVMEikim2r08=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6hHBJftPM4FNUs/mEHKNjZpvMdJP0vqsNPP7Gff05n2/Va2ax6eIf2p88xGMC621ApGaXrnlpwFWALlOVnzhSFcUDXyjnIVyFCAvjZyZJUgYcK4aOxTh8YcQJ1rScV3wwkpYhVFXj6PY2ENy3ybsveEERVerak3QBwoxIsvMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gojVf0Os; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gojVf0Os"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so984591e87.0
        for <dash@vger.kernel.org>; Thu, 26 Sep 2024 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727340989; x=1727945789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D//3SJfwpQ/VF1JbbtflAvnTA4tOfdCHZqMMERPOoTM=;
        b=gojVf0OskA+C5CX8T9FOGekMLx0vIHNYYe7Ldg/MAidl+Z9GpdeMv3KIUMwhJRIM/e
         hx52NPV43sOjANQPOrA3kuKFAAWJlheWlQj/tpxitgu3ER6wdcXo4xx595D5rpukJ7eq
         pmAwBoZHDlIR5kw2QK9K9FDtnWXYMFUV9ql1sMC55MFMhRd6dISkjv8yYlU8aZ0qGSq0
         JPPtKKFPzkH7IisyB8GqNdjLvojLPZVOAKM+2XC4xUB+Uijvh70uCnTDLJSVcAwMxnD7
         3/4v56WaaYa1CyXZWsQ4/WVYh1y0vyi+WQ36E7IAoCJbpIfInkrxr3aqrCDAxt+k7sW3
         6WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340989; x=1727945789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D//3SJfwpQ/VF1JbbtflAvnTA4tOfdCHZqMMERPOoTM=;
        b=MIJUPkssStLNRpSXUl35BhX1Ds6FQgMYgX3sZ/xvANs28W3lsZqD/wcs161ZljuAj+
         uMyVVKo0v0M7W4NHWrs5EQhTqH1qtvp0MskBuBt9rOiJsdtNK+TAhY8nTorXmw7BdaYo
         pJIva054ZR1hzZdMGuXur3IqrChVPv7Djtg2bIV8XZsMmmJ0mZT5UrYNRSUZiQBibtk4
         nzb3dfRhsrnQUuOVajCljbRMifpg64wtIGSDpG0ZQ+a5Z8BSWJJ+khySsb0utAXgG292
         lCJpcO1DLo7+qj03bPyrOc/Gsxqi1DWmPuXjLDk5ww7yr/QirSo4qzVTEFPwelfU5mit
         BNvQ==
X-Gm-Message-State: AOJu0YzD63hD158aodRFBPTIHdt65f7KONNep26EMfE2LTY+j33QgDsr
	dX6I16hZUbjbCyjPg6M9fSOPUhMjZlS7+jzYtr1oFlZYzrEAeZejhpSibQ==
X-Google-Smtp-Source: AGHT+IGnDC6VmyHRuFv11uK2unPRGguHzSvU3q7COeGa1zWk9nrQxIu/2OUOqsKPq71YOJZ5gUAqUQ==
X-Received: by 2002:a05:6512:110f:b0:536:553f:3eed with SMTP id 2adb3069b0e04-53877530b72mr3742253e87.23.1727340988581;
        Thu, 26 Sep 2024 01:56:28 -0700 (PDT)
Received: from gmail.com (178-189-136-154.adsl.highway.telekom.at. [178.189.136.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4971a2sm2893368a12.32.2024.09.26.01.56.27
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:56:28 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:57:30 +0200
From: Johannes Altmanninger <aclopte@gmail.com>
To: dash@vger.kernel.org
Subject: Re: Signal handler not called when trying to open fifo
Message-ID: <ZvUh-rllKxZvEgtT@gmail.com>
References: <ZvUgIAOfG-TXB_Wf@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvUgIAOfG-TXB_Wf@gmail.com>

On Thu, Sep 26, 2024 at 10:49:36AM +0200, Johannes Altmanninger wrote:
> I'm trying to recover from the state where a fifo reader is
> unexpectedly unavailable.  My idea is to signal the writer process
> after timeout, to avoid it hanging forever:
> 
> 	mkfifo fifo
> 	timeout 1 sh -c 'trap "echo cleanup...; exit" TERM; exec 3>fifo'
> 
> This works when using bash or zsh but with dash my signal handler is never called.

I realized I can work around this using

	timeout sh ...
	if [ $? -eq 124 ]; then cleanup; fi

That works for me.

> Instead I get
> 
> 	sh: 1: cannot create fifo: Interrupted system call
> 
> Is this supposed to work?
