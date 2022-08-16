Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A73C25B0E
	for <linux-dash@archiver.kernel.org>; Tue, 16 Aug 2022 14:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiHPOOB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiHPOOA (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 16 Aug 2022 10:14:00 -0400
Received: from uggla.sjd.se (uggla.sjd.se [IPv6:2001:9b1:8633::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6777FFAC
        for <dash@vger.kernel.org>; Tue, 16 Aug 2022 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=josefsson.org; s=ed2110; h=Content-Type:MIME-Version:Message-ID:In-Reply-To
        :Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description;
        bh=p7r1HRr6yY96xwlz8qnUGyQaL/DzLK7athVQYzm4wCI=; t=1660659239; x=1661868839; 
        b=mdb71DMcH/XJKJ5ZfIhGIQjfbod1pJBXQjgLenKX98Kdlb7SBCQtszg0DeWMACQxO6Fr7Nv6n8Z
        kpLQirsdqDg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=josefsson.org; s=rsa2110; h=Content-Type:MIME-Version:Message-ID:
        In-Reply-To:Date:References:Subject:Cc:To:From:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p7r1HRr6yY96xwlz8qnUGyQaL/DzLK7athVQYzm4wCI=; t=1660659239; x=1661868839; 
        b=jac7i/QFP/ejpchHmGGW+Bi7OXLK70xdh23bRCbGcv9OnwGYBk4/G+2B2pfxfEZvwIrkoiuULXE
        MDcXfoq7UH8+O7WlhgNqHg03F5U4AWFZpd6qqT/hYbcjDcXYTLw+6vQ+hl3UYcL26BmQTteWT+aFI
        tBmBBAvM3pMvXeS0zasw2GP7DoHtaHrmjz92JJgPCPLFsLvfK6LuwPfwOYV4ft93LDquVLw2eYp35
        e0frEoIcPU6pqw+MuOT9VI+nMb2Mzxw1Cb6RsPk1kUPBJtNYTRWM7PjAOEPu7FALvZ9I2bMOyiyrW
        5TRXBZgJqpiA7qC9lzgds+2FQwMGt0ZPM5VyHXShoBL9W56tUJvOugMgqnJ7+gwocoh7V2dIl/gYo
        kPx3v3Qg88Vz1aEV/6O+XZ9NWyRGci+qrn71xDaYrOS7mPAxU/R2Ucl1eEvoLoPWo8q1vZOg0;
Received: from [2001:9b0:219:600::834] (port=59326 helo=latte)
        by uggla.sjd.se with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <simon@josefsson.org>)
        id 1oNxKP-00Dkot-K4; Tue, 16 Aug 2022 16:13:57 +0200
From:   Simon Josefsson <simon@josefsson.org>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Subject: Re: command -v ../foo when ../foo is a directory
References: <87zgg41gx3.fsf@latte.josefsson.org>
        <296789cd-17a7-90aa-7f81-0612ebf1310a@gigawatt.nl>
OpenPGP: id=B1D2BD1375BECB784CF4F8C4D73CF638C53C06BE;
 url=https://josefsson.org/key-20190320.txt
X-Hashcash: 1:22:220816:dash@vger.kernel.org::+1JGDynCWGdgz6uD:30Qu
X-Hashcash: 1:22:220816:harald@gigawatt.nl::DReYPfPjBucFkBf/:b5lO
Date:   Tue, 16 Aug 2022 16:13:56 +0200
In-Reply-To: <296789cd-17a7-90aa-7f81-0612ebf1310a@gigawatt.nl> (Harald van
        Dijk's message of "Tue, 16 Aug 2022 15:04:21 +0100")
Message-ID: <87pmh01djv.fsf@latte.josefsson.org>
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

Harald van Dijk <harald@gigawatt.nl> writes:

> POSIX says for command -v:
>
>> Utilities, regular built-in utilities, command_names including a
>   <slash> character, and any implementation-defined functions that are=20
> found using the PATH variable (as described in Command Search and
> Execution), shall be written as absolute pathnames.
>
> ../bar is a command_name including a <slash> character. There is
> nothing in here that says to check whether it is executable, POSIX
> just says to write it as an absolute pathname, and that is what dash
> does.

Interesting, thank you!  It looks like a bug in the POSIX specs, perhaps
we can get it clarified?  Either by mandating a particular behaviour
going forward, or at least acknowledge the different interpretations
somehow.

/Simon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYIADIWIQSjzJyHC50xCrrUzy9RcisI/kdFogUCYvumJRQcc2ltb25Aam9z
ZWZzc29uLm9yZwAKCRBRcisI/kdFoq5pAP97Fcby1gl9UqtM2+wwew8UEaMgVUvn
nmrxIordU8azfwEA+nm6PM1BJ02fVwrojQBfahIpdp/8/GrDiq6WtSyMMQM=
=hN7g
-----END PGP SIGNATURE-----
--=-=-=--
