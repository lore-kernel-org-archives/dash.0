Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626010949
	for <dash@vger.kernel.org>; Tue, 23 Apr 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835246; cv=none; b=K8kF8yFW/hkWdkZyblyIWzHgB0QOcxwsTaDoQIqZLely2dcaQjXk0qXoRqMkkGZX1+mfCwfZJ5Rll3EiH34KBLYGQZs2VwrHdXZzoedezeeB0CsoaAGNyT27l3tNLtMwXEJMh1Dd3CA6VHSEE9A80kranmiXhcEIOi9UFyhIoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835246; c=relaxed/simple;
	bh=jer9wToZiH90S246caFDivD8d14rzVzR7wiu9fTlB4A=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=T/St9senYlao4YaK0It52Luu/1uSR4O2bZNRHq6g5TAijC8v2xJew+vDuSRvhYusCt8hUE+0Rgk35NkLqX49i1zl+O9toZYv+RDr7uNK/NfJ618VFbpNpfc941idKjlbXROXXJEXSOnC5v711f1e5zzQkeyyYDUVUQukbkl2PQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=hxDS+had; arc=none smtp.client-ip=185.70.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hxDS+had"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1713835242; x=1714094442;
	bh=uoz7kNOLXxxwePHg/nkQ583297tJFPQcpnlQcogAAFw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hxDS+had4aVweBs0+O+8hTWEDKli8pnuBWwD16p2b9nP4aQqagDpCAix0Qut/xrny
	 GPRSJr5vuH3DtfFw+AzgT2r007Cg2wg0WZWWTqoqTp+pxsgJDihNd7tepjDTqj0+CE
	 Dt/V8Bn7f/T39av2F/C950YxJAC26pcSOtA46x4niTXgA4ho5K39Y1tjG+jNb2Dtdc
	 YtWq+Klk4vs6Pv34EEFhL0HyCIs/TRfZiMg1jSMyFs5tp740LyI+w7RgtqqDK5G68+
	 lxTkgQB96fv9mWU9AdnReboORl4pM1ba5IVd9r/084r26JWVBxFihnGrXB2WyAZ55A
	 qt5GZh+Oy/nAQ==
Date: Tue, 23 Apr 2024 01:20:38 +0000
To: "dash@vger.kernel.org" <dash@vger.kernel.org>
From: Avid Seeker <avidseeker7@protonmail.com>
Subject: Dash core dump on network monitoring script
Message-ID: <WgTCSYEuzKbHuKFOr2TSJ8vLHAP7U_I8xGdY6fJP0LpGnQlFT6wVBbQIlpKZxlVnzr_7odCse-q9myZj5yjrf9XKzKVFvCJsngYL723T4Co=@protonmail.com>
Feedback-ID: 42841990:user:proton
X-Pm-Message-ID: a1156deb1406882dbe8e915a0da89b9d1cdc4702
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

systemd-coredump[65616]: [=F0=9F=A1=95] Process 65608 (sb-nettraf) of user =
1000 dumped core.

                                                 Stack trace of thread 6560=
8:
                                                 #0  0x00007c545ec90278 n/a=
 (libc.so.6 + 0x4a278)
                                                 #1  0x00005d3418d15df2 n/a=
 (dash + 0x9df2)
                                                 #2  0x00005d3418d16057 n/a=
 (dash + 0xa057)
                                                 #3  0x00005d3418d162e4 n/a=
 (dash + 0xa2e4)
                                                 #4  0x00005d3418d16395 n/a=
 (dash + 0xa395)
                                                 #5  0x00005d3418d16413 n/a=
 (dash + 0xa413)
                                                 #6  0x00005d3418d15ecc n/a=
 (dash + 0x9ecc)
                                                 #7  0x00005d3418d1673d n/a=
 (dash + 0xa73d)
                                                 #8  0x00005d3418d20693 n/a=
 (dash + 0x14693)
                                                 #9  0x00005d3418d1d5e0 n/a=
 (dash + 0x115e0)
                                                 #10 0x00005d3418d13f57 n/a=
 (dash + 0x7f57)
                                                 #11 0x00005d3418d13f57 n/a=
 (dash + 0x7f57)
                                                 #12 0x00005d3418d14318 n/a=
 (dash + 0x8318)
                                                 #13 0x00005d3418d13f57 n/a=
 (dash + 0x7f57)
                                                 #14 0x00005d3418d13f57 n/a=
 (dash + 0x7f57)
                                                 #15 0x00005d3418d13f1b n/a=
 (dash + 0x7f1b)
                                                 #16 0x00005d3418d13f1b n/a=
 (dash + 0x7f1b)
                                                 #17 0x00005d3418d13f1b n/a=
 (dash + 0x7f1b)
                                                 #18 0x00005d3418d13f1b n/a=
 (dash + 0x7f1b)
                                                 #19 0x00005d3418d14564 n/a=
 (dash + 0x8564)
                                                 #20 0x00005d3418d1dae5 n/a=
 (dash + 0x11ae5)
                                                 #21 0x00005d3418d13f57 n/a=
 (dash + 0x7f57)
                                                 #22 0x00005d3418d16db9 n/a=
 (dash + 0xadb9)
                                                 #23 0x00005d3418d20693 n/a=
 (dash + 0x14693)
                                                 #24 0x00005d3418d1d5e0 n/a=
 (dash + 0x115e0)
                                                 #25 0x00005d3418d13f57 n/a=
 (dash + 0x7f57)
                                                 #26 0x00005d3418d1ca6a n/a=
 (dash + 0x10a6a)
                                                 #27 0x00005d3418d10288 n/a=
 (dash + 0x4288)
                                                 #28 0x00007c545ec6bcd0 n/a=
 (libc.so.6 + 0x25cd0)
                                                 #29 0x00007c545ec6bd8a __l=
ibc_start_main (libc.so.6 + 0x25d8a)
                                                 #30 0x00005d3418d10435 n/a=
 (dash + 0x4435)
                                                 ELF object binary architec=
ture: AMD x86-64

The script is as follows:

#!/bin/sh

# Module showing network traffic. Shows how much data has been received (RX=
) or
# transmitted (TX) since the previous time this script ran. So if run every
# second, gives network traffic per second.

case $BLOCK_BUTTON in
=091) setsid -f "$TERMINAL" -e bmon ;;
=093) notify-send "=F0=9F=8C=90 Network traffic module" "=F0=9F=94=BB: Traf=
fic received
=F0=9F=94=BA: Traffic transmitted" ;;
=096) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

update() {
    sum=3D0
    for arg; do
        read -r i < "$arg"
        sum=3D$(( sum + i ))
    done
    cache=3D/tmp/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=3D0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

rx=3D$(update /sys/class/net/[ew]*/statistics/rx_bytes)
tx=3D$(update /sys/class/net/[ew]*/statistics/tx_bytes)

# shellcheck disable=3DSC2046,2183,2086
printf "=F0=9F=94=BB%4sB =F0=9F=94=BA%4sB\\n" $(numfmt --to=3Diec $rx $tx)
