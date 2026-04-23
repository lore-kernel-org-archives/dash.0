Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6827C162
	for <dash@vger.kernel.org>; Thu, 23 Apr 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954149; cv=pass; b=kOIh25XV5MKuI0RU8UzjLUch051lLQqC0I+USFMI2aaHFzOBkevdBoz4hKM6LcFah7M168UIOgDAtWL7zo+5r04PLBtXp95EC4PEqOPaMeeamjoNaW1WU+Hc4HIX3pc81QD0d0o2UdYPM3KQW03nZP8TwF3f5wgtytc/A7WJciA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954149; c=relaxed/simple;
	bh=munBGMtiLbXq1qtOrjX5Nly9gqkwjZ1WaXhSUlI7L4w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UUYo2Fqj0gQ3Vvbu5uwrFPjSChAEps3I2vUX5HlmuePkRQl71O+EJhAm4vA8vMeuDtep7IWjF/1No86/YoZDIn3HpDaGqUlJ9ECzEVNwy9L611CMNlPl+6RdGDsy7zzzlAqyHdtBfn03Ar5t+ZPzbmksiS32NWt2LJgeTvAueFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBXiyRj7; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBXiyRj7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso3922096a12.1
        for <dash@vger.kernel.org>; Thu, 23 Apr 2026 07:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776954146; cv=none;
        d=google.com; s=arc-20240605;
        b=Ot7BD0Zs+YkHjLju7bYbYZnhNLgvsnpZKrPWil/69nV0xdfD0bjZoks3mbixuz0N0I
         R6+0SZPVhwuc+bY/zfRKRprQ969UAPxQpq7l1G5X0fyrGv6hGj9tnvO5R77fr8Mj4vwy
         o1w58wWsq7o7YHuaTQNeB9mvYiYb2o8mpbq1ROdwgYWs50bl7U/4qn+34eaKF8aoQmmI
         Yw7ESrtoPNcNAUIVB0LaCsP9YGupcCR6mFZvoV0vuEeE55kj+uwbUjC3JRRi1eCKBqur
         UebxomoJjW8XGrEogGYrlURZ5ZkNVpeSMvxHL/3QBXqztpybX/RLGBuHro1Ztb7NwlYe
         pNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=munBGMtiLbXq1qtOrjX5Nly9gqkwjZ1WaXhSUlI7L4w=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=du7TBrxKkfZljZofuuhw0VnO+sqHPH5TydYS6RgIzpweyiOdzOof29YM4gIeLGeTiJ
         MjWDm5FjJtdOX5mY9I4f2j3Lbv2iSTplOTNBsoEZ/BPlfFB8wY72jji7dY9yflsWFKmG
         7ps/3d5TKNZeicbiKJWJFu0/R32awZd1maWsni6ZhrUs1v3zFx03D99oyVYAisZBNBtW
         vBP44A9MMqQGs8fJNl7KvpEitmwvr47WceY3unhxjTCCfM026ZdGsdvF54KY9sy7DtE7
         d2kQqUKUtS0lQrJvnn1bsj4l1ruc5YhbUzLOoAH/JFTUs7xA5C2mBQ3MqZ7Z6incMELn
         5TCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776954146; x=1777558946; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=munBGMtiLbXq1qtOrjX5Nly9gqkwjZ1WaXhSUlI7L4w=;
        b=jBXiyRj7xctuHPgz0vOqoL46Uq8lKVZar8rDvvFu7BlkWEGILN+jHs0q6t1gCq6R1I
         USTHxy2vrDW9dgO7aCI8+et+Cs3NqCuGV97Fh9rpzpArOaBiwtOSHkqT/wZL076J1gK9
         OOTplH5yxdKOL+W6xO81aXF77KdIl32mx01uQTewDgoqKmrIWAXUyOSzm7Sfzwn1aOO6
         Ehp+7tlm6Vlnlt488v7AzYwaFdKhuqAAwOsmXVVZIV1YZNO5SU4K7DZOFmESBgP+Sn+G
         s9BSC+fVWG08ghSTo6C+tiOE4RBBd2gEfK9q1cfr33rjjaVxdHmxAzWVTR0l5x/+Tbvj
         Uh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954146; x=1777558946;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=munBGMtiLbXq1qtOrjX5Nly9gqkwjZ1WaXhSUlI7L4w=;
        b=qKqhkcADTPYp8n6ccdHLu0NFh1plGHVyqd53J9iH0IXBcjICW6RHNssJuIbNmJjisU
         kOg04GK/M80ts7A4hUyFrYThhZQk8WAXbcLewcVIuYSyoyE75ePnTiG7SaM48czODRs9
         7e75uS6WeA4Wil3bABzhjFHGoeEJ54WGHUPXLJoyIhwka+jUCig9wp3O58K3ubf1F4YJ
         JNthP5cFs/AUDdYKp+I7XpnaUKqOI972CNnohPL9FhW2jpYhI7UG4szUj50MZZi/OOJa
         9pvjVDJITW/RSCctsbM1p5u5WwYY+3RWJk/bRA7MDny0nLh5coaJ6WXvwu8O6WAhcLPG
         7OMQ==
