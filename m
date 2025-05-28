Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34485258A
	for <dash@vger.kernel.org>; Wed, 28 May 2025 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468841; cv=fail; b=fIPua13rw74v+RD3y5sR0qQtW9HQu8W9bwKXwCRrCMV/mhPQkI6rnUs3pfV8ugK8eBaOn3iqBrfGpnCQ9du/t1Q6aw7zkz+F17hxPGAcvCIZZeR4tj0El1HhURQeXPqkjjDCY9G9IfGAVG2dEWKvMZhgyo9kO41H1YzdJtCJLWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468841; c=relaxed/simple;
	bh=eT2g94ZXdFYkNaBDAyTmv+YesZae+0UUxdwMa1KHL4I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XGvAwUmxJonwZc4YhbnAtbcKp7IvcZz//ZN0aQFAT8OxvDM6AFjXw1YQHjKmMTYdGiu/2bSSNq0WY9DCG5g8bP7fbbMwxrkipcTonPYtu2bTuYQwXNu5MZXkodda9DyS87D7ab0FGerwa1meF2DEqW0SjkdmKwu6/4L6v7k1tC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SLOEX6029075
	for <dash@vger.kernel.org>; Wed, 28 May 2025 21:47:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u5394nw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <dash@vger.kernel.org>; Wed, 28 May 2025 21:47:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfqUx2PpB1jAQAcTTwk+7akUNoqxknqrAPbrueG9Ch39xwEHRNRHGtI+Wg+55XH1+K+9qiTWAcsxesdVnZehtWGaDGkjf6BB5utc+R98fRRdbfuDb2nw3irmyIMV9NxDBNGlp8aF8AWBYrViH4Urs4+OyKYPTJP+hvXABG5Id/sQeZiSGw3752ebFTaEwAYdbou5jdSQj1EA8EB0u4+ymoV160cEVd90olG3Hrb/U2HE78ewrynB4m983/l2KxKSLnQdK/wLc8zJ8+ZmhyuTN8vSu5Hn8OtuasrpqFx92a0wIFeJTrmsF7M4YOf9CTItMynUcHt5LGjy80t8LMHTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opdDbPXmC28Sw8+wytX7T9ajRalMeLtqQe29jvSN4Vo=;
 b=OJ26+3UYnovT4UOx5ZQSO6pg1ll6hDFsCpil5r9VxtZvPeTEZLbCSrKFn4Yw9qiYrn4u1coMUoTB13ap6CWuIZ7c+U76UnvPjOnhq9PCak7wt68EnCU4Q6LnKU8yCSyTtbkL1SSa81FxZGBlmFebA3hRCDHXdev5vDG1mfpqlIr8Jk3sQNPF9f93RgdnTsxKJvYXVKoUlOwewl8+dZjY257jmqEWakN2bGc5z7/WJguyBzITR0hDYXiLvrzFRpxPF2Zx/iknKxEe7SNHbAil7xQPmiQe6Wcpu/qQfYJcr+8Usf8q/MrInDzXQz7z/V3MJ1F/OqW8g8gE1DHLj3CtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 21:47:11 +0000
