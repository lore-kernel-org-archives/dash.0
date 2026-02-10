Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805301662E7
	for <dash@vger.kernel.org>; Tue, 10 Feb 2026 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685875; cv=none; b=o2ecct22IV4Ll+heySuGvq87A+1NG1Yj09peRZ2uqh8+15r3d7Ak6BwU376/hnDSD9/BFscwlvqffPI87z+RNRDHRX6XAnZC1YEIMVLrQEjjzMTHl13EuYu+RgYogBvtps8mxxGrayfYNMw8gSCF8ijLelgnHej2C1rp8n/L8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685875; c=relaxed/simple;
	bh=GOTs1PhDyJ8SOTg5gorCenaOKdODHWyWfoEk7nU+NjU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bguNuhMh/3yHVe5cKcpVT0kub0yqa+qiZkk865+RQYyyZvSpP/VvLiEsnOdkFTJE6+q09FJU7Eo1go2JPycTNquKcNU/bvA1CPXjE0DyhBZ0HoRcdUnAhzy4piszKIiM+7PSHvYf4JdVdjRz16r08hmRaOcXusBOKz5pdH51v3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+h9QOMF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+h9QOMF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4832701b9b7so18822095e9.2
        for <dash@vger.kernel.org>; Mon, 09 Feb 2026 17:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770685873; x=1771290673; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=epblhyQcoLqyjuSI8m/vZLBzzSFQ816yaaItFlP4vlE=;
        b=U+h9QOMFyc1pyu+iT/A2qFZHvYF/VMO5qpbyCu0mB7cxBEce3Owm9RCJL43yS/fBac
         buBQZk/fs+OLisPI4J1SGZo60HsxkTVFpmEeKYA45JmEOCsK5Q4p7Q2hhuOXi9kJGhyD
         MGQTpseEUhUYHYIGIttCzuHa6EVMnDDWnft3O0isOAA90AP7c/ZnJ+TaytItyaPn9kpW
         AqDVXWZYppwQgmLM/47qTOJTaIAGGxOihKpjjZnYh9otk0xjqmBnjtkKTMbkUSP9KPj3
         TV8LnBjj7aXM+tVfhsIosocYwKDVjpsIewmEpJDuFQT1jb8Vxtp6+FzykFgBxV8OWqqn
         oZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770685873; x=1771290673;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=epblhyQcoLqyjuSI8m/vZLBzzSFQ816yaaItFlP4vlE=;
        b=Ad6PS4+onYk5vFb5RKpbsRq4hj7V0+IPbaJCom3TVRZA5Gkf+jywAi2WkCwNQ13jsS
         C2btB7oA8Uob90gp8G/hAp8Ap9nM0uNgnux3gNRw34pcsxna+HyTg9TKvnzZLqXL62Px
         RK6SutsovklF8jieYrtKbEWMMR+Eob+qbzceGQQ1lCQC181IqIlikZKpiONTzga8Pmln
         QLbWOE8fP6rMJd3INOLsaNgcMUlinKBXntC2EddaglWNFNVeNE8C5KDbrFETrOikwz3A
         H7yNjAk2Zc9zp2TafsCrCIiniUWENohANJC87yIdXvdExWk621DFXD8WKt7vL7VuDKwG
         hFUQ==
X-Gm-Message-State: AOJu0YwaeTe+uR61kPxGCLi4UsMw143SapGV8suTkO5d9LiuzXSmh0TX
	KdWV+e+nppuDEWBkpLIYm0XkhSxlz7n3xX4hj/aYNLNmnt2AXd77i8xD53CsE9YXQQ==
X-Gm-Gg: AZuq6aKM8Mp1ApYsarKOQTEMBnhEMdUoPV2wiJPMcuW78badioDeib21h6bk6dV9j0t
	EMgvKwb6CcrxB3z6bkgPoElSFhljQKMwhp19JAfe2uY9FN6x9ycg0XDU2lTwcpVCWb9o9/Hw04y
	nEqVXqhVajeRuLyl9Fb0dnxkB2OjSEvRBTTs2cDJxi9x+EbktU81dogoR/0zPOR9rnPR3Mw4rZt
	NMPvns+pQgfu9RKL+7lkfbCk06PmTuRdkvNS0d5VrPyxh33HAImJxp8+7N2Ipw4Cwc2GomfQ6Gs
	9EOK1Vdefl7e0V7JAeVsn2vTMp0mCdo5X/07eDzk0+xtnItKunoRPkhnED1c/PjFYqHEToOS7YM
	FsVCG2R53JIUkPVwd7X3KWkLB04AYdiSrjufLSiU7AOBXeM88G+dDUmqLjXtR8s4vGqKZFFwA2w
	TPKz7Suxe0tQ==
X-Received: by 2002:a05:600c:4506:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-48320213830mr158163335e9.19.1770685872772;
        Mon, 09 Feb 2026 17:11:12 -0800 (PST)
Received: from teapot ([78.143.211.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm109129145e9.14.2026.02.09.17.11.12
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 17:11:12 -0800 (PST)
Date: Tue, 10 Feb 2026 01:11:11 +0000
From: Earnestly <zibeon@gmail.com>
To: dash@vger.kernel.org
Subject: Surprising behaviour when reading from a named pipe and standard
 input
Message-ID: <aYqFr-Twb-njdsDh@teapot>
Mail-Followup-To: Earnestly <zibeon@gmail.com>, dash@vger.kernel.org
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I came across this behavioural difference between dash and sh(bash),
bash and zsh.

When attempting to read from a named pipe and stdin at the same time in
a backgrounded process I appear to be losing stdin:

    #!/bin/dash --

    f() {
        mkfifo pipe

        cat pipe - <&0 &

        echo hello > pipe
        rm -f pipe

        wait
    }

    echo hi | f

This outputs (busybox sh likewise):

    hello

With sh(bash), bash and zsh I get (and expect):

    hello
    hi

At first I thought it might be a difference in how dash implements
set -m due to how jobs without it set have their stdin opened as
/dev/null but adding set -m does not appear to help.

Can you help me understand what is happening and why dash differs?

---

I would like to use this technique with age to read identities from a
pipe as the tool doesn't offer another way, read code below:

    decrypt() {
        # XXX https://github.com/FiloSottile/age/discussions/685
        tmpdir=${TMPDIR:-/tmp}/curator-$$
        pipe=$tmpdir/s

        defer rm -rf -- "$tmpdir"
        nofail mkdir -m 0700 -- "$tmpdir"

        # XXX Using a pipe limits the size of the identity to around 1MiB on Linux.
        #     cf. /proc/sys/fs/pipe-max-size
        nofail mkfifo -m 0600 -- "$pipe"

        # nb. stdin needs to be specified as without job control (set -m) the
        #     command will have its stdin set to /dev/null.
        age -i "$pipe" -d <&0 &

        exec 9>"$pipe"
        rm -f -- "$pipe"

        key_request private >&9
        exec 9>&-
        wait
    }