X-Gm-Message-State: AOJu0YziaBPRB6j3OxcmKZ45Z0oLKEfVVwNJCQF/KErxVtuQUTCYt3te
	1vd+RohC2/tQqI6kNHifpCTvdOB0KvjtC8wguvfb2YvWZoLXAti0F6ITIhWWBGHQYcdDrPPbIn8
	EgbCDo/1Q5rxspkhlptw7Fa+OoA07aPcgycXFu1LrFg==
X-Gm-Gg: AeBDievojGFmyT2Dkhb3mvxjuxqMhPcARp2feXFzU1sHwyjxtnevkizLP88d3w9vvLc
	RG3Qx9GO0BKz1jSyoO9fdGoZjQHoI+DeAdC3PxRyh/TF1CI6pGqcAXZPOlLFf5u8/UcZK9IXLkH
	IsroRSZ1RUh7LJqnEp95HH5Tu3fzxmMEPbuUloQs9t/Iv8QI7/vg2ZA3VtPMGssIu5qz5xHalg5
	SWkzg7T1N7OXcHtIh6hQoy9Gk2rXtUaq+2LbNfyp6Doi419CeQ0KGIyTeDw2eIIvnT9/r4Wujl9
	JpMRf2emsepivCsYVw6Niv0aL+tM
X-Received: by 2002:a05:6402:a54e:10b0:669:cc03:334a with SMTP id
 4fb4d7f45d1cf-672bfd9db0dmr9729188a12.11.1776954146457; Thu, 23 Apr 2026
 07:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Gr=C3=A9gory_Pakosz?= <gregory.pakosz@gmail.com>
Date: Thu, 23 Apr 2026 16:22:15 +0200
X-Gm-Features: AQROBzBQmqJ5YaSR1LicsxEDJA1QE4JmugRouterpSYriI26eU6ssTLh1OS00z8
Message-ID: <CAC_01E1y9zYecy6ugvmwCzNm2tb2ipWqPKG6f6QUpOKU5AsK6g@mail.gmail.com>
Subject: ${var:-default} and ${var-default} append default value instead of
 discarding it when default contains multi-byte characters
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

It seems that Dash regressed (but I don't know when).

$ dash -c 'x=3DX; printf "before: %s (%d)\n" "$x" "${#x}"; x=3D${x:-=E2=86=
=97};
printf "after: %s (%d)\n" "$x" "${#x}"'
before: =E2=86=97 (1)
after: X=E2=86=97 (2)

I'm using Dash 0.5.13.2 on macOS, installed via Homebrew.
The bug seems to be locale irrelevant.

Regards,
Gr=C3=A9gory
