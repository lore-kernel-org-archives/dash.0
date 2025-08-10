Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2AF2D6405
	for <dash@vger.kernel.org>; Sun, 10 Aug 2025 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864454; cv=none; b=ZLUM7WkGfs8OuZ+AoP55r1KBr5IZrsQ7a180QGsoT57K5jWLEOgpekNJ9PQCyFNhkyfhqFL9CzQ1+TxelaKl34gXEKJleYKK288Uk7xanMILH3hlsIqzTVqp1Y1BysZoywbaKX/g7zhEQEM8wrk7VuHcVBp1Yob8Ei1QObRlziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864454; c=relaxed/simple;
	bh=SaSrsUSgdSq5Y/q9cLdtycHUgL/mZ8lvNjde1PrHRn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rRmHw5Qlu7B4KKoGrrd5mjMVjapkL1sO2FkLtm31sX4t/giD12X6jbahkdI58Hw8ACX699Cz/BVWg1wRlC5heXeU8guEFVYhQVC0AzTJJkss+UiUMGMJV63Ih971LD6k28GwxLx/ks+M5gD8D4H6c3Jx13ZJA9UqhreaqeJFOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=Q/cDCrEg; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="Q/cDCrEg"
Received: from [10.96.0.68] (185-177-124-97.hosted-by-worldstream.net [185.177.124.97])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id A5DEAE9;
	Sun, 10 Aug 2025 23:20:41 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A5DEAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1754864441;
	bh=hmTcNxF4/dHPLdJrBb9qvAvy/aXrGQEV47F/vU/Kqb0=; l=2163;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Q/cDCrEgJo04dSid3LkSqFgY3L9vM1u9XWU5q25sIiYsazw09mihHZcVR5/RV3uCp
	 m/HnV3tYCNDRETpDUOgmYH69Po/+Lu3K6hvGg6mEogNE+vxOc1iYlmzKrVBIR9TOd1
	 rOfpK/DF35aleNw21c7lQMwqF52vt2+o1Ao2AjG4=
Message-ID: <b6a063f8-9844-4f81-90a8-0f65e7c819bf@gigawatt.nl>
Date: Sun, 10 Aug 2025 23:20:40 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Looking at "int vforked" in signal handler is racy
To: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
 <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
 <559d8542-bda1-15a0-2e68-9b3ea04db2e7@redhat.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <559d8542-bda1-15a0-2e68-9b3ea04db2e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/08/2025 20:33, Denys Vlasenko wrote:
> On 8/9/25 15:52, Harald van Dijk wrote:
>> Hi,
>>
>> On 09/08/2025 14:29, Denys Vlasenko wrote:
>>> struct job *vforkexec(union node *n, char **argv, const char *path, 
>>> int idx)
>>> {
>>>          struct job *jp;
>>>          int pid;
>>>
>>>          jp = makejob(1);
>>>
>>>          sigblockall(NULL);
>>>          vforked++;
>>>
>>> <<<< Parent can get a signal here.
>> The sigblockall(NULL) is meant to prevent that from happening.
> 
> Yep, missed that. Should be ok. I'm mistaken.
> 
> However, this method requires three syscalls:
> one to mask all signals before vfork,
> then two syscalls (one in the parent and one in the child)
> to unmask them back.
> 
> Whereas the method of recording PID usually needs
> just one getpid() syscall.
> Should we consider switching to that method?

That approach seems solid to me at a very quick glance. I think you 
don't even need separate have_vfork_sibling and vfork_parent_pid 
variables, just make the existing vforked variable a pid, or 0. A mostly 
untested patch using that:

--- a/src/jobs.c
+++ b/src/jobs.c
@@ -991,20 +991,17 @@ struct job *vforkexec(union node *n, char **argv, 
const char *path, int idx)

         jp = makejob(1);

-       sigblockall(NULL);
-       vforked++;
+       vforked = getpid();

         pid = vfork();

         if (!pid) {
                 forkchild(jp, n, FORK_FG);
-               sigclearmask();
                 shellexec(argv, path, idx);
                 /* NOTREACHED */
         }

         vforked = 0;
-       sigclearmask();
         forkparent(jp, n, FORK_FG, pid);

         return jp;
--- a/src/trap.c
+++ b/src/trap.c
@@ -312,7 +312,7 @@ ignoresig(int signo)
  void
  onsig(int signo)
  {
-       if (vforked)
+       if (vforked && getpid() != vforked)
                 return;

         if (signo == SIGCHLD) {

I do wonder if the use of vforked in a signal handler, even in current 
dash, would require the use of volatile to ensure no compiler 
optimisations mess with it, but I think that is not affected by this 
patch. If it is necessary, it is already necessary now, and if it is not 
necessary now, it will not become necessary with this patch.

Cheers,
Harald van Dijk