Received: from DM6PR11MB4753.namprd11.prod.outlook.com
 ([fe80::7d37:5895:57cf:e610]) by DM6PR11MB4753.namprd11.prod.outlook.com
 ([fe80::7d37:5895:57cf:e610%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 21:47:11 +0000
From: "Kuhl, Brian" <brian.kuhl@windriver.com>
To: "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: [PATCH] VxWorks Support 
Thread-Topic: [PATCH] VxWorks Support 
Thread-Index: AdvQGckiOoQSvOKqSvOFrpLZC/7M8Q==
Date: Wed, 28 May 2025 21:47:10 +0000
Message-ID:
 <DM6PR11MB47535C0C8F14FAF266B04D309967A@DM6PR11MB4753.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4753:EE_|DS7PR11MB6063:EE_
x-ms-office365-filtering-correlation-id: 04be7283-301c-4e11-2f88-08dd9e31337a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?83+Aa1eTPzs2s2TZKP1bj/6swbCPkr0qQyljf1eJAoQvCILqbYdJ7nH5/wWN?=
 =?us-ascii?Q?1FHLNRPXngliLQ1qLdVZV5K8K0v1SDSfXuzgrMA0krPqebO2+2LLFA8Dw7bo?=
 =?us-ascii?Q?q6UN5CVofscXxmyK0vMA9H2u7ZfyrS7AduEhhWGk2n+DUGbg3atybcQo84DS?=
 =?us-ascii?Q?WtUI4Hdar/Xb/aNXIDF5ZhDe1Vp8SmnWqxKkUOOZnt84LktKzzTOGmlpFeZS?=
 =?us-ascii?Q?ftSFts/eR2q7uZPvG4SjdQAvQErOoegn2jkiC9FoyWV4ISKYWCzhSGohG76G?=
 =?us-ascii?Q?pxKCBqtJk15DCOcYHcv91oPU3DjViPNIF1pxJW65nRhGF9j5AZSemsEOhAmB?=
 =?us-ascii?Q?9IjYL9s/WxQtiYTXwvPODbzFknN2IXVvzb25wwvzoB2ABn2uDsDQTYJnjDNe?=
 =?us-ascii?Q?sMTJaflLczs+RvEg1tCnYTazyhMSgdkI04Q+pXdZGxsbDSYFIm+YEZvdw8FO?=
 =?us-ascii?Q?0SGzExn8j2tk92bh/yArke/2DUDl3C3D4Uz1orNoLPEMYeL51paSdSJ5rDu+?=
 =?us-ascii?Q?UGGZloFXfiu/r+5b7vT/Z5hTkrbaNXq1xU4zEIz1AxqOtrsQi9+b6OXI/LsA?=
 =?us-ascii?Q?3vCRe3lzNdbD+SjFTH0lP6kbpXzRs+vBDFv4TxNwusvOgIOxIsKFfe3ZmEFd?=
 =?us-ascii?Q?XlV6DJyuNiRMV+PFmiF51M4VjhoLC7PeEkFN1dvTGMiFPF6CNtIOizqBgjgM?=
 =?us-ascii?Q?EpWp3kI/KI4oLzIVClCZE+K4UB7+W+AIiaZGhWY1PDvBUYAADC1/rzpnQv4p?=
 =?us-ascii?Q?2YuRgAOaabVAdGbW7IofurehiKt/82qXHABjVRUqfK2lpvIRoi4WXzauQTvs?=
 =?us-ascii?Q?ybvF1zHJ83MGBZltAPTWleCJjHMNB0sXo6Rkhi1fn1DB+Izi6/O5Hh40vZ8E?=
 =?us-ascii?Q?Q+zfXH+nUyfSXakMglI3YZlsR3JJl2DOeE4MYLl+fVdWRS9ZqWl1bceRcmLv?=
 =?us-ascii?Q?18JO9AqMv9FQqh0zIhmOf9RVdUO7dxtyyWD9Kl1TCd71JfhanpSVkTZQiniL?=
 =?us-ascii?Q?P95NGHro/SD0riQCHy2xQmiRDnUyJLIAeHmZWrJlCvyte4BKRmLoaZBtWBYM?=
 =?us-ascii?Q?i3tKpZk6oPr3XoLMEj9B7APJkn9osIBwAKC6Oz+OkFuR2yuPpDSFk6zx9VAi?=
 =?us-ascii?Q?uW2UEemuDu34ygb9UYU1fISHLjyD5FyIR2Nf4yU65NeOj0nUzaHQlACRX+QV?=
 =?us-ascii?Q?j2ofjBagVUPe4HkNFjZmWAnF+392lQgr71bEB2lahy/pI0e5UZPnXzh9nBF3?=
 =?us-ascii?Q?PYbXxkq2/Zk7SVmCNvD17KyDxno3TkWERtQ6nuB6fdTjvq+VQSuDo/mkAFLL?=
 =?us-ascii?Q?mhqB+ZHxoKY4JgLGAQDSStJuFRBrs+Fsa/jfwlvTmNjxh4CQZPuMHgMoFS20?=
 =?us-ascii?Q?Rp7gfhkev5HO21/eESZVY33IR8csavCRlSETpO9aCr+o1OgrzpDO+OHVx+sG?=
 =?us-ascii?Q?P/XFytLPFPey46hJCoCB7pBXOhKF5wfBbPWBfGq3qckKvTW2ZOk2fA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4753.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zYdV8+CnvmUSwUc/Ofyn1GHZaCKsLQLtgQWyvkP8tY8+sbbAPOXd8thb8dcO?=
 =?us-ascii?Q?Z2wVb24olTVLnTg/MQH1Ka3sO4F6Tp38CEDG3zwx/3ymchtJbt+AOQZ+ymL8?=
 =?us-ascii?Q?tA+fC2XEVwoLqWLd7GxHrKoL+xWRKgrCMzF+S9Vgpy3Uh0v/2E/QIMrxiTpW?=
 =?us-ascii?Q?gTeqpz3pMK5s4WwAheR8hX3JC/kQEROwHaLAR5yl8xv+8Of6xA3vtmkTYkbr?=
 =?us-ascii?Q?Ny3R844cz/ikTGgfy9mlQ8MUoESi0RDPTpdVE71V1ZFzbE+qB/nRxmaxt9MB?=
 =?us-ascii?Q?r/y203qxhB9BoHu+uuWNuiiTkwKclGL9nINVOAvpUOIcTZj1kljbGGXHg56g?=
 =?us-ascii?Q?6Bdw+Qwu7wjrCTCyP3hl2ZOedyeziA7bNUv+LfeA9vvtpksoWCkdpdGvDuk/?=
 =?us-ascii?Q?9K0nuHMBEaQZTJCCHmPMinW0l+20nRP+fQ7N3eNzYGfwzOShXHecrNsg3aAa?=
 =?us-ascii?Q?Y7wkx9WH+mdgh91cyOPx+RTR1+o0p2fO7CPxGkxs6PcQOLAPwUJhDj4nfYmT?=
 =?us-ascii?Q?ln0t8tfr6kaz4b11/7+p25jD6YySzlLAAbcfSacdCQmMSebZVVxYOg1UNzn2?=
 =?us-ascii?Q?QDbR/XtA8Nzhmccy61CmNyjCZbO/fn1pk1e/xZE3FxOoJ7qzCjWlAylkFqzQ?=
 =?us-ascii?Q?QhATRxmYTvbP6ChGHJ2yrR4ZPJYNUrpsFkdHOMYA0QO2IE7aFgByDgdwSSUS?=
 =?us-ascii?Q?oRI31qDlMMjKsf6WHVw+Sa9Ohx0ZFrGbCBE6xO5Yviygnc799iWe+ijdowmK?=
 =?us-ascii?Q?ncznuXXFZy8aRc61hCpE2Ean5ZGtJGzLLO5jXunEZVH5+jTZRzFYhmgei+3g?=
 =?us-ascii?Q?hFt6a5gsel+nSXzoahRBjke8j6WrladsbiHd//8d6gSETXogOZiRmGS5QX9Z?=
 =?us-ascii?Q?vCRHWbw5BDtcNqAJrGnLv0Z63m1c2ZRAk7L3EIPkfQaA5Siq1BaxlmXXn2QM?=
 =?us-ascii?Q?3ibHgvaFJI2JBDBMnlCh9HiUEo6rPb1l6qLDz/XIc1GpxKth8SyMBZ413872?=
 =?us-ascii?Q?YhuvZ56PSpqMfbC67uGz0w1jqdcUckAaoxIJKT8CdBn1SN8BmkS8G2jYVqFs?=
 =?us-ascii?Q?2iHZjGApcPnBihgyoqSeIHduni7vw4hBlMI1B6U9ZRwkHvIGczCkHVlKYCQF?=
 =?us-ascii?Q?LOsr+OpD953h0Z0VhBsRV8GrvCT3c+XAD0YgNgyBGmNtG07dihg7F1uRyqKx?=
 =?us-ascii?Q?W0FWduaK8T5IDYVEs6zkrpMJ67oWwoygZi1ZNQzC4Q9k1Bcl4vhB2StXquXB?=
 =?us-ascii?Q?4BGkPSNYae2pHovsc/aJCUk61BfsF8oJJK5NsbQ8tztVdt2KLEj2Ey3WM0q1?=
 =?us-ascii?Q?B7ReCYZoibjbstvNsEWN+IeROJc6ZjIlmXu9xOGOYhV7gGPqAJOuhN1bdUVP?=
 =?us-ascii?Q?F0LB0GELGEV14CybXvodlMIVdYggCv5QWpnHUGlSJtItnW4ghCzAPXjo7KPA?=
 =?us-ascii?Q?JknmhGr8H4NoZAgbr2Evy0Mhz6O8kK7MS6RiHwwVtnQOeLz5ixQNFXx9/VIG?=
 =?us-ascii?Q?hTBE2jLqlSVk8rKPaFhkxURQGjVg2AamkHSNCwV/UWaenRKc0Wnge7e559G2?=
 =?us-ascii?Q?2jrKbMtZ1XQZZbIyr/K2rPBtfOaxWv4svl/hfLQK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4753.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04be7283-301c-4e11-2f88-08dd9e31337a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 21:47:11.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVUPUM6ttBVu75WMZIvpFubw6IWMvIoo+SMtCG1ajV/BmTVD839vNCjnhA7AKfm0/07WgunJEomuVNoXdXSuVEJWRPtyVOQDdHwsR9M5yg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE5MSBTYWx0ZWRfX7al4TCGzpLLr K/ab+GFzpMbkG0+lK0Ct1fGEiSyd1UJSETb3yjenwyb8U8Jj9ZiLurWGBqqshhgx4DbBztgfsGb zH/wjTsm+cHnkgJfDXbosCzaShgpNqXPcSu+oo/jdcYKxOi7mHncuev0qfeS+FkZjLydw+9GgzO
 IAPxzVKjzp8LugH2ri/xh+lgirTFeUlr4omqPGXjY3hD1fTCHpRKcEnXgvcYC1v8f9HeePa6wZr 3yqcxVXW8e+MCpBhSI6EIT86RfW8EkVXB+erA1fNpwoYeFxFPzFlJVoG3FrV6ttJFNZtvPc8gP5 WmE0jCuItKDb7r/0Y/u+NRqUNt68a8Kgf7DaaJCtUzGaxYN92FeN60mAkQa7iAym2IVmwHGLxEO
 NCc36CbQ77/D1/cc9iLVjTMjARHP47KC3PhIYRZ4MmAOWsC3byJAhdA6qIJp40OJzn4oL+Gl
X-Authority-Analysis: v=2.4 cv=NsDRc9dJ c=1 sm=1 tr=0 ts=68378463 cx=c_pps a=x6qgWyjPDOdqnx7vgGQFOQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=D_xNadQG-27a6yWHtYIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: mRnEimaXmP0YC1BWMkkzogSlmM6SYXcr
X-Proofpoint-GUID: mRnEimaXmP0YC1BWMkkzogSlmM6SYXcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=913
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505280191

Recent versions of VxWorks support fork() and as result can support dash.
For example,  to cross compile for IA with this patch applied,  and your VS=
B environment sourced (aka sysroot)
 =20
./configure --build=3Dx86_64-pc-linux-gnu --host=3Dx86_64-wrs-vxworks --pre=
fix=3D/usr \
    CC=3Dwr-cc CXX=3Dwr-c++ LD=3Dwr-ld AR=3Dwr-ar NM=3Dwr-nm OBJCOPY=3Dwr-o=
bjcopy OBJDUMP=3Dwr-objdump RANLIB=3Dwr-ranlib READELF=3Dwr-readelf SIZE=3D=
wr-size STRIP=3D wr-strip \
    ac_cv_func_faccessat=3Dno    \
    CFLAGS=3D"-DJOBS=3D0 "

make install DESTDIR=3D${VSB}/usr/3pp/develop

For other architectures update your <host> appropriately.=20

---
configure.ac     | 4 ++--
 src/bltin/test.c | 2 ++
 src/jobs.c       | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index ba4856a..bb09534 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,7 +44,7 @@ AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use gl=
ob(3) from libc]))
 dnl Checks for libraries.
