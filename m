Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB21F7569
	for <dash@vger.kernel.org>; Mon, 13 Apr 2026 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044044; cv=none; b=ZZb73HkYSWbDriH+m70s61tg3uZfgZqL9f9AqjGlq+VfnBdKs3N/GpxHrrN8BHdssUo9pqXrKiw0j0q+5mcDSmPPqBpdv78ps3wjP7IvpN9FWXHA5354lQLBvnxZ6tGLs5UGNwgh4oziHzCvu2K2lxKHfu/lG6q6VkzSBKjap0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044044; c=relaxed/simple;
	bh=eHHSdW30dMtsed+7xoUxYbRRDY90D3sjKscbX/TgsVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AjNhwIQVxPv1foRyhaIB8k7fhpvQk8JWNjK1tB9lpJ92Fn7Ir8/DZD2GsgJhko7GbN1Rfc1FLqH/NHX/Tc9RpP96M9qztr+7y0CuxgiiEJn03F/rxDstBWpFJ0o87+u8YjJgYEtiP/RjK1Zdl3p7JrKLZneonSx7HKFgOVDIL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=Z6q4l0pj; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="Z6q4l0pj"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 7E1B5A01DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1776043567;
	bh=VoY9/7WeANp/wAteo0EZKTMt+faT+iXCpWYtAZoQBiE=; l=812;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Z6q4l0pj/AFBsU/cxh5UByHk1ReAZOIZ0l819dZQi9xwkY1GXSn7NOx3cQffs5OaV
	 Cs02s5lBrUrMgKkvHD2CC8W6mtXfZVTFAkYrKWqdHm/jMe+LzTOoGvYb4yGeE99H6F
	 YUx6PZazWWD0YYLuRfcshjwF4RCa20wu3jApLyw0=
Received: by mail.gigawatt.nl (Postfix) id 7E1B5A01DD;
	Mon, 13 Apr 2026 01:26:07 +0000 (UTC)
Message-ID: <a7604baa-02b5-4b26-8569-a27a806b50be@gigawatt.nl>
Date: Mon, 13 Apr 2026 02:26:06 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WASM + dash (again!)
To: Samuel Marks <samuelmarks@gmail.com>, dash@vger.kernel.org
References: <CAMfPbcbH6C6vd8Cp-sWfpZL5ih_q=2pTMcDbZ9PidQFjzc+3hg@mail.gmail.com>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAMfPbcbH6C6vd8Cp-sWfpZL5ih_q=2pTMcDbZ9PidQFjzc+3hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I don't know enough about WASM to comment beyond just loading it up and 
seeing that it seems to work for basic things (which is always a good 
sign) but:

On 13/04/2026 00:44, Samuel Marks wrote:
> The port successfully passes a headless Node.js adaptation of the
> `dash` test suite.
What test suite did you use? dash does not have one. As some basic shell 
constructs require forking, they do not work (as I think you expect), 
and I would have expected these to be covered by any test suite.

   # echo 1 &
   ./this.program: 0: Cannot fork
   # echo hello | cat
   ./this.program: 0: Cannot fork

It is totally fine to say you are not looking to fix this, I'm just 
wondering if your test suite gave you some indication of what other 
constructs may not work either.

Cheers,
Harald van Dijk
