Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64560EEC3
	for <dash@vger.kernel.org>; Fri, 30 Aug 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049482; cv=none; b=ciXcXkHA9oJT/utMVK3576RABjiatu6PXMI4mRoIQTPkm3bQSxp4slX3ShI1VeuHyAtFse0wLyAT10RuWVk8v7y6vThDm0AEnbrEQmLd08sH1ky7r+VbvRJnIFe9myWATJgNbp43eyf9+b36BZbSi6u1N6DOxCfHA8d1KDoV7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049482; c=relaxed/simple;
	bh=PlYuMlI2jKzuLHeeXlHvMk624MmwkAyh9puG2wjeC+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RtsNo2rGn5t/G8sMlcuYLOFupdOIXyhQ6cjtiYpuOOcUZJzB7DFsbfUBGpenE9yNMjn0s2iZOmnZn8oNOiIfiIzPNiFYsh5QfTvddliPv83hG58JTxdwePge2hHtIJzL/tRuIYJrMveJDmZyP5pdJ1dDvut/HjsjlurhpXxhp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=A714O1/Z; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="A714O1/Z"
Received: from [IPV6:2a02:8010:68a1:0:aa8:4aa0:420a:466c] (unknown [IPv6:2a02:8010:68a1:0:aa8:4aa0:420a:466c])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id E680A512;
	Fri, 30 Aug 2024 21:24:37 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E680A512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1725049478;
	bh=4nw5mGNe1lVQ3u35iOMCCV/HfeGct9Mw+Kir5zBjyaY=; l=914;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=A714O1/ZeZ7qajFyqfZZhxeWEvMpRpkqrehGfa4tYDZZ+8b7yBrZoitzK4rbDP0j1
	 /Bvm3+K9yNkFOu3iHooEAOAjJcB0Bf7jaIGRutq7IWPyuQtGZSeTfU8AaeHk8rxu90
	 MQG/42m2uZQAuNxUDX0eShTZP0/WMCwY/ZzUgG1A=
Message-ID: <63da0ea4-61a5-4095-9aaf-036e3faed245@gigawatt.nl>
Date: Fri, 30 Aug 2024 21:24:37 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does the command builtin not circumvent invocation of
 builtins?
To: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>,
 dash@vger.kernel.org
References: <9098f57c-66f1-40fc-a714-b73d208c81d6@anselmschueler.com>
 <58645737-6af4-493e-8674-378c574fa78c@gigawatt.nl>
 <74ff2a7c-e973-443c-8006-07a6c17dbec7@anselmschueler.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <74ff2a7c-e973-443c-8006-07a6c17dbec7@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/08/2024 21:17, Anselm Schüler wrote:
> I see that I have misinterpreted the text. Thank you.
> 
> You wrote “This also matches how "command" works in other shells as 
> well.”. I wanted to note that this is not how it works in Fish, where 
> e.g. command cd will try to execute a binary named cd from $PATH. I 
> believe this is where my incorrect understanding may have stemmed from. 

Ah, thanks for that information! I should have said "in other 
POSIX-compatible shells": fish does not try to be compatible with other 
shells, it tries to be its own better thing (and I generally like what 
it does), and there are going to be other confusing differences as well 
when trying to move from fish to more standard shells.

Other POSIX-compatible shells that are useful to compare to to determine 
whether behaviour is likely to be intentional include bash, ksh, yash.

Cheers,
Harald van Dijk