=20
 dnl Checks for header files.
-AC_CHECK_HEADERS(alloca.h paths.h)
+AC_CHECK_HEADERS(alloca.h paths.h sys/wait.h)
=20
 dnl Check for declarations
 AC_CHECK_DECL([_PATH_BSHELL],,AC_DEFINE_UNQUOTED([_PATH_BSHELL], "/bin/sh"=
, [Define to system shell path]),[
@@ -89,7 +89,7 @@ dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit isalpha killpg \
 	       memfd_create memrchr mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf tee)
+	       strtoumax sysconf tee wait3)
=20
 dnl Check whether it's worth working around FreeBSD PR kern/125009.
 dnl The traditional behavior of access/faccessat is crazy, but
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 6d844f1..0323944 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -418,8 +418,10 @@ filstat(char *nm, enum token mode)
 		return (s.st_mode & S_ISUID) !=3D 0;
 	case FILSGID:
 		return (s.st_mode & S_ISGID) !=3D 0;
+#ifdef S_ISVTX
 	case FILSTCK:
 		return (s.st_mode & S_ISVTX) !=3D 0;
+#endif
 	case FILGZ:
 		return !!s.st_size;
 	case FILUID:
diff --git a/src/jobs.c b/src/jobs.c
index 51e6fa1..8d6ecf7 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1202,7 +1202,11 @@ waitproc(int block, int *status)
 	do {
 		gotsigchld =3D 0;
 		do
+#ifdef HAVE_WAIT3 	=09
 			err =3D wait3(status, flags, NULL);
+#else		=09
+			err =3D waitpid((pid_t)-1, status, flags, NULL);
+#endif	=09
 		while (err < 0 && errno =3D=3D EINTR);
=20
 		if (err || (err =3D -!block))
