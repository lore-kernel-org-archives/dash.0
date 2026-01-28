Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E8156236
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580365; cv=pass; b=mNFU96YYL0PHIX/Cl1QnH2945+qKoi2cPrjzrQA+nBARXUTGEBqKfsSkqjQTsvSyz26WBBkCNn+lqRfGWTY7irWj9HCPdEcRg2gwL5Y3Ru5UVXrMF5OQyM+T29uHdVhrnDE3ovcabQt4i8CmUpE8GhWGrISVfI+OLjpWDxp/CvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580365; c=relaxed/simple;
	bh=WDFdrhCxwPcMxxsKM6SdPwHIi91m9C2orRSiuG/xAeg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HmlouYO3yt6ALhrAuxV5Id3FL72XhRs2WPcqtk+0PvtYcTTC/HJ0f+yHvTPqqu83Hl0FaoJ7Wtur2qRG1Vn0Y8uNVQYI9M7DPlNjEDvmsoODo8sCvd7QQ3zYY3KkmMbv2MJfKo1EkObViMNgEN/sI4j4I22X2zmXBnNGkdoer7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Rh0qsnMS; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Rh0qsnMS"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6465a88d296so962553d50.2
        for <dash@vger.kernel.org>; Tue, 27 Jan 2026 22:06:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769580362; cv=none;
        d=google.com; s=arc-20240605;
        b=b5EwsAh5AfFfQ7mQd3r07/ID4vsMTzhHN6sVoRh0DCYINBrD4EqlZswjk0k1Vis9bD
         NVAEa+KkmDsFRcEfs1gmhlXkDZaql5kL+rqiPIOlAgFOQR0Uz8JRjQ922h5Ovb2d/HlX
         kjbNIUfeMqjDUXx3TJvd7Duie2uxbl4PH0q3cisHOCjov0aIhjm4L7GuD4S15ke36w6M
         Zu9PNGdA0SMLpJeGDwrXzIMFZA61pfVRrF86JjsxktBF+VvQiZFb00Pjf25Sy06Sdp2s
         /NXMG59pPF7TintrwsQy1Ig1AF+DMER4Hnh/EXySVRFEIvBzvXA1Y1XFCAudFznIDcPP
         ArBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mCCLufLWY13KYPNmGM9asjUgLq8FLsMW9sgjWN4dgmY=;
        fh=8ViJBE7khi76CnJqQzrAav0OoHrBlpLAVTsfTw9REA8=;
        b=kqmz47ldFYcGSQSS159vaL0ZwWX6zwbRpvYdF/g2TN8DqA/sF18iRkkmPYjAwc6g6Y
         PfqKTaSgQDCNPwCdgLGrAsE8SCBAZWkHylWlomz8Qj2kKL3vvFvd1pUgVrQFgVqm8t5Q
         ZZmj9U4BmBDo+EhgXaIsBqqWjEhJwoNy6Rt2dx1A8zLB/93a+ZZVPZr2U4ahjJNYHMko
         KR1QZlTXpKmQyxgHetb1iV6F4nC3aEbGP4opzlUbWaGEdQUdZL/2gxPcgzNsNPwacX5b
         gMcxkwY+pC3BiBCcPJAYGYHzCw/pmcNix76/o0drwLS1p5wTyVaUi9KZuchGQlY7lX9C
         WEoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769580362; x=1770185162; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mCCLufLWY13KYPNmGM9asjUgLq8FLsMW9sgjWN4dgmY=;
        b=Rh0qsnMSq8Cv8Pn2qpvROpayKZohYtRwONO6eVg1xprbSljByFbhZ8sFRhh8h471Ts
         Mvv+fuzmH4ZDFU+8y0szH1OOA3GlNcyxFedL8C20Ep+HBXZOe27DNXgdsDomTQ4GwFC6
         K6jF1rMtnhcUIregX/VCpwBdSViCrDdGGODZUexe5kdewMVOVy/6g2mgZNDeGOljoK7K
         jR/LBL1GjCVCwzlnHNjp8OzlfKqEuqkGBae1fAKmjKnsARu7TCuH+RlQjiZJ8bBomZS/
         AFMZaoGIkhgKFwz9b4xfnVIvtoWQmIzAmVvLYLJdLoEomrLWkAFwfvvII5qeHIGXLdju
         6j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769580362; x=1770185162;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCCLufLWY13KYPNmGM9asjUgLq8FLsMW9sgjWN4dgmY=;
        b=Y53r7ssszlUtO4Rzg+KIsE7OBGbo2IAymhXzNeITeg/kM5+hPrOl92jZNYcOIKOo/C
         wqlgjIkk51IjoY8dty618U1tXuc0WTNsf0hZEnB7mVUzFsRXH5f9QNx7sTcU716K1YUu
         NSe+IR97nTlTejnJvO+svoCtHJxw+Tu2B128QiCJb64gmi3sFWhXteg1ZMISPRN8l6+q
         RwawexZTnbtlCu7a51BNhr0IZ7felOrD4R9/UOfAsHgoUD0YieRhityUa+vrDjhTCr6c
         uwu9G9/U20toF40ykFAqWQXB//wkfkkuD8zViBH8icqhUPeuS9p1ZnN1eTD1wlfhQ9OV
         1Okg==
