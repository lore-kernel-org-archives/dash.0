Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970D32ED28
	for <dash@vger.kernel.org>; Mon, 19 Jan 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840729; cv=none; b=OVDaVs+FyutaO31L9w3G7PSwbhiGORVrswL8ItCVtCjnyCvweXTH8uOnl9ZG6ZJ22Tk9qn3+/B7WEwG9jI9jnuIXrl8tqB/aE70O/aEhjW2uVVMxGLrsUU/FLiJ7KAonshY/mPzeZOSVm8cUC5YISQm9lKODfrIkeZ9tjpI8zHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840729; c=relaxed/simple;
	bh=9XmOIPDSLkYpTV8+V1B+hlce9H86efruBhE+cWqalnk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NkL+b4Te6fy60Z/8GtCxmOPUAx4fK6uIMh9J5RCrRvbYhzd7BLwqe2LZgiYXTWLmXLe6k9j3E7DM6Fa32GIbddpHr4MDOYi3KpzqCNJHh4R1MPLmz87DuRkGIme/4SpPFtWmiMs8+pPdyetArWgwLhk+h5uQiNOs+Z72ofdHba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI2opqAZ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI2opqAZ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6446c924f9eso3663788d50.1
        for <dash@vger.kernel.org>; Mon, 19 Jan 2026 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840727; x=1769445527; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYn/en0kcr5JL4lY+tGrWTbnQPucdDODq1+185NIHPA=;
        b=KI2opqAZd60WpFr+91Iqhpy4kAC8vwHR9E9o4aSCvOZkHbdOu0X3wCWKw2jiomVxIk
         1KoMRpYWWl7C25dmrbw4UMvUuV2cL5xdgvMW3mdvAScYy6prNBW0ZfbNzPpl3V8H0nlQ
         I4LczEv4D0yFLDjvC8JLtXXanJpWU+GA0F11e8q5QlbGqmn/4Pg6AUgJFcMfNFVzTgbD
         +jhkzp07u/VWswTtVVAXgeiP8id8Uw2OUOjPp2bDTta8xQpmxAIkoPzNbMVWQ2n24hNk
         1nAtQT0mATIpMXhLZ/lce3ftnJzgt9KJkZwtRftQjNR0yWM8cH9lCVGzbaeIYnKuCgFJ
         mdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840727; x=1769445527;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYn/en0kcr5JL4lY+tGrWTbnQPucdDODq1+185NIHPA=;
        b=w2BrUkYGaO9L8m/8QFziJ/EV8bUEBbTerFWRWFh8fLTdc7bEaigUuvzXzeONe1zbiC
         e25aHVsCMDSpU84UINEMmzbnx8PZ+r9KVvdeosmEWRUj+KwJhzf8ksoUlHo/iBra7nHI
         mBirN+AXMEI9TNAenjW8Ak/YW1p/oSO4IJzwYDlBqBwhaLVCQXNBnwnfj7jdPAiEZvDB
         wxrtFGzTE6PHV/HX+EdXxOGp+rpQ3tM81MVPqwjtBBtU0tGRlDScN1JpJIjPXr6LafZl
         vWPFE7xcmiFMlo+L0ec1nEg2r8MvYjxrNcn5QYSa6Dd1DAjgEIwz2JTsBLEW3Fq0656p
         yyvA==
X-Gm-Message-State: AOJu0YyrkziXHpKposeYhQKfDkC9YLvBBL3TDn8uIIpOL6XkTBp3cev5
	wiMevgVhDbwsTyON/FFAHQuoc2OCg9xJ4VrgH8RBUhVmwDzO6GwwNDt/poxbRxX/CfqD3NjNnxa
	r3/oiiuuUJ5tHA3rzuHiPnLf1HuIqgb3oXmXDDqA=
X-Gm-Gg: AZuq6aIbOzqpAyvZ2jtVhuVz1B7dINLzLvC0jLt6BJLN477hCMdEtKAYKAmO0ToMZPD
	RYq5DILcL//ek0QnpAcBF/huCmIByNXslj50o6mW2NwJgUEazQEhKcHxa/WyBsq/PMpTo+8dM/X
	jFOoxOy9gq+aF017rygTm7X+xMpGmlsD8PK98j11FjmJ+R7JP8eY6epCeDSlj7OnFLn1Q1yzsJm
	5MQuIcPxY6LO/oh1D63JvrwW+qi7RZxAEkp3faN4PKslrXRfIQ0CNuVsqPoBbCasFfrEHXRpoUL
	K7tmta5DLIscOXn2BorHDVjEgA==
