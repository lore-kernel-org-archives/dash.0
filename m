Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500DC25B0E
	for <linux-dash@archiver.kernel.org>; Tue, 16 Aug 2022 13:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiHPN0J (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiHPN0I (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 16 Aug 2022 09:26:08 -0400
X-Greylist: delayed 1485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 06:26:04 PDT
Received: from uggla.sjd.se (uggla.sjd.se [IPv6:2001:9b1:8633::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D3870BD
        for <dash@vger.kernel.org>; Tue, 16 Aug 2022 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=josefsson.org; s=ed2110; h=Content-Type:MIME-Version:Message-ID:Date:
        Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=exQoVGpQSAMXNTRYmt01dR2QODOXrggW7Ndw4gmzJl4=;
        t=1660656364; x=1661865964; b=55OUMoUnMb7ln0NygM1/HSmJFFiMdMChhD0ijCvCNaCGJYE
        sOki4uFJqJOTlUuBrdQAXkVVa6uIk6F8Ab4EkAA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=josefsson.org; s=rsa2110; h=Content-Type:MIME-Version:Message-ID:Date:
        Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=exQoVGpQSAMXNTRYmt01dR2QODOXrggW7Ndw4gmzJl4=;
        t=1660656364; x=1661865964; b=PqgU7SRO2J0s5cKYm0idcTHxFZWksUGzK2BBpx7MdghGG5j
        m1cqobnEM2C/N9c7VhkIkXz+4P5QNa+qsMY8chWxhq8PGm9CMzro/ju0ZJU5eddJa4qK16U9kucqH
        w5J7WZbCLPCOR/ypPDfPYx1K9dR93zNZdeJiiGAFGUxvMZcokhvgKi0BJ8llhKyYKasYBkJkYrtIt
        Rjr1sPeK55ykQY5sIxUVHlRAlxrHIAlK8KTDq/Sli3LxOP+FEYLKm8NBjd91sy3yi5JdLxXXpQb6M
        LzUMHwyF0WA3lNAAmvR5GN8lV7DQDf/T7E0tSdfjh7FQE14L5Ho/8M4UJLdIK4Z1SLouasLiSMKVb
        GTtlZvxnkEYKi0Vf7YzoxSLz3DvDwsRiK9OcHwN7mfxssmfOCCd2glEyG6Mc1ypiHUl2tX7TVeIGs
        55U8FpyBR+zg4M0mCrJd4dn8;
Received: from [2001:9b0:219:600::834] (port=44134 helo=latte)
        by uggla.sjd.se with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <simon@josefsson.org>)
        id 1oNwC1-00Dfhv-H2
        for dash@vger.kernel.org; Tue, 16 Aug 2022 15:01:13 +0200
X-Hashcash: 1:22:220816:dash@vger.kernel.org::IXJHQtvV9PlhukSS:0s9r
From:   Simon Josefsson <simon@josefsson.org>
To:     dash@vger.kernel.org
Subject: command -v ../foo when ../foo is a directory
OpenPGP: id=B1D2BD1375BECB784CF4F8C4D73CF638C53C06BE;
 url=https://josefsson.org/key-20190320.txt
Date:   Tue, 16 Aug 2022 15:01:12 +0200
Message-ID: <87zgg41gx3.fsf@latte.josefsson.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

I noticed a (to me) unexpected difference between bash and dash, compare
bash behaviour:

jas@latte:~$ mkdir -p foo foo/bar
jas@latte:~$ cd foo/bar
jas@latte:~/foo/bar$ command -v ../bar
jas@latte:~/foo/bar$ echo $?
1
jas@latte:~/foo/bar$=20

with dash behaviour:

$ mkdir -p foo foo/bar
$ cd foo/bar
$ command -v ../bar
../bar
$ echo $?
0
$=20

That is, dash's 'command -v' return success on directories for relative
names.  I believe the dash behaviour is incorrect, but I'd appreciate if
someone else read the POSIX spec here.  Do you agree?

This is on Debian bullseye with dash 0.5.11+git20200708+dd9ef66-5 and
bash 5.1-2+deb11u1.

/Simon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYIADIWIQSjzJyHC50xCrrUzy9RcisI/kdFogUCYvuVGRQcc2ltb25Aam9z
ZWZzc29uLm9yZwAKCRBRcisI/kdFonmLAP4xlipn40o53CTToDm5A6kpC1MPKWJD
VbNRCmnurarMDAD9GK0PRTg1sMnAZEHwFCuIunksB0EIcXOTeVFUrl5xUAM=
=XcDK
-----END PGP SIGNATURE-----
--=-=-=--
