Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6486277818
	for <dash@vger.kernel.org>; Sun, 21 Jun 2026 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782010805; cv=none; b=m0XWdz8G7CZsM9Az/VxXoRiOXWpu4kzFiOW+hLRnkTvYibL6BED4/B56uRZeWs9mkT0sTRooxTfDtwIvvL/B0uU2KD8ZNL4hd8eGJuu3aQE13V0rI+Vg97kCfQCARAEHtOoGXEfXc15qUXlYB4snfDMweAllzCNhplGET0Q2IXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782010805; c=relaxed/simple;
	bh=Nkf2W3CeyNoIdBvYH3wu1mcND6qJcFD7hPxhDVZ5OaI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=dJjMZEwwXG0td/n1hSU3sipa2xbGbVyUgMlrgy8AfegSWZeV34ETIo25zS9NpbhkhPq/hv3hUEkq6GBRo8TmTSZWzvrg3AtpXkKQPMUX851XTxMEeWIUZ6MXAV+sYSCRBDXnmFTVj9fvfd1k9ooDmQ9H6YVUjDYJsxvjT4UtNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=HL57GbiT; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="HL57GbiT"
Received: from [192.168.1.218] (host81-133-56-137.in-addr.btopenworld.com [81.133.56.137])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.18.1/8.18.1) with ESMTPSA id 65L2WJLG016275
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Sun, 21 Jun 2026 04:32:19 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1782009139; bh=Nkf2W3CeyNoIdBvYH3wu1mcND6qJcFD7hPxhDVZ5OaI=;
	h=From:From;
	b=HL57GbiTo2POkiUn21cQnz6YluX+4efH8QcDhhcOCvdMd4DrHwgRMw3+qFJa9sIbO
	 2/kkKwmE7T61uSjkaJwjdUXA0C5SCu3SSxC69Ca2Ry6DMGIVTfw1s0npCdyGN97z0B
	 JH3gX2SCOmD9eDBzbujBEOWdhO194YSenTeQzSko=
Message-ID: <c125cdad-746f-4b21-a486-8df226c275b6@inlv.org>
Date: Sun, 21 Jun 2026 03:32:19 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martijn Dekker <martijn@inlv.org>
Content-Language: en-GB
To: DASH shell mailing list <dash@vger.kernel.org>
Subject: 'case' bug matching $'\\\\'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The quoted strings '\\' and $'\\\\' are identical, but the 'case' statement in 
the current git version of dash does not match them as such.

Reproducer:

case '\\' in
( $'\\\\' )	echo ok ;;
( * )		echo WRONG ;;
esac


-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

