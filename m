Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387117;
	b=eZc2/Qw+WqHyC2jHPtEfEfkqDrCdyDE9m6sEtzdu9rSyNZWjVZraDLmc9tqHuH85qbIP
	 8ENLhzgoVAXCOsM/DT9fTCpwpfGxi9GRKumf9IBRk98FBCWlkfTLQDmZcshZDPOjjDdZZ
	 mwaY0Vy/ia/JH9/fnw8khzU8/PAc+gsA/fl2NEfXgk71xkR++OYib/xFRWg1rYYpOHHid
	 4vL2qeiEILS3JUetIal6d05ibx4/4AVsUJ7NimtCFRZFsSBmzT8fFF0u95R5+BD6DhtKs
	 h3fkvMAoDoDGOMtdEnwUat5OT4wH085jG1pstvmirq9C2pXljYfbhg8VuLS458bf9aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387117;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pEN2UVnakguLD2zgtjDJ4eacbOAolcV6tlcFyjWOEXk=;
	b=5hFO0dsPnO50j2Sz+HCJFur9SP83l3trvZOJXo9F9X1E5vavHfSaR16LXYk3X2cUZUGY
	 KfBXa1SmAVvpQPFlj7q0Q1SmdlGnp9AV14ps9V0hJsxd0vR9itcpDHmn6VrQ/KC9Kwyxi
	 gU5+M9ZLnF0RO8OsBBpoUHuuPkY4PKxnulTS+o2o/H0HcQhnpjwQcAxSdgqggUbuhfJgs
	 CmqJhCsvRcnCAVR7WQ4rR1sh7x6ykcBz+1iMAkKGWDFs3HiFTkSHFNU9ZvNUw7RWpWCUC
	 Eefup5n8sHPg0bnOaDi05IsWAXmmJfpRuBqy3MW+JYR1Xo9ER9zYocbMlddaZ5Q3qWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b="cypx1/7o";
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A6606A32A
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 08:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 492A6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=cypx1/7o
Received: from [192.168.9.110] (198-27-206-187.fiber.dynamic.sonic.net [198.27.206.187])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AB8ph38009257
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Nov 2026 03:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794387106; bh=pEN2UVnakguLD2zgtjDJ4eacbOAolcV6tlcFyjWOEXk=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=cypx1/7oZzfwbMyeBs/Oafq1UblTjUWyhqx5E8WeVnEkunkLynobxSiqWm8BvF86W
	 C/RB014s3++ZH9Ad+/v4cjeENj9v/6ehX2p2r/0/q3R+l7TUfpKkLpiNm5nVrUh7ny
	 XDv86hOyRiZLhRJtY0vhsObiTRq8hZn3PpXvV6Z5X9fYK+6OevUmC668KIs3XFxLg5
	 udcJo5XZQfw2PmnhBqIuFqyTjvjIv5BPy7Ljrm/TeEGJO7dm7Q4aV5Y7cggDjYlW3N
	 W7PlTBgAJCzkOA/JfANAPkB2J9cmCy0SbA5kXW7QxXHuNm3BRpAuJIsdwmk3mhCZru
	 BZzu+o+8/CXew==
Message-ID: <c6f2b0db-e5e3-483c-aeb2-eaabb574112a@mit.edu>
Date: Wed, 11 Nov 2026 00:51:43 -0800
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
Subject: Re: [PATCH] shell: Fix unsigned char promotion and truncation
To: Herbert Xu <herbert@gondor.apana.org.au>, j.daubert@posteo.de
Cc: Dash <dash@vger.kernel.org>
References: <df9d5e861c3fc9bf6754fecc113616c1@posteo.de>
 <aPeKvExPB1HluHly@gondor.apana.org.au>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <aPeKvExPB1HluHly@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 06:29, Herbert Xu wrote:
> When a char is promoted to an int, it needs to be signed as otherwise
> comparisons on it may fail.  Alternatively, an integer needs to be
> truncated to char before comparing it against another char.
There’s another instance of this in argstr() case CTLMBCHAR:

  		case CTLMBCHAR:
  			c = (signed char)*p--;
  			mb = mbnext(p);
  			ml = (mb >> 8) - 2;
  			if (flag & (QUOTES_ESC | EXP_MBCHAR)) {
  				length = (mb >> 8) + (mb & 0xff);
				if (c == (char)CTLESC)

Since (signed char)CTLESC is negative, it never equals (char)CTLESC on 
unsigned char architectures.

Reproduction:

$ uname -m
aarch64
$ dash -c 'IFS=ë; set -- ${u-a\ëb}; echo $#'
2

(Expected 1, as on x86_64.)

Anders

