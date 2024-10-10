Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB21C9ED3
	for <dash@vger.kernel.org>; Thu, 10 Oct 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569140; cv=none; b=REbyTJmE0zW32ld7Fng11FoS/Y3WXnvJItqYZZ+i+UBlMYlwVCCV34uIjZnFmxnmqlMfzAhWUGml7B1zldHzfdUFqjB71YL68MycDm6bUtd3YbzN8HzLMh3Ytczr496NJ3DfWRl21CSNZyfkq5fAyTc3065LY3tBDz0r5/pBN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569140; c=relaxed/simple;
	bh=XLWmv5JTdpug5IP7aiWAbb11tHMiZcTsClNUyFVhcv4=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=GihL76d4cI8mjgz+RCZZJDtOq0pRhe0LtkYY2LuvSKN7Q2zV3P72y7X0McJztDw1AyoKd4Klbx6AscJD3n3Cjobgg/2eNBjqLF482Z1ryXVzw79PCndR+lV0Y2/Sbnx7poNq360GhDFHRajR+wDT8wChyG82NbGB2ng9S8UE38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b=FK2yXzlb; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b="FK2yXzlb"
Authentication-Results: mail.aegee.org/49AE3Jb3917928; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1728569000; i=dkim+MSA-ssl@aegee.org;
	bh=XLWmv5JTdpug5IP7aiWAbb11tHMiZcTsClNUyFVhcv4=;
	h=Subject:From:To:Date;
	b=FK2yXzlbK0NsvDViK6G5mdAME0NrloSdrXH1l0v5/UNZuZytEj22OPD82/tGZIJ2V
	 X9WUSgjUnik7Ywg6IRY23HPOeL0WWL1MPWC1R5DPOvVJHjXmqE66dtS0U6DwnCN4iP
	 MAL2D1AFuHptCbGypPp5Dsxm+jqvKPYecY4CNYNr8xnikloz315DeG+Ih3lL76Fa43
	 wipBxOUZwpKANhxhluHHsQfwuhBFvAxCm5dF8wmUp/N5PuR8X7MbF6KlnX8U53l8Cr
	 /Y4SHpUtb+qAThu+5e3eZEupjavtRsgBAXYHLsEliNPRoXCXOYautBPg5pqTTuI6bk
	 AS+JLgG7+BQeWH4+BgwmB2lkWPZ8w7gb/aRHLSD6KSEbZvJKpkSLGdfYdrvN504uib
	 BCAbnxvX7r+FkY2N6296YYlRbhKaRcRNb2ZqV3NS+IskVy1EukcDULJI6k7E+VJOal
	 mFolaot2+kdq+OPSwv7iOq3qaNM5nkAipQEpUr/KI+NKLl0Zm66RfjKKxwFqNIIaIM
	 jP5FVJuDY85afftbgh0h1agUQu3vLuNK3dUXhTp7C1oXHQhC8CC4rOV35i5RDnAMSh
	 KdT1o23u/pDkZ3uFpUH0IY7jlhwWJygd1NDA4yHO0wMx+j2MBtPkQJASOV5jwazr6L
	 y+5FGtZhBlHMsXHo3Y6Cz3TY=
Authentication-Results: mail.aegee.org/49AE3Jb3917928; dkim=none
Received: from [192.168.0.242] (95-43-114-153.ip.btc-net.bg [95.43.114.153])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 49AE3Jb3917928
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <dash@vger.kernel.org>; Thu, 10 Oct 2024 14:03:20 GMT
Message-ID: <9f71540061aef0eb970b23ed3ad7e12faf8b7815.camel@aegee.org>
Subject: =?UTF-8?Q?=C2=AB?= echo '"\$z' =?UTF-8?Q?=C2=BB?=
 =?UTF-8?Q?_=E2=80=94?= differences between dash and bash in POSIX mode
 irrespective of xpg_echo
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: dash@vger.kernel.org
Date: Thu, 10 Oct 2024 17:03:19 +0300
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

I download https://ftp.gnu.org/gnu/gdb/gdb-15.2.tar.xz and run there ./conf=
igure . configure has on line 19728

   echo 'cat >>"\$ac_tmp/subs1.awk" <<\\_ACAWK &&' &&
 =20
(also at https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dconf=
igure#l19730 ).  It produces the file config.status .

When I use the most recent dash (commit 60eeccd0324a904a5f, ./configure && =
make install, /bin/sh is that dash) config.status has on line 708

  cat >>"/subs1.awk" <<\_ACAWK &&

But if /bin/sh is instead bash 4.4.12, line 708 in config.status is

  cat >>"$ac_tmp/subs1.awk" <<\_ACAWK &&

Why does it differ?

I have written at https://lore.kernel.org/dash/15ef5aaa-8766-48f7-9f3d-6b11=
838a0b95@gigawatt.nl/ on a similar topic and my reading of the answer is to=
 use print instead of echo, and that the output of the snippet below can be=
 modified by calling shopt -s xpg_echo or shopt -u xpg_echo, before the exe=
cution, or during the execution (by including  shopt -s/-u xpg_echo  on the=
 second line):

  #!/bin/sh
  echo '"\$z'

But it does not change, bash always puts \  before $, while dash does not i=
nclude the slash.

See also https://sourceware.org/bugzilla/show_bug.cgi?id=3D32252 .

Greetings
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD


