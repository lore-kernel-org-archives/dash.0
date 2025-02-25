Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393301DF993
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496397; cv=fail; b=KpUeQzu1QfgdoAb1Ek4OfA+94sVo2EbVAen56d6kxNkiuYrDfR6nvJ4CODwwjWmx+Y5rcuE+cPpg3o8SV8Xpso+tc07xX381iVZs+FC47ABGcnkWIVP4dZ0s0xB2OF82+NcEfNSnY/lBPMgFTqFnJvpQH12ifwIRwKLKUgLMq2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496397; c=relaxed/simple;
	bh=a6dJv1zRbocpthf2P50yYIbNGaA+vbqzzpk2UEF2mww=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NgQGz8R6fDmQp6KeL6QN5rLIbkAGDpkQOz/H8FHOAiK/ISxWmnYYyYEHR8LWKZtIrYOBYysJ4REpyxshVxKbjlL5IX5ZhD/lYlzFlOgmpLVtLQkn5fOd3cwtRRMLcomSPOfq0dmhpInidxoARZtysngLvbSFzjm6D9jf3Seeu5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MqSq7Td2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQcA38zR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MqSq7Td2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQcA38zR"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFCL64025360
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wWCEEZR5qjpM0yFw0V
	5Af9C8VxWbamIfGXF7JDrHBmo=; b=MqSq7Td2W8XQbLrIOyjiIrVbtSpt3Uv2AM
	TxluwyVI6H5Urjp/RjTiUNnTIophPGkqZT9OgdJWhtY4yGKLsK73rubi+toiTJ//
	QtVF4/sE7uHxw/lclXadNUcphvtRyntPrG6rYgbnCzPtYLYf6kC53rQzOF0Q1qNa
	gP9ylRt+JLOf5PbiP4pB898XuePVUPRj2RHFzVl+jN38uFxwfJcw09kmx7TG1oKP
	Idw/F1JfClJfpzsn3JVFtSch8LKRJXdxhhMtJ8S80vmmA1/TKpQE1voRk7JZ1wvt
	tFZDLhkkzHR7tCLqErC08bFSGNFqbcCNfT9qP+7egQyPxXq4q8Rw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5605f26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:13:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PE81xs012625
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:13:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51akep6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 25 Feb 2025 15:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATTjo9jjF3vd9VA3P1jx7Zci6hufixUYUhZRqFy10NkT84s42qDIXivlLu5uycMdLzFcn8tTdJ4TektYVI8FtWMjzz71rFbh7XQoDWf7iX2vhlnDxnF9OtpKKH5oGoHcNV3b95eJwPXSptVe0v+5EVxAL2sMKr+iBpIhqnWIUAVlDSnKCEeyXPCMpexydTGRwl4Ls1L/3t95c5DbPOyr+YQDA+spFgBSNLl7DknJJ97xFHOCuC3mCp5uuj0ki5HcAOiD1ib7hUuSrur/s8ubfVYA+Z6rNmfHppn+GhtgjOIsQ6WaWYjrkb4Kf0kukqQN23mxBDhUZlnKEr4FhkpdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWCEEZR5qjpM0yFw0V5Af9C8VxWbamIfGXF7JDrHBmo=;
 b=r7NQ4u45id89Q6Pfn/v9To8YMbzMAP7hxwP5JcLSXEZKFkU6SjNpbB8F/yhwInGXv6R6rqUnmQc+jcCK8j3HbUFgzuoKkl3tNPbYFVMCZ6sihMpND1pavIOAvg8ph+OnnCNjl3nJjY0+H/kTcWeZCmXxjYkQ4GjXiklWUEVc9DayL9Ujk+pNE+uL1iTV0Hh8X1N0PNDEiC3aevNiQ9hdsUUQHMTlAYjg4rp5L5dY9kUE4vHHW2vj74t43oBnA9+HQ4O6bi/uLN1aVPSd/9G9qph4ypLeWq1NgshDUeh9z+2ONHbD1SA3H9HEPlIjtNdMc8OZXmkGgF5QITN/l+Vo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWCEEZR5qjpM0yFw0V5Af9C8VxWbamIfGXF7JDrHBmo=;
 b=hQcA38zRKaV2sR2UqR14vDsjhMOfLpc9SuVtSupUOniIVnO1/aG1l76CkDt26KtIcTANPKQxGKaepftfNfx5Mlftc/9DjC2RtkhnBqI/0paHRbxjz+Odj87qQUYVb6iaZ7nEpXr48wDaJAcOmiG//uA5ZiO6zKMX5ZFhYl4tEjk=
