Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04FA259C
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596894; cv=none; b=hQSxJkGpsJRf46hZSU2CSmPoMywkHbELZR+pgvyZZ5I4qhTIcOnnDjJSsnAEvRtIubevwS9SIkgDP7vnP8X1RjKSI6lYuQpQbkwiFAfVtUI33Uq8lg/L8lediamGaleGYmMzHFfq6fSGChed4WZgOkNQJAlO9ZP/8rBk14KeHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596894; c=relaxed/simple;
	bh=XDAwa3OBwUwHvjJTqV7P+jhb5+OqItcwHLbK3ak9mrM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YfG6Cb9eomu36je8cz3s4vMCC9d6NQnKASDI960obxAqJWNgop0JLOPYBaqT/Yz/8D6Ec2TTFj+CqLde/sXVSjHdSLFamnqkIy5jBjC/dUnu9fFmjuJuSCQkIKIEIgJBFF6FwxFbR848lvnB7TfRhfPfmI7/EVq5/oHs9rRFWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=d/HCoC4H; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=a9qL0wi+; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="d/HCoC4H";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="a9qL0wi+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1723596326; x=1724262992; h=date:author:from:to:cc:subject:
  message-id:mail-followup-to:openpgp:blahblahblah:author:from:subject:date:
  to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=T/aGdspKXFuKmFPjPNzbCEivAF9rf90dKyLVxvlaqaQ=;
 b=d/HCoC4HzOZPlI4jYtCGzBbdAGWhUihRqk9bWwxVOAlkLlg/d6GiOdgV2sZ2S7P3NQ0NBQNt
  dlu1a7UVsUUZqFRw22YVjbOxAD6kie0RIovNgWrRp4tYATtx+ZbXzyONR4j2kuhk6YQ92ndPCb
  7K91fkVHb6e7NCTO7Rnf5q1/4MFBuMeJyg0M2zZDL5FU+Q+RAjQKfJr6ewmpb0SuMdXc6z5VWI
  RYkaDxFE9jRo28TCN1mqeu9weieqqmsldgrdDMLf/EDH3Y8nkj5v50Ta9k5dHH1xD8xbQPB2aR
  mdVUuRhMHnG4j4HzkzzN7p/Jm6Pzw5lz41yVvbgBvKrAmY5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1723596326; x=1724262992; h=date:author:from:to:cc:subject:
  message-id:mail-followup-to:openpgp:blahblahblah:author:from:subject:date:
  to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=T/aGdspKXFuKmFPjPNzbCEivAF9rf90dKyLVxvlaqaQ=;
 b=a9qL0wi+SzqNV695OqF2nMmXkqp1GPCIksZXMf9/+YH0TnPkxrXIJt+WBstclLYnT9lvKBGd
  i4mL3kFJkdz2Bw==
Date: Wed, 14 Aug 2024 02:45:25 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Question on $@ vs $@$@
Message-ID: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
Mail-Followup-To: dash@vger.kernel.org, busybox@busybox.net,
 bug-bash@gnu.org, Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.25-599-g5c75a327b2
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Hello.

I include bug-bash even though i think bash is correct, but there
lots of people of expertise are listening, so, thus.
Sorry for cross-posting, nonetheless.
Given this snippet (twox() without argument it is)

  one() { echo "$# 1<$1>"; }
  two() { one "$@"; }
  twox() { one "$@$@"; }
  two
  two x
  twox
  twox x

i get

  $ dash shbug.sh
  0 1<>
  1 1<x>
  1 1<>
  1 1<xx>

  #?0|kent:tmp$ busybox.static sh shbug.sh
  0 1<>
  1 1<x>
  1 1<>
  1 1<xx>

  #?0|kent:tmp$ bash shbug.sh
  0 1<>
  1 1<x>
  0 1<>
  1 1<xx>

(This is busybox with my arithmetic patch, built on April 20th.)
Unfortunately my MUA is also bogus :(

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
