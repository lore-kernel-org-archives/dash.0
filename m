Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7824C4332F
	for <linux-dash@archiver.kernel.org>; Mon, 14 Nov 2022 16:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiKNQm1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiKNQm0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 14 Nov 2022 11:42:26 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 08:42:24 PST
Received: from adc-dmzmx102.arconic.com (adc-dmzmx102.arconic.com [142.79.57.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA02DEA
        for <dash@vger.kernel.org>; Mon, 14 Nov 2022 08:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=arconic.com; i=@arconic.com; q=dns/txt; s=arnc;
  t=1668444145; x=1699980145;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iHjcMqxei5hPoLiE13apwGnO6A0cOgjjPWHdOQgY3uE=;
  b=I4uE+OPSZLN4/xzGQ6i5AUMq1dRb9QjZFxyAdLE8DBD+yuDRqhI6osRN
   wiF2nbVEp+tn38tomvLeZ1abIrK93HjdvAx23PMV9YwCYz4WDwICLJVCe
   iTnFZhPZnIlSab4UPTIqLhpdETmPiIMqHNUuN0CVU7B9Lh7DgJvVzARVJ
   N7MFkWn3Sq/TyPpz7zUDtoEhG1DEuI/6ZGn6N83YUH4+MteAvtpGgWT7d
   KjUKe/acA7ksNtWP8YeICU2RkEkUY1lpkaD49SyCknMdxoqZX1C5C93ZQ
   Ik3mKWSPqe3rqR141fA7iTwMBbAHlN5s3H2P7RsRSfKWHZXztv2DkSHKB
   Q==;
IronPort-SDR: JUuZIcW3q5lo7cPgCs7JixMFdCBYIEDhOmqlDZORm48Rn0EDbSdFmvjMS25HFVxV3biu5zaw2W
 xwy3+k7R9quQ==
IronPort-Data: =?us-ascii?q?A9a23=3AwQG3B6umkD3MJBzdC8/fJ98ZJ+fnVIpcMUV32?=
 =?us-ascii?q?f8akzHdYApBsoF/qtZmKTjTa/jYYzT0L4xyaNi29B5V75bSx4cxSldpqn0zE?=
 =?us-ascii?q?CsXpJueD7x1DKtQ0wB+jyH7ofUOA/w2MrEsF+hpCC6FzvuRGuK59yMkiPjWH?=
 =?us-ascii?q?uOU5NPsYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43?=
 =?us-ascii?q?orYwP9ZUFQejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5godW7gsepYxV8?=
 =?us-ascii?q?F81/z91Yj+kupDcW2Qmafv/DSOu2iIPHbarhgVPryA+2aF9P/0ZAatVo2zR2?=
 =?us-ascii?q?Yktjo4U88zoIesqFvSkdOA1eBlRCSVzJuto+aTHLGKXuNaYyEvHeD3nxPAG4?=
 =?us-ascii?q?EQeZNVJpr4nUDwTnRAfAHVXBvyZvMq/w7iyUOpsgcJlMsDxPZgcunhmyi/xA?=
 =?us-ascii?q?vMvQJSFSKLPjfdU1Swwrt5BEOyYZMcDbzdrKhPabHVy1v0/YH4ltOGvj3Dze?=
 =?us-ascii?q?HhVuFmV9fJupXbayBF82bThO92TcduPLfi5V32w/grul1kVyDlDXDBH9Qe4z?=
 =?us-ascii?q?w=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AArdfcqPJUqfwC8BcT8j255DYdb4zR+YMi2?=
 =?us-ascii?q?TDiHofdfUFSKClfp6V8cjzjSWE8gr5K0tQ5OxoX5PwDE80lKQFq7X5WI3NYO?=
 =?us-ascii?q?CIghrPEGgP1/qA/9SkIVyEygc/79YtT0EdMqyIMbESt6+Ti2PYc+rIguP3iJ?=
 =?us-ascii?q?xA7d2ul0uFJjsaDp2Imj0JbTpzZXcGIDWua6BJdqa0145inX6NaH4XZsO0Cj?=
 =?us-ascii?q?0sWPXCncTCkNbLcAMLHBku7SiJlHeN5KThGxaV8x8CW3cXqI1Sv1Ttokjc3O?=
 =?us-ascii?q?GOovu7whjT2yv66IlXosLozp9uFdGBkc8cLxTrk0KNaJ56U7OPkTgpqKWE6U?=
 =?us-ascii?q?oskvPLvxA8Vv4DpE/5TyWQm1/AygPg2DEh5zvJ0lmDm0bupsT/WXYTF9dBrZ?=
 =?us-ascii?q?gxSGqZ12MQ+PVHlI5b1WOQsJRaSTnamj7m2tTOXxZ20mKpvHsZl/IJhXA3a/?=
 =?us-ascii?q?pfVFYRl/1dwKpmKuZEIMvI0vFiLACoNrCa2B9iSyLZU5kehBgo/DXjZAVrIv?=
 =?us-ascii?q?7MeDl/hiXc6UkooJkx9Tpo+CQS801wiq4VWt1K4f/JPb9vk6wLRsgKbbhlDO?=
 =?us-ascii?q?NEWsevDHfRKCi8eV56DG6XY53vAUi93aLf8fEw/qWnaZYIxJw9lNDIV05Zr3?=
 =?us-ascii?q?c7fwbrBdeV1JNG/xjRSCHlNA6dgf129tx8oPnxVbDrOSqMRBQnlNahuewWBo?=
 =?us-ascii?q?neV+yoMJxbDvf/JS/lGJpP3Qf5R55OQENuGPE9q5I+QRaDs8jLIorluqjSd+?=
 =?us-ascii?q?vSPqPkFXI+Vmb2EhI4LUzOzQV7nzWWs1PD8WrssinWCzzCFLpLYdvnw9Q=3D?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647316800"; 
   d="scan'208";a="109408955"
Received: from noaadc-exch801.valueaddco.com ([10.14.31.80])
  by adc-dmzmx102.arconic.com with ESMTP; 14 Nov 2022 11:41:20 -0500
Received: from NOAADC-EXCH801.valueaddco.com (10.14.31.80) by
 NOAADC-EXCH801.valueaddco.com (10.14.31.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.2; Mon, 14 Nov 2022 11:41:20 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (172.30.11.68) by
 NOAADC-EXCH801.valueaddco.com (10.14.31.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.2
 via Frontend Transport; Mon, 14 Nov 2022 11:41:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcAqO9otCA2vI9EKXzKvsMkdiw0a4KO6jfrR4B+0U3V0lco0rmZA6bSleFmyDlC3WfJch+TRbMPuGZwExq0hYtyu7JZ7MW3/94xvczS+XOzCF4n47kEiql/fgOoDDMvLeQvRsONaoHN1sj/WS00+eWbUqzMQT+JNwtdzCGmApR7tg6iTj0nIBa6wDrWwgjJoA6bK+B0BSxK1TKQwRJINnGNQVc/AkNLul7LrVCtS/VOHMQwgpE9H9pNTYD/8KvUdAzNX0a586xv5fDhTus4+d6SIR7ZKw9GOKRzV4zJ+QmF0vsAfhjJACqLPxpvPS9k06MdLxoH8P37GolaHTTPzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHjcMqxei5hPoLiE13apwGnO6A0cOgjjPWHdOQgY3uE=;
 b=DA3FmRFWIFoYmOZoPldWXdQRLPIP+g+pi3InlOnCR4DdZ/EYbBvckNOXoD15qbXpzxL81ixL4HwRgiuxzk9XzmuU/C/KMd7qGuL0RvFhFdmqKO8V5kvK1Dwjpc+IbnGffxu4XLFuS8sz252QLO61V4b2Jr6fMM6I7BzUXPEnuTC9jsqMymCCUzQYotG4r0TXZFEmXjR1CEnHYjon9HD9nqXBI6zFIJGZmq0ULDFdP3BiOFvF7h6AjTopEb8tsRoBwl/NpPmCJoshB4BmIEubfiPX0Er3rDBGYjA2QZ0AL1apCQxLrNxKC5yugeRVXRp3sFPYE7a9y7dTEpXeCw8oiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arconic.com; dmarc=pass action=none header.from=arconic.com;
 dkim=pass header.d=arconic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Arconic.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHjcMqxei5hPoLiE13apwGnO6A0cOgjjPWHdOQgY3uE=;
 b=REK6ZyE7nB3ZP52o+lJxxzzKRfRZwwWijAKwj/51UqgKUyNQkOItGacCG5E/SClDLpdEYmkKpDKRoyBml6d1yYGfEhUlg2EMdLo7CnJ7FUQP1FjrGZQqMF0lN8btds5wsE4e7AnYFdh5e5e0Q9MqH72IugMQXY82FIb6ZpeIRFOHEo0WhWgVtFMqyzFiBzMuVz0+Rv3Yc+EvaL0/frVKD07KYJE3KG/2Ca7dFsCYQn66QaiEybV5VAe78dSHECUyR0w3HQVlDVu8C75dFc1O4SEniE9X+1/pBrXiShLnTDRF9IQkmtZ6T9EoPgJ0yNuSMtg9IaZLTGKe3jQGIA1UPg==
Received: from CH2PR11MB4230.namprd11.prod.outlook.com (2603:10b6:610:3b::14)
 by SJ2PR11MB7548.namprd11.prod.outlook.com (2603:10b6:a03:4cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 16:41:18 +0000
Received: from CH2PR11MB4230.namprd11.prod.outlook.com
 ([fe80::82e9:8058:fe12:e174]) by CH2PR11MB4230.namprd11.prod.outlook.com
 ([fe80::82e9:8058:fe12:e174%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 16:41:18 +0000
From:   "Fisher, Charles J. (Top Echelon)" <Charles.Fisher@arconic.com>
To:     Akbarkhon Variskhanov <akbarkhon.variskhanov@gmail.com>,
        "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: RE: EXT: Re: EXIT trap does not fire
Thread-Topic: EXT: Re: EXIT trap does not fire
Thread-Index: AQHY9oZbKyISlkbPLE2Uu1qbDPI8Wq4+oUpg
Date:   Mon, 14 Nov 2022 16:41:18 +0000
Message-ID: <CH2PR11MB4230294BB3964937E921C51781059@CH2PR11MB4230.namprd11.prod.outlook.com>
References: <CANeoM1GQ6XsittRZAE-hZLQYngjF_B5Rm7f786cB3vLQY6dLmw@mail.gmail.com>
In-Reply-To: <CANeoM1GQ6XsittRZAE-hZLQYngjF_B5Rm7f786cB3vLQY6dLmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595_Enabled=true;
 MSIP_Label_265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595_SetDate=2022-11-14T16:41:16Z;
 MSIP_Label_265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595_Method=Privileged;
 MSIP_Label_265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595_Name=265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595;
 MSIP_Label_265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595_SiteId=10a639b6-59e8-459f-b873-5b0257cfebe4;
 MSIP_Label_265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595_ActionId=400660d1-3b03-4f81-a1b6-19b96f11316c;
 MSIP_Label_265bbeb9-6e1c-4ad3-8d2d-c2451bb5b595_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arconic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR11MB4230:EE_|SJ2PR11MB7548:EE_
x-ms-office365-filtering-correlation-id: e56f2a07-49c3-44ca-7606-08dac65f0dee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svutg/XrsThYyqtYgKYwPgrYc4ibiXPKcs4gn4HKoVCqyCNSro6UB2q7lFJD9oy+H7meoH7ViIUUPL9IXsg9TIcGo2ftnX8H1+/+9uTOxrpD//20j3zW2IGLH1Nk7d7bs/W1mbD8zAkz87d3SlWEbKfG1+u9ohki58Lp9y2k/S3z8taFZFrXtKMYhpmgWqLY7/ONJ/1qV8fUYYAHV8jzGrDmw6H8bLIog0ktU16xLfndHq7PWCA6IdruV6H4FSLbbx6S1Fdw5HBi8/aUanTeHp3OFsLNQFxE52G8f9qjYKwW/H9TL8uUwWV4lvwymiRm+ZgjzbWRSAvI1bwbnJ3FIsC9MTydUke4zRd9mxwg7XpcrjPpsSUS0hqWnnc7OxqZGtM7B6ZJHBo83p+CNpI3/0wamIG1fu0gGuOSb4kexqw6uEjc/Tk58sTuWTQxPywQSqzumrnWb1ZgW8cTpwm0RFDzcAo8hbqoGCn0i6SqcrM7cDxL4KHjdKef0ofiO5lOC+Gh8ao+b2sTyLXN9++3ziEtDkFBAcKlYpH+062I/Z+sQRaUcQL6+Gj/+aFVcqJbc6iOthRIUhhE3hZVqVCocDithTmZNBlreLD0E1kdT7SAaW1FF1pufwTyXCeimdbxj7Zm/9VS2QmeqiYRMnCQF9rxJhn0yJVx/Q1tsWL/QvnVZYJYFDiluO/oI6GZR+AOAGgQZQlZp4Mx7kNLBB9h7QXuoPmIJcDrhuxJQOPR+kuh/SEtUQcHMXix34wzAvc/CsFA9aXK32LVkjLAeCzIGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(55016003)(71200400001)(33656002)(7696005)(2906002)(5660300002)(122000001)(110136005)(316002)(38100700002)(83380400001)(6506007)(8676002)(64756008)(26005)(9686003)(41300700001)(186003)(76116006)(66446008)(86362001)(66556008)(66476007)(66946007)(38070700005)(52536014)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXRKNm1sNzdmMDFkWGM5VkIycDlUQy85ZHVWL0xKSDQ4TlBHdW9SM0ZBVEYw?=
 =?utf-8?B?SEhhcUlXNytwU003WDdsK2ZyTEhkMVpYNDF6eFE1Yy9BQWk3OUQ0YTJZSzh0?=
 =?utf-8?B?UTYwaVlWMG9RYTlieEwzTWhFRFg0YTRLYUJVbHF1SjM5ZjlYQUlmS1BhNHY0?=
 =?utf-8?B?NXpnMXYxQnFqWVRSckpsbHdPUlJzOHp5S2M5RXBuekZKVy8wYW5IMzRlV05N?=
 =?utf-8?B?d0RxenlON1g2ZzVYSTdMV3BBSWc2K2FYTEdxRjluaHViTzBDT3FPenBxQmJz?=
 =?utf-8?B?NEs0UWdNOVBVOVNGVjNaSDhFK3VSRnBLd1VvOEVQQ0NGc0FHeWFJeG9Fckk4?=
 =?utf-8?B?ajMrUGF5WDNSTjZMUG5HY1pyYkszenBXa2dVS3UyV2RLZnJyaUJKaktsNDZZ?=
 =?utf-8?B?NmNxajlZZGJyK1pPN2RRbW1leUQrMHJKV1pBMC80dFdtWDZQZXg2UGdJYjAv?=
 =?utf-8?B?d0l0TDNDNkptTTUvM1hRdGloQkV3bjRJbUFKMmc2WXkzTHpobUV4QWxTOGh6?=
 =?utf-8?B?b1dDN0dWMUdkYWVzYVZuaFUveXc3NW9BV3hEbVVOaFBSUHFmbTh5aFBhQ2Y5?=
 =?utf-8?B?eFAzMk9qTmFpVkxBR0JXLzF3bDA3VndHMWpIOTVSWDNhR3FWL2k0M3ZNY2dN?=
 =?utf-8?B?UXZySHdqVGFIOGxWS2YvK2tPeE5aeW1HMXYzMVlZanBsOVhnM3dxc3pmYUJW?=
 =?utf-8?B?Z3FrMER2NDJ4ZDZ4YWNDQUFIaTYrS1AxSDZxY3g5MUwwNGUzTUtxNnlhVno5?=
 =?utf-8?B?Q21uRGhsdStSaVBWa2dma0ROQkxDaWoxMGlySjJ4M3gvQTY0QlNTOUUyVDA3?=
 =?utf-8?B?VGJOUjJUR25WRTBpRkF2a2h6aVlmU284RlZBTGI1R3NOUVhhNmNJMmhFZ3Jm?=
 =?utf-8?B?Y3U2cDNjU1dlclVOUW1hQXBqZlhWUmx6SC9udXNTWkd0bW5qd0doOFA3UnJC?=
 =?utf-8?B?VUxJdnpZeC80cW9WOTh0ZUZvc2p2MDQwOHp0WkowTnNRNHc3MlBaT1JuTjEv?=
 =?utf-8?B?K3BEWmp0RVBUTW1qNzJ6L1RZTFRPRjNBUkdjaGRiUDFRZks1Y2MvSHFtV0Vz?=
 =?utf-8?B?V3FlNUlmMkUxTGd0N09GWE1MSFJaS1ZQdnZGSEZKeHB4bFJjUGJoSUVJWFYx?=
 =?utf-8?B?dENrcFBQZDZNVVlKU0xRQ3l0VTg5QWZNZ0dNU0NTYjFwVWdtSXdpUkRNdmMx?=
 =?utf-8?B?dGNhSnBGMDN3Ykp5NWR1UGlkcEsxK1JIUGVpc2hxU2xRaTNNakZuQ2hlcHJM?=
 =?utf-8?B?QkkyMXMxbzVaemo5KzBGWGNQdWZVdGM1bWl0WVBORE5oOHR1QjhpUU5iY2FI?=
 =?utf-8?B?REhBVGFlNEdBUGRnT2JZblFZa2JBN3A4aWxsZnZvQTAwblJ5Smd6YmVzUldy?=
 =?utf-8?B?RURiZzF5UmpOT3J5OTBUOHZLM20rTVE5NzhoRHZNQSszd3JpREpwb2FHZXQ3?=
 =?utf-8?B?OWxXYWwvejVaZnhmRzJHREhOTEtQOFNoRlVKOHEydWhQUTVuVUo1STNXZkk5?=
 =?utf-8?B?ek1qL0oyOFdhR09nanhHdU4xNWtWcXNHNHA2a2VnZmJVa2VycVNNLzFEdUM0?=
 =?utf-8?B?SlVzY2NXSGdTNzh2Zk96azMvc0J3M2pEb0NhSm1VaC9sUmNHTklRVDc1MlAz?=
 =?utf-8?B?NWFuTlo5Rzhoc2xlL2ZhdFlEUVdoQXBsdUI2ZVVTU1dtR2RIKzJyNFZTRU1U?=
 =?utf-8?B?VXBkTUMwaEozOTkrcmg5NElpS0FpK0lJWnlCc25tRDYzaDJMaEREMnBoOG9H?=
 =?utf-8?B?ZzREYjBBaUNjU0NMeGc5andCYnNRMW5xSSsxWk0yY29qR2NyNm50NFBmV1ZV?=
 =?utf-8?B?aWxFczhNYWNiUlZ1RVhKT2ZncDVGME1Cdi9zT3F2bENvUnhGOWhGU2xXRkw3?=
 =?utf-8?B?SEYvMDVDeXJDYmZkaVBKam42S3dHRXJ2KzdXNFlkSStRblpQU1huNjdqS1Vo?=
 =?utf-8?B?bUJJY2ZyUjhKRHRkdkExM0RIZ3BtL0xkTi9PU2FvclRmUFN5N2ZKOWMxOW1B?=
 =?utf-8?B?M25SNHhNQUR5M1BFQ0tnK0kwbEFFdDVWOFROQk1IeXIzRVJVOVFDcGtVY1A1?=
 =?utf-8?B?d0dEeXJEUXRlRXpsVDVUc0o3Y3E2NUNqRDRiYldMQ3FYTEhZSVpQY010bVoy?=
 =?utf-8?Q?/qIKAX5P/DmPBGgMppZnFmjoi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nkxK9bV2eaYj6gFuFzRFUxUI/L13aHXr7wKut9UgoIUgDi9meJhXwLsUs4lXYXDnGfeAtZQbLawMUvTlqVMYaDkmQ64vmY34QYKHFmmhGbLc1oLnbXQAWQYY808Yj6wUj/md2o4Ba3piGb1b4vca8DvMnWjU/zDXrT4lQ98V8rPzaoEtOHvpdLIe876FdRwqaWhn+MJcWMh/f88rvz/8ZmaiZxBVsJEqXo5PK47JiOUkj3r2D0V3uYgvcce8s1zmWInFfHLcw5off7lkwDmEeVaIweQ2/euvj5MQXHnrfs+WMIz7nkjXQ1yDrGOIKfnm238uq/MU9PQPSPdKcfyqCQS6UvIAuW0TqBzxj40vU0TC/h8D0SNGjNHVAmmXBKF+IBmnFwD6CjGAhVHuvJ2RQPJgfiZsE83OpUH4a3Ot86/4n4bnXv7W+saaeO4yNTAKPRbxBTM+NDtGtVSXgIGnOxCIjBvmujXRbhQKg2xZUUjEEjo+OycG8/jnPRLrhwP3blDSn/RHy1lsegd+vQNUGqMgkvOXaNh+LF8p3tDgiKwIKPgM4Uhg+RGAKVtWQvM4b7hH7vl/wFWqN1KiOwxoUQ2YrZUBkTiiAClb4WlhhMZz17wYyvriPJpZ7gq0jgk90YW8hTAJQ2gLSJ2lU2wGqZb/fX1xtJwD4qTvPyZPT+slhUdYd8ge3/o/o019vpU9EAOLAsuV+c9fz8qJu9pibq3LB3tUBXejfcO4vErg7o3ls5PFXv17UD0Jgwqi3MIeI54zlguoDcZIPjoNoCO3RKjmG3abC8AS1UjtyU53lCO9Nbuu32UBamzXBejsKZOd
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56f2a07-49c3-44ca-7606-08dac65f0dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 16:41:18.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 10a639b6-59e8-459f-b873-5b0257cfebe4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao+0DrnqRz0VnvkRuEkMVx3gE4933jDRU67DqrHlnGdpGWXZ78Y+Ek5JrKCMLkK0KgKp1YT0Q9fxTlVBYbgcYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7548
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

SXMgdGhpcyB0aGUgb3B0aW1hbCB0cmFwIHRvIGNhdGNoIG1vc3QgdGVybWluYXRpb25zIGluIGRh
c2g/DQoNCnRyYXAgImNsZWFudXAiIEFCUlQgRVhJVCBGUEUgSFVQIElOVCBLSUxMIFFVSVQgU0VH
ViBURVJNDQoNCkFkZGluZyBDSExEIGNhdXNlcyBvbmUgb2YgbXkgc2NyaXB0cyB0byBnbyBiZXJz
ZXJrLiBJIHdpbGwgY29tbW9ubHkgdXNlIEZQRSB0byBraWxsIHdoZW4gSSdtIHRyeWluZyB0byBh
dm9pZCBzaWduYWwgaGFuZGxlcnMsIHlldCBub3QgdXNlIC05ICh0aGlzIG1heSBiZSBhIGJhZCBo
YWJpdCkuDQoNCg0KQ2VudE9TIDcgc2lnbmFsczoNCg0KJCBraWxsIC1sDQogMSAgICBIVVAgSGFu
Z3VwICAgICAgICAgICAgICAgICAgICAgICAgMzMgICAgIDMzIFNpZ25hbCAzMyAgICAgICAgICAg
ICAgIA0KIDIgICAgSU5UIEludGVycnVwdCAgICAgICAgICAgICAgICAgICAgIDM0ICAgICAzNCBT
aWduYWwgMzQgICAgICAgICAgICAgICANCiAzICAgUVVJVCBRdWl0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAzNSAgICAgMzUgU2lnbmFsIDM1ICAgICAgICAgICAgICAgDQogNCAgICBJTEwgSWxs
ZWdhbCBpbnN0cnVjdGlvbiAgICAgICAgICAgMzYgICAgIDM2IFNpZ25hbCAzNiAgICAgICAgICAg
ICAgIA0KIDUgICBUUkFQIFRyYWNlL2JyZWFrcG9pbnQgdHJhcCAgICAgICAgIDM3ICAgICAzNyBT
aWduYWwgMzcgICAgICAgICAgICAgICANCiA2ICAgQUJSVCBBYm9ydGVkICAgICAgICAgICAgICAg
ICAgICAgICAzOCAgICAgMzggU2lnbmFsIDM4ICAgICAgICAgICAgICAgDQogNyAgICBCVVMgQnVz
IGVycm9yICAgICAgICAgICAgICAgICAgICAgMzkgICAgIDM5IFNpZ25hbCAzOSAgICAgICAgICAg
ICAgIA0KIDggICAgRlBFIEZsb2F0aW5nIHBvaW50IGV4Y2VwdGlvbiAgICAgIDQwICAgICA0MCBT
aWduYWwgNDAgICAgICAgICAgICAgICANCiA5ICAgS0lMTCBLaWxsZWQgICAgICAgICAgICAgICAg
ICAgICAgICA0MSAgICAgNDEgU2lnbmFsIDQxICAgICAgICAgICAgICAgDQoxMCAgIFVTUjEgVXNl
ciBkZWZpbmVkIHNpZ25hbCAxICAgICAgICAgNDIgICAgIDQyIFNpZ25hbCA0MiAgICAgICAgICAg
ICAgIA0KMTEgICBTRUdWIFNlZ21lbnRhdGlvbiBmYXVsdCAgICAgICAgICAgIDQzICAgICA0MyBT
aWduYWwgNDMgICAgICAgICAgICAgICANCjEyICAgVVNSMiBVc2VyIGRlZmluZWQgc2lnbmFsIDIg
ICAgICAgICA0NCAgICAgNDQgU2lnbmFsIDQ0ICAgICAgICAgICAgICAgDQoxMyAgIFBJUEUgQnJv
a2VuIHBpcGUgICAgICAgICAgICAgICAgICAgNDUgICAgIDQ1IFNpZ25hbCA0NSAgICAgICAgICAg
ICAgIA0KMTQgICBBTFJNIEFsYXJtIGNsb2NrICAgICAgICAgICAgICAgICAgIDQ2ICAgICA0NiBT
aWduYWwgNDYgICAgICAgICAgICAgICANCjE1ICAgVEVSTSBUZXJtaW5hdGVkICAgICAgICAgICAg
ICAgICAgICA0NyAgICAgNDcgU2lnbmFsIDQ3ICAgICAgICAgICAgICAgDQoxNiBTVEtGTFQgU3Rh
Y2sgZmF1bHQgICAgICAgICAgICAgICAgICAgNDggICAgIDQ4IFNpZ25hbCA0OCAgICAgICAgICAg
ICAgIA0KMTcgICBDSExEIENoaWxkIGV4aXRlZCAgICAgICAgICAgICAgICAgIDQ5ICAgICA0OSBT
aWduYWwgNDkgICAgICAgICAgICAgICANCjE4ICAgQ09OVCBDb250aW51ZWQgICAgICAgICAgICAg
ICAgICAgICA1MCAgICAgNTAgU2lnbmFsIDUwICAgICAgICAgICAgICAgDQoxOSAgIFNUT1AgU3Rv
cHBlZCAoc2lnbmFsKSAgICAgICAgICAgICAgNTEgICAgIDUxIFNpZ25hbCA1MSAgICAgICAgICAg
ICAgIA0KMjAgICBUU1RQIFN0b3BwZWQgICAgICAgICAgICAgICAgICAgICAgIDUyICAgICA1MiBT
aWduYWwgNTIgICAgICAgICAgICAgICANCjIxICAgVFRJTiBTdG9wcGVkICh0dHkgaW5wdXQpICAg
ICAgICAgICA1MyAgICAgNTMgU2lnbmFsIDUzICAgICAgICAgICAgICAgDQoyMiAgIFRUT1UgU3Rv
cHBlZCAodHR5IG91dHB1dCkgICAgICAgICAgNTQgICAgIDU0IFNpZ25hbCA1NCAgICAgICAgICAg
ICAgIA0KMjMgICAgVVJHIFVyZ2VudCBJL08gY29uZGl0aW9uICAgICAgICAgIDU1ICAgICA1NSBT
aWduYWwgNTUgICAgICAgICAgICAgICANCjI0ICAgWENQVSBDUFUgdGltZSBsaW1pdCBleGNlZWRl
ZCAgICAgICA1NiAgICAgNTYgU2lnbmFsIDU2ICAgICAgICAgICAgICAgDQoyNSAgIFhGU1ogRmls
ZSBzaXplIGxpbWl0IGV4Y2VlZGVkICAgICAgNTcgICAgIDU3IFNpZ25hbCA1NyAgICAgICAgICAg
ICAgIA0KMjYgVlRBTFJNIFZpcnR1YWwgdGltZXIgZXhwaXJlZCAgICAgICAgIDU4ICAgICA1OCBT
aWduYWwgNTggICAgICAgICAgICAgICANCjI3ICAgUFJPRiBQcm9maWxpbmcgdGltZXIgZXhwaXJl
ZCAgICAgICA1OSAgICAgNTkgU2lnbmFsIDU5ICAgICAgICAgICAgICAgDQoyOCAgV0lOQ0ggV2lu
ZG93IGNoYW5nZWQgICAgICAgICAgICAgICAgNjAgICAgIDYwIFNpZ25hbCA2MCAgICAgICAgICAg
ICAgIA0KMjkgICAgIElPIEkvTyBwb3NzaWJsZSAgICAgICAgICAgICAgICAgIDYxICAgICA2MSBT
aWduYWwgNjEgICAgICAgICAgICAgICANCjMwICAgIFBXUiBQb3dlciBmYWlsdXJlICAgICAgICAg
ICAgICAgICA2MiAgICAgNjIgU2lnbmFsIDYyICAgICAgICAgICAgICAgDQozMSAgICBTWVMgQmFk
IHN5c3RlbSBjYWxsICAgICAgICAgICAgICAgNjMgICAgIDYzIFNpZ25hbCA2MyAgICAgICAgICAg
ICAgIA0KMzIgICAgIDMyIFNpZ25hbCAzMiAgICAgICAgICAgICAgICAgICAgIDY0ICAgICA2NCBT
aWduYWwgNjQgICAgICAgICAgICAgDQo=
