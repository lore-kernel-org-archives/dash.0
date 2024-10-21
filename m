Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBF1DE2AD
	for <dash@vger.kernel.org>; Mon, 21 Oct 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541447; cv=none; b=mxF1oDcOYdiwKHJn7X1ad9fRmxdZDGFGrN7vBGoXxMPITla+3COB8/gL9JOHW16WNPhkFh7kVr8rmTCJKXHFo5E0adq24GxHyfeIa7sWssG7OU32mGQrMfE1k8v419iVqRN27t4i5TaAxlg59i9qamND087+isxJ9zEI0A7L5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541447; c=relaxed/simple;
	bh=Td0MiIYMXlydl0wTm4pcah9z2h+/NnBu/HeVm31akLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=besUyTEcnn1Wd1tsgh8lKzz/qTU4e4CNAQbWFwP9zakRwoit2EfdpjKDeez4wnvInEcg1iepmbpb1HioVUk/w5bdorls+POR6juS+kdE6PJnfJVrn5qn6rK171OIX3YDR1AS0MKK+BKeuQ+bRSdV72CqxR4hRnChQtkm6IXATZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b=kJOSsaB9; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b="kJOSsaB9"
Authentication-Results: mail.aegee.org/49LK49ns3113991; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1729541050; i=dkim+MSA-ssl@aegee.org;
	bh=Td0MiIYMXlydl0wTm4pcah9z2h+/NnBu/HeVm31akLY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kJOSsaB9MBE7fEpk9i5UGeLE1rPfBgOzN+vpOozEC7byII2QMB56zwepuTBJwOs7o
	 RxqAeLfy+GHY1fWvGkCLbnbeweaqprXhWp65VLV8C6x7bDPqGmaXLOSfcDXbpkvMlY
	 OY0WsT1PLsMKPM3KabkAnqxkmw4pJk2R1ueWwuRa1i5x+XWDfvl7bAYjQPya0UGwkl
	 A4pdDy9ThKVPULMjwi/DCyoLrtYpP6c0i0nF9H2fHR8ykKvqq97cRkVReXJqbPb1BS
	 LAj1KXdiQEf8GwkztThsMaP8fmVz9Ut2YEdCxkj2arXsIfUfbklcO2i+QgEAi4MVQ4
	 RLJC/0ELXZPHEM2PwqnxvMWVZeqW2Nb8t6uf/HtfESpEiqWkFsCAsdlYF49Mn49U+2
	 0lHYW4glZAg9NsSzIJClDzQGJU9PkdcE5swb+oFmEF/LYKc1d11BSIa82qsGvOiQ9r
	 kHmJaB/fGBJ+4mXIZ/lFjlsT31xSnT9mV6Pxleo3UUf6lp7LsU6HbdScZg+OTLGnDg
	 B1/ONjsq6ByJPU8CQrwYRbY3odKhfWfaxTgFseKNdgfdblWwdoE+ul7XOVWeQy/CO6
	 Sxjz75lZnVzNACmZh+yUOLYP2TDft3nz36/G8yRp/ur9wGVQrJzmDtKUrbJGTcDYPl
	 8n5cgSck5aYubIc1oT5ywRTM=
Authentication-Results: mail.aegee.org/49LK49ns3113991; dkim=none
Received: from [192.168.1.101] (clients-pools.pl.cooolbox.bg [78.130.216.20] (may be forged))
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 49LK49ns3113991
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 21 Oct 2024 20:04:10 GMT
Message-ID: <02c599a58448508c799e4f08be33d53847202292.camel@aegee.org>
Subject: Re: =?UTF-8?Q?=C2=AB?= echo '"\$z' =?UTF-8?Q?=C2=BB?=
 =?UTF-8?Q?_=E2=80=94?= differences between dash and bash in POSIX mode
 irrespective of xpg_echo
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: Harald van Dijk <harald@gigawatt.nl>,
        Herbert Xu
	 <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Date: Mon, 21 Oct 2024 23:04:09 +0300
In-Reply-To: <ffa48796-347b-4a7e-8cb3-c47f22fab897@gigawatt.nl>
References: <ZxXZ0Omt_GWMh2DN@gondor.apana.org.au>
	 <ffa48796-347b-4a7e-8cb3-c47f22fab897@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.1 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

autoconf was updated to avoid this pitfall:

http://git.savannah.gnu.org/gitweb/?p=3Dautoconf.git;a=3Dcommit;h=3D53c23bb=
4e1cd8aa35248c73277fa08b7c38a6ad9

Greetings
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD



-----Original Message-----
From: Harald van Dijk <harald@gigawatt.nl>
To: Herbert Xu <herbert@gondor.apana.org.au>, =D0=94=D0=B8=D0=BB=D1=8F=D0=
=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 <dilyan.palauzov@aegee=
.org>
Cc: dash@vger.kernel.org
Subject: Re: =C2=AB echo '"\$z' =C2=BB =E2=80=94 differences between dash a=
nd bash in POSIX mode irrespective of xpg_echo
Date: 21/10/24 08:01:53

On 21/10/2024 05:34, Herbert Xu wrote:
> =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 <dilyan.palauzov@aegee.org> wrote:
> >=20
> > I download https://ftp.gnu.org/gnu/gdb/gdb-15.2.tar.xz=C2=A0and run the=
re ./configure . configure has on line 19728
> >=20
> > =C2=A0=C2=A0 echo 'cat >>"\$ac_tmp/subs1.awk" <<\\_ACAWK &&' &&
>=20
> The issue is that echo(1) with a backslash character is not portable.

This particular use of echo with a backslash character used to work the=20
same way across shells and is widely used in configure scripts in a=20
large number of packages (specifically: any that use AC_SUBST_FILE). It=20
was changed by commit 776424a8 (parser: Add dollar single quote) without=
=20
that commit indicating that this would change; are you really sure this=20
should not be viewed as a bug? The impact will be massive.

Cheers,
Harald van Dijk

