Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E45BC433B4
	for <linux-dash@archiver.kernel.org>; Wed, 19 May 2021 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2866109F
	for <linux-dash@archiver.kernel.org>; Wed, 19 May 2021 08:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhESIYi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 19 May 2021 04:24:38 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10]:54098 "EHLO
        netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhESIYh (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 19 May 2021 04:24:37 -0400
X-Greylist: delayed 896 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 04:24:37 EDT
Received: from 172.17.5.173 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey256); Wed, 19 May 2021 08:08:17 GMT
Received: from ex01.beckhoff.com (172.17.2.168) by ex08.beckhoff.com
 (172.17.5.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Wed, 19 May
 2021 10:08:16 +0200
Received: from ex01.beckhoff.com ([fe80::dcc:24dc:453b:42fb]) by
 ex01.beckhoff.com ([fe80::dcc:24dc:453b:42fb%7]) with mapi id 15.01.2242.008;
 Wed, 19 May 2021 10:08:16 +0200
From:   =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: eval: Do not cache value of eflag in evaltree
Thread-Topic: eval: Do not cache value of eflag in evaltree
Thread-Index: AQHXSuz7gj+orzzLD0CcMKDrhDiAGarqVNuA
Date:   Wed, 19 May 2021 08:08:16 +0000
Message-ID: <b2f9eabc5850a26df6efae657043c0565d46c63e.camel@beckhoff.com>
References: <20210517071923.vv3qfm23mven7je3@gondor.apana.org.au>
In-Reply-To: <20210517071923.vv3qfm23mven7je3@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.204.43]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F50503882274640B00DFA74848D0055@beckhoff.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

