Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00A3A4502
	for <dash@vger.kernel.org>; Mon, 13 Apr 2026 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067364; cv=none; b=JBEWvHz25NQujes33hVheoeH9LUxuJmr0hRKPE3yBUhrBkhENrgRJnKtHsdwvKPX4lhB0sqgRJ+BS2BiXstzmwyr6ti/TQiWG26PRSNl9FIvL6S/grfeXd+CTvBANJmQaNFMkx6KAeBcw2IQMhwc6soKnwtzd+/NRpXtIHMVTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067364; c=relaxed/simple;
	bh=Uunzx77lPK2lt/IRsdbnqZInQCb1BIlVWqtnlZy6jwQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=Eq0l5V/7gz90O/p2oMwIEFE6zXr7639QXUk6qfD8KZOzK0gvCK01p1q+XgAwfJ0WZXS1JmJoWaMKdnA9XJaTR18lgVyM05no5NY1eyc2ZFCPG42cTfFjWfeaLBuIzH7KF3+0IyR6OQqYq0klTok+IAJ/8bkrq6/tRMyAV/CVXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1M6lxe-1w54hN1dR0-00GvOF; Mon, 13
 Apr 2026 10:01:59 +0200
Message-ID: <f44600c9-4e9f-4887-9778-a3c18042dd87@green-communications.fr>
Date: Mon, 13 Apr 2026 10:01:57 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <adtpoV0A0LkTXW6X@gondor.apana.org.au>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: Re: [PATCH] parser: Only reject non-word tokens in case pattern
In-Reply-To: <adtpoV0A0LkTXW6X@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZUH+Sx3mrvdEiRl+laYsAz05sJsFK9728HcBq+eqwf5XQeKveha
 I7g1e8JcaA8eVGH/hA8tX36l9ejh8YSYW+jOmmeZEX+vlH+SwzKi50F96OoPk97RWjR6mMs
 4q0Ia8tBz5jQqT+Q7PUankEWKMyE5XlWdQfFA0bmmezojV+r3dPJbVB+W+p1MbrzXPwUUj8
 A8/dRhmvahPm4ZbrhOyNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uiUZ6JPotrM=;vr31Sno9FpPej4aBtjpkQvW/z8V
 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

Le 12/04/2026 à 11:45, Herbert Xu a écrit :
> Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr> wrote:
>> This syntax is accepted by all shells except dash 0.5.13.2:
>>
>> case "$test" in
>> in) echo input;;
>> out) echo output;;
>> do) echo start;;
>> done) echo stop;;
>> esac
>>
>> on dash 0.5.13.2, it fails with "Syntax error: "in" unexpected (expecting word)".
>> Reverting e8c0324af64c("parser: Catch bogus case patterns") fixes it.
>>
>> POSIX says that only esac should be recognized as a keyword when parsing the
>> first pattern of a case.
>>
>> An example of a real script broken by this change:
>>
>> https://salsa.debian.org/debian/netplug/-/blob/debian/unstable/scripts/netplug?ref_type=heads
> 
> Thanks for the report.  This patch should fix the problem:

Indeed, this patch works.  Thanks for the fix !
