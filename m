Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC891C3DA78
	for <linux-dash@archiver.kernel.org>; Sat, 14 Jan 2023 10:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjANKzp (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 14 Jan 2023 05:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjANKzo (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 14 Jan 2023 05:55:44 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2054.outbound.protection.outlook.com [40.92.53.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FBF6591
        for <dash@vger.kernel.org>; Sat, 14 Jan 2023 02:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAlDktl+gOKGbYDCRCy00r++btXGHsrm/m9lnU1tdQVTLde4DV2jJd6KeS/qs+toRXFWa0KSgDjGHyrYG7TBOKIIe+2rsMxkthxZt+X/d2Y9UF7Xdq1s4xDrJGtpvtaqyqWuauNC/8dmpgHA1CbtfsMD/zFzKSWZmQSqyDE/+/zpD3Jslugb8PvlBObYdmjJ3W6Q2mO5W/v2suge61ezjBCixwUtQu84v7BA/K18CL/cYiEseqd7XYUrU1Df0+OLvBnQFWeAtIvILMh76hu0Q9ihLjeCSiF1crGrEdwUCA+YE1rsDqTGLm1kOOnPhS6oc1JjztTkY07d+rZ9N1ReVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7xDBlxbGpR6ScdrrNXnMNK39iBtZV48PjcwAAR1kPA=;
 b=arLA+gAFlIxnWhW2fDX7X2861aGdBv+mzr+H2lkVSq7+MzEcUpC9UgtzsWnUJFUxkv5lw8UepAjtyKnRkHjKraxb+gG1KiAXB2nSmLDNzoH3VP8za/+V/0jS+aZIZjoNUvK3o6l3Hy1SLVlJPSr8utXnTIhtHo4qLX2x4zN0mbe17Od5zxp9hlWRrgVm5RSKgM/infv5WoNypioQlJlMsMV7OG4MJI6075qv1iWCx+PVFs7tYm5V43KoPvuI3M79fOik4Ib8MSe5p6+iqUCu5Yhv1WpGZK6lT43ZXZC3kberxf5zefmj5GyzwJ2VaWZX1Gt/FzUReEiDiIhNx+avKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7xDBlxbGpR6ScdrrNXnMNK39iBtZV48PjcwAAR1kPA=;
 b=Qu9SX/N0XQtzsaaZT8aJZabuSKRv2Jw+D9sVcD470bDQVYNHwxOWIebhxTKXZZP2zXexRXW3JAXipJdv5+W9vqeiV5qjjVH8QolAgEZqUbeP9FFwvBmmLlIxQGpP7XmM1Ij+6FzCnceWt7iFXJ9WiXYoVeFePi6faOq9EhiT3kpjFdQ6oH7rMgn5i5mn5lGCktIblGudzP07FYiFZq93DpNacB7+HTk9cnFaSrqpWGpBY+Gw8gjtFtd/+OmUI9SohoS2AqjJca6GT5+nHf/kevO7Dta9BbP6gqGptEfg9iJW+ynE7XuHGikvwRiucSoLyMPvRNjnBrdI2s0o30KhqA==
Received: from PS2PR03MB3830.apcprd03.prod.outlook.com (2603:1096:300:34::17)
 by TYZPR03MB5246.apcprd03.prod.outlook.com (2603:1096:400:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sat, 14 Jan
 2023 10:55:39 +0000
Received: from PS2PR03MB3830.apcprd03.prod.outlook.com
 ([fe80::7337:c64b:e35f:15b5]) by PS2PR03MB3830.apcprd03.prod.outlook.com
 ([fe80::7337:c64b:e35f:15b5%7]) with mapi id 15.20.5986.019; Sat, 14 Jan 2023
 10:55:39 +0000
From:   "anonymous4feedback@outlook.com" <anonymous4feedback@outlook.com>
CC:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBCdWcgaW4gZGFzaDogSW5jb3JyZWN0IGJlaGF2aW91ciBvZiAk?=
 =?utf-8?Q?LINENO_in_function?=
Thread-Topic: Bug in dash: Incorrect behaviour of $LINENO in function
Thread-Index: AQHZKAa9/xYdNOd8QE+wtfNFCJhLBw==
Date:   Sat, 14 Jan 2023 10:55:39 +0000
Message-ID: <PS2PR03MB38306209EFE7E00A8B49CE9F92C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [pq5f70QAGVN+yupvJmp3zOkJ9iT476CZ8pyuFIQ3hOTR5EI97/dvarzBwEwddDD7QbE8msOoaC4=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3830:EE_|TYZPR03MB5246:EE_
x-ms-office365-filtering-correlation-id: 347bc899-4369-4570-9caa-08daf61ddf9e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXKGqqu7jcNDyYry0LntJ6n/q5LdSvOsNqnOLKRyYIYqyk2/i3df8kCYcpkn7txCNxjs19ClijjxZIs0IzANcMohYlfbp2NrJ7yJbcIuHwLDIxf1JL3xzptaLR6S7cDDv/fBLQw1wEGfPP1ey7kl8OSHgWCZT06QNIreEKfMONyfIqliCs8iA7X6fnGV+sTjgUnTRUw524ZWNTgJnJfabxkBRlL+9fJ5R4erxDZ9fuAKmsu3KHm36TlJmpO64Wh6uRdsSdL4LSDdwsbYzvgkoIEORltERB9HiMHyhbPXd0o66AJTiv3HhYzqXajz2LDtnYG1Vz7XzSrfzEIu7td4OLTJ13rBxjajxZb4zN/5C4iNJM6me25/rrTmyzSbSnwjFJd9SDoVm5KTV5za92AtZtTOc1QdhnF4CbW75bVKSWH/yzqK0XMmTXdxpmTz9yOIBGlgF8nyKOnfosX2PI5xdTZOVlqlHhrgGoISVFfy+px2gJMr00WQw6GLePOmSdDxd+as8xG6z67YaoB//mIbpnBwcEV9JOmP7AtfLJgbxXsrxpLi9ox2pJjam4Bw2kkkmlyMj6YQEuIQd9cY+CmBl8USo2lOD3J7yT3Xh8nnfOY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkpqdUhQaU9EMHY2T0swWm1ka0FGYXE4dXc4U2pWeFFaT0tNa1hxMGxORzJh?=
 =?utf-8?B?YWt6dk16d2FsdGthdUlTTTNkcFdscnJmRGpqOW1Ob0Z3YkNnQzljR0EvYkF1?=
 =?utf-8?B?bUo3WG9oSDVxcVBnazZrWlJTYVhqZ3U3S1JpcVRWak15Q3VWcXBWRUNUbTFH?=
 =?utf-8?B?U2EydXhUdFRaWGIrcU5UcEJEcDl2SFVNaHBjbnVBOTBxam9aVmRSNEtLZWoz?=
 =?utf-8?B?MTRjN3RJNEpnT3l5MndqRzRyZXpzb0JaVklKdGxyWlJQV2NqNkNpd0cwUElh?=
 =?utf-8?B?MnZDQU1vVHRjbWdkZU1qUXJtRnoycVhjbVFtSjZoN09NK3dya0RBOHJWWUpK?=
 =?utf-8?B?b0JSNHF4WWtxZWdmRENxSE9XeGZrS3ZYS09DWEFGeWxJYmVMdEhjSllpR1dm?=
 =?utf-8?B?MU1la21mb0xnM2U2RW1PTVd1SVpYWkdZTldpSFJNcXdQWitRd2xhTGNXWVhG?=
 =?utf-8?B?Y2o2SE94Mi9JTjUzanNldEtucUMwSUhGZEFFS1VtRmRQS3NJdDcyT2xhS2hp?=
 =?utf-8?B?c2tmL0JVQ04vQVV4RzNPOTdKU2lRR3VFMUhTKzY4RWNONzJsd09sWWRDZGxK?=
 =?utf-8?B?N2NtcFhYMUtlYWRCUjY4M1NBdk5CSWJkZlk5M1ZYbE54enhNOHBvN1lXMHNX?=
 =?utf-8?B?eFZoNEhyQ2pYS1pyTUNBcmN1cDM2OXcySjFGYTZ5am1ocFZmVUl6bHArTFBE?=
 =?utf-8?B?c2dldUxiQUM1RzRzS3ZMclhJV0RDUHRJWVNFZUpkQ1dla2pLaUZ5RFZXWGQ0?=
 =?utf-8?B?WW85REdHc1p0ejNzQWdpWHhiMEUvemEwV3d6Q25vdVJyRTlnNEd4RWtxZnQ4?=
 =?utf-8?B?N294c3RRcXAxVHlWbXNFOUJZcWlwWDhGRytRWXlzbXovRnIyTGVzd3dXbG90?=
 =?utf-8?B?MEUrQlBVek9PUzlmYzNFZHNUdUQrUjBKdVRoUFhWbDhnOEs5SVErcFVMb0JB?=
 =?utf-8?B?emRkUkZXUkdYK1kzajgwY00ya2pWTkxzNitzMzBGNnEyeVpaZmRZdWV2U3Fq?=
 =?utf-8?B?SEVBL1VKekt6NHovSCtBbEViTzlnR2RnYVpQZ3JibHhuWDFQY0pPUUh5KzRT?=
 =?utf-8?B?a2M2YTltSExtN09qa0lNNmI1OUdNSkhObmo0dUpkODlRdDRySmNTdUkwTnJy?=
 =?utf-8?B?SHZGQzU4NTJyOTVtcTBGc3ovMVI4dnoxNGlqUE9lRUFzWDFHSzQ5Y3Urb3do?=
 =?utf-8?B?SDBERjJOYUZPaTFpaitHbysyU1AzdVFKVXUrbVdBcUgrOGtzdzVXVzB0dnlE?=
 =?utf-8?B?c1Q4V3FCUTZPMHJlOU1IVzA0Y0xENGwxV0lZUDVlTzVNS25OaHl2dUpoSm5D?=
 =?utf-8?B?ZjRMMmVCOEdUSzZONDc0b1ZOVUV4WjRiY1c3emRtZ2o4N1ZoRlBJaDg3b1VY?=
 =?utf-8?B?TnRYRjV3SWM0dkt2TFZ1OEdYd2xXdHg3T0czLzFNVFFObzhvSGF6eWs3K2dR?=
 =?utf-8?B?di8yYWxQSHh3TDNHMjZ3T2ZhM2tBdW0xcEVrK3VTZjJmQWtVR3dzaktUWEQw?=
 =?utf-8?B?SHJGL1dKbW16WnpqUk1pTXVKaDh3VHpNUjNZN2plQURPdlJPRGlRS2FuTy9E?=
 =?utf-8?B?TVQyb1dQY2FqczNEbmd4MGFrYkg2VVVCb3FiWVhualhjVWJsai8xdWtYd2dI?=
 =?utf-8?B?eWlnYk1va1pibk5VbUJqeUxlZ1d6YTNrQStDcG44RmxLYzI0UHpGaHJrL3Nn?=
 =?utf-8?B?VExtRDNIbHRHZkd4NWtyVjhqMGQ0SjNjWHVxa2h1WmhnQytPYUYxSGJmMHE3?=
 =?utf-8?B?MlFmOGVnSktUTU9RRzJ0RjFjaHFBL1hXMkNHQzZHMkNiRDFMaExOV3ZxSHFh?=
 =?utf-8?Q?BBYB7LziexYX4aVwgsvBasgJoFACULzeaxFhs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 347bc899-4369-4570-9caa-08daf61ddf9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2023 10:55:39.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5246
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

U29ycnkgSSBkaWRuJ3QgZXhwbGFpbiB0aGlzIGNsZWFybHksIGFuZCBJIG1hZGUgc29tZSB3cm9u
ZyBhc3N1bXB0aW9uIGluIHRoZSBmaXJzdCBlbWFpbC4KCkkgbWFkZSBhbm90aGVyIHNpbXBsZXIg
dGVzdAoKIyBsaW5lIDEgaXMgZW1wdHkKIyBsaW5lIDIgaXMgZW1wdHkKZm9vKCl7ICMgbGluZSAy
CiAgZWNobyAkTElORU5POyB9ICMgbGluZSAzCmZvbyAjIGxpbmUgNAoKZGFzaCBwcmludHMgMiwg
KGxpbmUgbnVtYmVyIGluIGZ1bmN0aW9uLCBjb3VudGluZyBmcm9tIDEpCmJhc2ggYW5kIGtzaCBw
cmludHMgNCwgKGxpbmUgbnVtYmVyIGluIHdob2xlIHNjcmlwdCkKYW5kIHpzaCBwcmludHMgMSAo
bGluZSBudW1iZXIgaW4gZnVuY3Rpb24sIGNvdW50aW5nIGZyb20gMCkKCk1vcmUgdGVzdCBtb3Zp
bmcgdGhlIGxpbmVzIGFyb3VuZCBjb25maXJtcyB0aGUgZ3Vlc3MgaW4gcGFyZW5zLgoKQ2FuIEkg
c2F5IHRoYXQgbm9uZSBvZiB0aGVzZSBpcyB3cm9uZyBiZWNhdXNlIHRoZXJlIGlzIG5vIHN0YW5k
YXJkIGFib3V0IHRoaXM/CgoK5Y+R5Lu25Lq6OiBNYXJjIENoYW50cmV1eCA8bWNAdW5pc3RyYS5m
cj4K5Y+R6YCB5pe26Ze0OiAyMDIz5bm0MeaciDE05pelIDE3OjM5CuaUtuS7tuS6ujogYW5vbnlt
b3VzNGZlZWRiYWNrQG91dGxvb2suY29tIDxhbm9ueW1vdXM0ZmVlZGJhY2tAb3V0bG9vay5jb20+
CuaKhOmAgTogZGFzaEB2Z2VyLmtlcm5lbC5vcmcgPGRhc2hAdmdlci5rZXJuZWwub3JnPgrkuLvp
opg6IFJlOiBCdWcgaW4gZGFzaDogSW5jb3JyZWN0IGJlaGF2aW91ciBvZiAkTElORU5PIGluIGZ1
bmN0aW9uIArCoApoZWxsbywKCj4gSXQgc2VlbXMgZGFzaCBzdG9yZXMgdGhlIGxpbmUgbnVtYmVy
IG9mIHRoZSBwYXJhbWV0ZXIgc3Vic3RpdHV0aW9uIGFuZCB0aGUgbGluZSBudW1iZXIgb2YgdGhl
IGZ1bmN0aW9uIGRlZmluaXRpb24KCndoaWNoIGlzIHdoYXQgd2UgZXhwZWN0IGZyb20gYSB2YXJp
YWJsZSBleHBhbnNpb24uIHdoYXQgeW91IG5lZWQgaGVyZQppcyBhbiBhbGlhcyBiZWNhdXNlIGl0
IHdvcmtzIGxpa2UgYSBtaW5pbWFsIGJ1dCBkeW5hbWljIHByZXByb2Nlc3NvcgoKdGhvc2UgYXJl
IHRoZSB0cmlja3MgYWJvdXQgYWxpYXNlczoKCiogdGhleSByZWFsbHkgYWN0IGFzIGEgcHJlcHJv
Y2Vzc29yIHNvCgrCoMKgwqDCoMKgwqDCoCBhbGlhcyB3YXJuPSc+JjIgZWNobyBoZXJlIGF0ICRM
SU5FTk8nCsKgwqDCoMKgwqDCoMKgIGYoKSB3YXJuIGZpcnN0CsKgwqDCoMKgwqDCoMKgIGFsaWFz
IHdhcm49Jz4mMiBlY2hvIGFub3RoZXIgbWVzc2FnZSBhdCAkTElORU5PJwrCoMKgwqDCoMKgwqDC
oCBnKCkgd2FybiBsYXN0CsKgwqDCoMKgwqDCoMKgIGY7ZwoKwqDCoMKgwqDCoMKgwqAgIyBkb2Vz
CgrCoMKgwqDCoMKgwqDCoCBoZXJlIGF0IDEgZmlyc3QKwqDCoMKgwqDCoMKgwqAgYW5vdGhlciBt
ZXNzYWdlIGF0IDEgbGFzdAoKKiBpbnRlcnBvbGF0aW9uIGNvbWVzIGZpcnN0IHNvIAoKwqDCoMKg
wqDCoMKgwqAgZW50ZXJpbmcoKSB7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlY2hv
IGVudGVyaW5nICIkQCIKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIkQCIKwqDCoMKg
wqDCoMKgwqAgfQrCoMKgwqDCoMKgwqDCoCBmKCkgZWNobyBkb2luZyB0aGluZ3MgaW4gZnVuY3Rp
b25zCsKgwqDCoMKgwqDCoMKgIGFsaWFzIGRhbW49J2VjaG8gb29wcyAuLi4nCsKgwqDCoMKgwqDC
oMKgIGVudGVyaW5nIGYKwqDCoMKgwqDCoMKgwqAgZW50ZXJpbmcgZGFtbgoKwqDCoMKgwqDCoMKg
wqAgZW50ZXJpbmcgZgrCoMKgwqDCoMKgwqDCoCBkb2luZyB0aGluZ3MgaW4gZnVuY3Rpb25zCsKg
wqDCoMKgwqDCoMKgIGVudGVyaW5nIGRhbW4KwqDCoMKgwqDCoMKgwqAgL2hvbWUvbWMvc3JjL3Zl
bmRvci9kYXNoL3NyYy9kYXNoOiAzOiBkYW1uOiBub3QgZm91bmQKCmNvbmNsdXNpb246CgoqIHVz
ZSBmdW5jdGlvbnMgYXMgbG9uZyBhcyB5b3UgY2FuCiogaW4gdGhpcyBjYXNlLCB5b3UgY2FuJ3Qu
IHlvdXIgc29sdXRpb24gaXMKCsKgwqDCoMKgwqDCoMKgIGFsaWFzIHdhcm49Jz4mMiBlY2hvIGhl
cmUgYXQgJExJTkVOTycKCkhUSCwKTWFyYyBDaGFudHJldXg=
