Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6C223311
	for <dash@vger.kernel.org>; Mon, 10 Mar 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595719; cv=fail; b=P7xSArmlGqXUi3fn+IOwSbOthcFdzL2yZYS4w0uogzxoLAmokvIX0BsTW1snmBYYR84iPnHEAtvytm+H9CMJKX9seqgxCFQpnOZvTHfoSJ8mnia/TcmIZP8OofTBncGV1u6brw8azD/71ogYsfebuL9STWGqoyG/wUgFblQdbcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595719; c=relaxed/simple;
	bh=24fmFHHSe1BOSKUH3q2JboYBIHGT6hq+ZzWDljqLfIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+fbnaojG+k+CxdL1UQZrD86T8pLKX4YZOUOi2b/WkJBGZBUjdOFlN37za5AM6Q/G59FmahbwijVmjpmwvKbroMN1OrBHvEFx00xZabGLnxpoxf4jDf5ahsMkjDABe3DIl7zLuOoThQrWCrfHUXpbeXLFEgouCYSEfmJSZOTpJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JC6zvX5M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LaPYnhcs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JC6zvX5M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LaPYnhcs"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A6fjUL002632;
	Mon, 10 Mar 2025 08:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Glotz3/ydL4RxrxNH3
	zxhwaecBpK2glRUq6LsaV1DhQ=; b=JC6zvX5MP/1gcgkHzQabgd/mxgotRFdVqm
	KaqRF6W9sxcr6JybzwO4nFjLFPFTLEzvtWUAYo90rtXLYBd2LmexXdCbItrp4dy9
	bhkLcWCa6QTxRPtUSDvkhPJV19qITZh1DACRm0c2ij+ZQhpD6RmMupL2HJd8UsPR
	lA0yHM3daKa2M5nX0bl4gAK/qNqYsGxokE4s7azWCDMUoMcdWDe0TrWb5hdIIpOc
	x0VTMEuPCQzdYq+AZY/oDbRSdNKfo2+xq9spUTKpnRnEtEH9eVf3BKPWWTq2avpl
	/P4PWSAnoYOedrxDfEz26uzjmTh51j1QiOMXPD8anHC4uvZ5oQfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9j163-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 08:35:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52A6X3Ig028975;
	Mon, 10 Mar 2025 08:35:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb78y01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 08:35:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZidG/qcERNze4ZYzurOkE5kZaT7U5y5jESdy3MOyv3drCW38g6uIHUbv9LJUUrnSXnkNPRUGy4+Pmikk2HUdYLGgmjdKoRxapZvEe1Kv0VzcWKd24PDu23GndZfbL7EpbxulJ5As8K1TjPDO7x47vd5oZbv+6oM/BEdjxrVrbCwwIl/qt7/MUJULF+g43rGwl4MmvSBXUtkyttBh1Nba+naKPaiU1ob56lFqkd4KpQx7uD7YUHkneSLyc01GUKzCBDDlqfKlmx+o9NwJa5rU9YeRHwSEdZQQWCsGGxcQKYBMq1uMEWYi2rDhD49IaTKJ1Zb5MGIiy7lmFggPDNhDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Glotz3/ydL4RxrxNH3zxhwaecBpK2glRUq6LsaV1DhQ=;
 b=Uzx7TPMPEz8onnu5645tgttRoiQMjJj8PQlOlsl0a1GaDPryT8txyDl0FkswWgHC4cG/+Q+2n/LCUk0L7oov+sB58RqaoaDyI0YOceuLIDlmNCkEcF2uUGn90070A5FnZI1XZXwwbM7UEZUJXC0R6kKG1xF28qQddRj84K8wwFRqukr+VzPy8mjdDhUu1wTr9wu1GgHIBp4E0LlMcJZEKPQ/MrBvJ+rszoR/vwUsottsbWbvi8KNMF6729wBQcdwXzb1roxwYLwwaCpVoS/qihpNsiLSunw8ysKxY9HfgyWyOmZBysV6cBS58cCpD4cOnnw1Is2xBRy6I+xD9mBCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Glotz3/ydL4RxrxNH3zxhwaecBpK2glRUq6LsaV1DhQ=;
 b=LaPYnhcsMtD+Wb2RC2RuiYaITklOcYWdnuQnnrq4zJy5liHfjxB+biej+vaPOXTsLjMEjfNlZUhcKlstBwXnoyIp5kGQ+JUvkQ4e2qQMwOgCjHl9sRqIDAiFLi9O0TWxu6ZKfz3fj6ATeEIf7ZVBU9ny+4xHHk67sHk1rrlIQhY=