X-Gm-Message-State: AOJu0YxM3Cl7l1aj0vsNHGt048GuiqJxQCU8HssncSmqM3yelf8keAGF
	SyCecrD/56CVk4HnhEqHNuWjGBM7qy7U/rfj3QSqFvAM501y+rcNJ6TA6BYpbcW2o5WEEamdN27
	ORliVo/Cuw/nGzYh+BDpMFZ9OP1uxq9DEnyZw
X-Gm-Gg: AZuq6aLoHX6PlbwcdqvMQN7Hss2xNUvmAfe5uKMe4DV7MtRRkD/CLFJ8aRxwXRzmOzk
	UO0KqAdOYQ8zHMHitt8aM6Iu9IVIPVvywgU1GXxPyHhzBn4zpcISWbtA+tDtRptBZbWTwVsWurz
	TjALTNeXO1tE+FGVhi0F9McVTThM/NqhG+VBjw+8LNLpS9xMj8m9oOZsZay4Y7cuvpouLRDt9S7
	lbtD+oRnVDjJjpCaIgJ7K1PUNLeEqekoPtcIIPUDDB/K812NA0jiHa7hGvaXa1q/QBHDDzuwg==
X-Received: by 2002:a05:690c:d91:b0:793:a268:81f with SMTP id
 00721157ae682-79485c5bb74mr4671367b3.2.1769580362427; Tue, 27 Jan 2026
 22:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 28 Jan 2026 07:05:50 +0100
X-Gm-Features: AZwV_Qj9mZLCUuZl5JrbC4sIv6DPBf6o5Lzsn1utKCww0lk2uEkN8sSDDIF0yB4
Message-ID: <CAK1hOcPd4Lm6ixcQ_+NG5rsA5uP4A0-oHwWQWdqj3BCyJHJE7Q@mail.gmail.com>
Subject: In JOBS = 0 config, stoppedjobs() always returns 0
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good day,

There is only one place where JOBSTOOPED can be set,
and this place is conditional on #if JOBS:

#if JOBS
                        if (state == JOBRUNNING)
                                continue;
                        if (WIFSTOPPED(sp->status)) {
                                jp->stopstatus = sp->status;
                                state = JOBSTOPPED;
                        }
#endif

There are locations where code can become simpler
for JOBS = 0 config. Example:

                        if (!JOBS || !jp1 || jp1->state != JOBSTOPPED)
                                break;

The above is always true (because jp1->state != JOBSTOPPED is).

The largest of these is:

int job_warning;
int
stoppedjobs(void)
{
        struct job *jp;
        int retval;

        retval = 0;
        if (job_warning)
                goto out;
        jp = curjob;
        if (jp && jp->state == JOBSTOPPED) {
                out2str("You have stopped jobs.\n");
                job_warning = 2;
                retval++;
        }

out:
        return retval;
}

because "if (jp && jp->state == JOBSTOPPED)"
is never taken, therefore it always returns 0,
and global "job_warning" stays 0.
