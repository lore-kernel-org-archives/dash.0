Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759821386C6
	for <dash@vger.kernel.org>; Sat, 17 Aug 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723938379; cv=none; b=iKzr5MzI6exHGt1Vz1fQo/FGUhnJZcsGRx90uKZPXaSHyhsAow+UBU4BlHgTeX9lg71jRJbRAKtp75SjkiV3EoFi5m9VnyoLd9HC8i/+iHSGD6mziFqfX7T6kQYPg2i+EgnXNimiseTT6Yl8Pk/0P6LtSKfs+Y1VntWTjb22oiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723938379; c=relaxed/simple;
	bh=QKNRlgNi7oKQBytVPbbvwqIq+DXphOEl8NbRZ7Dwp1k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DLHxYi/e6DNMAbQ+9m4nQ2bmv7sz0ua6gV4+N/DBipXmmMSTYhavG5ONnOirr08itU7NnMjyIjbBD9aKLZbNw3nzAwD4TpDTtmUICKn5Ch63WQmpfEjzR0fqcrBX/5L/Rvz/1SSwe+wiZo34iCYiyTb3vmXNbcvsBi0FJG+Xpes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLaea3Ci; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLaea3Ci"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5aecbe0a9so1882580eaf.1
        for <dash@vger.kernel.org>; Sat, 17 Aug 2024 16:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723938377; x=1724543177; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QKNRlgNi7oKQBytVPbbvwqIq+DXphOEl8NbRZ7Dwp1k=;
        b=VLaea3CisckfUkVp5v2W6PoCcKiPQs+pxKf+XJ0m2+wTyMzG3PTkr7cjfLTk0ZdcOC
         KN0EfOTTNU+jOFTWtBNE98iB+KsvhDnTa4VfExKIWL1OkWmjDyXMpgpLLj5R79f1B1a8
         4Ll5PQ9QZH376nn+bhs3UyB4sDXe7OVLPwnzR9HVgJWadQS2tI8mopVd3Ex9O18WaQk2
         /gwuYhKln0aWX+G/H2mxPepVs8Qg1XBZCwfdZ/CC3DEGiFQKvDctqPT96xPdMoZG+gm7
         5z3Z++U4WwOA/4c8oT4FDUmnwtiZ33OWxI7Bp6q8XIVeeSmej3/lDQ3TDDRdGDKHBRjd
         1KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723938377; x=1724543177;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKNRlgNi7oKQBytVPbbvwqIq+DXphOEl8NbRZ7Dwp1k=;
        b=leTTb+ceD4QOExTlo0a5AQCJcvLux3NdsfPK8kd0r3sMwbsOp93pMcRltn0O1mtLtI
         i0Z/w5drZAXirfDRmE2CHg6pThBiyPJGpfCWrrYsvJI3e95G1LB8YLW+dKpmTA2MPr9w
         2ux1BXn6OvRFDmFi86IW+oO2cSqtOVMnP+38RLaNua7031R0iEqKYvv7mnAC3yuW2Zbk
         OBO1tHhhAxmcrWuxsCTlWolMUm+Cc2eofS/1Rf6YxC/5kURl+x9D5KB0nKduy/K7t5nB
         LucuI3Vztp1Lf7Gk5jthb2ZAKOGeArBbHqAlaA4a+wGcjqIX1BrL22DEQoKJ6U4jytxP
         G34Q==
X-Gm-Message-State: AOJu0YzS858dNGi+IiI/WtaA3atbxowcrseuptJ+ydDrqU2cRgmR76ar
	MurdhUjm6TEhhx1cFF+0UTKQTk6TF7Xka5fpaf5sl1bgMfbHpeAh6LuPNNwr5jjwIbpbRujbUfC
	1f1NUAA44W8Orcs//tB+10mbNm5eYDKuk
X-Google-Smtp-Source: AGHT+IHkDk3j2EKI0S70K+CXkTaiWGYDI4Sk7u1iz5v9N7ycmvhMFFw6Ix8Hi38YaYsHrOGwxX4P9IlzNbcrXdWIWHQ=
X-Received: by 2002:a05:6830:6189:b0:708:8c07:c646 with SMTP id
 46e09a7af769-70cac8ddf50mr8494748a34.33.1723938377281; Sat, 17 Aug 2024
 16:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
Date: Sat, 17 Aug 2024 20:46:06 -0300
Message-ID: <CAGPRubTtcy+XPNrd3koy1Jp9to1Sg5afSG-pnu7KNoCULMAciw@mail.gmail.com>
Subject: ANSI escape sequences not being respected in PS1 environment variable
 when vi or emacs options are enabled
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In my `.profile` I have the following:

> export ENV=$HOME/.rc

and then in `.rc` I have:

> export PS1='\033[36$ \033[m'

These escape sequences are interpreted by my terminal to colour the
text, and do so correctly when executing dash normally.

>dash $ dash
>$

However, when vi or emacs options are enabled (either through command
line option or with `set -o`) these escape sequences are interpreted
as literal text.

>dash $ dash -V
>[36m$ [mset +o vi
>$ set -o emacs
>[36m$ [mset +o emacs
>$

Thanks for any help :)
