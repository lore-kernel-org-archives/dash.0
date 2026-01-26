Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46276315D22
	for <dash@vger.kernel.org>; Mon, 26 Jan 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428538; cv=pass; b=DEo8cUiyEMIimycj5QWq9H4ty5FERndHYp+QwSWD2vgaYnmG/7uBd1jrLGRtZD2mXCgK7NCx4GJhtNox40U9/vlkwOXgCW+GD/sYcjW/75LyCprlG6xC45v6J0ZfGZNQ1X6rUUkiskG+NFLOni0Cb8+XpfDct9w9v5RbmwKjyFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428538; c=relaxed/simple;
	bh=FrB5zUPuR1VN1qxZZKHdrbaMnXGMBkuWyHKjFEgbytI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ff11yBbppmOkoIL5Nqp9VUjRgAZvGIaUr7imVC1aT2RG+dD1hYJNemv1yCoEpuWv7lYOsptYyHNaRewrU43p7n2GNmh3mEFu5w4/BM6PtzNttGRQBrugKpVz5FxUmo5OcX0R1vCLvHBxVcg4SqFzv4S4ngPYNYtfvxs5ekcjJsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7NeAr8K; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7NeAr8K"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-793fdbb8d3aso37636507b3.3
        for <dash@vger.kernel.org>; Mon, 26 Jan 2026 03:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769428536; cv=none;
        d=google.com; s=arc-20240605;
        b=I1D1su4dK/gH8DtbJkv9XCeqkPKaRLFzxK2QXxUSYNrnJ9nmXy1eGKgQVpi+j9hYnG
         LoiyLDcaC3xnoVYQuv4QnGxDLYuFJTTl0LIR0bEIcP5lNV1i9A4LHBhSI952iMGod6GF
         gBj+we5TyBuliy9cbYZ1DbO0mWVluB58ExCm2naGYK+3aK4CC9SM7fBCfq9l+tN6xEZX
         3gtqkXhjGGN0neBu96A3az0luHcTCv5mRcwpyLU4iEimPbIyzhRn8aO6ajPUa1QxpJ25
         VXxfAV+AklRPiE9MI/8FPpqtvxw3mvq/VvOtPZ5Pj/2fnBNhrGdk4sawsF6SR+EZO4eH
         NerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VNOf65vzwACCvtZ55/sE1jHyQg5R40X74J9/M7E/rXA=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=XNHy47JjIGPLF1AN/8TNtw8lJSdUj0jY3j4MHLW1EWJY0IhTIGkftFMbZUnQWS7Ijx
         wHOm4WRrDUj/n12eWoaSBNwFRCHqlG+6IkLNV6v49pUfYsBrVLKRtBpUzQLHqRq/IGGE
         w5XjGUQzJo1tHcG3vYup+qaXlq6zxwxw2kLcUYtqUiIpCGbka7cKwehhW6I0llUKW93c
         dBgUgqZoIPcTjEOA05FeRdF8fwF14TZtr9Wf+V/HtG7Ipb5XXR7F+Qcm5RmQCuI8u4X3
         nQoAHg1iDdmpku+viqHfOsZPZ1WML1W2sHBjMqfU1vQqL5qsXn3/xh2D1tJYo80Gr9HR
         3IUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769428536; x=1770033336; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNOf65vzwACCvtZ55/sE1jHyQg5R40X74J9/M7E/rXA=;
        b=J7NeAr8KFsbYHdNvmHROmNBZRpg+u/7DDTuOP7gUAeAhorUnMK157/cMqSj5TiDzLX
         2somE3gqE4N++/HozPN+wl9NpmYpEyHBNmlvZy00XKY6a9dVCvAo/S6T3DOHx6VtsQD7
         vBSyN7d13xNfmrvY2LirMs4nD+MCMf2ou5MyrUBfSc5eH5aQ6uZFDLT4/kuJu+l87mVG
         WBTqUNS0IWOsY5vOwIZ/m8Leb/xtLevxacm9ycltOhWrhksNT8FACxCH6f8YruQ5ZpUx
         5dhYCcJcxRGaosn8593VBORi8K9jqh/zqyf4FT165yO4y3OXfcCmYE1EavKTKruWcYVx
         PfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769428536; x=1770033336;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNOf65vzwACCvtZ55/sE1jHyQg5R40X74J9/M7E/rXA=;
        b=GtCX5VYlIjfEX+3yUGVo9S7RvRTE2KMZlWTZuunp9PWKxRVF/QS21b/pA8NCK3sWRE
         X89ewnw/dlMuTDVnZsbJGT9+DWqcHx6c0kbu/xcsmRD3S+uwo48uEfdKpInNOp26SKrL
         x/sUysR9R7xya/B5HvLi1nVAynw1Y241AISlXaxGYlsIQfDFxJb1VsbmdBUY+y+HI1tV
         Mvf9PXE78HH+NmloaRU7P9V/aXxQbI/Fp+gZj5nwnbcH1VgnlPut1fDzqVNeFzuQbCyW
         sd42cD/4Quq+9faMzqqRQvizkzEQb+5kNA7oS57yb9Vp2P5EM994EBy88jR3uC62x8oA
         fsBA==
