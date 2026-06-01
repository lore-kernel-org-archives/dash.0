Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D363ADBAC
	for <dash@vger.kernel.org>; Mon,  1 Jun 2026 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322192; cv=none; b=nWOCfzmaryHdvk2xm4o/0NwMklFMpSzvlYenbRPJPENnWcnZmoexhSMgiuaGJkLsUQIY1ggW9ZGv0UfhGWnnSUbAEXp/cS+m/5+BC+Yk1T6je99PF0ixzha10iAh05bt8F0ROoNHBw5kxJoYBV2ra67NeyCFZvxKQgym2knVjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322192; c=relaxed/simple;
	bh=olV/OX2BnA1upoiOFWkN3wYG01kf2D8HPleKsvMXVFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac6MRczji4CyEn5ykwX9xqLuLtb799jUQ3mr2NHJXUZ14EeB/n/hGDRqBnQQLt5QzoJRgLSJTXAzGYn2qvNJ2eJ8WUp30oKwfFNk/IM/MvnGak3ddhE2MxBHsQtqmbOsI7XZiuWOxYGv9xYvtQlwckLSLEdVx+9BvVbStfdSaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdOgz6vm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdOgz6vm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651CxFWD065560
	for <dash@vger.kernel.org>; Mon, 1 Jun 2026 13:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uCEm1K58D37p0K47wNuG4PkkFIVOWT
	S8CbpWa2WF+UY=; b=rdOgz6vmyuvEc2TJYW869YBh3r5rxszNSV6diZ4P88+cYY
	ejRZ1t5nTu5roweLZa+MCvcrvSjPC0KQIbxrKvBm6SvWck3NNfXU6jPIcjeKuO8z
	bZzC+ZKBGx1rmow9m1MLevAqs8TDhHR3vk7RjvddIi3bju112eg3H1W7X2D5Vy/m
	g3b5nMoAFT9dOtOdajfnBK7NPOpFx0cwdqCInvi5j4vT3PhK8Sca7BwOvcro+jRb
	8a7WDXO0aFnez7isidjJZOJ8L1H4/vk75tjGh4pP81L30SHi4IhOOSyr3ZTDVjhK
	7CA+XhOXorK1ISSjJQY/YXkBJ3nV9nWwMxpQ41KA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4s0bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:56:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ds51A010179;
	Mon, 1 Jun 2026 13:56:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy639v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:56:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651DuRV935324378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 13:56:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A4432004D;
	Mon,  1 Jun 2026 13:56:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31EDA2004B;
	Mon,  1 Jun 2026 13:56:26 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.23.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 13:56:25 +0000 (GMT)
Date: Mon, 1 Jun 2026 19:26:22 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Ilia Kashintsev <ilia.kashintsev@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [BUG] stack-overflow in src/parser.c
Message-ID: <ah2NMlFNWuLR6w28@shivang.upadyay>
References: <CAF6ebR5pJm63sQ41rvD4jP511BrnY9A84+F4c-cNt=-ejaaonA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6ebR5pJm63sQ41rvD4jP511BrnY9A84+F4c-cNt=-ejaaonA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: GqerJz1AbxDbdIlI67RA1f9bQ8uyc2hu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNiBTYWx0ZWRfXy0aoAQNCVmN8
 m4kJ9AQZCdQ7xSLjXGH7iCETqGij5rp5aPW1PDA8+cntW5IklSTO/WrkGe/QHenvxmZh+x0s5eP
 9NSTTj+p6QvewuvCL+0SoPZuhfdoOz0YQg3/k6xGgklkSZPLzObdvSBEIM5OKbFpMxE2w27eaxs
 IORgwbuMjE26MFnBJ5gSj3xlefpiemEIV84QG+MOePnw7fmoRDm46tsmj58oD2RpCW9ZVadnYwr
 EmumOJ840cH/uko2hJmepRn9udCthsuooLUDHDexhseNXEchFiR5QAgHOFJSyDPcrVrNaZI3QUm
 KtksH0dqGWnYpwSLjiu03aAtx1HVswBhA+VLfIJuDQSICUnpz502VGcH2/s6xlxBvnod2q6LK2f
 7hNdn5BItixZ8GomwbhW84rDlgA7x9R3ttTTv5VOc15Ev9xVvnkVK8x42XSatKdV6L9Sw5QTRyN
 1i8PB1Re8wmOQSlnKag==
X-Proofpoint-ORIG-GUID: kZ6oufUbHzzvVnBWc2_Bv6ObBQAQxPme
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1d8f8e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=gI2CxrMYZS36xPz1U0EA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010136

On Wed, Mar 18, 2026 at 02:12:02PM +0300, Ilia Kashintsev wrote:
> 
> The stacktrace itself is not always consistent, f.e. sometimes the
> crash occurs upon entering command() on line 321 or inside of
> xxreadtoken() on line 810.
> 
> Steps to reproduce:
> 
> export CC=clang
> export CFLAGS=" -g -fsanitize=address "
> ./autogen.sh
> ./configure
> make
> #80000 might be excessive, even 10000 is enough for ulimit -s 8192
> printf '%0.s(' {1..80000} > brackets.txt
> ./src/dash -i brackets.txt


Hi Ilia, Maintainers,

I have a small fix for this bug, which is more direct. setting a
recurse limit of '(' and '{'. I think 5000 should be fine. Although
there can be a more proper fix using user m-allocated stack. But
I am not sure how to implement that.

I'll send the patch as a reply to this message.

Thanks.
~Shivang