Received: from CH0PR10MB5388.namprd10.prod.outlook.com (2603:10b6:610:ca::5)
 by PH0PR10MB4613.namprd10.prod.outlook.com (2603:10b6:510:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:35:10 +0000
Received: from CH0PR10MB5388.namprd10.prod.outlook.com
 ([fe80::f392:4a3e:5ef7:d338]) by CH0PR10MB5388.namprd10.prod.outlook.com
 ([fe80::f392:4a3e:5ef7:d338%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:35:10 +0000
Date: Mon, 10 Mar 2025 09:35:00 +0100
From: Jan Pechanec <Jan.Pechanec@oracle.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: [External] : [PATCH] expand: Add bypass for literal "]" in
 expandmeta
Message-ID: <Z86kNH+oXupDQJ0X@len49>
References: <Z73cCB4Xm89Y5AuT@len49>
 <Z81ikFIDPKfySXN2@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z81ikFIDPKfySXN2@gondor.apana.org.au>
X-ClientProxiedBy: JNAP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::17)
 To CH0PR10MB5388.namprd10.prod.outlook.com (2603:10b6:610:ca::5)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5388:EE_|PH0PR10MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ad824f-d6a3-49b4-82de-08dd5fae7802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zg63qPM0bea4g8UZVKjg+qutmbzzPlxpNKQxRe4eOZp8vAyQfc8c4zfq+/RP?=
 =?us-ascii?Q?TyuGt57zzX9ZdsaoJtY+ghllfPMwE/kmBDFNz6flir39gHqrKn9RVFi47cgk?=
 =?us-ascii?Q?mX+O2AOhvtBXXUTav80M46uIO79UxZL0IKx+gYuO+D+kWeRDfSNd2HtzkdTt?=
 =?us-ascii?Q?BKHRrMh9HAsBN19uiBHd0948fHHSi3O1l5lJQpK2Jf4EXlTAXT7Uko0ZkAh7?=
 =?us-ascii?Q?P+wuSUoBuhkhWNOXjwsXS7sPxx3G+s8zltft0GdH3V5c53ZCxnnKwC2n58A/?=
 =?us-ascii?Q?CcVXgdWinxL4XtGp96wREBvSrKhYyUiCAdfyQOfzFPtQi9kNE+NwIVYfBzQz?=
 =?us-ascii?Q?rxgkRKGUtPGwrruMhxZMu7DI6MBn+VdjKf6JaTvBiCc3Ebt6TEkx1u9//40T?=
 =?us-ascii?Q?gQ/ettTMOM5RO/3Eb4OUTqYDcheNj6CLUxxA4/X9ee2mGfffueMitqg8KX5y?=
 =?us-ascii?Q?rv0cL4VSIxJwnbZE5bGcY1YhGRt92yvDw+8zZQoieeliZ5p+E7dTi26yooh/?=
 =?us-ascii?Q?ykizkoQiFN5N2mWr3sEje5D1pVaj/qsmK2oHf+Ajv7UqG4jwTqPrgUQGCnGs?=
 =?us-ascii?Q?+eaaTbz+tmNXSq1BbUwNDU5h7ewXf6jdssleQewoJmX8mwSwEBqMNWpqzr13?=
 =?us-ascii?Q?bD/nEOeI7zh78rGzxTOKTFJI9AjGKEUBCUaWNpipJdlyEHy16pqUkF5ZUz/P?=
 =?us-ascii?Q?QyZBNezlKHwuJI7qRKeo6N6LTsFmkdg0mBPeSVpFLYQQZYEB5N1n0Mie+F/p?=
 =?us-ascii?Q?4JVHKAR6RT46oK1t3D/VhL9+RhDT5yCllDSQv13ou52/USWDo8EXpPAdipYe?=
 =?us-ascii?Q?S2mdBLCHSbhtVyTV5ke9pnixtRdlS2xuSB5SlRMurXhzLtnddVM/0YpEzgqY?=
 =?us-ascii?Q?vS7pswAdwCThXLJ3/lY2NpcVhuHyrRdexHuWMNRSYQriPqb2tWmnsvyXNVsX?=
 =?us-ascii?Q?hsYavk7yDQvHZI+sQP/pI+ZSAPE/ioICnUY6DteJqJ3osK8rZYcVKZDZCQ19?=
 =?us-ascii?Q?suAbiIgo03x3AVxEOfHYkwo+CQ4Ie8Jr7cbo7JtVmTmyuO4zlrEjJAar6FIx?=
 =?us-ascii?Q?PUs3B6QYhNTwWk9isbduONrrOXrJKZ09Mpom8GaBjhcumMiW4y4Yxp7FNISr?=
 =?us-ascii?Q?OXhWMTn5qsxAOOQx0LxYskjsrk0hr/lTpb7JEipzV+IonGFupWQ7AQlVqGRc?=
 =?us-ascii?Q?Yo4zGcfVOYIryUaAVxa7FCAGsoSW9Hjtp2CdpzcysTjPStTJ7zy5iIkg3A7c?=
 =?us-ascii?Q?awtIco+65TkTAJnWE08lKZxSiBoZ8Q8TSiAIC9ovNzikoe5sJp4fHmWWtVbw?=
 =?us-ascii?Q?J6maQ6wcAAEjrpJAkOTm0iVkw3ZcU/e00iOGNRAroED4w3i7idRh6ss5KVGL?=
 =?us-ascii?Q?DoFlzxZVhXbsyg2gQ1Izq5ecnaJD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5388.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKe08tiyS+4+9Owk/wSJ7LeeA2O7JbteEi+ZysO/Q/LMWbeIxTLoAVH5yaOE?=
 =?us-ascii?Q?t45DRnTTuz+FyJpSRODBuHRLFx+HlB9vgucflFuypMHqbkLQKwfYCOOmB+De?=
 =?us-ascii?Q?UyJej7Euna0KyFX6TyANdhgHNdmGYcN5cRPDEF/JViC1LjBr0DJiuqBXKfdo?=
 =?us-ascii?Q?cJ4Thy2pOi/UU01ZOE3+q2zcs0EBrP1HU9s+rlunrqAAdCZQOZBrp750W/vd?=
 =?us-ascii?Q?Dztq7Z43tAX489b0cYruoAMqCE4gmFBjACKcqYHyld7UUyj6K7nXzue7jhm6?=
 =?us-ascii?Q?HvxrVmDj+luonpnJS9DY5ocJYUhFo5rxIFLPee0H50c49EIrc5X4pHqhwBz5?=
 =?us-ascii?Q?AF0YaDuWia0ToTtFHz7Uwx/XlojRFOGW1D3GvLrnCVdgmMUJXB1EdIYNyHO2?=
 =?us-ascii?Q?+Bx75a3FabcNGPR329Wr4JV8Gf9fzpiO6IfG48b8xK8fo5rrGdI7HSm2gcHh?=
 =?us-ascii?Q?WXXaiRlha+8DyKIFSDAGLZcy4McfapHQVe3b3YDyj/64Xgz2oEOLVUcckZY5?=
 =?us-ascii?Q?cH+mhJLiUVPJpsnfLOid1NFW4FTReOJzComzTilnEC24sbipLwnAK5y3+wYe?=
 =?us-ascii?Q?hxz00p8cbdlDomtfv+jAKig7q77YSK/MfqiKDpt0NGnXuvUh9H7k9FEmScfx?=
 =?us-ascii?Q?8WRYR4ECSotrSlRUA5yb6ATPdF0WVOD9iVZKlh/xCzTmZCTXQexrksZc5Idn?=
 =?us-ascii?Q?Hbxmvs1CBSIDxkkTw9FyewWHFgFkaElLIjp5cNDmUpekZYfvkt3gG7zd7c0u?=
 =?us-ascii?Q?XbvILgjL4mNXRCtUqacnuiwgRh6gZV8SCIfkWS0qhOnb/kFxbUX2b9iYJ33V?=
 =?us-ascii?Q?oHc1bjZfUTiKhjbjKmbgDmp4RpHF6mr4PA0lHWykiAHWKPRPa285va+MeKKd?=
 =?us-ascii?Q?CxKyxpj5urWRZaGnHuIsSNwFCvFRED9fwBcR/URxyvS8eWmin7I8Me1uG8Vl?=
 =?us-ascii?Q?Mv5aovfZ1M4d/GsXbx1B08gsdsXHIy6WEVBn42i96YqALKzTVxo0UJhXKDda?=
 =?us-ascii?Q?oyPEqtCzoc+0AyEvhL2iQ6J3+zt9dOSR1IUMaL1doId/ChZ+Gr26Dxijkbmy?=
 =?us-ascii?Q?fe2B0eywUJDz9Xv6Ii8WmSmoA5wwz7eKAbAOsB/+IOrAxLwdO3cN/JCi4H+/?=
 =?us-ascii?Q?YmDXxVZBEc3c5xJ4NYjp3IcpiPelPxj5O8OltToKZBQj+UiikWZspFj63B80?=
 =?us-ascii?Q?bY3BLIWSeQVZOV4k+IR/sYsRu1WcL1NbnDYtO6oQXUt6iv+qYZCIeGWBKWds?=
 =?us-ascii?Q?A3puSgftHs7m0vCa3is/V+9YM8+lkJrvUiVjhVHdoGjiZLSl+92RWb+r9n1r?=
 =?us-ascii?Q?XT6XAMV/UbBnXyMZ6wS8v5UKrk+OGZRD5q33GdifjwyjDFOcI2pUfbMbLElO?=
 =?us-ascii?Q?tgD9xdAxwaTrYDP1yPPIeal4lZGWhfouES1lHDWsbKm1teSZ3RE3idxWY2aP?=
 =?us-ascii?Q?OqbEe7GD2lh9jDajcRqiRPmoVQboo/JtzyeGgSggHz4CZTgmQMdgDkKFH96q?=
 =?us-ascii?Q?YRxEN44OhNHkCCRksKiE78IDEbATE7H0lKj7eAaS1+FOid5IT5CcUgS2T1rw?=
 =?us-ascii?Q?f7v6PePSrDAtnDNQvvFyjpogT9NlJaogDEIDMb9c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r1PPRJsygHIoQqoeDc2hqb7L+YVJxynuMz+YS4hP/GocAqkNPWA0HKmaeI2nHfDb/sVJyws/SrLLrjSXSD/T83IZki0iktqaVJmiOG06N9IjEOgllnTSRUPW1mGR3TXnJR/SRKYbp4OdMG+jDDXVeUli6efL5Gyzx3MqHq35kh9i5RJKmhACzt5Q/EYpuXLtiQyp3JASG6ur4VaZqdSjN36il3NuAfktIE34i2l3qcu+tu+q9VRz7BS8QFQ0br9ZMBB65taMwml2qtaKAYlIlQioZ/kDT+nFAJLsw3cOu13hhk4d3oXp1WnAKnNtYIjsFhB1vOpwKo8jQ39HuQoAHh4xGObFUPQHPl61KKgutAWT8KkuKyI2f3b4R+xMMKmJVCXFTmsly4pDuMg6wpzJox/+i22hYUlnYIskn2NnZ5PeYApItivujP5oVqHy9I7ahOlzhQnS7w6DPD82daDE3ONbKjKR007Gydk+C0UNze8xDs7rurAOPhBy0suL/BaQkVdsVPtDKMe0vhoxD1u1Yq/+g6zw45d2lcFoCrGMLhs6sSU7mYaPkabnWNfXkBNCYwQalZbPYbAn0P8buwX1RFjpQqqwt+XXudHhbWNSxHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ad824f-d6a3-49b4-82de-08dd5fae7802
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5388.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:35:10.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C0l7mshrI+7aHnu27qw9az1BaHfgqeOiBXabJAWXV0nFKLcl/I23pHIQVnrwiiTdh2VpWWcfGEK0F/N1uGzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100067
X-Proofpoint-GUID: _1ewj7eOl0lDiSpa_nar0SXraw8jph2c
X-Proofpoint-ORIG-GUID: _1ewj7eOl0lDiSpa_nar0SXraw8jph2c

...

> Fix performance regression for idiomatic "[ ... ]" expression by
> adding a bypass for a literal "]" in pathname expansion.
> 
> Reported-by: Jan Pechanec <Jan.Pechanec@oracle.com>
> Fixes: 8d0eca2d9fb5 ("expand: Rewrite expmeta meta detection")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/expand.c b/src/expand.c
> index 7a30648..5114646 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -1555,7 +1555,7 @@ expandmeta(struct strlist *str)
>  
>  		if (fflag)
>  			goto nometa;
> -		if (!strpbrk(str->text, "*?]"))
> +		if (!strpbrk(str->text, "*?]") || !memcmp(str->text, "]", 2))
>  			goto nometa;
>  		savelastp = exparg.lastp;

Hi Herbert, thank you, this seems to fix the regression reported.  I
just applied the patch and succesfully re-tested.

Regards,
Jan

-- 
Jan Pechanec <jan.pechanec@oracle.com>
