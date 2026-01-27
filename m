Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4335CB96
	for <dash@vger.kernel.org>; Tue, 27 Jan 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527370; cv=pass; b=RO84CL1e7bzc+NIcAMp37g5BwIjXL6XsR7YLzVt6KKtzEWIBuRTVVlv0ETI/bnJI3300q4kAsdUn67+jAsoyNpgjTKx47KXUzOdsH7AWjPWavGQT0sexNXIYwZ9IsJiOctK7v6NLZii3SnRDhLB6opabtH3bSUwdI4u+r53Qy8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527370; c=relaxed/simple;
	bh=1IFhqNBZRL5QA2Kx6/2Z1MY0YodNBoAiqg2n/ShMCUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGfOa119/hMnlvSdlIsjpUf3aKupVdmBcbZL/Q8xsJl2WjiqocLP9vukQlo0x5sEcgy0jeJiaXCIXvTtTqc98y8FdaqubRQPEpzM08m7NI84ldREOW6aDTSufXWqu5ZDv19YOymCKTnW1cOtY4OcQHa5pyUih7F6F6RnheIjQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bofmC0zZ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bofmC0zZ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6465a88d296so856375d50.2
        for <dash@vger.kernel.org>; Tue, 27 Jan 2026 07:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769527368; cv=none;
        d=google.com; s=arc-20240605;
        b=fcQ7IXEe8trVce7fZJQM2NB6qx5dLtYSwToQQDyAyiNElJN9UnbGpTCzcGatfabh+3
         v5qBrXjkZJyMkDkx3nao/hhF8sxHhpJHYq6vdeT26wLJ/aMEloQby+BV1zJnDUc5TuFG
         iKY8fH+Hd3pzsdTbNWvc2rxdpBp4HPb/+96I28nKQUdvMIU9l3xyl8uPNNqvxWW1h2cX
         HP5/B+PCK+c4pziFiGFK4YPEaNTT9LV6Pr+0QAuUgdXSl5pRp1le+FIHvN4Ey90Fh5gH
         BIZxdsdUKGj5CZGAsVAH/AwoVdm2SvHvS+LM6vGTqLaj9UyQOcw2poK1Wvsa2jwg26C0
         08+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPw3WkuaIG+/osh0v+qWCK5Ko0JKtzhO1c8eC2KICjo=;
        fh=vrOAu+YagyUpXpQa4mln0dhLjYI/Re7o63mWbOaIiVw=;
        b=AIt5oW0LaiGhGK5Y/iTqP+b0Ih1lkYk7R8n/1ysdu8/J0EP3yaQG9rFNPBDEiGDoGJ
         g8ipzYzE6QuzdIZiTJesTnbzIt7PW3HFemHQ9/LYEgTI3zzx8IZAXZN23fKnHuKj4c0K
         Ih7vEYNad+IuEIr+EQdDjNBw4ksVrGpW23jM3btM/yvrWCbKx3SjryESu8H0zSmiRkFt
         F7EfN9mnFQ6PkjatyvEkGNffUl2+uQoRAbL75ZdKEB8IlS9SMq8djicY4DTpeR9eIHvt
         bBT/3PCexJmMm8Q7sWKDmvJzfvhOkHshhI4I3FldYFK32MF4f4s0yknbe+k4blv6+BLU
         seUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769527368; x=1770132168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPw3WkuaIG+/osh0v+qWCK5Ko0JKtzhO1c8eC2KICjo=;
        b=bofmC0zZTiXQxnmDfNFEw3TricY62RdZlS7b+KJOyv3v2STe/2GzgPdApzDqPJLGDI
         QJEem7e22x/wLjOmA/wRYVn07w9p0KlUIorA6MnoBL+RJ/Tm1UiYwFIaXr4HXecw354C
         FsOhai3wTFWDSfGHCAJidpCvM0TnD+MJvTuVgqjTgKwJqqiZCjm/ux7ZwNRru/ZfNTyx
         PR/1MSt4UZ9LSc/CzdZPyQUu+7oNMZG9SSQzjSn7GsBztHCBhA8IdXPPsyjdB9/SEt6X
         p28xkxbsMJq+eCkG+A4ntUfSGGlkEUBOsKa5rZrlVndioyLIzkhIPuFo4hdGnwk48g6I
         oMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769527368; x=1770132168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPw3WkuaIG+/osh0v+qWCK5Ko0JKtzhO1c8eC2KICjo=;
        b=CWXJ/JUhJK20L0xpGvpsZZUfLqtt7Sv/eseh9Vns7D69MQvxoaIPl5CxLrqHzAfCax
         TWkEwv4ap6eXN9iMnS7OioxyG9/gICTUbwuR0QgJQIp6IdYs6t/SzkHmSUUSGa9u+hx5
         tpZiyh1xHOCvJ4rVPlAMrWwmXyY02JmpP8qh+MyR+8J5su80v0TRXfjv//0LVCZWtHIV
         3j7y+kNvGpxWJjBy+gb/hBlekuhgkoETB+GarxmxR7l1tPcktvBDDz0NEsBlWDbxfTmp
         eVmDqePT2xlp+/8s33xqKDgN/MmE4C3ve6tjeh7llRMSYw+to2IYeDOyWlIJEnpngEfA
         fsbQ==