Received: from CH0PR10MB5388.namprd10.prod.outlook.com (2603:10b6:610:ca::5)
 by CH3PR10MB6902.namprd10.prod.outlook.com (2603:10b6:610:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Tue, 25 Feb
 2025 15:13:08 +0000
Received: from CH0PR10MB5388.namprd10.prod.outlook.com
 ([fe80::f392:4a3e:5ef7:d338]) by CH0PR10MB5388.namprd10.prod.outlook.com
 ([fe80::f392:4a3e:5ef7:d338%5]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 15:13:08 +0000
Date: Tue, 25 Feb 2025 16:13:01 +0100
From: Jan Pechanec <Jan.Pechanec@oracle.com>
To: dash@vger.kernel.org
Subject: Re: dash performance regression with [ in latest github code
Message-ID: <Z73d/QFOMxwgIsGX@len49>
References: <Z73cCB4Xm89Y5AuT@len49>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73cCB4Xm89Y5AuT@len49>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To CH0PR10MB5388.namprd10.prod.outlook.com
 (2603:10b6:610:ca::5)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5388:EE_|CH3PR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f0cf7e-d1a1-4416-88e3-08dd55aee95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRMf/jLA8t97X6QtArxKe6iSCVR7ptpK17HlzVMUZXMxZXxuzLdSJxEAaJ2/?=
 =?us-ascii?Q?e34rCz6tbYc7fGC5fkK/HaTS40Yjpk97kQURsbY/+ld1ur3ir4/Ab8g5SP9o?=
 =?us-ascii?Q?EqbTl3/3UGSx4L0kMQumc08GbeLFa62CmzlBhOlMz/tXjN23szoq27d0BQUx?=
 =?us-ascii?Q?+3ych3epigwCjWeOE481xipLWWI34jDPk/aVVvjGi5MSkaBDYz/yAp1B/0Vg?=
 =?us-ascii?Q?h4l5V3IXd+ZdsGHxoyBoLf6jbnvrlNRTzFWwDOtS1wNIRytHJAaU2vNEHx6C?=
 =?us-ascii?Q?334hSdguYrUbMKlW0zh7JZFUJqbHNZJTktN0gZEA21SmifW3qfixVWfqseN9?=
 =?us-ascii?Q?HOvRA/bItY/h/dEK7LkhNSiUsLKYNEvlhkZIy+dQKIbSi1EcwlO4FHhC+KH2?=
 =?us-ascii?Q?TikSjIQooLBwW6BwdJdMPEtWyMRBwJWyPV/nN+VisFlWYp3czW3tbqqCqhDx?=
 =?us-ascii?Q?VwnMhVKknPujPBIyKfCnV9TZMogVHnBA0arFeWlWDKkRq3/XnV275Mh42KZq?=
 =?us-ascii?Q?qzaWUCRTeKGbG52abmGw0VpPJ9On3SJwjl1ZcXSC6962mpNzaP1fdz16H1f8?=
 =?us-ascii?Q?9eI0BuYgTarrAwJB9w0hfF9sL4R3JV7EhlcXLM5rKJZUXJ2nOHnXAZ2zdh5k?=
 =?us-ascii?Q?AbxBhQPkwLRqQIAY9tOJvxKrXzWweifaFo7tDTFpTcrFJL3FcEvHBcnd9WWy?=
 =?us-ascii?Q?8nYUCaWNRSxvaAJfQoDa+OjWbtbQX+EIpVJuM1guiRQ87F62C2dfi9bBrMSg?=
 =?us-ascii?Q?HX1wqcm1I53Z9H2VIOt+tU2l/XSFeq2Ent9mbA0Y4XYllgi7zJfyEWZWqKnq?=
 =?us-ascii?Q?iJ96+vY7ikNRKaN8Q6Y29dodAjiq7hjUcOjBnsKugNE9kq25L0uyjACfKEAy?=
 =?us-ascii?Q?sXcrqHTJThkIvDcFcA4HN1BnP/OAKe0IBL8iv8hronpBmqnRNashDB+1EU8h?=
 =?us-ascii?Q?mISJmMpvxEqvggSYRh3O2cTGqGLMRVYy2yYs/JqkM02KDSCyxXqfvujKtkDF?=
 =?us-ascii?Q?kRVRa5dJLG7XvM/WlDrGVbcYr5/CjLIxTXORWPk2+7wCjfJX7haoAHysL7or?=
 =?us-ascii?Q?icnDyUQPLnFV47Bz5GpoD/yn69FapkQ1QlPDWso9IxNHYIHnnKGWvd7uPxik?=
 =?us-ascii?Q?5Qv9sXG/9aWDiNpuxcctomZZtfkTaPJ+nDdvRZbRNhqorvgCRzqRw0FzsKl5?=
 =?us-ascii?Q?lRNoWKCLejr1eYKM6IqmSB5DRlkmd1suPZf4VH7gtHGw82fm+mJBOK5xbGzO?=
 =?us-ascii?Q?A1lfgowdap5tQRGYVVvgYt0hds+Hdfz49mSY/YB/98L7Pbyr9nbtzHET4D6q?=
 =?us-ascii?Q?Yko8aJmYQPak2c7r7nVOo1jb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5388.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnAvkzmgIs1svLw9zSfQaSa3CJh5cS3KFbcPzuNPTAvwbP4Oh8kYZvpeTCe0?=
 =?us-ascii?Q?Azdr88iZQ+vs5WXIoCi4ynUAx4YNFBJMHk9F/zyJdBg/5eKwj0w9Wx3m5dNF?=
 =?us-ascii?Q?ZRWJDPQxIHdt2x8gQohcLNxul35sq9i0+wR4GxeDMZkTrFvfNgB++O0CWlSz?=
 =?us-ascii?Q?FvOhVb5wGHi72T1Z6s3TVjMSuR7DZiTkjX2Osp4p/+A91D7LDq/q3jbmeBkx?=
 =?us-ascii?Q?CZIkUS4gSjZdJ8Vd+ehFrNh29UkvN5FZxm2uCpj565EkaoVhCGxlCwjyMaB/?=
 =?us-ascii?Q?VZ4gMPN6mndct0fNjfY8x+/NVN3DZqhsCVN9LC0vDIF01lh4WXmCew48D3e3?=
 =?us-ascii?Q?zEGfF1CMTTmwg4z9wecyNCXCQLM3Lv7gDE1tQCFN5X6ByixXN6OK2poKSFZG?=
 =?us-ascii?Q?M9P8eAoeyFlimJ82WG+wLW8dswk9TV6UjhHewrV5n9S6p8cMMt5lgJMHRFN9?=
 =?us-ascii?Q?7qBhTSiO0MI6fCov6i05YK/KkVOAbtSvelI4ImeCqy8yvgihwIyAU1+AOmF5?=
 =?us-ascii?Q?4pIkCi1+7M0HMEoK5t2syGrtKzrjWD/qC5JNHwerefby0/vuz9vGf10+n8Cq?=
 =?us-ascii?Q?A6RljTkTyqv4JhzVR1pvnC6Oik8Q72rpwQK8kujSg1k/ZwWDdBVQU/A7z11t?=
 =?us-ascii?Q?JhGkAmns+eySPL2fQ6oCTKpz6k1NbImYfaYFOMSgVxlYBQTcM0RhZofulhZt?=
 =?us-ascii?Q?Bdwwwm7FnPdFfsXqmJBIYE88Gl2xdCQnLCYXMN9APqJszhYmVH1pAEuiQAg9?=
 =?us-ascii?Q?4kIJt0X37f4BjIBlsj1FviuzsjaCV2GcFkW7g2fe5EdE8jUTQxJQdHJ1GWRk?=
 =?us-ascii?Q?bEk7vWRPwfG4wui2Fhr5xwgYNZ68XLjJjnCH0UFimOGrXFlKdL3f5Nw73FL9?=
 =?us-ascii?Q?qVrudDAmokjEx1cXep5+8HA3Sb4k3ROuqa7sgRAhJ6nhtz84HS6stp6dMZlJ?=
 =?us-ascii?Q?lIwuGS7npq1TgWOPthSJNDSgZ/KXazBYpSrDbS1SRFRzE2PGKEVVaCRXBLPL?=
 =?us-ascii?Q?XXmdraIXkgISR4qKW3vK1aMprtBd0OExHX5kWi4JK/nDTbXKJcrTlhqBsXWv?=
 =?us-ascii?Q?VZvtkCs5bHLPqcymTTr1DSiDubVFgL/4nN5uoi0CzWzUuFeRi+LffLNkgZYN?=
 =?us-ascii?Q?jtRgeiSnPMvqKu9u4TRDGt9nLMw2pOEf04NVZQphcL17hbV9EkV1T7Y3DGHW?=
 =?us-ascii?Q?s2seSJcQ5UBpHeNeYdvWeHujvnYhcGM0rAp/AMHzCyOgjql4ekeihbLaRjT6?=
 =?us-ascii?Q?ceGNQ9hzw8XD/DK8JN/JkkecSVgP5cq8pb/BeITB3kSadqTTcSHHYtRL6YPL?=
 =?us-ascii?Q?udUPE1b9+cMyHSGZp16uTQHx+kS0wBKw7x7+k0EZhNpgAoIuMLrqi5wu4GLS?=
 =?us-ascii?Q?5PfAhUrqsrSXtKC8M1cIZKAPYr9yN9YOn5Si0wuWZBURiKAQeHpdJGlBzxZw?=
 =?us-ascii?Q?Z+ydbwwcXqNf3UCvEewK9H98D8CZicT7duQvOKjQk7Zq5Zz9vBt6PICx3PwG?=
 =?us-ascii?Q?hsm0oXNKQh1U8a5OWX7RbZkk2RCy4hYZ7UWuRFDU2uDmsAopeJvvQn9Cotkc?=
 =?us-ascii?Q?mnirFvzmA1nDi8v3yIdoQcH1GYCP1eWf8ozSyv0OJ9D5j5xzh4urMVgTAKyr?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C/4FtejvzjNA1MmJj/7ILg79CcC6SjYDexdTs6hu2OEBspoRTkB1cieC3fVs4bOioVPoge/iGOBFuyTTY0S6xCUMLuE5udfw35gE+WWtVByGFWG3yaGiIdmTJXycP9yc/5285gAD9L7tWUphi8futS65KEGFpzCRD22KHhD3xrWv6IfHp94dZFqRmeA9itwju3SJeUAHbz5Np/Vv+zE4NaywyRhzetacCVghwEXGLrt7q4CAW2GgTKM3J9WDZVxRHFM1ZVztEohO5McSvCBddhzi7dc21rgH2d+8HeTHAAfCR1qCjiJVGbm/s0sMzXy2z23MuXQGajCpltiY+FRL3lVFPbpAiZ085xRX3BndjYJX6U3TWjEOTKm5x3th+tfDfNrHqR/rVjmvlm5by2T6ne2SqmwRTFLZDVhIxRn9Nz6NMvKHb0dr7hUvwGGRLFb2NoQLsDXB3xTu1+UN2rPxqweQCUkkSX2wugYV/iv83q6X3CfUdK9OIS4zpdFOt13zOojk1QU9diDioHR6ADSNV8b9uest6cY+gj0gS6z1tp0cWI309adFQQVmiREpfiLzhIul/LbrcIRF4hDAlQxF67HqMA6w+5nvYT5GWPTaAWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f0cf7e-d1a1-4416-88e3-08dd55aee95c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5388.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:13:08.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLBtJRWtQakWjbZNuUxvNB2+2ulaG3fScAwS5sG0Paypm1f4P7BvmgLWWDgfIrvAEWjHwgwYp8qv5elBTeUU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250101
X-Proofpoint-GUID: pk6e0uWk6Ibwuz9v0gTjshHodZ9yVL0g
X-Proofpoint-ORIG-GUID: pk6e0uWk6Ibwuz9v0gTjshHodZ9yVL0g

My apology, by "github code" I really meant the official git repo as
specified on http://gondor.apana.org.au/~herbert/dash/:

  https://git.kernel.org/pub/scm/utils/dash/dash.git

Cheers,
Jan

On Tue, Feb 25, 2025 at 04:04:47PM +0100, Jan Pechanec wrote:
> Hi,
> 
> thank you for working on dash.  I was testing it recently and it worked
> really well.
> 
> However, I noticed the dash code from github does filename pattern
> matching even for code like "[ x = x ] && echo ok".  I believe the
> unquoted space after '[' should not trigger pattern matching but rather
> only to invoke the test/[ utility, as before.  It seems it works fine
> though and only doing some extra unneeded work which may not be
> immediatelly noticeable.
> 
> dash installed on my Oracle Linux 9:
> 
> janp:len49:~/_INST/dash$ strings /usr/bin/dash | grep dash
> dash-0.5.11.5-4.el9.x86_64.debug
> janp:len49:~/_INST/dash$ time dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> 
> real    0m0.752s
> user    0m0.748s
> sys     0m0.002s
> 
> dash from github (commit b3e38adf6718801e7f06267b438c45caec9523bb) take
> way more time to do the same thing:
> 
> janp:len49:~/_INST/dash$ time ./src/dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> 
> real    0m4.202s
> user    0m1.361s
> sys     0m2.804s
> 
> For the latter, strace shows open, fstat, getdents*, and close system
> calls for each iteration and it depends on number of files in the
> current directory.  With more files, it takes more time:
> 
> janp:len49:/etc$ time ~/_INST/dash/src/dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> real    0m15.591s
> user    0m5.704s
> sys     0m9.828s
> 
> If I change [ to test, the dash github version behaves as before, and
> possibly even faster:
> 
> janp:len49:~/_INST/dash$ time ~/_INST/dash/src/dash -c 'i=0; while :; do : $((i=i+1)); test $i -eq 500000 && break; done'
> 
> real    0m0.662s
> user    0m0.659s
> sys     0m0.002s
> 
> Even bash would be faster than the current github version of dash:
> 
> janp:len49:~/_INST/dash$ time bash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> real    0m1.943s
> user    0m1.939s
> sys     0m0.002s
> 
> Unfortunately, I do not have time to work on a patch.
> 
> Best regards,
> Jan
> 
> -- 
> Jan Pechanec <jan.pechanec@oracle.com>

-- 
Jan Pechanec <jan.pechanec@oracle.com>
