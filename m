Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CC2309B5
	for <dash@vger.kernel.org>; Sun, 10 Aug 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754861425; cv=none; b=j2KwXbOP1MZc1Gk0273fA+bN+r76SVmKSv5y6shvPZQdG/aZnQGaDMcLsEJceQyAQXAuU3WjMjVc5MTnI6ocTWaglCvWB08IjjzG6AyI0FQzR5U94Ug5kGCN6C+xQUQ8aIi8uWVm4CtgO8RqVFXVigKpBepj6MdlvAO3ksLxhi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754861425; c=relaxed/simple;
	bh=4F2y5Z26hJDO/E+T+M+nE6xEoD3nqTWnTBxKgsJOkf4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VtPqvL1YJf7l/wJPE8rk1qnYZQebdFZwWz8DzrgIuWZ8s9PTFSysBxdNSPo9R44NeauvrBTAAI3q1Hs4j5I6gLgoFuOroJyc8R5JWAeu8goWu58cGzYUzYIViOma6EZLBgf4upK6LJ0fLn/OCuJeP4NSA2i0W5whbnS/LImJ5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoGNb1Od; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoGNb1Od"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754861421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tLk4Q7r2iF6Plf2Wdju45XgRHsPcSHXwiRaPUSLEuW4=;
	b=XoGNb1Od6Up6rFjY/4qNvFbByBDKwNN/VXhsDUcsUSH5u1mo5WFWu+JXa3byob6XoG37pv
	hJFigQgM9YKPCBAXN6+OWnhKsUCIUucZw2teMsOw+5PAWfXi+RWIY4t4NwX1bFZFNLDN9e
	093pbu3ARSfLOzhtY6NdXmzUuFggg9E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-EXs6J01VPBu6043K8fNHLg-1; Sun, 10 Aug 2025 17:30:20 -0400
X-MC-Unique: EXs6J01VPBu6043K8fNHLg-1
X-Mimecast-MFC-AGG-ID: EXs6J01VPBu6043K8fNHLg_1754861419
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-61831157d7eso296176a12.2
        for <dash@vger.kernel.org>; Sun, 10 Aug 2025 14:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754861419; x=1755466219;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tLk4Q7r2iF6Plf2Wdju45XgRHsPcSHXwiRaPUSLEuW4=;
        b=fPdiR0ndIlO0HnboAg4dAiMGZ1HWKHfGbyx9HMJqxAqstjMuN+9fuF11iF893byLmT
         dVhNnr6y5XPB/+nDCvB3HvJm4ZWX+0KpqDAAVH11lO8/SPVkP0uwXtzx82tpjV7QCjIH
         ggg1RqoJ3huKTmFqXK4zUMVTK2PufCYDNUjCCluuB3K8gZMLITiGTcTSXMP2kKzG2fOP
         IB5XFE5dT6yg9esbqTiWglAv2Jo1fBqGUOyuedhVFa80mQe7oV7BZ7GFRrmT7Nc5Ypj1
         cQxFkHcVfPrbGJjM2jYhmVHL2Pr1M4e+CsToVxZkvhzrRLz7cUkmaLpAmU8zU7pdGuCG
         Xidg==
X-Gm-Message-State: AOJu0YxMzoJhRXGizHoBfTydl1Sosv78QUWTZ5Fjp3vq+1cXQf395NDG
	oO/enT4IRBlFlps1q8fi5DeXGGmWWal230MZlMrbyLZtQE8W3uyUNBi6+zVRErqqbteA/5I3qoh
	qwskp3B+mEWPgBsAjgbNaCJ8NLnza1XhMIHfbk/X7f6HssHVGu2fq0Ok040IO1lBt8g8ghFQX+V
	WBlbhSVVHOF0HhIxXjwrrJhZjuZbWKIR3Auo6AuRE=
X-Gm-Gg: ASbGncv7JI4EYscvDHiRK92eaAhv3bsAL/4tGCnTrDb5rqSUBEuToRPptNn144dFyHE
	OtPEqnG9LywYE60/dV7WrZPGeeRaRkEhO4pIDoPgX4azKqo4ei7GlF7WwM+N+IDHfJPQqM5ocSm
	byP4EXZTJNPBsZ43zSaDWMu6t8d+QnqAM07p/Ef0zppdOwmhcyUtOnEikXMLLFSmWYp4dODfpJm
	XBgohC/re8V0MFXwdGCkCZ3LdBqCGu89z5+rofQy0aLGvCQCg/dSu/Cg5BHJRj6N4k/UDAlnTK8
	Zy/deZJghY3MatonoZc0VFrGpWG4JUmCkIj7tAtKhIe2