X-Gm-Message-State: AOJu0Yz6GdYzb1o7tji/AkAErs/jkZsQXD00liquVbrGx297q5HYiSKG
	LIE2qmZqzteU63BfqtaiCgtHTGN7YppflopQ7cLNYPSQlcteGIO1aQm6iKLTS8GukHkAO/JMDr7
	M/LF+NXxCXPqynyio/3yRedwUasw/PLc=
X-Gm-Gg: AZuq6aJHdjQ6iofL3CDSHhq389swIESkz2anouYZodTpy4xwSrof86Nw80b7plRhQ19
	RYAIqRGr7WcJbNcMAsnwQwOCk/w/dIl5pIDPNYLRugF+ZUn56YS1bDkfKnpKXX+d8PsNRXrfLsX
	G5gb47ioKn32aRhw9CkwIEX4YXOAOakGFKLY5dHkD0c3GWeDccUe0fPij5WMYxNIACA6b9m3eAz
	Vpqr7k0wl44Av79El+G84RJ/9McnHtuXcSnaQST7ma+c4Yi81mKmwLRJpLO+mNoLzjxxtcpPg==
X-Received: by 2002:a05:690e:1515:b0:649:2373:5c8b with SMTP id
 956f58d0204a3-6498fc4f165mr1082758d50.5.1769527367712; Tue, 27 Jan 2026
 07:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1hOcNHGv-7tkmD=XKw_oTy0s4NvZY0n1Mq4m_5_NX9miU2_Q@mail.gmail.com>
 <a3efe506-a5a6-417c-85ec-a8889b13c1bd@gigawatt.nl>
In-Reply-To: <a3efe506-a5a6-417c-85ec-a8889b13c1bd@gigawatt.nl>
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Tue, 27 Jan 2026 16:22:36 +0100
X-Gm-Features: AZwV_Qj64JLlb5D1jRFDK193JifiQSQS2eihAGpaq2xSRehTrzcP7Rz8p5QmSbM
Message-ID: <CAK1hOcMxctsmA_K3QiP4OuYchwMezaNBOQcv8F6oxfEd0dhGwg@mail.gmail.com>
Subject: Re: Unreachable code in evalsubshell()?
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:49=E2=80=AFAM Harald van Dijk <harald@gigawatt.nl=
> wrote:
> On 27/01/2026 04:26, Denys Vlasenko wrote:
> >          switch (n->type) {
> > ...
> >          case NBACKGND:
> >                  evalfn =3D evalsubshell;  //THIS IS THE ONLY USE OF ev=
alsubshell
> >                  goto checkexit;
> > ...
>
> The last line of that first ... is rather relevant though:
>
>          case NSUBSHELL:
>          case NBACKGND:
>                  evalfn =3D evalsubshell;
>                  goto checkexit;
>
> evalsubshell may be called for NSUBSHELL and for NBACKGND.

AHA. Thank you, I did not notice that!
