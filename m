Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6BA2A
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291736; cv=none; b=XWtl1NBcB0UhbT78nH3vO+ERwTyVz9a57J/18DAYJGORSaf2voTNg4n2Fabv3Rzkxi6VUQaFPmSmBp5BOCNIqofWUP4tRE8p4RzT9C3elIkp/faz9oSOEDvR3gE2EscbVPP7E0OAYpsz2/BKHKy7QUuDGO6gqZcykAwOE1JVaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291736; c=relaxed/simple;
	bh=Y0hLgI2lZ3hdGRn7Kqs0y+q6e173f1AqnigfTidrbBY=;
	h=Date:Message-Id:From:Subject:To; b=CSlSdFOCLRVICSMlWMJuYbyHEbI1c01yKJmw8dU4BaTIJQMdM0cGC9WgMFl+tPCVDoOIHymSnWY4qszzUU2Tg+MqTmy01I2ZbkBw+2KCBgVsbmrPB5Wo0GrYdCprEW7wu0ojMx+uE77b09Tdp/6y+CMOZszziPrOvdqBVa8QC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa1Z-004iQi-0d;
	Sun, 02 Jun 2024 09:28:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:28:43 +0800
Date: Sun, 02 Jun 2024 09:28:43 +0800
Message-Id: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 00/13] Add multi-byte supportAdd multi-byte support
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

v5 rebases on top of the expmeta resource leakage patch.

This patch series adds multi-byte support to dash.  For now only
fnmatch is supported as the native pmatch function has not been
modified to support multi-byte characters.

Herbert Xu (13):
  shell: Call setlocale
  shell: Use strcoll instead of strcmp where applicable
  expand: Count multi-byte characters for VSLENGTH
  expand: Process multi-byte characters in subevalvar
  expand: Process multi-byte characters in expmeta
  expand: Support multi-byte characters during field splitting
  expand: Add multi-byte support to pmatch
  input: Allow MB_LEN_MAX calls to pungetc
  input: Add pgetc_eoa
  parser: Add support for multi-byte characters
  input: Always push in setinputfile
  builtin: Use pgetc in read(1)
  builtin: Process multi-byte characters in read(1)

 src/bltin/test.c |    8 +-
 src/eval.c       |    3 +-
 src/expand.c     | 1019 +++++++++++++++++++++++++++++++++-------------
 src/expand.h     |    2 +
 src/input.c      |  119 ++++--
 src/input.h      |   15 +-
 src/main.c       |    4 +
 src/memalloc.h   |   10 +-
 src/miscbltin.c  |   58 +--
 src/mktokens     |    1 +
 src/mystring.c   |    2 +-
 src/parser.c     |  136 +++++--
 src/parser.h     |    2 +
 src/var.c        |   12 +-
 14 files changed, 978 insertions(+), 413 deletions(-)

-- 
2.39.2

