Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169119343B
	for <dash@vger.kernel.org>; Mon, 29 Sep 2025 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173535; cv=none; b=I4WYM2wSy7ZeH0F12TGikR+Ytqlo3rQLo1aczOsgO0fV97Bs56Go9dg+QccAezlHUqXSar5W4d2P/3MoMft59eVDr1U0HKBpLL+UWDAOf9hi3C3nZS8cdM0A/4KPMwPa4T4aTRY8rivUFPXmKb+zO0q595vhIf5xX83iLNJQGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173535; c=relaxed/simple;
	bh=/XBo3fwRiWov6xSIzDp0auDMU7wocyNNXAVdkO/r44M=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=HBbDzSxfykvnk5hljniFktc61n9H8wDlMpQuWQ5cTlwmpNAsiBty1LZwKyoBGqx7lSI487ubAx/0IoHaVf+TFg2lU09OoTeg/eOh46hr2IlQp2k8r8n0YZgYJOSLm6+TmlyHw9pXUvXa0qd4GabwfFJpgBjZCkGWEO7sa/RlLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca; spf=pass smtp.mailfrom=SystematicSW.ab.ca; dkim=pass (2048-bit key) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.b=nbu0uPML; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.b="nbu0uPML"
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 08E2E876C5;
	Mon, 29 Sep 2025 19:18:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf18.hostedemail.com (Postfix) with ESMTPA id 6EEC82E;
	Mon, 29 Sep 2025 19:18:49 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------TEiBCgwv8j1OedmwOwTWDmaY"
Message-ID: <9e8eeb20-6cc8-47bb-8614-00dd5afc2f4c@SystematicSW.ab.ca>
Date: Mon, 29 Sep 2025 13:18:48 -0600
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: dash@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
References: <aNpTTNA7XTVQu4Ki@gondor.apana.org.au>
 <b3583ada-32c3-4732-a540-3b8bfb750f12@systematicsw.ab.ca>
Organization: Systematic Software
In-Reply-To: <b3583ada-32c3-4732-a540-3b8bfb750f12@systematicsw.ab.ca>
X-Rspamd-Queue-Id: 6EEC82E
X-Stat-Signature: pd1xndomzm585pu4an5zqhm1a7g6cstk
X-Rspamd-Server: rspamout06
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+l8yd3l5JQE8lyy+W6covzvhVO6mCw+VM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=content-type:message-id:date:mime-version:reply-to:subject:from:to:cc:references:in-reply-to; s=he; bh=7PQ4Do9HqcNJxkcwn+DS1aqDyHXjYjCpZdQGRyqz5ow=; b=nbu0uPMLo8/oYJvbsFNfrQr+nKSqqZAWKPmlviPTpn5YO201JjW3A/zxQyvSvSNyzsdRwrkS1fNkXOI4dbauwEUNEOi5QP+BcRC/JwTPIzf0HK5NRkr5dkOakEau3P9vIBHj5G1mmz3aSPcdCGHGbr3gHZ9n0Lf7T4rd0Dpmzrpl6fM10CTFLJsPhw1ep4DnPoUvwYPbHnOh3lbH09TkYJJu7/z3nAKflCGP4QCQecrVB5zuuY8k8Me+8fXR5UtJ/C7eJ264kh5+ak6zlSmELYaixjTEywgIjoap4PmIdvlo2r4uNX1uPX4y1bo8gmBI82FvgHEMDpTdrWVHJJ1Hjw==
X-HE-Tag: 1759173529-207154
X-HE-Meta: U2FsdGVkX1+GXt5gLgxJy3VnttULzN6Fyo4NkdV4+qRF09fgeGCKKBqSX6HfaRttuWH/rZKxHo7nIcHwWqfAeyJbwxNSJu0955AD6FTlnh4Qf7IZ7RVdyUFM4PZ1s3ZvVLSIxWRZn5wX2vi/gdB3cylZtbOO8JNlzlMbbiQv+I0m/cCQVijgPk94zTekobn1VjOD5oDMHdQQD/oKhIeKyPA6lDvh30qstGU18vcuLEctpkORQuI3SlGLv8Pwa8nck1DM3bp05VRuS2/Xg7VcucPpdcjjH2hW4mzQZyaRZeTTmFWpfoX+y07FIJjCSlPJesqDFZKOCPVbe/gPzyfnNOeD9Lh7vOeg16FhVADMQriiRpxzKpIOvu2PrdntF87FtIjg9QceZrsq2r9wlQTLoSI7uGMuPGNO4+/eXofhpxInLlTnA2GsN6pTDqbCfONy1mClLzLF/KVs8hZGN7cXMGGFamI7QaceASOYqR+NvJwwc2u0pq7daK2aQIIuokC3

