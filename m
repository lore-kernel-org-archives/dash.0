Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41626738C
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495891; cv=fail; b=BEEVwGYa2RKT1cZipiQuEdkOiidxjXNnoB2lw4xS68DDS0ZLWRT2XfR2ZCVlfYE9IVhThwJBjiDEj61HbL5Y0YobFh7xv4i8ggd66jHMS+oT2ASTgFJ5pVcWt4ZQ88Sr60xmC+0cpPEEjzyJwUAFroM2T7wmcgk5rEVdP/lWvr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495891; c=relaxed/simple;
	bh=V3PFxKf/sfkGEMuWMs5W69zk+v6ynrPZ0N6Fy7pC0KE=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=o/jE4Y3HUB3L4rnm1evJeRizbozrf/DstsW6fzaYPIHcu6lPp0pz7UyM/75bj0HJw0lrXM6bwpOOXvOMK3KB4uRtJ/ellY9Ie+bRNgbrCiC2RexTw5b7wksjtm1DBvCM//RySdPzqheTDTI8GZL4OTzk+94jCRYbIZKz02FrQnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KlqETuD0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pGJCcuaV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KlqETuD0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pGJCcuaV"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PCfaan027090
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=xWcu4E8D2C6tfdO+eioD6febbIhAvt5w8uBA6lBZg1o=; b=
	KlqETuD0NiKXVW/o+RrUUzeqtoXNOWYobU8ai3WxVWfv10oTjxkw47aMmQDvqv+W
	dOAhKsEBz2O7g8XJGCignp0SJ8xValxVjVjN/rWOx9xlrJs8Mu6+4kaUy7/lJlAm
	qIWjDDR3R520e67FmrcOwQBxzKDyNFTmfpbKSVSluFVgISGtm+wp/YkGBYOtbY+l
	QlpIY74ttKBIRuHP+4qwXUT+deZRV93EyZOGiAD5MSEtL8ecbZhDyW509J0uTmmu
	av3+y+lsHahHdAC7fah5ireGhI/AZSVnHtbSLH69VPiUMXEVJT/mJEUay9YA7FUg
	AW1KpzFldftn+eBzmZelDA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sddep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:04:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PDaFWT010010
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:04:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51927gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwihgsdmccaGjFpvy/eqvc+e3cIHS7Jg9aMvLdPHb92I13aqYWKwIvSPWnGFxZGvZ0gy2sXZrd9D3sUBEy53LuPy+t+cD+kEF/1T95kyuXaGcRFNmLx+S64TaYeUFBIlCffVPFPtHN2WH0kmen6viNVl7//FC156pY5LbmSjgxLO2G/UeffMKqKSNzZGX3tEJ3kBgeRSEpwWiX4knHgnw3IgbJ9LuOx6NuRyWM0T3cCuIhGsH3SlRi0JdI4t1y93kIj8DeToe+PBLXKpT5+ZTbBmWdBUdPc8BNfu5dUi4zyW+u/Tv4BBmZdo+nz/+cBHc1ClSFCtJvvijFdoZnm+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWcu4E8D2C6tfdO+eioD6febbIhAvt5w8uBA6lBZg1o=;
 b=fQZ7JQUzrnUAiUdNrRrX2wKEwlgyfd68mR/mnwAXpbmDMR1f2nLx3n09aSUzCGr31/+GrTk22Q0VbQavN6ji1mGDf3xAVVzT6O1A0WlEy9SBz/r8Zw0zyMSWnB894cBaX54UQ68vcqd3vXigdpxjeHz9BIHlcjJwofqmkSquZQAVeH+U5R/SFpHYFiRsFCh0Cf5rxSQ1zb274xuYlGrflP2cIfCnv/rcrS1QqWSljWi6vtOPBeCeEgAv++Pc4izQNQgyoiDr4z9pC+aC0hQd2OE+rBMCWu85aGnEndt4eOv2sGYbbIjA5otACL9pCsIwF/ZOfQRPOlpaQzb9WL/kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWcu4E8D2C6tfdO+eioD6febbIhAvt5w8uBA6lBZg1o=;
 b=pGJCcuaVQq2b7qH4b6j5OzQSfESHIUTTSE5rU1UlKVSxYcCCpy9capKlN0mzlsFyYLz0DUQk8YrGvUAgnPWtCR0RahPTXiyv/M8Xj1G3bYYn+0tEgOhYxIDaPPb+ht+oL5Pz3URDQVULpOgWWoTzz/H0R9O86c1HIYToaG127Wg=
