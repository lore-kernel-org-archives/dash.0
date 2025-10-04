Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B117A2EA
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547991; cv=none; b=Gi4rznvEi/keZQqdOXn0bxVpZyXMClEj7QhsOcVsgstF4DUaNwzgaL256DE1oItIBsgwSBmESagKc24gDriSO/PmKKzbPFePi8ddkBqdgyDOUoK0rIiiu4apswNjBjbHqJpyVOEET0Z4FldKyGhxAxOaxlH+bdYmCmY5SGTzxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547991; c=relaxed/simple;
	bh=dR0N/BaUO9kFGucF9CTmXaBEXMb/TPP8qT6gZ9/JHE8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b6B1QBwDSDKaO9pkgqNNhLWj4KzcZtyYX8n9EGO5cn5W7atqD9jXvWPazlYY697QJHMrYTWyy8RCRYha/457gvcP0zsKOg1fRlw6jgNteyaKy2xtjO2Oz+b4tfHOGusIfu8kiNbJETwDMaJN57oawile763VBDKnWgIFS/PMYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca; spf=pass smtp.mailfrom=systematicsw.ab.ca; dkim=pass (2048-bit key) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.b=B6f2T06j; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.b="B6f2T06j"
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4A39A13BFC8;
	Sat,  4 Oct 2025 03:19:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf18.hostedemail.com (Postfix) with ESMTPA id AF95230;
	Sat,  4 Oct 2025 03:19:40 +0000 (UTC)
Message-ID: <e16023a7-bca3-4537-a8f8-f0e952c70e1b@systematicsw.ab.ca>
Date: Fri, 3 Oct 2025 21:19:39 -0600
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Reply-To: Brian.Inglis@SystematicSW.ab.ca
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Content-Language: en-CA
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dash <dash@vger.kernel.org>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
 <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
 <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>
 <aN97a6Nn2C56006t@gondor.apana.org.au>
Organization: Systematic Software
In-Reply-To: <aN97a6Nn2C56006t@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: nxsyooup66u4sr151xubdpbp7r4bigta
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: AF95230
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+hiAeUCgkq5w++wGRwXcxfL6nMuQFtqTU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systematicsw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:cc:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=o1BDRv1P029PwM0P9r7h7AJ5RYoltiuti4H6aABsIzY=; b=B6f2T06j9Z9GQ95CJ+/1Y8jf4yaxqmZhNrcVfujFpxrUziI5uGdxbsTFqdt24/9DLi/qK0vJ11ij/WiiJHJs/q4ZzuyR+S3JLXsJ9jXNMJuAho9br6IiLDQem2//QJlqjdJZSZIwoZD6NDYp3nsDUNKE82ryMKBGQaaRVPEJqfBIOdz953HKUvC05cNo/0VjGT9BT08r45NfzpOXuqdvGLdAVGjQnQ2aOXdFSz3Jw+t6lHp7qTTHt8HJ8SXkjv2IGAflIq5HHbTkUjlzte/bjBUuveJA+Jo/acih3nPTxxjQhUqpuIGkvMQSGTuRGn7sZYPViBqzOqkBle0YQL6N0g==
X-HE-Tag: 1759547980-205007
X-HE-Meta: U2FsdGVkX19ev2savrFmkVFlXGrqA0VnTyLVFXACeVF+83Btflxu81qTNjtTjjD43XceBVpJihau3wGxaqj/BfLjPWOZsUrpLhIGtIxZ46r3sAtk/znOIXMdvdfhi32/2YQ2AE4PlTCu2aCh1gd3LvvKr8koFGK0yJnf7GylGq7TrsEjTOzSG+hd5NPzmCDnW0pMxEp6wCk7Ptt3A0j7GpDMpaHl0YJfxK640h1wn+AC+4mzd9kkJP2vHDdTMH4fAa1WDjJl0PX6SV/BPh/7NCQLa/gKM93JUiq4MJfXV3GTLRKwutmBSs/3mv4stjk3WSMNYTOp7ij7eAXrIx0pzf/PI5maS+C1

On 2025-10-03 01:29, Herbert Xu wrote:
> On Thu, Oct 02, 2025 at 03:56:47PM -0600, Brian Inglis wrote:
>>
>> As config files are not distributed in the repo, it appears to be caused by
>> autoreconfig 2.72 as I cannot even build 0.5.12 without your packaged config
>> scripts, so I have already raised an autoconf issue!
> 
> Hang on, but you previously said that dash 0.5.12 was able to build
> dash 0.5.13, is this not the case?
> 
> I have tried building dash 0.5.13 with 2.72 and it works fine.
> So I suspect there is something specific to Cygwin that is causing
> this failure.

Likely the autoreconfig with recently updated automake 1.18 using existing
/usr/share/autoconf/autoconf/status.m4 stanza:

# Neutralize VPATH when `$srcdir' = `.'.
# Shell code in configure.ac might set extrasub.
# FIXME: do we really want to maintain this feature?
cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=1
ac_sed_extra="$ac_vpsub
$extrasub
_ACEOF
cat >>$CONFIG_STATUS <<\_ACEOF || ac_write_fail=1
:t
[/@[a-zA-Z_][a-zA-Z_0-9]*@/!b]
dnl configure_input is a somewhat special, so we don't call AC_SUBST_TRACE.
dnl Note if you change the s||| delimiter here, don't forget to adjust
dnl ac_sed_conf_input accordingly.  Using & is a bad idea if & appears in
dnl the replacement string.
s|@configure_input@|$ac_sed_conf_input|;t t
dnl During the transition period, this is a special case:
s&@top_builddir@&$ac_top_builddir_sub&;t t[]AC_SUBST_TRACE([top_builddir])
dnl For this substitution see the witness macro _AC_HAVE_TOP_BUILD_PREFIX above.
s&@top_build_prefix@&$ac_top_build_prefix&;t t[]AC_SUBST_TRACE([top_build_prefix])
m4_map_args_sep([$0_ADJUST_DIR(], [)], [
], [srcdir], [abs_srcdir], [top_srcdir], [abs_top_srcdir],
    [builddir], [abs_builddir],
    [abs_top_builddir]AC_PROVIDE_IFELSE([AC_PROG_INSTALL],
      [, [INSTALL]])AC_PROVIDE_IFELSE([AC_PROG_MKDIR_P], [, [MKDIR_P]]))
m4_ifndef([AC_DATAROOTDIR_CHECKED], [$ac_datarootdir_hack
])dnl
"

to generate config.status ending with an unterminated string where that _ACEOF 
line appears.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
