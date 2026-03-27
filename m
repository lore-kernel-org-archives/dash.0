Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1815C158
	for <dash@vger.kernel.org>; Fri, 27 Mar 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621703; cv=none; b=p98k2JGnapQ9XhOTDobgLJ7R3ZdRvAm8wo/93314QoQglsLvslFyLQfQT92VVFJwn9oZP5FI5KRdXcMQacB7KA2XLHpy+Ty3DH7380itzkDPtQisQzI1ihHSCMPJjcZycaXU/uqv7BYA11QejbTGeVSdBYRtivzVKaXObLkr58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621703; c=relaxed/simple;
	bh=nP4Xb5WHLp5FYnE7UtBCkH/7++o3nCTZHgBSZaDMuZ0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lEsx4azRpm9ywF5ooHRRC86oWbGXs+9Ib+im92uSeCwZg7F8MQoflgB0CHaCf5bDYlFtshTYUEBsQIqfY8O7fOwl875RXzDjikA/W5SfF+EwWys/hdF3UiWp7E0o2HDI6K97s0OZdRk3cKxx82LXQR3oVjdX+fZFVu5T4Uj9ABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1N7AEs-1vTarJ3bIa-00zO4n for
 <dash@vger.kernel.org>; Fri, 27 Mar 2026 15:28:13 +0100
Message-ID: <3e89cc83-a890-42ec-8e8c-13c5e65905d6@green-communications.fr>
Date: Fri, 27 Mar 2026 15:28:13 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dash@vger.kernel.org
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: [BUG] case fails since 0.5.13.2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YJJ0D0nfuVKZ08CGqpX8eE/S/ZUh+YaSAP134TcfaY19a7jP83V
 YNq2/mbOzZXlCRqnHMu3lFDrUtRUPp1b8xT1NSH8draKMSo3CpLZFPCZAP/3JfksoUJWoEr
 RtpPT5yO5Pmj1+qFVeh4kgbt84yB3dA29XZJc31z1sp3AKHR00pPOmmftQTyo1OY6I0DkCg
 PBQJjoDfww7oWFhYovXcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NFWxnY8nwsk=;kl5PgGs6gUa2NDtn1TXWXPmQocJ
 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

This syntax is accepted by all shells except dash 0.5.13.2:

case "$test" in
in) echo input;;
out) echo output;;
do) echo start;;
done) echo stop;;
esac

on dash 0.5.13.2, it fails with "Syntax error: "in" unexpected (expecting word)".
Reverting e8c0324af64c("parser: Catch bogus case patterns") fixes it.

POSIX says that only esac should be recognized as a keyword when parsing the 
first pattern of a case.

An example of a real script broken by this change:

https://salsa.debian.org/debian/netplug/-/blob/debian/unstable/scripts/netplug?ref_type=heads