X-Gm-Message-State: AOJu0Yypxd/zlhP7abYwNkWc4yK17kgexfEKh3WlX8nE8MkPlXh5BOvt
	GANaq0Pr0r+Br3B9q5Rwdkqt1sIrr3KYRTk4LQGWTSJdjUa0+1bn0tYoUoB7935gViQ/c3utAd4
	jL8HQXaiCYAmvgq0aUBbd31KnLLugHkUVWJOT
X-Gm-Gg: AZuq6aKW+qSdNxWuBXaPPjRm4ZCUH5JxYbD5GjJSVN3NM08BM0rjk9URuBxZ3or+JV5
	HrCjlgFz1vRNVY+MbmH85Rd7bTf8jbZlcg+DSgbVByPfKCSkyrieJoBKY2gt6x/0HXx5vpXipBe
	SVzUThbcwLz6Az+qY9rWnygO/LowqyaA42vO1aP4zT+zdvzUm6TBXgIbX/KimBUvGaOI2v3E34Y
	3uGa0I85tqhWQYjeRaCrnDvhUM3LncLTqQ9yXe3I3b/yk6Nd447aVoxlkYvnDuBvo9wVNuZ
X-Received: by 2002:a05:690c:f05:b0:78f:984b:4be9 with SMTP id
 00721157ae682-7945a86ff68mr31438747b3.18.1769428536063; Mon, 26 Jan 2026
 03:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jari Aalto <jari.aalto.fi@gmail.com>
Date: Mon, 26 Jan 2026 13:55:24 +0200
X-Gm-Features: AZwV_QiVTd6NJa5oW_48tSKHOpGoSwTWKJsY4PjbPSsskzJzqFGgS3-6xLA30lQ
Message-ID: <CAOU7Hif8YDD-EAvqEV24_YAP5N32j=gh7zca=oXY8MfbUPQcYA@mail.gmail.com>
Subject: Dash 0.5.12 bug - POSIX process substitution $() handling error with
 embedded comments
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Machine: x86_64
OS: linux-gnu
uname output: Linux congo 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.1.15-1 (2023-03-05) x86_64 GNU/Linux
Machine Type: x86_64-pc-linux-gnu

Dash Version: 0.5.12-12 (Debian/testing)

DESCRIPTION:

POSIX command substitution does not work with comments.

REPEAT-BY:

See code below.
- The old backtics `` work
- The modern $() doesn't

FIX:

The process substitution is defined in POSIX and
should work identically in both cases.

COMMAND:

bash -x <code>

OUTPUT:

++ echo 1
+ x=1
+ x=
posix-test--process-substitution.sh: line 13: unexpected EOF while
looking for matching `)'

CODE: posix-test--process-substitution.sh

#! /bin/sh

# OK
x=$(echo 1)

# OK
x=`# comment`

#  Syntax error: end of file unexpected (expecting ")")
x=$(# comment)

# End of file
