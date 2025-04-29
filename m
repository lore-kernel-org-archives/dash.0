Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9869221719
	for <dash@vger.kernel.org>; Tue, 29 Apr 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958417; cv=none; b=TbrGLNr/CupFV55NVPhNlJVhPaRVz+fsEbZJ7J5oT4Eiwe9np3yMwZa68RXhtFGTfHdxaHqF7ywJimuZoDOYy3jCmVybmqyl+fYcQZfQyOEO7rKexr2Z61dSFsb8qj1H2CS0lokvD/gZspsSV02l/zFBdnHZcOVW2kZCCRSrr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958417; c=relaxed/simple;
	bh=M6q3ezz8mrV8XvHkXJhDOmnoc5pWWgrp7b+ahjId+F4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F+iiE3O5+ebfQWeNLjB4+E5pq0VAt26wMjJ7fd1Y/9om2T5Jx9lXRwBZTZsKTvyhTjxExsSZ9tZTxd26rLrWd9M73lL9PS0jLlb1OX3InxVYrl1BAqJFNaUPYDplEuFjEz1HMWH1EfNN4W5Zjk1k/11FP95l8b88yZqSK9bjZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdiDvx+I; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdiDvx+I"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso10119342a12.1
        for <dash@vger.kernel.org>; Tue, 29 Apr 2025 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745958414; x=1746563214; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKcO6PDhVELZFTq5mzxeiFc01gXmdk/uC7Hd8CVGurQ=;
        b=fdiDvx+IzWwg7AMG1qZBAK6NcDCMbIWx7MTve46DwfyV3dwqOhB4Xem7b4ZpAfl/PA
         UktzHctLcuDeRexouuLsbrb31Y368178XeyklBQfMGOogW4aS0x+fj3OnWrkq6TPsY7G
         RKSfV/1jaZYNaBmNnxpgN0akTdIrvxm7potxTklk7rSRgOspgzcSlGPjB2aYrLvUENyX
         x7oqw53IexHuzGKH4pZjEYlw50sb5KBfjrErL4o73WOqPQ86/s49FUh3ddbDUwWaNHSE
         L4nL+NkwQgi2FG5Ko8qfeTd7djEVa6jh99TSo4PwoGu1Xdbv5QTr9Ri8BzEUDHvwFgav
         BQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745958414; x=1746563214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKcO6PDhVELZFTq5mzxeiFc01gXmdk/uC7Hd8CVGurQ=;
        b=E1k4/+wCbXzk7e2nTTbUEABFTNKatP9CZUvbQio+9BD0k3quTRiWx+Ythd39H2ZX3A
         eQkANUqrQTrhEzYrTL1J0fkFo0UXrWYlVkKVK6ksRNSGe/iScqI2hOHest+KBl7BH9hI
         nInlpt/WHPL110ufdejuc8wsOVwJMBrSQ91OkKgj/n7G+BWi793gwqAIpYIP55jHj6oY
         bFu6WiInwn7+L9mK/CasuhC18fFhvYGdCylnWeV6lP+UHJ5BCSrANHr3+8Xy3NuAC6hr
         4NdVXW+flQgtCNPW/e+gc9EciUVPpFmbJxn9nV4pZPCSxT5UCV1R3gxjhNtkh/bXK7t+
         Pjhg==
X-Gm-Message-State: AOJu0Yybk5yyOZXqB/p3KAbhgSc+E/kWlXBPcsBhokMH01z9+yAangpi
	WClMSXgArdj27PM2IQLLrzd4Myh+Tyf/G4qfKi3g8n82aKjZuMBZ
X-Gm-Gg: ASbGncuhR50ZwpbRsnvNkgYUqlrh94EmgHq93O9jTeITBXW+t/dELP0oKIsYDcrHxy0
	XdGgG2jyG/Roph+IBucDNYYEiREqtG6N7DpMz40pVwB9/qg6ao1DjEou9/Ay0y+mfK+zNRNpQxb
	QX61Hu6mZ9l1dUATddSnckvdSz7m0xleOr00rWJKXefFqRDRpnaKd1Bti5c8RYeWsBirRYvvjZX
	G+X/utPUep9QqVmdDoS52AdoQ2431CEZGCE0ujzeTQQVXwyqTW3wbUBqp6pKM5kP+yraTEOFHMK
	P9rfSg9lf5L9nhZh05HEGjydW6Vb6DNVEVr0rN0iDzzW1EPSLqxZ875T7miizOS7Z7XHvkRiBvq
	q1+2gcIo=
X-Google-Smtp-Source: AGHT+IGI667MZS9mjKl3lfOV0FJLSkR7/vNFul/8Z3zrXh2QSXEEliE7AvjurP0ZoQ0+4F7cDpUYgg==
X-Received: by 2002:a05:6402:3585:b0:5f6:23b1:ab43 with SMTP id 4fb4d7f45d1cf-5f8997634acmr342671a12.0.1745958413775;
        Tue, 29 Apr 2025 13:26:53 -0700 (PDT)
Received: from gentoo-framework (92-70-146-242.biz.kpn.net. [92.70.146.242])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f6770sm8028087a12.43.2025.04.29.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:26:53 -0700 (PDT)
Date: Tue, 29 Apr 2025 20:26:46 +0000
From: Zurab Kvachadze <zurabid2016@gmail.com>
To: kit-ty-kate@outlook.com
Cc: dash@vger.kernel.org
Subject: [BUG] dash -c 'echo test > "${1%.in}"' sh /tmp/META.in segfaults on
 master