X-Received: by 2002:a53:b98e:0:b0:642:1d3:adfa with SMTP id
 956f58d0204a3-649164cd9c4mr7870359d50.52.1768840726960; Mon, 19 Jan 2026
 08:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleksander Ushakov <retes672@gmail.com>
Date: Mon, 19 Jan 2026 19:38:34 +0300
X-Gm-Features: AZwV_Qjv4NXVvEs_4CFtjZq8i3vWjPF6PFiz6qK9faA_w5mwStoAm1NMjNMcbjA
Message-ID: <CADdNFas7pVJoDNaq_kZB-cXZjQZfrNYPKsuPZm6xboqHmJBDtA@mail.gmail.com>
Subject: [BUG] invalid-shift-base umaskcmd() src/miscbltin.c:258:26
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I encountered a bug in Dash 0.5.13 and would like to report
it. The details are  provided below.
# # miscbltin.c:258:26: runtime error: left shift of 1073741823 by 3
places cannot be represented in type 'int'
    #0 0x65484e899f22 in umaskcmd /upstream/z/dash-0.5.13/src/miscbltin.c:258:26
    #1 0x65484e872c55 in evalbltin /upstream/z/dash-0.5.13/src/eval.c:975:12
    #2 0x65484e86dec4 in evalcommand /upstream/z/dash-0.5.13/src/eval.c:923:7
    #3 0x65484e86b07c in evaltree /upstream/z/dash-0.5.13/src/eval.c:305:12
    #4 0x65484e8971ac in cmdloop /upstream/z/dash-0.5.13/src/main.c:247:8
    #5 0x65484e896e6e in main /upstream/z/dash-0.5.13/src/main.c:181:3
    #6 0x746fa5d61249 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #7 0x746fa5d61304 in __libc_start_main csu/../csu/libc-start.c:360:3
    #8 0x65484e839930 in _start
(/upstream/zz/dash-0.5.13/src/dash+0x42930) (BuildId:
f5787a810ed7cf088639c548c8ff13ea66dcb3e3)

SUMMARY: UndefinedBehaviorSanitizer: invalid-shift-base miscbltin.c:258:26

////////////////
My environment:
////////////////

Debian-12, x86-64, clang-19 compiler

/////////////////
Steps to reproduce:
/////////////////

$ aclocal && autoheader && automake --add-missing && autoconf
$ CC=clang CFLAGS=" -Wno-everything -fsanitize=undefined -g -O0"
./configure --disable-fnmatch --disable-lineno --disable-glob
$ make
$ cd src
$ export UBSAN_OPTIONS=print_stacktrace=true,symbolize=true,print_stacktrace=1,report_error_type=1,symbolize=1
$ ./dash < myfile.txt

//////////////////
Steps to get myfile.txt:
//////////////////

copy the text into file bs64.txt (between ==== and ======):
=====================================================================================
Y2QgLwpwd2QKaGVscCA+Ji0KcHdkCnB3ZAplY2hvIyAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOLWRHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQojICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24gMyBv
ZiB0aGUgTGljZW5zZSwgb3IKIyAgIChhdCB5b3VyIG9wIGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CiMKIyAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdp
bGwgYmUgdXNlZnVsLAojICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3QHRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2YKIyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlAAB0aGUKI2QtMQphCmVuZC0yCmE6eAplbmQtYQpi
OngKZW5kLWIKYzp4CmVuZC1jCmVuZC0zCmE6eAplbmQEYQpiCmMKZW5kLTEKYQpiCmMKZW5kLTIK
YTp4CmE6eQphOnoKZW5kLWEKYjp4CmI6eQpiOnoKZW5kLWIKYzp4CmM6eQpjOnoKZW5kLWMKZW5k
LTMKYTp4Cnd4MTAwOF09LGc9cngsbz1yeAowMDAyCnU9cnd4Yjp4CmM6eAplb2QKJEJWQVIKJEJW
QVIKJEJWQVIKJEJWQVIKZm9vCmJhcgp4eHgKMDAyMgp1PXJ3eDEwMDhdPSxnPXJ4LG89cngKMDAw
Mgp1PXJ3eCxnPXJ3eCxvJHJ4CnVtYXNrIDc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
NwA3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
NzdtbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbTc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzcgJ1slc11cbicgZm9vICRACnByaW50ZiAnWyVzXVxuJyBm
b28gIiRAIgpwcmluAAAAQGZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmICdbJXNdXG4nIGZvbyAn
JyRACnByaW50ZiAnWyVzXVxuJyBmb28gJyciJEAiCnByaW50ZiAnWyU=
=====================================================================================
