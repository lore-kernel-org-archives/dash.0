Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017633E1
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759618037; cv=none; b=G6LynUQgqBWj7pgQecoVMT58wXdP5vvX7dejq/VSYM1Stwf2bUF+CW9yoIsNFrJ9QlbAW1mEZsJ1GdB+4EVVz+eByliozez37khGFD106UO3VM1X9L5AkBjJiwaVclMweMm+I4I72M7CxPt4VwxFxoJhjfmFU+NIAeIFnJ0e7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759618037; c=relaxed/simple;
	bh=Xc9BYPELevUh+2nOVOT64KIWP+IzA4NXKT1PpNes5IM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i9FpZufzl9/M26LToGjaa/t6dVdMMZ22zMysEk5iZw7tL2hCOCX2vdBxJdOLm/a28qbF9ePjLWiOCtTXMx1bhrsLyVeiAoNAjImCSRi5RjaAlMfxpS2uMButeW+g+i1xXW1FIky2vDZuYDgFxAzeOxfRZGMbvQMZyKB9A3oOcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca; spf=pass smtp.mailfrom=SystematicSW.ab.ca; dkim=pass (2048-bit key) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.b=ECvqWpUO; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.b="ECvqWpUO"
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D5FF9850EE;
	Sat,  4 Oct 2025 22:47:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf04.hostedemail.com (Postfix) with ESMTPA id 457CD20027;
	Sat,  4 Oct 2025 22:47:06 +0000 (UTC)
Message-ID: <e4361489-5c2b-472e-a812-5e07f41c5774@SystematicSW.ab.ca>
Date: Sat, 4 Oct 2025 16:47:05 -0600
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: Brian.Inglis@SystematicSW.ab.ca
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Content-Language: en-CA
To: Dash <dash@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
 <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
 <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>
 <aN97a6Nn2C56006t@gondor.apana.org.au>
 <e16023a7-bca3-4537-a8f8-f0e952c70e1b@systematicsw.ab.ca>
 <aOCb3piwcPXpm_NI@gondor.apana.org.au>
Organization: Systematic Software
In-Reply-To: <aOCb3piwcPXpm_NI@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: m3z7ymgrm6xmc1ftt9nzhk6zdoo4gz5p
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 457CD20027
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18Fhv3lO+r+xzBonHSglTt4AV7TQF7fOpY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:cc:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=LESeXH3vzTrFrPeti5mPqe6HgT6tYBYaDXtyPFiRstg=; b=ECvqWpUOtm93mdoyFClsw3LwdJnW12QbWTT1yhy9xwvJI7wfzHvLOLpJg45wzsHE7qo/oY0tdbrQY+CThNZWrUigYa9RNMdn+1avL+vJZbMsCFDgaBwsXFutTWstWgQnXf0V3QtMXqkwdfrk49YV002ciWW+TdmQVw+d1lgP+cA4XjDXPAOTIrD6Vultg4hUB3SzlxDaOXnqdL7yC1AkvIJu447xa1lvebf8C8bDXePd2D3PYz9rGn9uac80m2Oi6Pjq2w+ar+JTXjmsiblQfvpdfGwUljAs9Bzmi1h17LRELic13nB5vbgoqID7XKAEAg1TRlMPQG6HPtKh1ib6Vw==
X-HE-Tag: 1759618026-458777
X-HE-Meta: U2FsdGVkX1/Et5GN9nYga6TkBKR7eFYyM3k7viS0Fs45ZH9/Xp3S3AIgawQeJ5Sq9I5RamLz6BztJ60bDitgT86OHyrIl5ecntLLjn4zBsRbVp35RDvZ4tKrahje+cU2BBBF+a9/ChCBREm8OBELWwrA2shz2akqa8u8skDQV5+gzOGWTbZp5ZTM0M3OhmfhzDvaB9wc8NNFn0BVlzzJpCM08kRp5ZmyU7sRC4cCp+j0ZliJE4++v8ANn9AhzKVOiaXYKW1O46y5W1sVyduhsj8eRieP4mX6CJFvFDMUP8jISnu5xmJkbI2BvxapcFVldUoXtCV9MxiaiAPZar1P4D0fdG0ketY8

On 2025-10-03 22:00, Herbert Xu wrote:
> On Fri, Oct 03, 2025 at 09:19:39PM -0600, Brian Inglis wrote:
>>
>> Likely the autoreconfig with recently updated automake 1.18 using existing
>> /usr/share/autoconf/autoconf/status.m4 stanza:
> 
> But it's always been like that.  The code is correct as it is.  The
> quotes are split across two here-documents and there is nothing wrnog
> with that.
> 
> For some reason, when you ran the script with dash 0.5.13, the second
> here-document failed silently, thus creating an unterminated quote.
> 
> Please help us find the cause by doing a bisection.  As I said my
> suspicion lies with the new memfd code which obviously won't be run
> on Cygwin so there may be an issue with the fallback path.

Nothing to bisect as all commit configs from 0.5.12..0.5.13 fail, because your 
repo code does not include all your autoupdated config files checked in, and my 
autoreconfig always generates config files that fail at that point.

I will retry 0.5.12 using WANT_AUTOMAKE from 1.17 and WANT_AUTOCONF from 2.69 
(not so granular without removing/reinstalling packages) back until it once 
again works, and then retry 0.5.13, without and with suggested patches if 
required, and if necessary bisect whichever axis/package makes a difference! ;^>

What worries me is that something in the autotools config generation depends on 
it being done under Linux, and something in the Cygwin autotools autoreconfig is 
messing up cross-compatibility, enough that configs are going to start failing 
under Cygwin that work under Linux cross-tools, as Cygwin has been increasingly 
dropping our previous Windows interoperability interfaces, they are becoming 
increasingly less compatible with new POSIX, GNU, and Windows releases, and 
packages are becoming harder to build without hacking more tools!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
