Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843D2D321A
	for <dash@vger.kernel.org>; Mon, 11 Aug 2025 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917064; cv=none; b=DK/6eaWBqMGc/YLlDnpB2/sUAozA0FzEgqg1vaz08wmFT+CErhtK8FfdtvxUzhlRCGXlSi8iJkyRN48NicARG2t6eDUjLAsQMZZP2tN650ISEYbZ4rC+hNkGhscaOrsdhrWsnnUkQ+Fx6NKJsmnhhd6W6xzX8ovBHTIeAjWWssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917064; c=relaxed/simple;
	bh=tmBT5vGd4gaXdKho2QPNmLTFyjh2sMwyrzc7Ri4UHnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IwNXaet4/sjRK3dt/FZ/G0pJ0b8jtJczEQNzgsISNN1128Rqx8l6lEmQBKaHezhs/2kkecVSMV94bxLXvzsDYumEcU+xsnxLZBy0Bel33YVECWG5R+PT83BX5P9G/+UsrNvRN3BgrVQ9ZkaS7/DnFPI43y3t4AElT9bga1vAk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=KUW/6P8l; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="KUW/6P8l"
Received: from [10.96.0.68] (185-177-124-97.hosted-by-worldstream.net [185.177.124.97])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 166DA91;
	Mon, 11 Aug 2025 13:57:37 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 166DA91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1754917057;
	bh=WGjpyZlwYAQWXx42zD9AjiBVmcmIGgGLHuktPcHytkM=; l=2574;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KUW/6P8l8L8K0+/WH9Kfhf3gHPUzY0Bn4N+JRHEv67KSKkA64WQ6T7V28F2M5216t
	 lHA+GmhldddKCQmwLz+ViecvIYGO+nvg0bGtWSC3cvuWp8zWnZpB2SSM1qLERP+QCI
	 UzFiN6+rG7d1k+UrV/rsJAOA+OU/IU0mPJuwhehc=
Message-ID: <c9366587-0723-4380-b50a-a43035678523@gigawatt.nl>
Date: Mon, 11 Aug 2025 13:57:35 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wait code is fishy
To: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
 <a708d788-e496-4478-b1b2-48ccfae092fd@gigawatt.nl>
 <5d9124b5-d687-d864-b73d-79d9bbcf160a@redhat.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <5d9124b5-d687-d864-b73d-79d9bbcf160a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2025 08:52, Denys Vlasenko wrote:
> On 8/11/25 03:21, Harald van Dijk wrote:
>> On 10/08/2025 22:30, Denys Vlasenko wrote:
>>> The reason for "pid == 0" retrying NONBLOCK wait for more processes
>>> is unclear: if we got here, we already did wait for processes
>>> just now, got none, waited for signals and got a not-SIGCHLD one,
>>> so there should not be more processes to wait for.
>>> A comment explaining it would be nice?
>>
>> A signal that gets sent to a process group can simultaneously be> a 
>> nonfatal signal to the shell, and a fatal signal to the child,> where 
>> the nonfatal signal to the shell may get processed by
>> the shell before the SIGCHLD resulting from the fatal signal> to the 
>> child. I do think it's possible for that extra> loop iteration to find 
>> more processes that have terminated.
>>
>> Whether this is an important case to handle, I do not know.
> 
> Of course any additional iteration of wait3(WNOHANG) has a chance
> of finding more processes exited or stopped.
> 
> But by this logic, we may as well decide to do seventeen
> iterations of it, not two.

I think this is misrepresenting what I was saying, and what the code is 
doing.

Currently, the code loops until it gets a result telling it there are no 
more processes that finished. You're suggesting looping as long as it 
gets a result telling it there *are* processes that finished. The 
difference is in the case where the shell got no information at all on 
whether a process finished, because the shell received a signal. You're 
suggesting (please correct me if I am misrepresenting what you meant) 
that because the shell received a signal, we already know that there are 
no more processes that finished, because any process that finished 
before the signal was received was handled already, and any process that 
finished after the signal was received is okay to ignore because the 
next attempt could have missed it anyway due to timing.

For processes that finish before the signal, and processes that finish 
after the signal, I agree. But those aren't the only situations: I'm 
pointing out that it's not only possible, but reasonable and common, 
that a process finished and the shell received a signal at exactly the 
same time. That is the situation that the code currently handles, that 
your proposed change would not handle.

Again though, I do not know the impact of handling or not handling that, 
so although I disagree with your rationale, the change itself may 
possibly still be fine.

Cheers,
Harald van Dijk
