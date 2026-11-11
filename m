Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362363;
	b=tm8WFy8AtweS4REjXLHZDMNx8hCAFAQhcZzjS1joVVO/1H1RQnb68FaWVPE0ugjlQEYa
	 LbJo7oUVO3z9sl9Jr1PxidNWP1pwCkxWkkoDmBVTq9s3j+8ARo2R6DStTHoGH0zAgDQef
	 okdSve8Tyvo5CEEyuQkUj7+fvwG/lVnOktkVSM/1Kdc2ScORa+SZZahNAaQMwJt3tsuwt
	 +v6I6zBKMW8q2ZwWFKXgwC2FsT5t4umhNbI0V5aGFNpVcanQMCsF2/xlvECvbbNTa7iGa
	 3noJpNkmE3qoDUvEKhtfpjqo4KAFc2JecvCuBtiWD5QBJJwn7B5ssJQJJnJLF2h0I4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362363;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9DaBZ6joCorCCROF3rxzhVVozrlB1IFRrQWl3eSBeFE=;
	b=X6P0Dr8FmywxhQbE79fWwRvxmidLFOKB0vZdSDR1P/o8fXOblj5/OdV5JpHI5rsZ+NtH
	 Tnx6m7tq+QYgYezz+qHevTz0ZnRv7Hx3e/iMlDoJY6f1dzbnpWknB10sHxkYXb5XjgBM3
	 ekIn47l1137YfMK7SgMomfJgDNeg4sn7HQZGpwxkkHhzyFl7zWwE+HozH3H3aRW7BkopD
	 XeEnMMtfyA7e7sfX7WU7I8i9h/jg4hI7muNRB/8FMKLxsQB9coEd0VDI7AcRKoruv56R/
	 USazoO4pIGHTLLoUeISL9Tk93CATb6Nu2ThQEHIAxfQ+bxJRe3LFtVlcVJ0nGBo/UJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=XOFueDM8;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256A606A320
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 01:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0256A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=XOFueDM8
Received: from [192.168.9.110] (198-27-206-187.fiber.dynamic.sonic.net [198.27.206.187])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AB1x3VY023375
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Nov 2026 20:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794362352; bh=9DaBZ6joCorCCROF3rxzhVVozrlB1IFRrQWl3eSBeFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=XOFueDM8K2RBYqZtKKi0UfwjhPbjO2etBPyBSHFkjn4Aytv8vHC+8XSBjaVbV72Qf
	 SdA7h97T7VUsQjyId1xVg+MRw2S2A9SLRx5Gp3Hv6CWGKi4w2sE9tmPF+f5xQ6zY+C
	 WdOlHWyBB96PJ1RI7LS+LkdpS4GvOD+Qp1eEmSX5dlZ/XBYA5Ol17j/0yZ+Z+LZQco
	 CaG1em8w8VCQiBKt51D9uebO7YwOGQaY5DhM55ymwL+xHJZllftpZcJuTjG6Gf2tzE
	 3an8o9wIPlsBfp2WQdonVM/qau7LpUk+ik9eWxavHbLbnZh6hZsbaodoY0n5dbGszk
	 l7zBjll2RzDAA==
Message-ID: <257e0d54-d007-458f-8acd-faf2519a9e63@mit.edu>
Date: Tue, 10 Nov 2026 17:59:03 -0800
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] expand: Fix out-of-bounds syntax table access
To: Ayesha Shafique <ayeshashafique123@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
References: <20260817202007.93924-1-ayeshashafique123@gmail.com>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <20260817202007.93924-1-ayeshashafique123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 13:20, Ayesha Shafique wrote:
> mbtodest passes a signed byte to chtodest. Bytes with the high bit set
> can therefore be negative. The syntax tables are based at SYNBASE so
> that signed character values can be used as indices. However, the
> is_type path did not apply this offset, causing chtodest and mbtodest
> to read before the array:
> 
>    $ printf 'v=\377\nw=$v\n' | src/dash
>    AddressSanitizer: global-buffer-overflow in chtodest
> 
> Apply SYNBASE to is_type, as is already done by the is_special macro.
> 
> Fixes: c0c860df08c9 ("expand: Count multi-byte characters for VSLENGTH")
> Signed-off-by: Ayesha Shafique <ayeshashafique123@gmail.com>
Tested-by: Anders Kaseorg <andersk@mit.edu>

This out-of-bounds read is also the cause of the stray 0x81 bytes 
reported separately at

https://lore.kernel.org/dash/CALwy4xJPUYmHJkBvwAr02zp9HfMp0h2upeRxc4NnyXT5ELn4CA@mail.gmail.com/

and it is breaking Git's test suite on Ubuntu 27.04 (dash 
0.5.13.5-1ubuntu1) on arm64, ppc64el, and s390x.

https://launchpad.net/~git-core/+archive/ubuntu/candidate/+build/33960211
https://launchpad.net/~git-core/+archive/ubuntu/candidate/+build/33960214
https://launchpad.net/~git-core/+archive/ubuntu/candidate/+build/33960216

Please include this fix in 0.5.13.6.

Thanks,
Anders

