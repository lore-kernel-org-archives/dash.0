Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFB6C46467
	for <linux-dash@archiver.kernel.org>; Sat, 14 Jan 2023 10:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjANK6F (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 14 Jan 2023 05:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjANK6D (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 14 Jan 2023 05:58:03 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2084.outbound.protection.outlook.com [40.92.53.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E13A8C
        for <dash@vger.kernel.org>; Sat, 14 Jan 2023 02:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ida+s+ZHn2/HXKbd74UQ/Fy0hdR6mxNJYZ5V3UBuG+HgsFhFlOVT53PXg2f9KyE2k0XHTxFVJrhCn+sRfoPdU9/CmWA2/m+6vPcrKrHmn2ak4AVG9KAFsf4Ot8X59VbZVfDwnkWxEtIdPNcYXDGunfgrDO447dcJLEwhJc1ArXnbWbWKu2fw3fPjKzU50iybMqPU7dj//wxpfddtIVj7iZcpTwEBhBCaW6Y1GYfSBwwmscNXNiEALhnEfL5UNFamqZCosn8dMIXAOE26t4+SkUZ6eJJOi4U/wgZzw2p1srZgIpAUkIXgX6cwYTpOm3h0vdULmvcONZQuhJnVwGSGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhXMwanPqkOzPsa6CL/+2CI8R7fRMixRNfeKe7uf0rQ=;
 b=R8y9mfr1oWcRjAuZRUDtLbCuNbHXawJfvUfTZoWLKVLCWYxFrDsAcXL2qUEncv6M7JTA01JrFCj4ZEwJKh0x4LrlDUTDnmM2geRCi9IkIN77JTrayGRwAg8rcByFqtMbWCgUsv4iCzspZfkL3v/r8OQPLRPfPyJJZIM9aDdCHZvt1G6JLTXnGGwo/XuMZYknbhh1rYOm/ryRaPX/uNH3PB8CMrT1cH0AWzIkLSuPJIfjUzigptWWLRwq8LXhuOo/Iq0yQEzrvtAAjy4fMqSeBJCILd1TnhyR3/UNlxoxJInU7jNjjQJoeu0zC6Nlv3OfMaXzM2eXDwAJBGp6z7Ry3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhXMwanPqkOzPsa6CL/+2CI8R7fRMixRNfeKe7uf0rQ=;
 b=c/zU9N8+dWH/MkHP3y+M+0VEaQJQBba4EY6YTHiZ/lrB0igF5TNEDUSkz1PHWqK5dwum15BKOV6fhTSLLLUep+YypCvSjj9DlcVM8RKfVunBDJCsjAR6eu3/sLUP0sX87buwcoKxTF+GURTTcy/u1/fp88uu+4cAGW1jk1RL3HtmbLFHIpA4oeOfMsRaYqoQBg0YdKNw9QYSa2mJt1eK4mAqi4LwOTN7auEXYan2sT9XRP8bcCoUKx0WjEQl+AAO7Pzx7ynviKBi+qC5srUzJMUqO5CkHxZRkmTslL2mybqpv80pVNEq+kESoxLCW0IpxDbyqxg68fBIuQaUbaDeAw==
Received: from PS2PR03MB3830.apcprd03.prod.outlook.com (2603:1096:300:34::17)
 by PSAPR03MB5384.apcprd03.prod.outlook.com (2603:1096:301:48::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sat, 14 Jan
 2023 10:57:59 +0000
Received: from PS2PR03MB3830.apcprd03.prod.outlook.com
 ([fe80::7337:c64b:e35f:15b5]) by PS2PR03MB3830.apcprd03.prod.outlook.com
 ([fe80::7337:c64b:e35f:15b5%7]) with mapi id 15.20.5986.019; Sat, 14 Jan 2023
 10:57:59 +0000
From:   "anonymous4feedback@outlook.com" <anonymous4feedback@outlook.com>
To:     Marc Chantreux <mc@unistra.fr>
CC:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBCdWcgaW4gZGFzaDogSW5jb3JyZWN0IGJlaGF2aW91ciBvZiAk?=
 =?utf-8?Q?LINENO_in_function?=
Thread-Topic: Bug in dash: Incorrect behaviour of $LINENO in function
Thread-Index: AQHZJ9ksAoE21oKuP0u/botIp/CMc66dqGkAgAAVw7I=
Date:   Sat, 14 Jan 2023 10:57:59 +0000
Message-ID: <PS2PR03MB3830467E11C8D6047363FCA392C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
References: <PS2PR03MB38309A4880282F1C60C3094092C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
 <Y8J4PmYwjp9fE7/y@prometheus.u-strasbg.fr>
In-Reply-To: <Y8J4PmYwjp9fE7/y@prometheus.u-strasbg.fr>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [vP/ZyH9Xf1XnPQY9O4sCCPijhIVbNGAZBYHbYRYOi/pgc4gfCiXUnM8Z4BBgU3KHNo1GMPTtFTE=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3830:EE_|PSAPR03MB5384:EE_
x-ms-office365-filtering-correlation-id: 505ccc9b-9d3b-4da9-b7d8-08daf61e336e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zq5nulULuQs27fE6YSC4fdh7HoOHvqIrCi4gz94534pbgZW6ZYKLFPod3ytU3zqF/Nvn5gfZLn71KysFIvtI5fai1Ibxobul5lO22Dz4sd8AcBkpIOY7xSGiZEkXTM86SzYJazp/xKqRobepmbisaebhlkTM4tilmg/USRPUWfvkuje1rXGefRpfZU+q2FKyOPvcQf2r0oPwCZoxQoT0YrceIIU1nbHXZOFcoCBDPYOQrmvOgsGEpfAK3BAUTRmA0c5xAwkL4SHA0EjbhqNQjAuUCNdnz6lbJw56DGkxQa7SYiOIH2yFIou/5ALYpopmVQZRKeMGPsodhxQTpiBnVVQhNLd6/48Av/zO3qBAKXn+A6NCxGz7QXYW5x/TEaZJMCiYFwF/MMcqT5ossDYC1mHpLbe6BDL8aHK9367kVVmMLADZV12Zuhcj8DOq99GnXKqEisjcObX1HzbRU+6gHORjgzKtZ75y19odCzOOK5rEdCO2VmNad2aToFzNYLpjuh+Qb9EN50Gic9aPRaQZJ58isg/ZOTy5KYbIR0SuFKLiBBBOCfy8uST5XAUmDYL/8CO+3As+cTmvXGtxUv+7C1j7rk+WwxmkyBVe4KXxnrw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3BpUmlabHM4T0JhSHc2TkdldWZjVmdyUUMwU1Z0a1dObkZmRFlGK2pwZGxm?=
 =?utf-8?B?M29URHNmUzlEWjBFZm1mL3J0NkxUQTNINFJGRGYrREZ2RUx1ODFWVXhFS1Fj?=
 =?utf-8?B?clNqeXhPYjljM1hJSEkrM0dCQjcwNDZyVmE2UkpaQjlUY2k2cWhETEhOdCt2?=
 =?utf-8?B?Mno5TUJxM3BsSyszT05xYjFNN1F3RjUyUHFiY2ZQNXVZUnZ6UFEvMURpMGVh?=
 =?utf-8?B?djc0a0xwT2puaGtKdnJPcWgwKzFhclhNY1hOYStPem51ZnlVZlNhcC9oZTRE?=
 =?utf-8?B?Y21TN1pjVzg3RklEUXRUSm1vTlJONERGQmpzaWFNV3Uwbjl3amtRVldkd3dH?=
 =?utf-8?B?UHZEcEprNlhQSktYSEZWOGliMlBsME1zcmhkWnpubjk5WVVsSFJvQWdwcmF1?=
 =?utf-8?B?MWRpTnp2OFpEbmw4T3VsU0xCTzl6YjhNSzl2c1Q2a08zdXUwTE9lMVZoNDBX?=
 =?utf-8?B?YjdzcU1oZDFYV1ZBZmJZQVNkZTUweUtTcXVPWXBrbTJyRndlMXZkd0NheGFJ?=
 =?utf-8?B?bDErV0xMT1JWNnpXK3A1VkJ5a2lSellTdmx6bXdZaTZlUEoreER3WXNjTUFI?=
 =?utf-8?B?dXVWcWc4VVRYZENaOFVkNWVib2JRd1pXNUM4a1lkdm1kQ1k3ZlpQR2RGdjho?=
 =?utf-8?B?TENtTVcxdEVNSmNOYWZPU1pOazNxd0pnMnlrS1RGQno5a2M0NEI0WHd5dFpQ?=
 =?utf-8?B?bFk0TWJPYjhDZEhsUEtyalEzb1dYcmV3QURWaFpBTE1BZ292WVhMT1BtbXZW?=
 =?utf-8?B?anhNelpHN0dkemdGVnBKU2g4SU5ndVJuV2FFVFVkM0U3MXJhaE5oZVlHVGM2?=
 =?utf-8?B?UUdlNDlEQXVpMVdKMXZLR0tsdFpCRHRlclh6STdMbHc1U0lsdzhwU3RPOFNJ?=
 =?utf-8?B?OVhRdXhWMUVOSlJ6d0lUSFdmeERTT2J4d0wwMmw1R1VTZkFvU1BPUE45MC9o?=
 =?utf-8?B?SFdLR1pLaCtxWCtoRjdzM0NwWGVrbFNzS1ppaHg3M3U2TklRcVRIQ2VZZ21w?=
 =?utf-8?B?RzJLaEJ5MU16MTY4SVNRLzNpTnRUQzBnR1RCY2VOZUJJTSt6THlrYWlnUi81?=
 =?utf-8?B?OTNHTk9GeEJrbEJESG9tckhJY2RDSlhRQzlMSDdtNFV2bmNBMlJwZ2xuV0I2?=
 =?utf-8?B?RXdDcUFvQWQ0YUlJTk9rTnRSSXBueHhMU01hMVEvVDBVeUZzL2NrV1NzTjlK?=
 =?utf-8?B?VVBRQmkzN0c5T2lMRVNXZWF0RndvU1dkc1FKMUk0NmFxUEVMMXFMcGlVSmJY?=
 =?utf-8?B?UytWTmR2dnVOYW5pUCtJMHRWd3FWRDFoaFNBd3NYeDJsQ2Vua1EvbmVpaXhN?=
 =?utf-8?B?RjJyeUExUVg4aFlLQ1N6SVFkKzhwYmJpRVdKbE1SVkw4YVErRC9oM3BWNkJ4?=
 =?utf-8?B?RU9ldTJvdjJ6STNwbXY5ZE9jeEpTMDlVR2xiWTl4ejFSQ3dHZnpaa1duOE9Z?=
 =?utf-8?B?ZjBVRkF1R3YwTVJwQU4zaTQ5Y2lZVmdYUmJzbVNtK1FUNEpoSk4yendsejFn?=
 =?utf-8?B?WFBvMzZZZ3cwZ2FoYStTNEJkc0xBNmsyOWhwekdPMnNaeko5VWk4Nk41WWJV?=
 =?utf-8?B?VHNWR2pOSUdqSlN1MWFJQlZkTTZreXdzMlNieXl4bzNGWXlJeHIzUnlXYXl1?=
 =?utf-8?B?N2YvQlNvbVpzM09NWFFzWTdlNDg1ZFpsMjc4L1YzY3F3ckp4SEVZNFprcVZi?=
 =?utf-8?B?M0N4S2d6OHVRaytHdll0bjZhRDBUKzBSRFZ2N1hGWnNneGZhNEhFRmZIU3Bh?=
 =?utf-8?B?SWNEL1drUUg1dXBGNUcxVENtRUFJMzF0QS9pLzRHQ1NKUkNFMVM2RGoxTk5X?=
 =?utf-8?Q?EOZ9xKGkv1QhM+SoDcjK2xjaruJCcjx5RQF2k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 505ccc9b-9d3b-4da9-b7d8-08daf61e336e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2023 10:57:59.8067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5384
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

U29ycnkgSSBkaWRuJ3QgZXhwbGFpbiB0aGlzIGNsZWFybHksIGFuZCBJIG1hZGUgc29tZSB3cm9u
ZyBhc3N1bXB0aW9uIGluIHRoZSBmaXJzdCBlbWFpbC4KCkkgbWFkZSBhbm90aGVyIHNpbXBsZXIg
dGVzdAoKIyBsaW5lIDEgaXMgZW1wdHkKIyBsaW5lIDIgaXMgZW1wdHkKZm9vKCl7ICMgbGluZSAy
CsKgIGVjaG8gJExJTkVOTzsgfSAjIGxpbmUgMwpmb28gIyBsaW5lIDQKCmRhc2ggcHJpbnRzIDIs
IChsaW5lIG51bWJlciBpbiBmdW5jdGlvbiwgY291bnRpbmcgZnJvbSAxKQpiYXNoIGFuZCBrc2gg
cHJpbnRzIDQsIChsaW5lIG51bWJlciBpbiB3aG9sZSBzY3JpcHQpCmFuZCB6c2ggcHJpbnRzIDEg
KGxpbmUgbnVtYmVyIGluIGZ1bmN0aW9uLCBjb3VudGluZyBmcm9tIDApCgpNb3JlIHRlc3QgbW92
aW5nIHRoZSBsaW5lcyBhcm91bmQgY29uZmlybXMgdGhlIGd1ZXNzIGluIHBhcmVucy4KCkNhbiBJ
IHNheSB0aGF0IG5vbmUgb2YgdGhlc2UgaXMgd3JvbmcgYmVjYXVzZSB0aGVyZSBpcyBubyBzdGFu
ZGFyZCBhYm91dCB0aGlzPwoKCgrlj5Hku7bkuro6IE1hcmMgQ2hhbnRyZXV4IDxtY0B1bmlzdHJh
LmZyPgrlj5HpgIHml7bpl7Q6IDIwMjPlubQx5pyIMTTml6UgMTc6MzkK5pS25Lu25Lq6OiBhbm9u
eW1vdXM0ZmVlZGJhY2tAb3V0bG9vay5jb20gPGFub255bW91czRmZWVkYmFja0BvdXRsb29rLmNv
bT4K5oqE6YCBOiBkYXNoQHZnZXIua2VybmVsLm9yZyA8ZGFzaEB2Z2VyLmtlcm5lbC5vcmc+CuS4
u+mimDogUmU6IEJ1ZyBpbiBkYXNoOiBJbmNvcnJlY3QgYmVoYXZpb3VyIG9mICRMSU5FTk8gaW4g
ZnVuY3Rpb24gCsKgCmhlbGxvLAoKPiBJdCBzZWVtcyBkYXNoIHN0b3JlcyB0aGUgbGluZSBudW1i
ZXIgb2YgdGhlIHBhcmFtZXRlciBzdWJzdGl0dXRpb24gYW5kIHRoZSBsaW5lIG51bWJlciBvZiB0
aGUgZnVuY3Rpb24gZGVmaW5pdGlvbgoKd2hpY2ggaXMgd2hhdCB3ZSBleHBlY3QgZnJvbSBhIHZh
cmlhYmxlIGV4cGFuc2lvbi4gd2hhdCB5b3UgbmVlZCBoZXJlCmlzIGFuIGFsaWFzIGJlY2F1c2Ug
aXQgd29ya3MgbGlrZSBhIG1pbmltYWwgYnV0IGR5bmFtaWMgcHJlcHJvY2Vzc29yCgp0aG9zZSBh
cmUgdGhlIHRyaWNrcyBhYm91dCBhbGlhc2VzOgoKKiB0aGV5IHJlYWxseSBhY3QgYXMgYSBwcmVw
cm9jZXNzb3Igc28KCsKgwqDCoMKgwqDCoMKgIGFsaWFzIHdhcm49Jz4mMiBlY2hvIGhlcmUgYXQg
JExJTkVOTycKwqDCoMKgwqDCoMKgwqAgZigpIHdhcm4gZmlyc3QKwqDCoMKgwqDCoMKgwqAgYWxp
YXMgd2Fybj0nPiYyIGVjaG8gYW5vdGhlciBtZXNzYWdlIGF0ICRMSU5FTk8nCsKgwqDCoMKgwqDC
oMKgIGcoKSB3YXJuIGxhc3QKwqDCoMKgwqDCoMKgwqAgZjtnCgrCoMKgwqDCoMKgwqDCoCAjIGRv
ZXMKCsKgwqDCoMKgwqDCoMKgIGhlcmUgYXQgMSBmaXJzdArCoMKgwqDCoMKgwqDCoCBhbm90aGVy
IG1lc3NhZ2UgYXQgMSBsYXN0CgoqIGludGVycG9sYXRpb24gY29tZXMgZmlyc3Qgc28gCgrCoMKg
wqDCoMKgwqDCoCBlbnRlcmluZygpIHsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVj
aG8gZW50ZXJpbmcgIiRAIgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiRAIgrCoMKg
wqDCoMKgwqDCoCB9CsKgwqDCoMKgwqDCoMKgIGYoKSBlY2hvIGRvaW5nIHRoaW5ncyBpbiBmdW5j
dGlvbnMKwqDCoMKgwqDCoMKgwqAgYWxpYXMgZGFtbj0nZWNobyBvb3BzIC4uLicKwqDCoMKgwqDC
oMKgwqAgZW50ZXJpbmcgZgrCoMKgwqDCoMKgwqDCoCBlbnRlcmluZyBkYW1uCgrCoMKgwqDCoMKg
wqDCoCBlbnRlcmluZyBmCsKgwqDCoMKgwqDCoMKgIGRvaW5nIHRoaW5ncyBpbiBmdW5jdGlvbnMK
wqDCoMKgwqDCoMKgwqAgZW50ZXJpbmcgZGFtbgrCoMKgwqDCoMKgwqDCoCAvaG9tZS9tYy9zcmMv
dmVuZG9yL2Rhc2gvc3JjL2Rhc2g6IDM6IGRhbW46IG5vdCBmb3VuZAoKY29uY2x1c2lvbjoKCiog
dXNlIGZ1bmN0aW9ucyBhcyBsb25nIGFzIHlvdSBjYW4KKiBpbiB0aGlzIGNhc2UsIHlvdSBjYW4n
dC4geW91ciBzb2x1dGlvbiBpcwoKwqDCoMKgwqDCoMKgwqAgYWxpYXMgd2Fybj0nPiYyIGVjaG8g
aGVyZSBhdCAkTElORU5PJwoKSFRILApNYXJjIENoYW50cmV1eA==
