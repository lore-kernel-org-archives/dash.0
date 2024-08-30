Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7E1BC063
	for <dash@vger.kernel.org>; Fri, 30 Aug 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042509; cv=none; b=HVgJj3Hp2OM/naLpWyZey6pmny9HiqMCjss4AGY1YNvDYEkB4P0DkWWlOd3Rl158rLgQmOcH3dKn3x2f0m/qfiQ+98WnNMm/rua1t7RQHA8QqcAIVbF42P/I2IQbfcE2YxrDEBWe5dOY3adhI8aFuNxWbiSeFqigu/ruj7moa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042509; c=relaxed/simple;
	bh=2k+s9X+uRhQvDH4lQMP47jrLxwh01l1cBbRYbvJOGUw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EKTLxSmjL9XDLTaQlP9Pup+/pxoVVAhsb5Xoyjn0VKjaYvVHd2H1+o/f9Pe16SgoJDpeZDjgIKr25ZD904nEaY4tiLwr94oVUWeyNCecCCZKPpO1fEkV41O40hVx3uMEh83FCjfD5FnToQDUvaRmJhpuKXe7XJV24l2uFCIQSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.179.249] ([46.253.247.91]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MofLl-1sHxUI3pbF-00cPGU
 for <dash@vger.kernel.org>; Fri, 30 Aug 2024 20:28:19 +0200
Message-ID: <9098f57c-66f1-40fc-a714-b73d208c81d6@anselmschueler.com>
Date: Fri, 30 Aug 2024 20:28:19 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dash@vger.kernel.org
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Why does the command builtin not circumvent invocation of builtins?
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:11caIfs4e+yP7g4cHpN+uuNSaIp9zomM+jkR/ujnUSqujOhRLVF
 UxdLJDxlay/d84fxnbvlLAL90fjT3ledwvS5JwMWJTriac7E5CWRUdOjuoas8Q9k6msH/yf
 JMg9ney5YGOOb8CBss1P+001p8w8PJ+IbvVrhXLALNd+B2oDN/wjjt93b4tVbcTZI24KwNQ
 /u8ee3WfZrWSgQbiRtfvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0VmBitwTqbg=;bv5s2Epzp9zFD69PxE9VQVr4bTg
 AHRgud3D0WZJd3SaoXX43LLeoFUEXxlRPBadLABSgRJuw9sqtbYB8rJu7Tj52nLzE0AkYzirI
 vAIymlIGqGwvrfNk05HpowRziBaMNU3obaUB+XqKoiAO52UrhAsC4yEdX7vTSg+Gk1m9yuJY2
 Gat/zWCOjNVa/H9Z073rNfcOvFfmfNkV+qPRtqpcR+ea6UI1EqEuJPXKh1d+4RYRwxhSLtANq
 hLQEe8p4d7q75H/XBntHoEXDy4pp7D/1XSAfi5Fje/qCOm4ezQjk7GbhFG5gnDNkpzvkOyQF8
 Pw7DiVujnnKBxGT90ZdV+KwV3kaOK2UL5fGPB+YaARw1L2Fa7umw8G51IMxZVRTqP2KjZzUu7
 6zzsqDJX/OxD643hQhEY+cnli/VQsZQBa6zG1bFzB/9MfFhqC29d42TtiwcmDHRpxEhYShnf1
 QfPBKbhQ9bWBG0ot1ROTxpPN2AbK5vjPPik7+ePYPj+yYvDgEsTx2eqsJzntryzzhdOZwczGI
 Ag+zJZaGc98jXF6guomt6p87lHKWpnvRNsJ9eieToAo8O4/BrHAQao09TbZ5SuyG25mpslarM
 nZHJO13h6xBk8fvXSPTnBdREk8r4ptfSTQEWf589TB0O+bTyUHQBpvHfEYJKyGD0izPSPwD+0
 6Q3/jBqWPvbtNVyu7ea2rdJ+6cw+pcII1f2tJ8Bt+5b8/dqFaFIRAoOveZrfxYxLjDVFmGstn
 zNoUeP/BgbGihEri8rtJ3CRAh7x31tbe4YA8dJ200YLp8LorWqUvlU=

The dash(1) manpage reads:

command [-p] [-v] [-V] command [arg ...]
        Execute the specified command but ignore shell functions when searching for it. (This is useful when you have a shell function with the same name as a builtin command.)

Because of this, I expected commands like command . or PATH= command 
true to fail. They don’t.

You can observe this behavior by running:

for cmd in : true . alias bg command cd echo eval exec exit export fc fg getopts hash pwd read readonly printf set shift test [ times trap type ulimit umask unalias unset wait
do
   dash -c "PATH= command $cmd"
   printf '%s: %s\n' $cmd $?
done

Is this an error in the implementation, the documentation, the build, or 
my interpretation?

The DASH binary I use was obtained using Nix from cache.nixos.org, which 
builds from source tarballs, specifically 
http://gondor.apana.org.au/~herbert/dash/files/dash-0.5.12.tar.gz.

Thanks
Anselm Schüler


PS: Why does this mailing list not permit emails that aren’t purely 
plaintext?