Message-ID: <zrznukw6p7xhwg7tpp6cnzeqyhcg3rdp2ls6ffnbdtejtnksj5@tsxkbmidd6qx>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

After a Git bisection and thorough debugging I found the bad commit to be
c5bf9702ea110bede687b57c0b5fa3fd0e15829e (expand: Add multi-byte support to
pmatch).

The command line that causes the SEGFAULT is
     
     dash -c 'echo test > "${1%.in}"' sh /tmp/META.in

I tested dash from the aforementioned commit with this command line.

The bug is "fixed" if the macro HAVE_FNMATCH is defined. The macro is controlled
by a default-disabled configure '--enable-fnmatch' switch.

The bug is in the src/expand.c::scanright() function (scanleft() seems to be
alright). Essentially, the isssue it that the function returns a pointer to
string A, but later in subevalvar() that pointer is subtracted from the base of
string B. This produces a negative integer which is later happily passed as a
parameter to memmove:

     // startp and rmesc are both char *. scan is a pointer to scanright or
     // scanleft depending on which side the text is trimmed from. In this bug,
     // scan points to scanright().
     loc = scan(startp, endp, rmesc, rmescend, str, quotes, zero);

     // quotes == 0, zero != 0
	if (!loc) {
		if (quotes) {
			rmesc = startp;
			rmescend = endp;
		}
	} else if (!quotes) {
		if (zero)
			rmesc = loc;
		else
             // Control flow goes here: rmescend now points to a substring 
             // of startp.
			rmescend = loc;
	} else if (zero) {
		rmesc = loc;
		rmescend = endp;
	} else {
		rmesc = startp;
		rmescend = loc;
	}

     // Due to the way things are allocated in dahs, startp < rmesc, thus
     // loc - rmesc evaluates to a negative integer.
     //
     // This overwrites a big chunk of memory including, the first argument 
     // of expredir(). This is where the SEGFAULT has been reported.
     // The overwrite causes the function dereference an invalid memory address
     // on the next iteration of for loop.
	memmove(startp, rmesc, rmescend - rmesc /* this is < 0 */);

(Comments have been added by me).

scanright() function look for a needle in a haystack, either from the start of
from the end of the haystack. The function receives two pairs of char pointers
(start + end), i.e. two haystacks of almost identical content, {start,end}p and
rmesc{,end}. Apart from two other non-essential parameters, the function also
receives str, the needle.

The first pair of haystack parameters specifies a pattern which can contain some
special escapes and rmesc points to string with these escapes removed:

     startp: "\201/tmp\201/META.in"
     rmesc:  "/tmp/META.in"

If FNMATCH_IS_ENABLED does not evaluate to zero (FNMATCH_IS_ENABLED depends on
HAVE_FNMATCH, i.e. FNMATCH_IS_ENABLED = 0 by default), the function iterates
over startp and return the substring of startp, not rmesc. But the calling
subevalvar() assumes the the returned value is a substring of rmesc, not startp:

     startp: 0x55555557c9b8 "\201/tmp\201/META.in"
                                              ^
             0x55555557c9c3   pointer returned from scanright()

     rmesc:  0x55555557c9cb "/tmp/META.in"
                                      ^
             0x55555557c9d4    expected pointer

subevalvar() calculates the number of bytes to transfer by (in this case)
subtracting the returned pointer loc from rmesc: 

     0x55555557c9c3 - 0x55555557c9cb

This evaluates to -8 (you can check that yourself) and, when passed as a third
argument to memmove below, we have our good ol' buffer overwrite:

=================================================================
==8694==ERROR: AddressSanitizer: negative-size-param: (size=-8)
     #0 0x7f316ed3b9ed in memmove (/usr/lib/gcc/x86_64-pc-linux-gnu/14/libasan.so.8+0x13b9ed)
     #1 0x5617237b53f4 in subevalvar (/home/master/dev/dash/build/src/dash+0x213f4)
     #2 0x5617237b57a1 in evalvar (/home/master/dev/dash/build/src/dash+0x217a1)
     #3 0x5617237b3c42 in argstr (/home/master/dev/dash/build/src/dash+0x1fc42)
     #4 0x5617237b35e0 in expandarg (/home/master/dev/dash/build/src/dash+0x1f5e0)
     #5 0x5617237abb92 in expredir (/home/master/dev/dash/build/src/dash+0x17b92)
     #6 0x5617237ad944 in evalcommand (/home/master/dev/dash/build/src/dash+0x19944)
     #7 0x5617237aa910 in evaltree (/home/master/dev/dash/build/src/dash+0x16910)
     #8 0x5617237aa236 in evalstring (/home/master/dev/dash/build/src/dash+0x16236)
     #9 0x5617237c4d86 in main (/home/master/dev/dash/build/src/dash+0x30d86)
     #10 0x7f316ea345cd  (/usr/lib64/libc.so.6+0x265cd)
     #11 0x7f316ea34688 in __libc_start_main (/usr/lib64/libc.so.6+0x26688)
     #12 0x5617237a5e94 in _start (/home/master/dev/dash/build/src/dash+0x11e94)

0x56172380022b is located 331 bytes inside of global variable 'stackbase' defined in '../../src/memalloc.c:110:20' (0x5617238000e0) of size 512
SUMMARY: AddressSanitizer: negative-size-param (/usr/lib/gcc/x86_64-pc-linux-gnu/14/libasan.so.8+0x13b9ed) in memmove
==8694==ABORTING


Currently, I am working on a patch. Should come up with something soon-ish.

-- 
Zurab Kvachadze