Received: from CH0PR10MB5388.namprd10.prod.outlook.com (2603:10b6:610:ca::5)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 15:04:44 +0000
Received: from CH0PR10MB5388.namprd10.prod.outlook.com
 ([fe80::f392:4a3e:5ef7:d338]) by CH0PR10MB5388.namprd10.prod.outlook.com
 ([fe80::f392:4a3e:5ef7:d338%5]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 15:04:44 +0000
Date: Tue, 25 Feb 2025 16:04:40 +0100
From: Jan Pechanec <Jan.Pechanec@oracle.com>
To: dash@vger.kernel.org
Subject: dash performance regression with [ in latest github code
Message-ID: <Z73cCB4Xm89Y5AuT@len49>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P265CA0312.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::20) To CH0PR10MB5388.namprd10.prod.outlook.com
 (2603:10b6:610:ca::5)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5388:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: d755f051-ec07-4510-97a8-08dd55adbcc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?flayhq6EuhYSus7M917LP3sqADyjtHZHn7EJtX929Hxjmjnc8hvB/NzX0t2h?=
 =?us-ascii?Q?OYUD8AC04Pzw06uKK6yu27QaU6hXWRicNq21knUMPahul7BG9FLqBG9DGqab?=
 =?us-ascii?Q?xsMtyqTRjlJ3so6av3j4YGr40WgQHaozYmnwFALfRn4MW3b/AORpXsaeg9U0?=
 =?us-ascii?Q?cTBi/NhehViROeSgFJrp5IX2FeSYcuDfVCce2KN58AFcCnywvxl+psU0EO06?=
 =?us-ascii?Q?QQRGznzLfc9CyTW/MYfcIWcEffO+32ao9t8GoLJ8GVTYCFzFDAwmF8acNk+P?=
 =?us-ascii?Q?lBVNCz18pCuaHf5WsuaSiNNDRCt/6VOl3+h6JeJilhJtdx5H/8ggAh2H2ic/?=
 =?us-ascii?Q?dVPX4MYjfVIdp3ACQYzHZjb1wqrFtyAGxNdFYqW0uEsYZKwWTH/vjds03sMj?=
 =?us-ascii?Q?EoT0yn9EQerkd/Ftnt9R2YtbW2ZUw/q4WSNpzmD8ovZJRbnoNB+JFZ084E2e?=
 =?us-ascii?Q?b4BBcyc8rIGT5+T/FSGJRvehztbv5OI1xjlb+TLCm8TBNf8JAkBUXJT+yJ+l?=
 =?us-ascii?Q?3cIakTm9nU7XsZ8GoOcQ7XFGPdj+k4m88FoNNwuErzQgxCG19ShK/BbaVdFz?=
 =?us-ascii?Q?JbpVKds6+18JQfxwSIkl0BrijeOc+Eu4NEvahPQWXXRehwmHORb0BR8Ml9v8?=
 =?us-ascii?Q?v9W0w0YIl5LrlgZtGBRCWeOc0ZC/iuKijIsVqTtOLF3sPjsGHbcOnFXQgss1?=
 =?us-ascii?Q?QGL/69uAFZx/ax//acu5tDzeW0vFadSrKIA97ohCrqn4mAFaXd3kngsFrEX/?=
 =?us-ascii?Q?x62GX95CNL0pQQlFyh1ecARlX/mnFxfsLSfsKOR96UbWzdA3/rQe4+7+CZIn?=
 =?us-ascii?Q?83SDtQFgTydzBaPhuJkQV0mN321vFGoepGj/oxDheQwGq2ovTieFtAH3Jpq0?=
 =?us-ascii?Q?uBFLS375zrYI+TMkzoLXF4XpMr9sR36nuGQAh21MAHSKMaqL1nqREk4sQIB4?=
 =?us-ascii?Q?WxGBo+HhdhWQwtzktDpoxSk72Uijc2Jh4tS7o+IQ8mXb3Z1U5yCCUlwwG/9J?=
 =?us-ascii?Q?ykMmw6Vo6qe4yWWYiLRtu+sYykwdoVbekeQ9gwSAiHwRdRgaqMVEA4wZq3G2?=
 =?us-ascii?Q?4ApdkuhqEQJP88PAsKBVsP1ojjs/znzLOytD0PRG20ubulEAYwX2zSwO95cK?=
 =?us-ascii?Q?zhzbKHsFoKic/lUql2vkGKZF46wtsgw+YBY/1ZvT0FVhlwWpBu1cdpsx81fv?=
 =?us-ascii?Q?WsrZfDasT2MJj8QAeYEM86CZll9wlKWBiuZGNy0vbynDs/RpR8bhfhFH7dDI?=
 =?us-ascii?Q?vKkkDwCeCiq/g3fJnXOHOggyeV0S9arvcz/tGDY3U7LSP08TqJWF0JK6GlUH?=
 =?us-ascii?Q?3qOp8/yh8rCrP0lenmqfOy43/U4QsSjz9tAcUMyY1+QkmjlG/Sr0ehVnlsXU?=
 =?us-ascii?Q?/kYc3RBZXUwN8y2bkpCo9kXTnC30?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5388.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mww3DKoaWvXG73Y+lU3gqgpjUxi1SBNTRm+4UB9Z9lt0CSIkRVdbv81WS/qd?=
 =?us-ascii?Q?hqiQufTSyJJws1INLQay7JjixujTSzxdKJB1wlR6tQEWnDroLXNI0YR17fFj?=
 =?us-ascii?Q?uzdxvLg5K04fKkrZ9W5p4dawUIf/FGUcEy7WJ0h1dD/KpwoXcX/1JaJM/d5p?=
 =?us-ascii?Q?QMpdKe6osex/eGBezqecvbSl/xrXD0C05I9YLVWLvacNoBgxe+e6aRjGV+Cy?=
 =?us-ascii?Q?Xol3aG7Qm8mdm2QnxEC3kgaCwMfn6sA53CZADB2a9JKsLRlRFk/vaoZmp29T?=
 =?us-ascii?Q?oycATei2OfC5MWo6jvXzwDDxO90YwSNrmxRZIhHb1t0oiL7h23tQaNwHRmhy?=
 =?us-ascii?Q?d9VurPeZm1SZuKfZ5CyIDyiUTtxtKAaogOpsiO0n9Rd1XK+NOtdCazdjL2JT?=
 =?us-ascii?Q?EhyF0uoiObCPuY5RCX495tQyQRyzwMlTOPnG36vMkoUZnr9yuzFWSNavQr0d?=
 =?us-ascii?Q?mg7RleDJKPrJuBH7Kbwu4btHc8g+9Lkfl5Z16p9ZdOfiqA4w1aeBXUPglEft?=
 =?us-ascii?Q?++g8m0xQSbRsb2B3FwVh9wgATIzFaxHnHff0V2Jj2t72KON7ShvMy5L1JCFP?=
 =?us-ascii?Q?jyus91TltoX3VoIAYe6TaIl1zSURjzG0y8wzuYgjbgbNZqOj/tGEQJM5FCTX?=
 =?us-ascii?Q?SuBRTMDJ4acvRaVaw207gihlkdxAitaUtJ1SkNEco53PkrV1DAe061ognHAI?=
 =?us-ascii?Q?qavu3jXCUKkdd3izTdFB5Hq5/qeGEd7AjHJ96zBi/U8hxvUfqeTJ7Lk71K2u?=
 =?us-ascii?Q?J7DtYzEcMlEeWGEEb51oUoE6ZL18VBhEcJEnCEzKQ/ot2QiWS9bG1IIGvWGy?=
 =?us-ascii?Q?zPS3pzHuE8Tagzxtv7KzSjb4RuBl5eYFTLrUAiVQih1uSUC70UQGVZJ44I92?=
 =?us-ascii?Q?rS5vJXIqA9pvdMNvrndLNetJfqKrTBkXWFtxMDnqCypUByIImL+Hg5KnFRcZ?=
 =?us-ascii?Q?RrilNr1TFW96zgzFVijQdXWqSRYqoDsu/PFZMotk9NGnXCcj/+nzv9PifmLL?=
 =?us-ascii?Q?srtJaP/O0quCwwjN/OR1kprkxpE37ck5ggGLCTht99tYuSfC8fxHRTdJqA43?=
 =?us-ascii?Q?LSjIIbv6ucW7z3bMmeKbGUfbPYeXQTtI5Lz/krzaD3yAF0OkTJouyMJEMLfl?=
 =?us-ascii?Q?g3i2/aHQJmIjO8dOh5kwVhK1glVc8vszYz3rN5tMv+H4B+V0ru56JW8QlnrZ?=
 =?us-ascii?Q?925A8vgSQBcRF/kZ51wKsQH9+16i/fOS0pAxyA+g13qSm2kM1fG/s8unm1tn?=
 =?us-ascii?Q?LAPWgN+vvu9Pd9ahNiMGDKLvFJ3Mvz8aD1N8XngMzJr1kDSj6zln97OYdCZa?=
 =?us-ascii?Q?Z+gpzfK+SlWLDSHP51QX5xhxwi2wFJ5QsCco0rEEwvgsH94thuOpN99kWMk1?=
 =?us-ascii?Q?rQrtjAqg59rkSbDHYaryk2/Fj08CTusquEEb9e/q1o7z9S6WETf6Ga7CPJyu?=
 =?us-ascii?Q?c3CKiCLcA4m5mbSbm20YpMdGJIaZxFHqSdTAKsh4Pn2WgyQ6u7sjCIN6eORW?=
 =?us-ascii?Q?ihrCHOZA0Q9ENaQJYPb627oclq3SC/1QptFYMfaWTQymB/ceXIWmgp0e8H4x?=
 =?us-ascii?Q?g1EEmtYWJNuAzHrZrNJd5Qk11MTmi/xxXGehrdscdh6rJ+Mu45yzMMwGVEbO?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qGwrPj3MbxBd56V+mHQ9sNnCJ57mAfew6dV1Fto8mT/xRJDcAiQ9heiALiBEXmxGvThV+3hATn43hjWQ7PmkeUQ+ruUoKtswRAHaviyis2TESJZ82aCyOIysa8yVEOlb1PxmUQYWGIakBTqD+vRmgte81izxDbo/zyp3dPv8IyFsN5kT/d6sedhsqo5gDDxDyulkpss7Eep+5uk3SSdAxzVnYz5O/nV9YMljEpmd0XitolYDeeo1GFYhOhXq3EC5s6+KI795jQ216+ASMry9bgxEVurekHfEolToNJg92eMvWDdfPJnuTVaab5h+imRiNgwQhEY8eJKMgEVd0mHV2x9XzX9EEwir/L6w821rV7rFw0gPK876rr4fyXCLpzBnISCGBWPE4fOiobfX+EubZIzxNAfn1O552W2wmXD7ky7FtACL4i711DUlUCDHQaJwBwXFqSBGDuISw70CLhgv3h9oOu93Ry3XTqBWKrFsaFwj0SVb5vbesIjGn+fo1pqXC4UU0WfPCVSdMi3lqzExjbxteKvNVFOZ2obYLOHixl7jfb9cbKxps8TdkfU05BLc6Kw6Ylx5h3TfyHsa1Am/1RbytioWEb1PKjLjZ/NXbEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d755f051-ec07-4510-97a8-08dd55adbcc8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5388.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:04:44.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQSX+5xQPBgxr7QPQTaARPUjAm81hS4tzBNqeU9d2xlKnm0ow+HoGVS8/n8Vls7Wu2HjZ+5SSQfW5Jc5PPbpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250101
X-Proofpoint-GUID: XlaF7Hh5v4tk0G1hZpHZXrZS_aWfdsHx
X-Proofpoint-ORIG-GUID: XlaF7Hh5v4tk0G1hZpHZXrZS_aWfdsHx

Hi,

thank you for working on dash.  I was testing it recently and it worked
really well.

However, I noticed the dash code from github does filename pattern
matching even for code like "[ x = x ] && echo ok".  I believe the
unquoted space after '[' should not trigger pattern matching but rather
only to invoke the test/[ utility, as before.  It seems it works fine
though and only doing some extra unneeded work which may not be
immediatelly noticeable.

dash installed on my Oracle Linux 9:

janp:len49:~/_INST/dash$ strings /usr/bin/dash | grep dash
dash-0.5.11.5-4.el9.x86_64.debug
janp:len49:~/_INST/dash$ time dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'

real    0m0.752s
user    0m0.748s
sys     0m0.002s

dash from github (commit b3e38adf6718801e7f06267b438c45caec9523bb) take
way more time to do the same thing:

janp:len49:~/_INST/dash$ time ./src/dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'

real    0m4.202s
user    0m1.361s
sys     0m2.804s

For the latter, strace shows open, fstat, getdents*, and close system
calls for each iteration and it depends on number of files in the
current directory.  With more files, it takes more time:

janp:len49:/etc$ time ~/_INST/dash/src/dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
real    0m15.591s
user    0m5.704s
sys     0m9.828s

If I change [ to test, the dash github version behaves as before, and
possibly even faster:

janp:len49:~/_INST/dash$ time ~/_INST/dash/src/dash -c 'i=0; while :; do : $((i=i+1)); test $i -eq 500000 && break; done'

real    0m0.662s
user    0m0.659s
sys     0m0.002s

Even bash would be faster than the current github version of dash:

janp:len49:~/_INST/dash$ time bash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
real    0m1.943s
user    0m1.939s
sys     0m0.002s

Unfortunately, I do not have time to work on a patch.

Best regards,
Jan

-- 
Jan Pechanec <jan.pechanec@oracle.com>
