Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD4FC433ED
	for <linux-dash@archiver.kernel.org>; Thu,  6 May 2021 10:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F9461176
	for <linux-dash@archiver.kernel.org>; Thu,  6 May 2021 10:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhEFKB2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 6 May 2021 06:01:28 -0400
Received: from internet2.beckhoff.com ([194.25.186.210]:59820 "EHLO
        Internet2.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhEFKB2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 6 May 2021 06:01:28 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 06:01:28 EDT
Received: from 172.17.5.173 by Internet2.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey256); Thu, 06 May 2021 09:55:29 GMT
Received: from ex01.beckhoff.com (172.17.2.168) by ex08.beckhoff.com
 (172.17.5.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Thu, 6 May 2021
 11:55:28 +0200
Received: from ex01.beckhoff.com ([fe80::dcc:24dc:453b:42fb]) by
 ex01.beckhoff.com ([fe80::dcc:24dc:453b:42fb%7]) with mapi id 15.01.2242.008;
 Thu, 6 May 2021 11:55:28 +0200
From:   =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: trap overwrites last exit code
Thread-Topic: trap overwrites last exit code
Thread-Index: AQHXQl3xrVEP9CUOL0Sg7PkG0k2ujg==
Date:   Thu, 6 May 2021 09:55:28 +0000
Message-ID: <7ee35167691c1b1e42100f91842f07cbe817b337.camel@beckhoff.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.66.114]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C17A77ED44F484BA61D62B605097427@beckhoff.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

SGVsbG8gbGlzdCwNCg0KU2luY2Ugd2UgYXJlIG1pZ3JhdGluZyB0byBEZWJpYW4gYnVsbHNleWUs
IHdlIGRpc2NvdmVyZWQgYSBuZXcgYmVoYXZpb3INCndpdGggb3VyIHNjcmlwdHMsIHdoaWNoIGxv
b2sgbGlrZSB0aGlzOg0KPiMhL2Jpbi9zaA0KPmNsZWFudXAoKSB7DQo+ICAgICAgICBzZXQgK2UN
Cj4gICAgICAgIHJtZGlyICIiDQo+fQ0KPnNldCAtZXUNCj50cmFwICdjbGVhbnVwJyBFWElUIElO
VCBURVJNDQo+ZWNobyAnSGVsbG8gd29ybGQhJw0KDQpXaXRoIG9sZCBkYXNoIHYwLjUuMTAuMiB0
aGlzIHNjcmlwdCB3b3VsZCByZXR1cm4gMCBhcyB3ZSBleHBlY3RlZCBpdC4NCkJ1dCBzaW5jZSBj
b21taXQgNjJjZjY5NTVmOGFiZTg3NTc1MmQ3MTYzZjZmM2FkYmM3ZTQ5ZWJhZSBpdCByZXR1cm5z
DQp0aGUgbGFzdCBleGl0IGNvZGUgb2Ygb3VyIGNsZWFudXAgZnVuY3Rpb24uDQpSZXZlcnRpbmcg
dGhhdCBjb21taXQgZ2l2ZXMgYSBtZXJnZSBjb25mbGljdCwgYnV0IGl0IHNlZW1zIHRvIGZpeCBf
b3VyXw0KcHJvYmxlbS4gQXMgdGhhdCB0b3BpYyBhcHBlYXJzIHRvbyBjb21wbGV4IHRvIHVzIEkg
d2FudCB0byBhc2sgdGhlDQpleHBlcnRzIGhlcmU6DQoNCklzIHRoaXMgY2hhbmdlIGluIGJlaGF2
aW9yIGludGVuZGVkLCBieSBkYXNoPw0KDQpPdXIgd29ya2Fyb3VuZCBhdCB0aGUgbW9tZW50IHdv
dWxkIGJlOg0KPnRyYXAgJ2NsZWFudXAgfHwgdHJ1ZScgRVhJVCBJTlQgVEVSTQ0KDQpDb21tZW50
cyBvbiBvdXIgdXNhZ2Ugb2YgdHJhcHMgYXJlIHdlbGNvbWUsIHRvby4NCg0KVGhhbmtzIGFuZCBi
ZXN0IHJlZ2FyZHMsDQpQYXRyaWNrDQpCZWNraG9mZiBBdXRvbWF0aW9uIEdtYkggJiBDby4gS0cg
fCBNYW5hZ2luZyBEaXJlY3RvcjogRGlwbC4gUGh5cy4gSGFucyBCZWNraG9mZiBSZWdpc3RlcmVk
IG9mZmljZTogVmVybCwgR2VybWFueSB8IFJlZ2lzdGVyIGNvdXJ0OiBHdWV0ZXJzbG9oIEhSQSA3
MDc1DQoNCg==

