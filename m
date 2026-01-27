Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20914A91
	for <dash@vger.kernel.org>; Tue, 27 Jan 2026 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488311; cv=pass; b=uPgxLiqllZLzguVpWyUl+5QRi8WwHgfudaZ/muwaZEroiTfweiT9hUHJibi0irlnqCTezctjfCwai4G206Pkrfzomb+VttUYJMxrNEku0x5voOBadVBG5dcYBmFnTzY1xfg/zR+GlmqvB9hT9DTZmZohZAn/F5p1B7RnjAIth/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488311; c=relaxed/simple;
	bh=U+7J3Bhr7FJPlhgDEZyXN3LMfGBJgSZ9HlkD0/5mXOs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M0E3FHKejMf1RY/JFEzlFOpb2L61nWtKSSLOXTOhpuKyCnqyF3eBA2mL3lo8OS/Np3MLgaLd/u+/sz0DT8/MeXBRXWnfkTxblhJGd+LsyZ0JUqNdz4tkAJoxeXH01Chm2o0CzOXFC2zDXZii7h7imeoR44t3yokCU6NRa12Kkbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YM/wEILT; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YM/wEILT"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-646d51949f9so759907d50.1
        for <dash@vger.kernel.org>; Mon, 26 Jan 2026 20:31:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769488309; cv=none;
        d=google.com; s=arc-20240605;
        b=QiUun8pWzKmFyH759CjcW+RssTZeTJQ7BB2jzxYdk04mNsZqsJZMVGzOqeYSy19FDt
         UfQFWrn05D17mLUMMRaaYigj3X8wHSd4/wj56jJuq3Jzw4BR0XGKFOHJH3NHXnqvywpD
         E8KYiVZpj9aYp5gfqyZegQWJuuD7TGXuB6X1lySmPth3VNbpejpNnBcU+H2/B9HCD9v/
         7HmUjcpOL0lCP4oeTfroQuhbXlpGEj38u6XN2OcAVczx02gFwY+92+coWakUBr7r8+ue
         hcFTnzUBnXb0y9lqAVgRm9wJRxCuuhBJUSXmYrnL5c462CpFMgQPZ4EfmHY54JzX0sXZ
         3nCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+GfIkRKFOm9uvYRQ+4QjAt/22qDo9jY61/Wbt0Dkl7E=;
        fh=8ViJBE7khi76CnJqQzrAav0OoHrBlpLAVTsfTw9REA8=;
        b=k6E8w24O8C0stUzFqxgq53qfyu6MZ+GcyvUTZ3zJU8LNrj+qB35yEvate7s+cp7z3C
         jCBxTacwccyp6rgLw7YErBDuZol8AEl4+aA4ysoC9xMX9H46PMVV2BEbFH2ZY9cheu+2
         3x8bKEb19YRaN9MTc/bbp7KNF+PY71K06cfww9HTxITmWJc725+xj7TigGgmagYbvSpX
         kHfBExBId6ZBq6fIHrl1uPxw66RPzo3FzvcOE48JvrlO9Ftv+168qwnuvWXrdu9Nq1fg
         xJx0D0jFuYWjBx1BPZ3nYF81gSzquHBnT/f7DfVg/GrU0unNznhNrAY1JyVjMdvyTS6i
         eA0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769488309; x=1770093109; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+GfIkRKFOm9uvYRQ+4QjAt/22qDo9jY61/Wbt0Dkl7E=;
        b=YM/wEILTvt7nIBpu38FI4ueHvpY+xOSff2mKkxG+VMLlm0srlRsN+9oOxY8oJlfM8w
         8ITJQh0Vh/Lav9h2to0LIS66NiNLhecXLKQpo8f02ZhGiUh68aYnvE15ddMx/NloMI3L
         /GMzHf0Y8x6iI6xxuiI5KB1541uadj9QOzpMl6IS4Q6ethU33shezp/gY94UZ+QfBHdR
         1oEmDs6DiDzd4+cx/kkxTEnSeZnUTB37bypGQ6Vtge5fpVVka3n5pEDHIk/3WRQK+iem
         XC0oFXlGVhi3KiQBmZq8Vy1+XvB8FvIy0yG2pq/pVqOfPWAtkohQFnCMTsUzkzc7+OhQ
         X2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769488309; x=1770093109;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GfIkRKFOm9uvYRQ+4QjAt/22qDo9jY61/Wbt0Dkl7E=;
        b=j8TZi9y8o8lHJYRqkR3qYsSdaEiqAzXXeH8cQcmDWgYqOZNDYIj7EJjX0Cvjahqlxk
         LY08KX6A9eyXncWlbDXngES38k0HxL+p9C9sldUWm2+n8WXkGk/8zGpWDn0gc4y/TqNZ
         YRJa2g8J/cCZPJHynUCwZ8rlsM6YC1Oho7ZDf+k/1ey7CdtTpQwdKv7hpJ1xC9R2ocZu
         ckd7CfEeiWSFNkpHmbbkLxvbjw7v4gN6K+B43wvzlSFDmO1FgRHneWg6BntP+JmKvXXx
         V6ZYwSrYl/19NtkxaMOzBhHJ+/rNmJdOxukJIzBGchcGZkg70F1AuG/5iUA4a/yX8PSu
         57Kw==
