Received: from greg.wooledge.org (unknown [209.142.155.49])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2DF871B3F22
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.142.155.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649341; cv=none; b=Ud5F1eLs5CChssbHkFNFe7mh+OnqIis47eQ/4ueCtkZMlV6DvYvsuAr5JZefCHRuGoRFlaNNkvdHNNCn7UDb8g+eE2pUVWzVxVgTjqfHmMSVL59X70/clejZyvxFYwYDPIcJxxp0e+5mfWH2q+AgE0+SkYptNErh4bsmj4CDulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649341; c=relaxed/simple;
	bh=LWkVBb3hEuiaJpFk4/LAhGeXU5mQ3j/n4lFRaHHhaGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLMHK6lkxL0NZZtcw0SwWgMToRY6LQy83Wcbs7Xs2Nypfu0sqduqzE0UNl8xIKXadV97hR6wILHGcgIWPXV3MB7Q+BervBiWaM9jcrkQjtZDKI0QE9IFbX/18IawLPg0IIzSanCB1Tf5QRni2OUaJHhDjOHXjdB7/uRw+/+UtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org; spf=pass smtp.mailfrom=wooledge.org; arc=none smtp.client-ip=209.142.155.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wooledge.org
Received: (qmail 163927 invoked by uid 1000); 14 Aug 2024 15:28:48 -0000
Date: Wed, 14 Aug 2024 11:28:48 -0400
From: Greg Wooledge <greg@wooledge.org>
To: =?utf-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>
Cc: Robert Elz <kre@munnari.oz.au>, Marc Chantreux <mc@unistra.fr>,
  dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
  Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <ZrzNMBkeChq-ZsNU@wooledge.org>
Mail-Followup-To: =?utf-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>,
	Robert Elz <kre@munnari.oz.au>, Marc Chantreux <mc@unistra.fr>,
	dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
	Steffen Nurpmeso <steffen@sdaoden.eu>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <ZrwTnBvk8_2mdQUS@wooledge.org>
 <ZrxzCOnZv-HffFuB@prometheus>
 <17108.1723645239@jacaranda.noi.kre.to>
 <CAH7i3LrWppOACxUU6zaLupJzX4WrtkiMGx2roVq0yvY90JHrQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH7i3LrWppOACxUU6zaLupJzX4WrtkiMGx2roVq0yvY90JHrQg@mail.gmail.com>

On Wed, Aug 14, 2024 at 17:58:15 +0300, Oğuz wrote:
> On Wed, Aug 14, 2024 at 5:23 PM Robert Elz <kre@munnari.oz.au> wrote:
> > However, as ksh93 makes "" from this
> > expansion, and so probably ksh88 might have done as well
> 
> No, both Sun and SCO variants expand "$@$@" to zero fields when $# is 0.

HP-UX 10.20 as well:

# set --
# printf '<%s> ' START "$@" END; echo
<START> <END>
# printf '<%s> ' START "$@$@" END; echo
<START> <END>
# uname -a
HP-UX vandev B.10.20 A 9000/778 2000153729 two-user license

