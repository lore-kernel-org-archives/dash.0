Received: from mx.sdf.org (mx.sdf.org [205.166.94.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84D25B0B9
	for <dash@vger.kernel.org>; Mon,  1 Jun 2026 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.166.94.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289591; cv=none; b=FZx5e9QNlFheN2t2flRvfydDUYWrs38OGwEYlOPJ8hqyuoBLkbg9x41f47gLV6aopU+JC6KKyHDTZBoqSxyln83FCd1CuKY6BQsJ+gmLYsi+gGAgLNdm1eBgtsbPAM3jzmdSJyrj9iizl1qjVxhtWv+Kp4beUfKfloQ5dbiKyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289591; c=relaxed/simple;
	bh=FsayF4+Mvb0K97ZT0dsdA6VpVcXkVHvWVodEiXzhkW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVeCtaB0rgqMBZ8uDRr0RBKLxOgX+Erv1TLVA8vbIpqtiMSErkyYl32aDINyCf3R6EliFARqzUlnQLOY1fdC6UHiXIZMHreTROpGDVVYGtnQCDYNIOMDQFPCe9d8jKodQFCElBFZ6TsO/2kKKHaRX1UZ4IppPz/ZmsnN3gm01nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stien.dev; spf=none smtp.mailfrom=stien.dev; arc=none smtp.client-ip=205.166.94.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stien.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stien.dev
Received: from HQ (pool-99-244-140-233.cpe.net.cable.rogers.com [99.244.140.233])
	(authenticated (0 bits))
	by mx.sdf.org (8.18.1/8.14.3) with ESMTPSA id 6514r6E4016012
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
	Mon, 1 Jun 2026 04:53:08 GMT
Date: Mon, 1 Jun 2026 01:53:06 -0300
From: =?iso-8859-1?Q?S=E9bastien?= Peterson-Boudreau <seb@stien.dev>
To: dash@vger.kernel.org
Cc: =?iso-8859-1?Q?S=E9bastien?= Peterson-Boudreau <seb@stien.dev>
Subject: [PATCH] Use proper grave accent character
Message-ID: <20260601045303.13750-1-seb@stien.dev>
Mail-Followup-To: dash@vger.kernel.org
References: <agBSqlE8ZkrKmnIo@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agBSqlE8ZkrKmnIo@gondor.apana.org.au>
X-Mailer: git-send-email 2.54.0

In the troff(7) (may be groff(7) on your system) input language, the
ascii grave accent (backtick) character is interpreted as a left
typographers quotation on output devices that support it. Likewise, a '
is interpreted as a right quotation.

IOW, if your terminal supports unicode (along with some other
variables..),

	`command`

in dash.1 can end up being displayed as

	‘command‘

which is not the input the shell expects, and so a user following
examples in the manual will be very confused.

The way to typeset the grave accent character as it most likely
appears on your keyboard, the character the shell expects for command
expansion, you must use the troff character \(ga
---
 src/dash.1 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index dbc34c9..f651a03 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -293,12 +293,12 @@ Enclosing characters within double quotes preserves the literal
 meaning of all characters except dollarsign
 .Pq $ ,
 backquote
-.Pq ` ,
+.Pq \(ga ,
 and backslash
 .Pq \e .
 The backslash inside double quotes is historically weird, and serves to
 quote only the following characters:
-.Dl $  `  \*q  \e  \*[Lt]newline\*[Gt] .
+.Dl $  \(ga  \*q  \e  \*[Lt]newline\*[Gt] .
 Otherwise it remains literal.
 .Ss Reserved Words
 Reserved words are words that have special meaning to the
@@ -983,7 +983,7 @@ or
 version
 .Pc :
 .Pp
-.Dl `command`
+.Dl \(gacommand\(ga
 .Pp
 The shell expands the command substitution by executing command in a
 subshell environment and replacing the command substitution with the
-- 
2.54.0