X-Received: by 2002:a05:6402:40c5:b0:618:19d2:7251 with SMTP id 4fb4d7f45d1cf-61819d27686mr3322875a12.10.1754861418596;
        Sun, 10 Aug 2025 14:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk0kQH4sH55NUTsKs6w3AmIcvIJmWarQ3Lpo7MglJR9c63Q4oXiibT+ze7BGwpWToroSWj1Q==
X-Received: by 2002:a05:6402:40c5:b0:618:19d2:7251 with SMTP id 4fb4d7f45d1cf-61819d27686mr3322850a12.10.1754861418095;
        Sun, 10 Aug 2025 14:30:18 -0700 (PDT)
Received: from [192.168.1.181] ([193.165.40.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm17023314a12.60.2025.08.10.14.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 14:30:17 -0700 (PDT)
Message-ID: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
Date: Sun, 10 Aug 2025 23:30:15 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To: dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Content-Language: en-US
From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: wait code is fishy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Good day,

I don't report a bug here, but some rather contrived code.

Looking at waitproc() first. Hmm, what that
"break" doing? Aha:

                 do
                         err = waitpid(-1, status, flags);
                 while (err < 0 && errno == EINTR);

+               /* Return if error (for example, ECHILD); or if pid found;
+                * or if "block" is DOWAIT_NONBLOCK (=0), in this case return -1.
+                */
                 if (err || (err = -!block))
                         break;

                 sigblockall(&oldmask);
                 while (!gotsigchld && !pending_sig)
                         sigsuspend(&oldmask);
                 sigclearmask();
	} while (gotsigchld);
         return err;

(Maybe rewrite it to less cryptic code?
if (err)
         return err;
if (block == DOWAIT_NONBLOCK)
         return -1;
)

So, looks like waitproc() never returns 0. It's always -1 or pid > 0?

NOPE. It's non-obvious, but if we exit the loop if got a !SIGCHLD signal,
err will be 0.

(Which would be more obvious if it would say "return 0" instead of "return err").

It has only one caller, waitone().
Which always returns waitproc() return value as-is.
waitone(), in turn, has only one caller, dowait(). Which does this:

        if (block == DOWAIT_NONBLOCK && !gotchld)
                return 1;
        rpid = 1;
        do {
                 pid = waitone(block, jp);
                 rpid &= !!pid;
                 block &= ~DOWAIT_WAITCMD_ALL;
                 if (!pid || (jp && jp->state != JOBRUNNING))
                         block = DOWAIT_NONBLOCK;
         } while (pid >= 0);
         return rpid;
}

So the dowait() return value is 0/1 "got signal" indicator:
0 is "we got a !SIGCHLD signal", 1 is "we didn't".

Not clear why we bother. We already have that indicator,
it's "pending_sig" global variable.

So the calculation of "rpid" is redundant.
The only caller which checks dowait()'s return value is waitcmd()
and it can just look at pending_sig.

The reason for "pid == 0" retrying NONBLOCK wait for more processes
is unclear: if we got here, we already did wait for processes
just now, got none, waited for signals and got a not-SIGCHLD one,
so there should not be more processes to wait for.
A comment explaining it would be nice?

-                if (!pid || (jp && jp->state != JOBRUNNING))
-                        block = DOWAIT_NONBLOCK;
+                /* If got signal, do one more nonblocking wait (why?) */
+                if (pid == 0)
+                        block = DOWAIT_NONBLOCK;
+                /* if waiting for a specific job, continue blocking wait unless it stopped running: */
+                if (jp && jp->state != JOBRUNNING)
+                        block = DOWAIT_NONBLOCK;
+

(If you modify this code, please move waitproc() definition up,
so that they are in more customary sequence in the source:

waitproc() {...}
waitone() {...}
dowait() {...}

instead of current

waitone() {...}
dowait() {...}
waitproc() {...}

And maybe fix the wrong function name in this TRACE:
static int waitone(int block, struct job *job)
{
...
         TRACE(("dowait(%d) called\n", block));

)

