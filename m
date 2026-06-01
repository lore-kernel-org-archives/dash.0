Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178037B40A
	for <dash@vger.kernel.org>; Mon,  1 Jun 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322590; cv=none; b=CyAw6umPezKq89ygexiDFxh4UHbMTEAa1VEP/fTKs9gSnaGNaE/FYeqnzy/jKEjvjYpiwRbb9+sYY/xKlbxQCQ/x7nqkuVej8iueSPFU2Yfz+FUCYhIHEWMZ82B7mb4l2iDjxHrHElsE3xY9OWr23FPp0y9rn7VIy6qs8DT1jU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322590; c=relaxed/simple;
	bh=AD/V27O5nip+c2602we9jnosXGJ0MhNqnNnmNC0x75Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAUG2T6Wv5vBDD3AJR/5pAaJFW8WINkvRUbwiTyIikK2q3OI0BLU7/Ce/efz0hvVEh+O9X8Cb+o8K8YTDogL4sKMQ6xnFt00Amwp4VJdWj0jKJ55zKOskdc47wkGQC/EZDB7hEqYXIxCecyj2wkhaPVOg5yg7oanW0mekjuSDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O3GfqCrm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O3GfqCrm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6517bBFj2606065
	for <dash@vger.kernel.org>; Mon, 1 Jun 2026 14:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q7uBgz/xUVuROSeiG
	UFpAo23QRKFnaqqh2Ct6i8a1WU=; b=O3GfqCrmXwwbWxFkdnbm3t7zSJ+KzWl0x
	PaRdsg8hXQ9XndLMeO9HBmSiG2XvdH8Y6NxPAYkFFNC2S1LoRTZPIbIEoyA7IWxw
	AFllStfd9FHxJ6wj3Ln1DRgnvEK55FvrzdSGVroVEoqqr43glYxNCCfHKE0NZ6uP
	UmuJRsxc8A5rja4Pqnx2FStgIU7RqqFguF7iJj++340sgP0dzcKYNt4LPPhSHQP2
	SZjoZDgiFknD9PLAE2R6gQVYg4pAwkqu6PqRLYa+bmcDc8tmGzRV7wMNWPQLr9yU
	1RmSZQsscuPRaCXVmv5t7z9cMyDm1T0nkrHjdmbhJfRTCuvsc3KRw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahgy2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 14:03:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ds5bH023375;
	Mon, 1 Jun 2026 14:03:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q6m9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 14:03:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651E334K50004454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 14:03:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 676ED2004B;
	Mon,  1 Jun 2026 14:03:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D94402004F;
	Mon,  1 Jun 2026 14:03:01 +0000 (GMT)
Received: from shivang.com (unknown [9.39.23.64])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 14:03:01 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivangu@linux.ibm.com
Cc: dash@vger.kernel.org, ilia.kashintsev@gmail.com
Subject: [PATCH] parser: set recursion deapth limit for parens
Date: Mon,  1 Jun 2026 19:32:58 +0530
Message-ID: <20260601140258.89135-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ah2NMlFNWuLR6w28@shivang.upadyay>
References: <ah2NMlFNWuLR6w28@shivang.upadyay>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNiBTYWx0ZWRfX77WiLkHViSHA
 /UMyc0EsbON9Vb6Ybg4Iks7/Qgk/lg+Kz4a1xhCsK1b8XEXZQYKfEYmeRX/n/w4fAh846ki2Jx7
 cI1G2740TCVCK+DKXNdYpPg/CU2+EmohFVJLhw+xt5Bwfurf/BMU+k4Tim93mPLQ0R9ZzJyRyaX
 LQPwb1BKutNdOmFBLL99Pw4oMLphPqGui78Kxgtuun5RCrISzjhUipyR+TthKSaEpgOorsfD3lz
 nxBmobMiqMp3INdzKY7vFw9QrzoGk7SSibDB6u5OM+Xti7ER1yeuG5Q/hKTnqu6+/LhFHmCrZlk
 IfhKEhXJYvYvr+R3xRRIrN9z0Lcqhn2QYziH46i7ybrJlhm/8fkYRPoIA1LCDTPYud0AW2Chegq
 4ULjasKiQrj6H03G9iVaaCK9IVPer3zgVTeK3Fri2iuAD2U1dU+hpJfvEWbfIGzX5N35Ey9vVKD
 MywG075+e0dCaMGhBUw==
X-Proofpoint-ORIG-GUID: SiAx6J_HkdGxThn-EChDBoRS5q-WPMAt
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1d911c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=WHsFyRfMjMqO9VnSqWMA:9
X-Proofpoint-GUID: HYJWtAgw5W9UDQ_ztV713JfMKcMnhYQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010136

Setting 5000 as limit for recursive parenthesis '()'
or braces '{}'.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 src/parser.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/parser.c b/src/parser.c
index 412e876..5198dc4 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -110,7 +110,9 @@ struct nodelist *backquotelist;
 union node *redirnode;
 struct heredoc *heredoc;
 int quoteflag;			/* set if (part of) last token was quoted */
+static int paren_depth;		/* track parenthesis nesting depth */
 
+#define MAX_PAREN_DEPTH 5000
 
 STATIC union node *list(int);
 STATIC union node *andor(void);
@@ -164,6 +166,7 @@ parsecmd(int interact)
 	if (doprompt)
 		setprompt(doprompt);
 	needprompt = 0;
+	paren_depth = 0;
 	return list(1);
 }
 
@@ -471,15 +474,21 @@ next_case:
 		*cpp = NULL;
 		goto redir;
 	case TLP:
+		if (++paren_depth > MAX_PAREN_DEPTH)
+			synerror("too many nested parentheses");
 		n1 = (union node *)stalloc(sizeof (struct nredir));
 		n1->type = NSUBSHELL;
 		n1->nredir.linno = savelinno;
 		n1->nredir.n = list(0);
+		paren_depth--;
 		n1->nredir.redirect = NULL;
 		t = TRP;
 		break;
 	case TBEGIN:
+		if (++paren_depth > MAX_PAREN_DEPTH)
+			synerror("too many nested braces");
 		n1 = list(0);
+		paren_depth--;
 		t = TEND;
 		break;
 	case TWORD:
-- 
2.53.0

