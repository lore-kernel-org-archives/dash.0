Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB05C7EE25
	for <linux-dash@archiver.kernel.org>; Fri,  9 Jun 2023 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjFINiE (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 9 Jun 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjFINiD (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 9 Jun 2023 09:38:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2089.outbound.protection.outlook.com [40.92.41.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8070B30F7
        for <dash@vger.kernel.org>; Fri,  9 Jun 2023 06:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWHsrtGp9PtgyarEoLLZKFRDduja/9R3DkImotaNp6x0dmZjNIWt4XPA9mV8H3kfRVOZ9hFVZGCr/BWuH7mxThpMSBL57yhNJxDnPG4kKpk6V51ydBKTLUXuN9xzaRv3o508MzjTy3zQYkWvbIHwLKLfzEHOXOac0vOHvIIlq630a+SsZMmzB0rigsH0QTWuDbzQv0TXaTRPQuxt9fS1vKJc7YkkKi6IetMd5VErV0EvklAGUWIIgmMWpKZ0+q1y5Y7iu2D1hcRkQxalSCK2mfdp5ENxVcz7ttyg8JJLRIoaxxt4+niC+vpuMN7b/WNbO1qtGqPkNuy0pizxnExp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP6O2pmi+qdOdyzkJxqU7P5uczjqynaVQb9Cc92XjwQ=;
 b=nkP9PWyw62dVe/+r7zE/khY//krgKr5f8tc2gd1A7M/8OqIiWvKGXNxKzH1gKHxihHRfQ1X7BObVGM3QxP0kAIIj5GjkcmB/6IofxHyontRVGQ00GezAEF4XQ1yMXINLhQPLPEIpEnIv5octe3HH51O08fHiiOWUEaIFOfoHuwAQDt8wKuHHm/3KnouFAvnNkaMqPSnLz42qSb6pFP13/Ypl6tju7ieqr1+zhfgVvkNhJzd1HkkScVx+N1qSoPAWMvGOOhFOLnMnn2jwayAeUbYpxGf77lJF5NM3/35XQWLCE0UHcggRdVs4DpK043P20lNtCgA+PbESATfRdyDhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP6O2pmi+qdOdyzkJxqU7P5uczjqynaVQb9Cc92XjwQ=;
 b=GHpDfbKeEpaV5IlHz+bqXp2TC0ePqyhZyiPtRZh/1kb0vdJSR5Sur6OD1o4+I1+nOGYN0DYzihbWn02cHD8gsfkoX3n6uX4wb4/JnAJYVgSycyWN+aBDpP7hJrreXXioPFtNkXiq408E1IEgpdad5Y11/57IS2x36DjVKopS36GYkZzIFUo3x1hL7Jx5KKpNTntQ8EuSM7GK06autqs+ngiEqnDslRL7TV6EDW5H8y/FdWSYbbPQYjpCZ1sdUKrqqCzvpdsu4m0srExh2mV+Exsn6gDd4MbKehN49b7OE6OH0bIzlYqbjbp/AuvvBtrKsYnupQZqyyrlrJaHkHBh5A==
Received: from DS7PR19MB4456.namprd19.prod.outlook.com (2603:10b6:5:2c6::20)
 by CH3PR19MB7853.namprd19.prod.outlook.com (2603:10b6:610:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 13:36:34 +0000
Received: from DS7PR19MB4456.namprd19.prod.outlook.com
 ([fe80::e204:692f:e30b:deee]) by DS7PR19MB4456.namprd19.prod.outlook.com
 ([fe80::e204:692f:e30b:deee%5]) with mapi id 15.20.6500.012; Fri, 9 Jun 2023
 13:36:34 +0000
From:   S M <mythrowy777@hotmail.com>
To:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Interested in porting Dash to Readline
Thread-Topic: Interested in porting Dash to Readline
Thread-Index: AQHZmtdomWD9vgYWMU68wi2KO9y8Vw==
Date:   Fri, 9 Jun 2023 13:36:34 +0000
Message-ID: <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [rVavizIVJvi3AF1MH7r0kltQTLkEXj2o]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB4456:EE_|CH3PR19MB7853:EE_
x-ms-office365-filtering-correlation-id: 9e49ef1c-14c1-4469-a997-08db68ee8ab5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: py23Sz1L0nqv4TTN61Yu7rf7MlhBFdbne0cnaonZkaxvHHRCSH6paGCxBdtRz5i7SaXnrPzcKjM/aVBxlLWZST9MAETpVSZp5PyIHmOsRXdDiA2woAGpmDHvN33dagDZaL6JWsofnZ5OBm1txE7E8UYAFxDT0X8ETheMZXc45KCQHOKs40a+TWFKi9RFmXHhmW3Hs/HqnS+LrBGj4zkBPbk7POY5LlxTMP4tVsLVWa3iNnWin+EARD5Fb0OG/utjoyFvXFZyMvt/9MGNz7qWxPnrv3YkFtGYoWpgO9v/dkyuoLXQkgmWK4HUcfe3XkHKWKW30cMWmLhoKdn7I5oWCmj/uplNgT7pMUcC1SkdD9lPo8FzEIRu1XJ9Z2ZbSf8VyS3B3QgdzGJJ2KFGcmtBfnuO8jlcLfRzZU4GddsbGJKb+JbObb9DT5CecMi1EZC8+midx2WHkP3M6sjPic9iLB97hGBiOEfaJKnlHPQXmQxi21Lr8PjgM6l8rSQQNBTcgUblSEwT2VDORadktrj9mKN29bau+COJvqQ9ISmdsu44ni6xAW3YLftttQpTyuzW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FVWf7IFC06wKwdFAebat5jem3m+X4bvBZE3uUXMeyhH2r26L1apZeHj/60?=
 =?iso-8859-1?Q?CUvCOJ/pbPBecNQVNc/HMvsFpgljuSfabQvkDKjscYiRVW3Jik/I6qcjFH?=
 =?iso-8859-1?Q?JzpltJha964IepfXZwdR/e9dP/f6nV3nhI/VrTa2vg22sD+1qu/XnjDJC8?=
 =?iso-8859-1?Q?zPcnc/zJxv8Kfbkx9a0jKjCoDVifwJnULviLz3MC7D2ehFKZ4pPf2pLXQl?=
 =?iso-8859-1?Q?XuFD3nMMgSTlns0LOj0QqJxAxM5Wggi8j2LVlmV/Ff9o98bgA0QMWAZJrs?=
 =?iso-8859-1?Q?Le0j0Q1JM0Y6I2FNYHDBj6jtPrYemtNE8au8h16TgTNWGfeRQo5eM8qR3O?=
 =?iso-8859-1?Q?C5XXDjGg1iGe6+04RFPh8B/AVF9bPzY1TtbtODMG7XyzjXU/ZUcZv0K9lr?=
 =?iso-8859-1?Q?sHcNIAupDOH3oC94pMZKmAyDq/QXJTC8ZdIes3dNbgWhqwwMePV8dLRxGA?=
 =?iso-8859-1?Q?xz57nLjKszO8WIgTuzhs3HNbJADoygZkI2HHxb3STniTLTvn1XIusjBCaX?=
 =?iso-8859-1?Q?bSy7Nl5YeYPG9VUEaWhAvTn5cH9+12aYhCNqYf1x40Vg1ngKMhuVRi7v/k?=
 =?iso-8859-1?Q?tW/s/nEOS6TUlFSkkNRuogUEH7XcxNFNUcFWi/V6FOE9UhMzODqqILUxVG?=
 =?iso-8859-1?Q?XenWSJHAPkoge2DJjXob61DfWHbjpSKOiqVUcjXvVjpxM/D473mTk1e3Pc?=
 =?iso-8859-1?Q?/xXloVdqgBxJUU33zm4jaL2F13Y6sjkLrAKHq0V7PVALw8MaqJuuJwnVaI?=
 =?iso-8859-1?Q?sSl6k441flEJAcys/Xth6MqboKoSunQOnRNU5xYz8uiSNr8/b6DIuTA+Zo?=
 =?iso-8859-1?Q?TT1wZpSz0QzeVy3yuVrIM7GJIBYmpTqQ1iuqRlOM72NfArhSP0lLqcUYoz?=
 =?iso-8859-1?Q?0dva7jKzqmsRVPNM58gT7zlQqxGsgv+U9+hHuCdi6eMLLMm8K3y6o0Nnf2?=
 =?iso-8859-1?Q?vchm72UdsuzhKNwvT6/cJdniVL9wPLwxcEfmSDAkuGpmzeTZoQ7R/AwSzw?=
 =?iso-8859-1?Q?9kzd6sWwB2YX0wjOmb0NwJzf+n5hnOUlRE1lb3CO8UNJud7UHaT1Tb91I3?=
 =?iso-8859-1?Q?KaQqgjy36CGDZvmJch1Jb5dR/8bbXjF/3/fVr/foKMolkyuh+NH4Gat6sn?=
 =?iso-8859-1?Q?2RtRuWe1F3KzytJ0HdLFvbuHNIc39ymXdPBqPt00ZdX+X2TpGM5nMh1Brk?=
 =?iso-8859-1?Q?Wlsi5JwB5nnWXyF5hefI0UFQxhL7cMR3pCH2FpzEjcwSrUPFkyXaUmGjCc?=
 =?iso-8859-1?Q?mU7nHTQeHdrRki9vFUTw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB4456.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e49ef1c-14c1-4469-a997-08db68ee8ab5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 13:36:34.1526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7853
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.=0A=
=0A=
I think I might be able to substitute Libedit in Dash with Readline and sub=
mit a patch, but first I need to know if such a change would be accepted. I=
 think its main advantage is that it supports file completion out of the bo=
x.=0A=
=0A=
Let me know what you think.=0A=
Thank you.=
