Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DDC3DA78
	for <linux-dash@archiver.kernel.org>; Sat, 14 Jan 2023 05:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjANFaN (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 14 Jan 2023 00:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjANFaM (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 14 Jan 2023 00:30:12 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2067.outbound.protection.outlook.com [40.92.52.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFBE35BE
        for <dash@vger.kernel.org>; Fri, 13 Jan 2023 21:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETcslK9zo9abSEh/GdEruL5Eyd6HU0zi0jlBWT8KVp1xZYgB4KM2PtDapYesoyyZH2Bcl2JEKV91DiWTyfAMGtkstaAOLWmcGfEi4YFwEQjq52c9I4zleJ0K9uxpy7k2QNPpevSAFw99dXLr9JQXUi0lGeDkBcFgs8if4psLvOODV4p8+0Fb1nDy1bCwQD8bQ3JlDNjXmmRJTOfPNoCBbccQm4EP9R0ZsMIOHeuxAng9fkrr/wQnT6NJAM2g+v7HHdlgHz5H4ZtfmdmkTbBP9RFp8Lp8UcJXBT2tY61oe/ymj8hGOTRBCJSt5yeZWWlQHwPjF0LDKOQKm17kgaFk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L9JoZHEw3kCGhlEeKiq7FkQoc3PfNJ8VrsvyaLr4as=;
 b=cbGhPZik6ZchgbB2lJOploInff8gPZAGjBEJ/axwLubUkH/MFdoFLy6GTiDR9qSDBp+BfFkRTc8rsM7vziHv7Kxz0JsRmNEZJfcioTCBCl3Ad0r5ca9Pp5fVqzo4RGt6bg0VMUqToABo1k214Qpkzkjz0XA73NhuaYX+g8/o6A8ZYACOlzMWT+weKaJQcX/+vdlklfNvMowzbg9fMmcw8EmFZ0fiTUaGZpdw5BygmAAv5j3fZkkr+eZDgKlmneUNYaDvf2DrSd2pIh37Q3rspvv+EcVZAYhxy2gNa47u6odNWrt95WCUpR0ay08MeefM+udx0O4kbXGb0lBXMYygaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L9JoZHEw3kCGhlEeKiq7FkQoc3PfNJ8VrsvyaLr4as=;
 b=fCNjXM7X/WwsBgrZybEOhkQFysNyGc2roXGqcSOuuiY9/bsK/vfocC1YKeEY/J+s2aJq2/7Uall3s5ovChko2F3b/BJS0sIOayk4tvcFTDbehLhIcwpA0X/nwelV3hNcVEkMgsNXlwgvr5FTvtTtiuZ4+K6znGoPuFRKZHYiuj8wGPsnaIx/tIDTCTZJFf8VvwzNOAi4fe9uX8N761/Ql+cjra87TPA471KQOe78h+GO2FX5RF2e7jBM+ezfhMAKdC2xybUG5kvTuiR+R1PjD+1Q7mR7e0+uqXh8gP0gtRKqksBemuYwi1rziyrrwCSg2Fop8cTiNFFq2yFbU/yi2g==
Received: from PS2PR03MB3830.apcprd03.prod.outlook.com (2603:1096:300:34::17)
 by SEZPR03MB6763.apcprd03.prod.outlook.com (2603:1096:101:66::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 14 Jan
 2023 05:30:09 +0000
Received: from PS2PR03MB3830.apcprd03.prod.outlook.com
 ([fe80::7337:c64b:e35f:15b5]) by PS2PR03MB3830.apcprd03.prod.outlook.com
 ([fe80::7337:c64b:e35f:15b5%7]) with mapi id 15.20.5986.019; Sat, 14 Jan 2023
 05:30:09 +0000
From:   "anonymous4feedback@outlook.com" <anonymous4feedback@outlook.com>
To:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Bug in dash: Incorrect behaviour of $LINENO in function
Thread-Topic: Bug in dash: Incorrect behaviour of $LINENO in function
Thread-Index: AQHZJ9ksAoE21oKuP0u/botIp/CMcw==
Date:   Sat, 14 Jan 2023 05:30:09 +0000
Message-ID: <PS2PR03MB38309A4880282F1C60C3094092C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [reCLGmunAb5meQPgr/4efFTENV7Tn+LEP3otHmVPVb+bKkpa26Yd12BhuoR5hWuj88gkkBsZdn4=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3830:EE_|SEZPR03MB6763:EE_
x-ms-office365-filtering-correlation-id: 8c25ae58-a82c-4c8b-0f8b-08daf5f066f9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r84a70I+5cC7t8KkkLb1FkImoWJhoKOP1KjYg4yzaf5wewRvf9iE6g+oIvx2cvK+Vj2OB/9J4G7LlhvCs7oodIsJhjpi2Q1VJfEBJvEo2q1DwGOLHi6Sbu1U9YpZrVwjjcpTUMZujVLmz8ePyOOuXvEoFaNwYB9t9uyhHsRfdFuBwCw7WxMyBp/Zs1uNcYRM3qKzcEWsVGXCosk85jGGEufYLUu6d3Pe9G9ZtJrPrzIAtcFnmc5X4FMDrBr4f0PqoAV/iExc9+HfnE7KT2t/El+2VbSoclvBjk5GfvhSiaF28LbYOSJurpTbBa5S3DYae3ByegKUsT/BSvatyhWvgwL9x3rFsvIM5LfrBzVYVqGJJZ+d/SoK+DkcsSXTyu7yuixwxWtTNvMZwTuAr/W4gquLt6EM9rNZAY2gW1oMKObzyJhyTJPwyj7M4uHU83GTnYW3xFlMNY28gScUrDIk2VQMV2S3qmYUohbPV6mcP9Of9VDOBTAhc59VYjT8+9cA/y3qEU5RjnQkCpqO0HZlpUSr1XpBAh5NAWT1GUrGKOcoy/yNmwzkQCZgBqDUiYOXj3j9o9K4icF7IuCH6EKRpg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dmRTNyt1dHRVM04vUjQvU1JIbGc4Um1IS0ZoQmFhaVhxNm5vYld2RzZDa2xq?=
 =?gb2312?B?T2xIQlByR0plemV4L0NHaTJuMXRhS2tWTjQ5MGFFc0UwbEwrZUM4Ujd1MnZn?=
 =?gb2312?B?em5qd1VyR0M2L0JLMDBwRnlYZXRzQkh6a1l0SWF6YjZrTCtxam9mQm9sZ3dx?=
 =?gb2312?B?TXZSdzl5WUlWTWxUOHZIamdjZTBidmVqaG1hY2k2dVcwbFpFcDVxM0VCWmpl?=
 =?gb2312?B?NEpVbzZiOXpTQjVrUFFRZHFCeTRqUjgwY0x1M3QxZU1nVDdydDRVQzl1QnZ6?=
 =?gb2312?B?ZlgrWkZyTTlXNi9aWXdjelZCWjZjWDNGRU1uMkR4WEFyanNpL2NDUkozZFdL?=
 =?gb2312?B?dVR0c3A5RVRVOHZGR0ZFRzl5dGJnejE2c1RsbFhGUWVIaW1Iaks0ay9VNHJX?=
 =?gb2312?B?TzVmQzRMUmVDNjRyT1ZFSjdBYmRWTG5KVUQ2NzE2ek5Ud3FLQmo1aTQ1eGVP?=
 =?gb2312?B?b2xid2tZbnpzb25KWXd0dCtlVjVoOVpIZ1NieUNSdzhTTERacUdMTVJIWktF?=
 =?gb2312?B?Rnd0QjNFbUFSei9KdFh0Q1h4MVh2eXp3ZUo3YXRMT3YrNTNoOXVyRFJNZlpR?=
 =?gb2312?B?NUpaRXJXcnJTU0NwelZYcHVaNXJ4S1JLQzlBK25KU2ZUeVVmd0xvR3Y2WWp5?=
 =?gb2312?B?YUVmRTNJSUM0WlVUMTd1RUhaYmFUYzhsRktnd0RlQU95ZU5VZzZFT1BnMUdp?=
 =?gb2312?B?R25lWUhDNE4xVmJTYnM4bys1bUh6bnNTcTNCbzRFZ1RDYjRXVGozaWp4UytC?=
 =?gb2312?B?U3NEOWhwOUxRTDFDak1lVXhkUWE3Nk5uUUlRTDhSNFV6aWxxSG95Y2lDK21k?=
 =?gb2312?B?Um9CM3VFZFZWRXQ4bWlyd3ltSGpNNWsrUjhYOFZUbWF0Vmp2RXJUeEd5azk3?=
 =?gb2312?B?Nkg0TUFQNytQdU5IaXpSOFFyZ21KZUpKMTBhVGE2Ni93S3RreWYyRDlhV0xF?=
 =?gb2312?B?dm1zV3VuaHhqUktNNVpSdy94NlBJZURiOUZpdXJqaDQyakFMUmdVeVNDWXNR?=
 =?gb2312?B?VzFHaXo1V1kzenNEK1pVWUdDU2UvNm1Hc0dlblFYcE8yNVRSQ2JLUjkwUDd5?=
 =?gb2312?B?WGVJRTQrMjNMb0ltOGJ5Wk85MGpSMllTNGpPMjJuKy9wa0E0MGxzR0JKV3hV?=
 =?gb2312?B?OEU1RDhvRmFDOGZ3c3BEZXNQNkVMb2J6akdqaE9tVE1RSXlTYm9vak95ZDhk?=
 =?gb2312?B?L0NCd1QwUVg1cDJrcDZndmFQZVlrOE5NbnV3S1FMc25XYUZMWW5QK3g2eUc2?=
 =?gb2312?B?VTlSTnRBa1ZoSnB0dlE0VGE2MC85b0JsL1VBeW50VGpjcWRmdVpueCtuSklx?=
 =?gb2312?B?V2VqbStmZFFnL1FFNysxdU1aVW9INGFwRHNOOEFKdXQxZUo3STNSLzJiYWd3?=
 =?gb2312?B?MWNLYXpJMWNZK3pmLzA0cEVuM2NHZnpqNlAwTXV1dmNrbS9zTVBIODNLeWdB?=
 =?gb2312?B?SlZzbjJLbG5TQ2pudmRJQTVlaldSRUZCTmt4ZXFuZzhkci9ITmtnN3NEbnpJ?=
 =?gb2312?B?ZEFOWGI3NHc5QXJLd0ZPVWxQMld0MnB1YkJ0MWJaalgzSXpQc0RNOEhpUEZC?=
 =?gb2312?B?eGRhczZXYXloTTlkdlRYTHlleUVPVFVKdjJ3R1J3RUtUS2IzWXhzVGM1bm9W?=
 =?gb2312?B?RVdSMmdEUVp4TElnRHBDR2RFdk5YNXZ1bjlFc3ErSytaYTk1dlBoVWhmN0V6?=
 =?gb2312?B?RHBCdzNPaFFNKzBxdW1hc1Q5bWdjNWRnUXphdzJoT1ZkREN2VkJIUlQ2TkpX?=
 =?gb2312?B?dlB2VVpPeVAyS0JHZnBTekhEejZqMWlpaEdYdGt6eWlaNXA3dWVHaUxmN2p1?=
 =?gb2312?Q?Iday/Nygho/+Dywc/Vz684Xr2DUDc+NWbjuGc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c25ae58-a82c-4c8b-0f8b-08daf5f066f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2023 05:30:09.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6763
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

RGVhciBzaXIgb3IgbWFkYW0sCgpGb3IgdGhlIGZvbGxvd2luZyBzY3JpcHQsCmZvbygpeyBlY2hv
ICRMSU5FTk87IH0KZm9vCmZvbygpewogIGVjaG8gJExJTkVOTwp9CmZvbwpkYXNoIGluY29ycmVj
dGx5IHByaW50cyAyIGZvciB0aGUgZm9vIG9uIHRoZSBsYXN0IGxpbmUuIEl0IHNlZW1zIGRhc2gg
c3RvcmVzIHRoZSBsaW5lIG51bWJlciBvZiB0aGUgcGFyYW1ldGVyIHN1YnN0aXR1dGlvbiBhbmQg
dGhlIGxpbmUgbnVtYmVyIG9mIHRoZSBmdW5jdGlvbiBkZWZpbml0aW9uLCBhbmQgYWRkIHRoZW0g
dG8gZ2V0IHRoZSByZXN1bHQuIEJ1dCB0aGUgbGF0dGVyIGlzIG5vdCB1cGRhdGVkIHdpdGggdGhl
IGZ1bmN0aW9uIGdldCByZWRlZmluZWQuCgpUaGFua3MuCgo=
