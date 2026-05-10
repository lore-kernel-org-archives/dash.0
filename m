Received: from mekboy.ru (mekboy.ru [45.135.135.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343D1FD4
	for <dash@vger.kernel.org>; Sun, 10 May 2026 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.135.135.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778414827; cv=none; b=NhxgXYcDZAeV3tSgFNKnipJ8uUgprYa676ZkpghErj9KqdN8ePTjEAake2ClPpkd3jiDeQLhkrPAF25qsvtcis+soLQiXDIbpD5IiH6hGIGKPBE7nnNl2BNEJow5glN1r6XAdpk0exEzWds+cpINHZalV+TjgLhZyzmy7gYm+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778414827; c=relaxed/simple;
	bh=tJapTL105LrQuYnEJKTWZ+/T/cFSCXukO+eVUISpEiM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B6pziUwuBNLDq0gQ7UzEn3fXtBLDul8xj4kSFf1Vkrz4s9SGozq/VcUai42xQurtDkojkxJZhshahysAyQU2WUlQhV3swrlt0wvx4n+fUj1JGPdIxsZPlnEPQeQuN+1IFgcixASFnzC9AFGyjTVYbODWJvfEIa13qPi21ZMbxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mekboy.ru; spf=pass smtp.mailfrom=mekboy.ru; dkim=pass (2048-bit key) header.d=mekboy.ru header.i=@mekboy.ru header.b=GOYqClbA; arc=none smtp.client-ip=45.135.135.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mekboy.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mekboy.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mekboy.ru header.i=@mekboy.ru header.b="GOYqClbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mekboy.ru; s=mail;
	t=1778414822; bh=tJapTL105LrQuYnEJKTWZ+/T/cFSCXukO+eVUISpEiM=;
	h=Date:From:To:Subject:From;
	b=GOYqClbArcLzplinEd0cM17eJXFk8X4rCMuRzKm8AZI3A55NmkJje7YOLBXwQjyhy
	 g3jxICj0L+um+Ctgfze/v2cgWl8chYbqtKGysE4uLGX3WtZMAcK3Tzva+qaVYdtan9
	 H5Pjvv8NAlAgwAjHTJEuovrVSqIlxAX9veLzQG086p/XRwHSost6JX5XpNEGdDh8ar
	 UoT7yWpDGHrbgz8+HgUrbQ8dkIiArpz+sHZEKEpUoAWl4G56Dmlwwi6X+dytI+M7H7
	 TvdxcB/RUs1wYSOGRFOY5YyteYygzg30IIXA0ovrD5cpaV1ivWjYet7hx7MS5kD23h
	 ir4Ch2PNfEy0g==
Date: Sun, 10 May 2026 15:07:01 +0300
From: dash-shell-80d677ffb5cf@mekboy.ru
To: dash@vger.kernel.org
Subject: Can't build with GCC 16.1.0 - libatomic problem
Message-ID: <agBwF7x-EtgAZMXy@micropc>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi,
Doing a static build on a system where static version of libatomic is
not available system-wide.

Attempt 1:

export CC="musl-gcc"
./configure --enable-static
# FAIL, from config.log:
configure:4037: checking whether the C compiler works
configure:4059: musl-gcc    conftest.c  >&5
/usr/bin/ld: cannot find -latomic_asneeded: No such file or directory
collect2: error: ld returned 1 exit status

Attempt 2 (telling build system not to use libatomic):

export CC="musl-gcc"
export LDFLAGS="-fno-link-libatomic"
./configure --enable-static
# OK, but:
make  all-recursive
make[1]: Entering directory '/home/me/media/930_GiB/dash-0.5.13.4'
Making all in src
make[2]: Entering directory '/home/me/media/930_GiB/dash-0.5.13.4/src'
   CC       builtins.def
   GEN      builtins.h
   CC       mknodes
/usr/bin/ld: cannot find -latomic_asneeded: No such file or directory
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile:831: mknodes] Error 1
make[2]: Leaving directory '/home/me/media/930_GiB/dash-0.5.13.4/src'
make[1]: *** [Makefile:357: all-recursive] Error 1
make[1]: Leaving directory '/home/me/media/930_GiB/dash-0.5.13.4'
make: *** [Makefile:298: all] Error 2

Attempt 3 (built libatomic.a separately, trying to use it):

export CC="musl-gcc"
export CFLAGS="-Os -I/home/me/media/930_GiB/gcc-build/gcc/include"
export LDFLAGS="-L/home/me/media/930_GiB/gcc-build/gcc"
./configure --enable-static
# OK, but:
make
make  all-recursive
make[1]: Entering directory '/home/me/media/930_GiB/dash-0.5.13.4'
Making all in src
make[2]: Entering directory '/home/me/media/930_GiB/dash-0.5.13.4/src'
   CC       builtins.def
   GEN      builtins.h
   CC       mknodes
/usr/bin/ld: cannot find -latomic_asneeded: No such file or directory
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile:831: mknodes] Error 1
make[2]: Leaving directory '/home/me/media/930_GiB/dash-0.5.13.4/src'
make[1]: *** [Makefile:357: all-recursive] Error 1
make[1]: Leaving directory '/home/me/media/930_GiB/dash-0.5.13.4'
make: *** [Makefile:298: all] Error 2

Looks like "mknodes" step ignores CFLAGS/LDFLAGS.

/Regards, Aleksej
