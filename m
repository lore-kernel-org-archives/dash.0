Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2DC433F5
	for <linux-dash@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BADD61053
	for <linux-dash@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKBAsb (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:48:31 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:29264 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhKBAsa (ORCPT
        <rfc822;dash@vger.kernel.org>); Mon, 1 Nov 2021 20:48:30 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A20anot010520
        for <dash@vger.kernel.org>; Tue, 2 Nov 2021 00:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=ACj2CTH2gfRAX1rSlQbKPM2V19ZjdjzKnxEe/tO4I/0=;
 b=SinJw26JHIRgPw9PsHBK1qWSJfo+odCd29Y7deGJRnzWH7ImkuEJ3GAk1g3PH9MX7FZ8
 tWzZIhhT9/U+mHLGs+E4pt3jaIJbU872Fb1uFAMMN4hLDiTDZ8QCQiAfQWvhBYg0x2/c
 KuxGzTfFDFojozqcuW+FyFYgcCm0Sne70Mf8Cqszr5FpFBtX30P7D9qJXecklS5HxTKm
 Muz+uSI5ui0NM7BmU4Zc6RGaMlZ3klOE5HNR1O/39HWpPUZ4u5p1SbYm1CUJxJoxvMDv
 hvhodlDNg9BkdVnUdvdddpE8eH0hnNTMIDx7EwVH11nhRgDFs8l2dgN9O9I74FXiBZ1u Bw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c2b7jrq2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <dash@vger.kernel.org>; Tue, 02 Nov 2021 00:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLsFv734Y2ZFNegLfYgW/VKbKH2h0G789ojz+1XdAvq5wctT8H17Nwnk+UH2FqTqBJMevc7aIRPY1LnfPBVFmlz6TBHQaxBS5PCxj20s6ghN4AYFBU7YclvPCoqt++ZXAQSIjQ1OjMJJp9zpmLTswzFj21/TsUb10wxybPO+W3g4lOuxDJIohtsAO54ItVwLguybB8OG7US/LxWpg8DrkauI+mLEHQ6aieXhgP64JZUXZyOIIqJp5C5POk+5zIyRwHxOltgPo6M2fj7fMNX4yxQyguBtQLOvgf6gr2+WoLjhriKc6i+/mnNbq+0DC+y/gT4W9tuhAgmxetUUxXPToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACj2CTH2gfRAX1rSlQbKPM2V19ZjdjzKnxEe/tO4I/0=;
 b=lxhVg0g4ntMCcndmELFSl0FyTjKdBiTE4PeTqjgL9503RJ1CMctZKk2c5C/QIjxaxP4g3K5LQ0etKJLpqU9HY6pooyQVT5/9+79e1PiIL1pYBo+dSNVEc2YWlaj78yuJ4pM4wQr6urJ5UZdWcnzN0AeP1Q5KXcllC85RqL0Ep2ylnzqBLQqhqKpw9so5VtEHnsUBcqLuzwOH0P3v0Ld2l4dQOMWsmGEZtDEpWFScLBMQ3Xn/SYCKiuh066j+Ox+SOixQ63OAer1c0dByQ40QjQny7XWgrSk08ns7/EuCYAQAvPVacPSQjOaWaHIOnCVBuEtVdsz1tlz4yWRrvbSWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL0PR11MB3458.namprd11.prod.outlook.com (2603:10b6:208:6a::20)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 00:45:54 +0000
Received: from BL0PR11MB3458.namprd11.prod.outlook.com
 ([fe80::e91b:817f:999:da08]) by BL0PR11MB3458.namprd11.prod.outlook.com
 ([fe80::e91b:817f:999:da08%7]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 00:45:54 +0000
From:   "Kuhl, Brian" <brian.kuhl@windriver.com>
To:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Testing dash on a new OS?
Thread-Topic: Testing dash on a new OS?
Thread-Index: AdfPf7mBfZHryTrOTuOeOpRog24GEgAAruMA
Date:   Tue, 2 Nov 2021 00:45:53 +0000
Message-ID: <BL0PR11MB34587FF7466464F0C18F2C68998B9@BL0PR11MB3458.namprd11.prod.outlook.com>
References: <DM6PR11MB34686DFD31F7C9C07D3F8B1D998B9@DM6PR11MB3468.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB34686DFD31F7C9C07D3F8B1D998B9@DM6PR11MB3468.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27ed4ef9-a0b1-4a1a-ab14-08d99d9a204a
x-ms-traffictypediagnostic: BL1PR11MB5318:
x-microsoft-antispam-prvs: <BL1PR11MB5318CB6A5A951FFE9CCA8D6F998B9@BL1PR11MB5318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Nhbjs+FkRaaZzjabwFnSTl+bUnS8TRpsdpp7VlC1iqZd2qCwjhCuu5jXYvHKLq67rLLCKRkzFb85nJJAX+syPB1Rq14ZJHSMAOoOFMQ8ptpWsB1FOfHBFCuRX37mesn7i80V8zs4yFWE1gEMOEiGCadMHxk5EuRBiFpkHcQerc9tV6xj+0LysxE+zxK22XqfCPfacTctu2qxLCFyp0deU+brPjQ2BCeWHp9y4IF6S2/Lrm5Ide8lbWYkvHrmZuph/MuN4kCl9wSO18aQ7zOzUq2t2kqMfmk5woZLbyFL28GBMESveRN3lL7jU72pCqBMvZYYrlNYLmNxpXbFmt0NC0fC6H/wy/RMBpB/BZcrAeSQrJqnCwiO3P2xU/c7hagbPaTlV+q35S3uBGu8AJCpEfExmpJS4Dix6MGtrrJH47KWS/zeiJdc8mzAJlalg6Mg9TvgYMcwNNv22wSTWecxGFF/pOrXdJJDTpib5S9JwRbyuQRGzAhzDQ1FAimB5SE2rS+0tnfk9adDuGKEk47x+OIEoE9fYpM/fG5rbT6Tr3oi2XcDzvaX6krES6wc1BYaIwX9yTmaqI3x/jjaNDIYBaLnJu5SeKmaeZJ4M9M8/6abCCQETYDM3qIgnA95UqmTJ9Ur58kObkBnoSMVST62v0ZMqAz1XM/MmrTUFuZ31aPFdN3eS5j1CRxgWI9XKTak7+2ymL6NMXIUaLxyX4lUMiMy2dd2WdoDgNo9NMzAAhkMtxAVlpq7fI/2CHFWuMOPUz0z8J0Ivu27AzGwCwACuL+qWWvRkwmpFeJzQzs2b0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3458.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(9686003)(38100700002)(2906002)(966005)(316002)(86362001)(55016002)(122000001)(52536014)(6916009)(64756008)(4744005)(38070700005)(8676002)(76116006)(66446008)(33656002)(508600001)(5660300002)(66556008)(66476007)(66946007)(7696005)(71200400001)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rAqYfCRBDQgoDrUR++rGte/VW+YY/H0JMHBDupbGlLVK1C/qthv5klSlf+Ji?=
 =?us-ascii?Q?5w8aag+lw6qJMF4dVZJisljgG66NGddHUcqDWmTGPHPjvBXMA/GCgvw10e/B?=
 =?us-ascii?Q?Qxm9IMvrYhjfcVoFDB21Mmiae3SqpIod0/spsicsJ2HHKPKk+BRW2Y9Elp76?=
 =?us-ascii?Q?nTPxcND5jUA8u1fKsbnaZ4jSeurkpncAm4dmvl0lVPvHGOwaQB4LnCay89bp?=
 =?us-ascii?Q?W1/vBdVIhVmzSI03jwLoP36sJWkgqOEQRcfHvv1ppDHafmTA+KNk+M/o84XK?=
 =?us-ascii?Q?10EIo1j4BN7OMhUUb2LLWjK0Bio619hej3M785FLohzWAwbKgpDLo2bCYoWb?=
 =?us-ascii?Q?pSRbrPrzCqFd3bmrfZVxKjVceNXSSWS81hiihy1ndBaWT6lSWdH7s54VBwZ0?=
 =?us-ascii?Q?VByh0vGl1E/sY9skcOWmc0qua4uuYnRG53qCrGzrqBG7Ws9JR3pU3jQ3eFfn?=
 =?us-ascii?Q?BA1f3epaJpNJTMBhi3XlvOh7CZoqgUTvc5u4D41wJZE/0v9oYkJ75bkgCyxo?=
 =?us-ascii?Q?Ye/xe3Zeag0b0Sf9aUDPALLYLKBhtrRdt4f5zUCeSfn14yXVq04B2LULRY65?=
 =?us-ascii?Q?80nQNKJb8E6xePlY2U13wCzSiT11a187ixKGicza5vJVuS6d1SXKGezD2taF?=
 =?us-ascii?Q?erPEeCMyHyB6E6X/PmTh1kxakG1/DzlsWa85SxMQMUdnGm3JxOSFeVFjt+oP?=
 =?us-ascii?Q?9ID251+MHQ2mG4G24rJ1Xt6a0ZqdQBMbf4Z8a/NGAG4Rm40I9sjjySfT23cB?=
 =?us-ascii?Q?60v9H+157inIZfsebeR3v/X0nYahtFY1jGkJISA309VgOE6DJdSqTZDntSO2?=
 =?us-ascii?Q?4VlRp0WsFAlGic7exjAjWo3Eo0R67XIcAzyP586LYXujKZVRMc50Jiv4LYiP?=
 =?us-ascii?Q?wUaNnDUc3csVKdEjdsCwIH/8TXj/ACXcMdqp2CP2LjqU7Cx1NmYBXNJ44pHy?=
 =?us-ascii?Q?Ll/zzduPep+7lpg1+KGxlAp6RUQeJX/4ODk/gVGN7jJ1gfxyOEfm2QTiC3Sh?=
 =?us-ascii?Q?gznf+SfVF+b1MBZOFuj6NKM85Xo9BllPc6dibY4SbId7wtXVdNbcN1+AKh8r?=
 =?us-ascii?Q?GRbvJNCGQ7QsexXFxzFdws969195xVCjz1bw0dFWT4K4tWw5w8jxE+DpBaQE?=
 =?us-ascii?Q?OSroDcc9fRZ7dgAz26eOeMOMu/52PFM8U10o3cIh8hjQ78tzw4ArBPZjRKbz?=
 =?us-ascii?Q?hHbo5jY9FpYnx7ewtMR5oZVmAJ96vu1Zgh9godz3PMYU7sMGo4H0NA0DVDql?=
 =?us-ascii?Q?UzVTahApd8MbfOUCKb8T5MHlhUQOuyLB0pNcmERVNJKkfIS4l8uVOvXZiOS7?=
 =?us-ascii?Q?+dLx4xIWYuZ0McZESdimDRlo3LwqozJZD0iBC9kwPPy08oCek9pP4lCQw8in?=
 =?us-ascii?Q?NTMjtRmivGsmke94M2pMbxhWkTtvo2OFqVhAcO06JV59pffPDwVPr9+njnbw?=
 =?us-ascii?Q?5KKEV5HQYh5isHKX6599jPJVzTTCkI8lSE9dl+Ok1wiELZxrKHseweEL3jUm?=
 =?us-ascii?Q?lgubm6vW8EePB1/5SDKHhI3h9IkMmS1Kv4vjZiotHjH+Umr4nwY+5MAepzJK?=
 =?us-ascii?Q?cJgCs0bB2DFQT03Hhazno6MkmE9yrH5jLF13GQbff11FKZEinrw5wKFYelsk?=
 =?us-ascii?Q?81MJawChAmn9K+xWir62aMkoBv9G5ShVBdJVDaPZagr+wYeFBna30r+A+GWJ?=
 =?us-ascii?Q?BSiBZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ed4ef9-a0b1-4a1a-ab14-08d99d9a204a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 00:45:53.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cldvib0jThyA80Hz/E+3Fvdimc7L7gHlR2QWc+R3hDGMZ+DU2TNwuvYYPmdSXHWWMksR/MkrMg9OrDqmKLpyMBbrqkM2SU3XdvueO6WP7OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-Proofpoint-GUID: 9cGHDj87HilvN5je9IoBBR2WyZrKRBfv
X-Proofpoint-ORIG-GUID: 9cGHDj87HilvN5je9IoBBR2WyZrKRBfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_08,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=842
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020002
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Myself and an intern are working on porting dash to VxWorks.
https://www.windriver.com/products/vxworks

I've found harness for testing scripts, I haven't found anything for verify=
ing dash itself?
How does Debian, or any other distro, (or for that matter a BSD),  regressi=
on test dash?

Thanks

Brian
Wind River