X-Gm-Message-State: AOJu0YzXRA4twIZrJLduHnpBA/PgfBE0sBYk3R4MaT+ZbAbcQyF36dHu
	ZIOY6HVNuGSfIfSb/FBsdQ4A86k0MjLkBJuWHdrPDWxN++jPHo1oTKVRzP2UEBD95Mlp+4t4gfQ
	/uRMN4R8VnlLGAqxkop/1jJ0QVVVsfuFDSwJz
X-Gm-Gg: AZuq6aIWI1G2cgogQ6c9dwfuUPP6/ZDRoR4WlNxwpg34dhpLVsa54OGwp1oQj7t5xXr
	k/Q0crDI9hdxrM1ivRhEMgA38Ifs2T4ozOdrIMN+rwDSuXK5+5EYxuHWpya+RKbeSvyUNTzAqFL
	/fCM24cwNimARU3ZtaTb9FmA4q1kKB1qENj15ivlZTcnqsJRcO64Jaz+BK3yVjnWBtcjMIAfxyA
	OEt0D5SutYVbogLGnHXAaWT+f1kPH3NHyuVmwUNTgMus/A4zYLVfLXChtFjlPu75CtIRh4nJ8vq
	TgKiv5U3
X-Received: by 2002:a05:690c:c512:b0:78f:84dc:5631 with SMTP id
 00721157ae682-7947ab1e87bmr2434837b3.3.1769488308682; Mon, 26 Jan 2026
 20:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Tue, 27 Jan 2026 05:31:37 +0100
X-Gm-Features: AZwV_QhacqZgYtIdKy3_5e1FdcDY7RAxFw0WBWz9STj_T36oJbh1gBLmY3xjmb4
Message-ID: <CAK1hOcN3qdr0ee_Ny0syn_eS6dh6yK59AYX8PgamV20P-MXFaQ@mail.gmail.com>
Subject: Extraneous test in setsignal()?
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

void setsignal(int signo)
{
...
        if ((t = trap[signo]) == NULL)
                action = S_DFL;
        else if (*t != '\0')
                action = S_CATCH;
        else
                action = S_IGN;
        if (rootshell && action == S_DFL && !lvforked) {
...

If you read the above carefully, you see that action == S_DFL check
can be eliminated if we rewrite the above like this:

        new_act = S_DFL;
        if ((t = trap[signo]) != NULL)
                new_act = S_CATCH;
                if (t[0] == '\0')
                        new_act = S_IGN;
        } else if (rootshell && !lvforked) {
...