This is a multi-part message in MIME format.
--------------TEiBCgwv8j1OedmwOwTWDmaY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-09-29 04:29, Brian Inglis wrote:
> On 2025-09-29 03:37, Herbert Xu wrote:
>> Brian Inglis wrote:
>>>
>>> Applied and rebuilt, getting the same failure with identical ERROR messages and
>>> symptoms, after building okay with previous dash == sh, then rerunning with
>>> latest dash == sh.
>>>
>>> Do the previously highlighted configure script last two config.status generation
>>> stanzas seem to have issues, or is that as intended?
>>>
>>> It appears that the following _ACEOF\ncat >>$CONFIG_STATUS ... might be
>>> misplaced, as it is immediately followed by a list of sed commands.
>>
>> It looks identical to the configure script that I get from running
>> autoconf, and my copy works just fine, even with the buggy dash 0.5.13.
>>
>>> These stanzas come from /usr/share/autoconf{,2.7}/autoconf/status.m4
>>> included by /usr/share/autoconf{,2.7}/autoconf/autoconf.m4 frozen in
>>> /usr/share/autoconf{,2.7}/autoconf/autoconf.m4f.
>>>
>>> Or is this an issue that should be raised with the autoconf/autotools team?
>>
>> Based on the fact we just found two bugs in 0.5.13 that both broke
>> autoconf, it's probably a dash bug :)
>>
>> I just checked your original email and your configure script is
>> identical to mine.
>>
>> Can you please run configure with set -x and send me the result?
> Complete Cygwin build run with set -vx attached.

Reported the issue and questioned the code which disables VPATH and may not be 
used often on modern systems (report attached):

	https://savannah.gnu.org/support/?111321

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
--------------TEiBCgwv8j1OedmwOwTWDmaY
Content-Type: message/rfc822; name="[sr #111321] config.status generation by
 configure in dash 0.5.13 fails with ERROR.eml"
Content-Disposition: attachment; filename*0="[sr #111321] config.status
 generation by configure in dash 0"; filename*1=".5.13 fails with ERROR.eml"
Content-Transfer-Encoding: 7bit

X-Account-Key: account6
X-UIDL: 657904ed00002951
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
X-Mozilla-Keys:                                                                                 
Return-Path: www-data@savannah.gnu.org
Delivered-To: brian.inglis@systematicsw.ab.ca
X-FDA: 83941818870.14.C3C086F
Received: from frontend2.savannah.gnu.org (frontend2.savannah.gnu.org [209.51.188.113])
	by imf08.hostedemail.com (Postfix) with ESMTP id 2FF4316000D
	for <Brian.Inglis@SystematicSW.ab.ca>; Mon, 29 Sep 2025 09:50:52 +0000 (UTC)
Authentication-Results: imf08.hostedemail.com;
	dkim=none;
	spf=pass (imf08.hostedemail.com: domain of www-data@savannah.gnu.org designates 209.51.188.113 as permitted sender) smtp.mailfrom=www-data@savannah.gnu.org;
	dmarc=pass (policy=none) header.from=gnu.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=hostedemail.com;
	s=arc-20220608; t=1759139453;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:in-reply-to:
	 references; bh=2/faqLTudQPM0R+0xb7ilqwT7XaKG9Yl/gHX7aOtk/U=;
	b=I9yP8F16KGCCcps2hLHVy95LMkBTLaV8bfgG//sHzK/a0uTUvc24j6bKMB/knD3NjT9H7j
	IEN1Vz9r7d9XnkIR1GBOru3WhZ+3ln2DTmjocJ7h9E5X7mc7S1YuaKhr+MWAJJmR9Da/m7
	FcTLqDsEUKkVx5GZ0dAi2lSYLrTkSHA=
ARC-Seal: i=1; s=arc-20220608; d=hostedemail.com; t=1759139453; a=rsa-sha256;
	cv=none;
	b=jt4s3zP50sdMIRuhvgOwkdzy7Q4/GIOk96jbdewLg8+GwhVgWPNu/faCflTw7Y8o2L9tMh
	pw0wXWCudgUOovfcKV+TFvUZdUrluM2DCvMShL60WB3kAvghth4jmv+QqPqsfG7adCuNAO
	snKntXw6fa5vQ1+3sQQSJGyRQS2AJo8=
ARC-Authentication-Results: i=1;
	imf08.hostedemail.com;
	dkim=none;
	spf=pass (imf08.hostedemail.com: domain of www-data@savannah.gnu.org designates 209.51.188.113 as permitted sender) smtp.mailfrom=www-data@savannah.gnu.org;
	dmarc=pass (policy=none) header.from=gnu.org
Received: by frontend2.savannah.gnu.org (Postfix, from userid 33)
	id 70410120EFC; Mon, 29 Sep 2025 05:50:50 -0400 (EDT)