T24gTW9uLCAyMDIxLTA1LTE3IGF0IDE1OjE5ICswODAwLCBIZXJiZXJ0IFh1IHdyb3RlOg0KPiBQ
YXRyaWNrIEJyw7xubiA8UC5CcnVlbm5AYmVja2hvZmYuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNp
bmNlIHdlIGFyZSBtaWdyYXRpbmcgdG8gRGViaWFuIGJ1bGxzZXllLCB3ZSBkaXNjb3ZlcmVkIGEg
bmV3IGJlaGF2aW9yDQo+ID4gd2l0aCBvdXIgc2NyaXB0cywgd2hpY2ggbG9vayBsaWtlIHRoaXM6
DQo+ID4gPiAjIS9iaW4vc2gNCj4gPiA+IGNsZWFudXAoKSB7DQo+ID4gPiAgICAgICAgc2V0ICtl
Xk0NCj4gPiA+ICAgICAgICBybWRpciAiIg0KPiA+ID4gfQ0KPiA+ID4gc2V0IC1ldQ0KPiA+ID4g
dHJhcCAnY2xlYW51cCcgRVhJVCBJTlQgVEVSTQ0KPiA+ID4gZWNobyAnSGVsbG8gd29ybGQhJw0K
PiA+DQo+ID4gV2l0aCBvbGQgZGFzaCB2MC41LjEwLjIgdGhpcyBzY3JpcHQgd291bGQgcmV0dXJu
IDAgYXMgd2UgZXhwZWN0ZWQgaXQuDQo+ID4gQnV0IHNpbmNlIGNvbW1pdCA2MmNmNjk1NWY4YWJl
ODc1NzUyZDcxNjNmNmYzYWRiYzdlNDllYmFlIGl0IHJldHVybnMNCj4gPiB0aGUgbGFzdCBleGl0
IGNvZGUgb2Ygb3VyIGNsZWFudXAgZnVuY3Rpb24uDQo+ID4gUmV2ZXJ0aW5nIHRoYXQgY29tbWl0
IGdpdmVzIGEgbWVyZ2UgY29uZmxpY3QsIGJ1dCBpdCBzZWVtcyB0byBmaXggX291cl8NCj4gPiBw
cm9ibGVtLiBBcyB0aGF0IHRvcGljIGFwcGVhcnMgdG9vIGNvbXBsZXggdG8gdXMgSSB3YW50IHRv
IGFzayB0aGUNCj4gPiBleHBlcnRzIGhlcmU6DQo+ID4NCj4gPiBJcyB0aGlzIGNoYW5nZSBpbiBi
ZWhhdmlvciBpbnRlbmRlZCwgYnkgZGFzaD8NCj4gPg0KPiA+IE91ciB3b3JrYXJvdW5kIGF0IHRo
ZSBtb21lbnQgd291bGQgYmU6DQo+ID4gPiB0cmFwICdjbGVhbnVwIHx8IHRydWUnIEVYSVQgSU5U
IFRFUk0NCj4NCj4gVGhhbmtzIGZvciB0aGUgcmVwb3J0LiAgVGhpcyBpcyBhY3R1YWxseSBhIGZh
aXJseSBvbGQgYnVnIHdpdGgNCj4gc2V0IC1lIHRoYXQncyBqdXN0IGJlZW4gZXhwb3NlZCBieSB0
aGUgZXhpdCBzdGF0dXMgY2hhbmdlLiAgV2hhdCdzDQo+IHJlYWxseSBoYXBwZW5pbmcgaXMgdGhh
dCBjbGVhbnVwIGl0c2VsZiBpcyB0cmlnZ2VyaW5nIGEgc2V0IC1lDQo+IGV4aXQgaW5jb3JyZWN0
bHkgYmVjYXVzZSBldmFsdHJlZSBjYWNoZWQgdGhlIHZhbHVlIG9mIGVmbGFnIHByaW9yDQo+IHRv
IHRoZSBmdW5jdGlvbiBjYWxsLg0KPg0KPiBUaGlzIHBhdGNoIHNob3VsZCBmaXggdGhlIHByb2Js
ZW0uDQo+DQo+IFJlcG9ydGVkLWJ5OiBQYXRyaWNrIEJyw7xubiA8UC5CcnVlbm5AYmVja2hvZmYu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5v
cmcuYXU+DQo+DQo+IGRpZmYgLS1naXQgYS9zcmMvZXZhbC5jIGIvc3JjL2V2YWwuYw0KPiBpbmRl
eCA5NDc2ZmJiLi4zMzM3ZjcxIDEwMDY0NA0KPiAtLS0gYS9zcmMvZXZhbC5jDQo+ICsrKyBiL3Ny
Yy9ldmFsLmMNCj4gQEAgLTI1MiwxOCArMjUyLDEwIEBAIGV2YWx0cmVlKHVuaW9uIG5vZGUgKm4s
IGludCBmbGFncykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcG9wcmVkaXIoMCk7DQo+ICAg
ICAgICAgICAgICAgICBnb3RvIHNldHN0YXR1czsNCj4gICAgICAgICBjYXNlIE5DTUQ6DQo+IC0j
aWZkZWYgbm90eWV0DQo+IC0gICAgICAgICAgICAgICBpZiAoZWZsYWcgJiYgIShmbGFncyAmIEVW
X1RFU1RFRCkpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGNoZWNrZXhpdCA9IH4wOw0KPiAt
ICAgICAgICAgICAgICAgc3RhdHVzID0gZXZhbGNvbW1hbmQobiwgZmxhZ3MsIChzdHJ1Y3QgYmFj
a2NtZCAqKU5VTEwpOw0KPiAtICAgICAgICAgICAgICAgZ290byBzZXRzdGF0dXM7DQo+IC0jZWxz
ZQ0KPiAgICAgICAgICAgICAgICAgZXZhbGZuID0gZXZhbGNvbW1hbmQ7DQo+ICBjaGVja2V4aXQ6
DQo+IC0gICAgICAgICAgICAgICBpZiAoZWZsYWcgJiYgIShmbGFncyAmIEVWX1RFU1RFRCkpDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIGNoZWNrZXhpdCA9IH4wOw0KPiArICAgICAgICAgICAg
ICAgY2hlY2tleGl0ID0gfmZsYWdzICYgRVZfVEVTVEVEOw0KPiAgICAgICAgICAgICAgICAgZ290
byBjYWxsZXZhbDsNCj4gLSNlbmRpZg0KPiAgICAgICAgIGNhc2UgTkZPUjoNCj4gICAgICAgICAg
ICAgICAgIGV2YWxmbiA9IGV2YWxmb3I7DQo+ICAgICAgICAgICAgICAgICBnb3RvIGNhbGxldmFs
Ow0KPiBAQCAtMzIzLDcgKzMxNSw3IEBAIHNldHN0YXR1czoNCj4gIG91dDoNCj4gICAgICAgICBk
b3RyYXAoKTsNCj4NCj4gLSAgICAgICBpZiAoY2hlY2tleGl0ICYgc3RhdHVzKQ0KPiArICAgICAg
IGlmIChlZmxhZyAmJiBjaGVja2V4aXQgJiYgc3RhdHVzKQ0KPiAgICAgICAgICAgICAgICAgZ290
byBleGV4aXQ7DQo+DQo+ICAgICAgICAgaWYgKGZsYWdzICYgRVZfRVhJVCkgew0KPiAtLQ0KV29y
a2luZyBmb3IgdXMsIHRoYW5rcyENClRlc3RlZC1ieTogUGF0cmljayBCcsO8bm4gPFAuQnJ1ZW5u
QGJlY2tob2ZmLmNvbT4NCkJlY2tob2ZmIEF1dG9tYXRpb24gR21iSCAmIENvLiBLRyB8IE1hbmFn
aW5nIERpcmVjdG9yOiBEaXBsLiBQaHlzLiBIYW5zIEJlY2tob2ZmIFJlZ2lzdGVyZWQgb2ZmaWNl
OiBWZXJsLCBHZXJtYW55IHwgUmVnaXN0ZXIgY291cnQ6IEd1ZXRlcnNsb2ggSFJBIDcwNzUNCg0K