To: Brian.Inglis@SystematicSW.ab.ca, brian.inglis@systematicsw.ab.ca, bug-autoconf@gnu.org
Subject: [sr #111321] config.status generation by configure in dash 0.5.13 fails with ERROR
From: anonymous <INVALID.NOREPLY@gnu.org>
X-Savane-Server: savannah.gnu.org:443 2001:470:142:5::113
X-Savane-Version: 3.15-189ce17d037bb02eaca6b9797c928f93c336653c
Source-Code-Offer: AGPL NOTICE  You can download the corresponding source code of Savane at https://savannah.gnu.org/source/savane-189ce17d037bb02eaca6b9797c928f93c336653c.tar.gz
X-Savane-Project: autoconf
X-Savane-Tracker: support
X-Savane-Item-ID: 111321
Message-Id: <20250929-095047.sv0.601956@savannah.gnu.org>
MIME-Version: 1.0
Content-Type: MULTIPART/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; BOUNDARY="8323329-957358572-1759139450=:562098"
Content-Disposition: inline
Date: Mon, 29 Sep 2025 05:50:50 -0400 (EDT)
X-Rspamd-Queue-Id: 2FF4316000D
X-Stat-Signature: gs7wchsx9guboxuukys5x36jx57m415q
X-Rspam-User: 
X-Spam-Status: No, score=-2.89
X-Rspamd-Server: rspam09
X-HE-Tag: 1759139452-341385
X-HE-Meta: U2FsdGVkX184BKLpRB/0czspheuk1DGL7FGUo9rQcGF1BRow7T3zoPKnv4VxsZ4IVBk6KZ+TMLxnGfL/BRrIAM9vsPvajIRmtS1gtuRE+uslAhbx8QS3YYL3vPUq7vmeLTPbqq0NoitlZrg2wmqkzJLGr5YPLQ01Hg58bpjaHL+8KezWyA20eKalDCeGRVZv+HvcixXQgMOH/VEFzKloYcsjzqL3DpfQAEmVB5Z1fTGjDWe/Fh5UJFKDK1JoUtl5Q1MQNrWnnjeL1LkvOYRqRCTHJ/CJSl1wLUZb4ATS21dA5rQz/SJDm1ixqjLMQ5dn5urb0DBIFMEbDGgPdQWflOCTYvHrPQA6njDBPKhM1nAWAiTVkpOZ4ZtZBKER/MNFsU69EXf3ubNX9lezw8dO2xy8uuqF2Z0OiMf1GcRDUhQMYFoH32w5eVNBDCBk9r22QImlZt1PNycDJHF8SHu7NAuCAPiSmnSQnLgPoq82ZaNMm0aOq+qgQTtGltwCk0n0ASKtUEJyzrfFbKWc9mQj5gvUReQ1e6kpaq60wG16EYy6eFV68QfjcLQCN2R1sluPd0CpPBFPUWhUbDbD/kxrdLJsCN4UIKxytsw/iE+3fyw7CpjQWwttSWwZikJdoD2LjLP2UTXvaJplrbXJ04RLbE8345SE2VbwRlJP8I3qXpEkNmnYCugpKhqLAh0YLsM7poWk9NVqgdxdBeSEJZmxefSK1cxoR//wdV3umMo74PAqo04H/aAsNlxFc8n85StzFvb8tZs1r9GgoP6pg77bXDGnA/FPFQd829otNflUVeyREjHJQ6VpGS0gGvinr1snwFgrlOkh57yCuP1l/k3Gs0cZsbK9/7VmztClXzPzNc5dJwmEhZQIxH3lT07FviYqv4aInfNV4UWFgjirh9bzg42u2RH+TOtUfmWUb7N4pDEqytBJeOZsdFxQwEGJMocSZev6MhnIZKXbAKXBrxRjQlFj3Ne
 rw1ZQGCsl52sk2l7SNfHj+hq+CZ4SR58S0XUg76tcadjmdOn8/QUPJf0woh2OikjNb9QLu1PmG6PdDggo7Umjv0Mc3jUCtXi42Tp7TGl/7S1BuzaNe3mp3Zm/O05TQgnX3p6cOVGxfP/MVtnFfamJ3dw9z95B9XDoC1xW4TLE+iSKRJ4PhvsA5ew3CETSp2j8dXGYc3OoqBWIF5BNJqkJzjankiKlH0awN5kWRjK03xnc3ThqbSp7AUq6cnXGqPm/XUA0OMw7iDuifuyFvnecWXQsKSeAbFYwcVwlM+ehqk+hQu0TzNX4AH0OHGQws8IiIeCTPIcI7v/muTr/6W6TqQq8xORqlEFKoJkAIz1e6J6ULTOELmVxLxSny8xhLyrcqHa8gkAFz64gkUcszNXp8VUO4lOaq8mGSj+n5jrP+U/8v+NgACrZdV3Hcf2cgDeef0LtfrkuC8xJFrOB6b2/RitGwwl4CLmqTtWle6L7VSjbUtyQB6AG2cWokA==

--8323329-957358572-1759139450=:562098
Content-Type: TEXT/plain; CHARSET=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: inline

URL:=0A  <https://savannah.gnu.org/support/?111321>=0A=0A                 S=
ummary: config.status generation by configure in dash 0.5.13=0Afails with E=
RROR=0A                   Group: Autoconf=0A               Submitter: None=
=0A               Submitted: Mon 29 Sep 2025 09:50:45 AM UTC=0A            =
    Priority: 5 - Unprioritized=0A                Severity: 3 - Normal=0A  =
                Status: None=0A                 Privacy: Public=0A         =
    Assigned to: None=0A        Originator Email: Brian.Inglis@SystematicSW=
.ab.ca=0A             Open/Closed: Open=0A         Discussion Lock: Any=0A =
       Operating System: Microsoft Windows=0A=0A=0A    ____________________=
___________________________________=0A=0AFollow-up Comments:=0A=0A=0A------=
-------------------------------------------------=0ADate: Mon 29 Sep 2025 0=
9:50:45 AM UTC By: Anonymous=0ATesting dash 0.5.13 by rebuilding under Cygw=
in with dash =3D=3D sh causes failure=0Aof configure when config.status is =
run, due to an unterminated null string=0Adefinition on the last line of co=
nfig.status:=0Aac_sed_extra=3D"=0A=0AThis appears to be generated by lib/au=
toconf/status.m4 about line 650 where=0Aac_sed_extra definition is added to=
 config.status without a terminating '"';=0Ait also appears that the here d=
oc delimiter _ACEOF and following line with=0A`cat >> $CONFIG_STATUS ...` i=
s followed by a sequence of sed commands, which=0Amay be intended to be par=
t of the definition, as it is '"' terminated.=0A=0AHowever, this may be som=
e clever shell scripting I don't understand, nor how=0Ait gets generated in=
to configure by autoconf, as there may be some misquoting=0Ain effect somew=
here. =0A=0AThis appears in a number of recently updated packages' configur=
e scripts, and=0Ais not changed by autoreconf in the relevant lines. =0A=0A=
Generation of config.status has not been affected until latest dash was tes=
ted=0Aas sh; bash and previous dash releases work okay.=0A=0AThe relevant b=
its of the autoconf macros have not changed in recent years: =0A=0A$ grep -=
A9 VPATH /usr/share/autoconf2.7/autoconf/status.m4=0A# VPATH may cause trou=
ble with some makes, so we remove sole $(srcdir),=0A# ${srcdir} and @srcdir=
@ entries from VPATH if srcdir is ".", strip leading=0Aand=0A# trailing col=
ons and then remove the whole line if VPATH becomes empty=0A# (actually we =
leave an empty line to preserve line numbers).=0Aif test "x$srcdir" =3D x.;=
 then=0A  ac_vpsub=3D['/^[=09 ]*VPATH[=09 ]*=3D[=09 ]*/{=0Ah=0As///=0As/^/:=
/=0As/[=09 ]*$/:/=0As/:\$(srcdir):/:/g=0As/:\${srcdir}:/:/g=0As/:@srcdir@:/=
:/g=0As/^:*//=0As/:*$//=0A--=0A# Neutralize VPATH when '$srcdir' =3D '.'.=
=0A# Shell code in configure.ac might set extrasub.=0A# FIXME: do we really=
 want to maintain this feature?=0Acat >>$CONFIG_STATUS <<_ACEOF || ac_write=
_fail=3D1=0Aac_sed_extra=3D"$ac_vpsub=0A$extrasub=0A_ACEOF=0Acat >>$CONFIG_=
STATUS <<\_ACEOF || ac_write_fail=3D1=0A:t=0A[/@[a-zA-Z_][a-zA-Z_0-9]*@/!b]=
=0A=0A=0A=0A=0A=0A=0A=0A=0A    ____________________________________________=
___________=0A=0AReply to this item at:=0A=0A  <https://savannah.gnu.org/su=
pport/?111321>=0A=0A_______________________________________________=0AMessa=
ge sent via Savannah=0Ahttps://savannah.gnu.org/=0A
--8323329-957358572-1759139450=:562098
Content-Type: APPLICATION/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQk97aszIMMAvLLwm6qLAuaBUf3TgUCaNpWegAKCRCqLAuaBUf3
TghDAP9PAbGBx5XFusnD7fy5aRyVV9UuYXgiP0tR4X65pWGiMgEAvMriTg+pa3Bg
K19uCdAn4Gi10pD+JMjkVcrgLkwxuA4=
=ovU0
-----END PGP SIGNATURE-----

--8323329-957358572-1759139450=:562098--


--------------TEiBCgwv8j1OedmwOwTWDmaY--
