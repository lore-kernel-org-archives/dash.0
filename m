Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7EDC64E7A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E0C20770
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="FFSMJ3B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLAKOs (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:14:48 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:32918 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbgLAKOs (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 05:14:48 -0500
X-Greylist: delayed 157533 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2020 05:14:47 EST
Received: from [192.168.1.7] (hvdijk.plus.com [81.174.157.28])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C1694137;
        Tue,  1 Dec 2020 11:14:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C1694137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1606817646;
        bh=rHOkYd+H1Io4xrxgfi4UfAezPYvP7WB9VPenl45/8qE=; l=4170;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FFSMJ3B1LCgVAuP6IdK8mWvwjujQ0hAvhgYeFZum9EYKd9Z1+1gsyQci3K9mBtKfk
         dCSof3pcTV5BTjo0usW36AoOIDyYWI3UQdvEzNAdKaeDdOeF87L6gPug2xlC9/ovRn
         ionjMxf/hXzUcDQgxlQcBP2JfF//egMJ1lkvNCnQ=
Subject: Re: Changes to job handling cause hangs in wait
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
Date:   Tue, 1 Dec 2020 10:14:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201060618.GA27281@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

T24gMDEvMTIvMjAyMCAwNjowNiwgSGVyYmVydCBYdSB3cm90ZToNCj4gT24gVHVlLCBEZWMg
MDEsIDIwMjAgYXQgMDQ6NDI6MDNQTSArMTEwMCwgSGVyYmVydCBYdSB3cm90ZToNCj4+DQo+
PiBOZXZlcm1pbmQsIEkgc2VlIHRoYXQgdGhlIHNjcmlwdCBoYXMgYmVlbiBtb2RpZmllZCB0
byB1c2UgYmFzaC4NCj4+DQo+PiBJIGNhbiByZXByb2R1Y2UgdGhlIHByb2JsZW0gbm93IHNv
IGl0J3MgYWxsIGdvb2QuDQo+IA0KPiBPSyB0aGUgcHJvYmxlbSBpcyB0aGlzOg0KPiANCj4g
CXNoIC1jICdzbGVlcCAxZCYgZXhlYyAkTVlTSEVMTCAtYyAic2xlZXAgMSYgd2FpdCInDQo+
IA0KPiBZb3UgY2FuIHJlcGxhY2UgTVlTSEVMTCB3aXRoIHdoYXRldmVyIHNoZWxsIHlvdSB3
YW50IHRvIHVzZS4NCj4gDQo+IEVzc2VudGlhbGx5IGRhc2ggd2lsbCBub3cgd2FpdCBmb3Ig
YWxsIGNoaWxkcmVuLCBldmVuIG9uZXMgdGhhdA0KPiB3ZXJlIGNyZWF0ZWQgcHJpb3IgdG8g
aXRzIGV4aXN0ZW5jZSwgaG93ZXZlciwgYmFzaCBvbmx5IHdhaXRzIGZvcg0KPiBjaGlsZHJl
biB0aGF0IGl0IGNyZWF0ZWQgZGlyZWN0bHkuDQo+IA0KPiBGV0lXIGtzaCBleGhpYml0cyB0
aGUgc2FtZSBiZWhhdmlvdXIgYXMgZGFzaCBhbmQgSSB0aGluayB0aGVyZQ0KPiBpcyBub3Ro
aW5nIHdyb25nIHdpdGggdGhpcy4NCg0KUE9TSVggc2F5czoNCg0KICAgIklmICB0aGUgIHdh
aXQgdXRpbGl0eSBpcyBpbnZva2VkIHdpdGggbm8gb3BlcmFuZHMsIGl0IHNoYWxsIHdhaXQg
DQp1bnRpbCBhbGwgcHJvY2VzcyBJRHMga25vd24gdG8gdGhlIGludm9raW5nIHNoZWxsIGhh
dmUgdGVybWluYXRlZCBhbmQgDQpleGl0IHdpdGggYSB6ZXJvIGV4aXQgc3RhdHVzLiINCg0K
SSB3b3VsZCBzYXkgdGhhdCBjaGlsZCBwcm9jZXNzZXMgdGhhdCB3ZXJlIGNyZWF0ZWQgYmVm
b3JlIGRhc2ggd2FzIA0Kc3RhcnRlZCBkbyBub3QgaGF2ZSBwcm9jZXNzIElEcyBrbm93biB0
byBkYXNoLg0KDQo+IFNvIHRoZSBwcm9ibGVtIGlzIHJlYWxseSBpbiB0aGUgcGFyZW50IG9m
IHRoaXMgc2hlbGwsIHdoaWNoIGFwcGVhcnMNCj4gdG8gYmUgYmFzaDoNCj4gDQo+IGJhc2gg
LWMgc2V0IC1lOyBleHBvcnQgVVNFUj1gaWQgLW51YDsgLiAvZXRjL3Byb2ZpbGUgPi9kZXYv
bnVsbCAyPiYxIHx8IHRydWU7ICAuIH4vLnByb2ZpbGUgPi9kZXYvbnVsbCAyPiYxIHx8IHRy
dWU7IGJ1aWxkdHJlZT0iL3RtcC9hdXRvcGtndGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC9i
dWlsZC5mMkcvcmVhbC10cmVlIjsgbWtkaXIgLXAgLW0gMTc3NyAtLSAiL3RtcC9hdXRvcGtn
dGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC90aW1lZGF0ZWQtYXJ0aWZhY3RzIjsgZXhwb3J0
IEFVVE9QS0dURVNUX0FSVElGQUNUUz0iL3RtcC9hdXRvcGtndGVzdC1seGMuaXM0bjZ4eHIv
ZG93bnRtcC90aW1lZGF0ZWQtYXJ0aWZhY3RzIjsgZXhwb3J0IEFEVF9BUlRJRkFDVFM9IiRB
VVRPUEtHVEVTVF9BUlRJRkFDVFMiOyBta2RpciAtcCAtbSA3NTUgIi90bXAvYXV0b3BrZ3Rl
c3QtbHhjLmlzNG42eHhyL2Rvd250bXAvYXV0b3BrZ3Rlc3RfdG1wIjsgZXhwb3J0IEFVVE9Q
S0dURVNUX1RNUD0iL3RtcC9hdXRvcGtndGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC9hdXRv
cGtndGVzdF90bXAiOyBleHBvcnQgQURUVE1QPSIkQVVUT1BLR1RFU1RfVE1QIjsgZXhwb3J0
IERFQklBTl9GUk9OVEVORD1ub25pbnRlcmFjdGl2ZTsgZXhwb3J0IExBTkc9Qy5VVEYtODsg
ZXhwb3J0IERFQl9CVUlMRF9PUFRJT05TPXBhcmFsbGVsPTI7IHVuc2V0IExBTkdVQUdFIExD
X0NUWVBFIExDX05VTUVSSUMgTENfVElNRSBMQ19DT0xMQVRFICAgTENfTU9ORVRBUlkgTENf
TUVTU0FHRVMgTENfUEFQRVIgTENfTkFNRSBMQ19BRERSRVNTICAgTENfVEVMRVBIT05FIExD
X01FQVNVUkVNRU5UIExDX0lERU5USUZJQ0FUSU9OIExDX0FMTDtybSAtZiAvdG1wL2F1dG9w
a2d0ZXN0X3NjcmlwdF9waWQ7IHNldCAtQzsgZWNobyAkJCA+IC90bXAvYXV0b3BrZ3Rlc3Rf
c2NyaXB0X3BpZDsgc2V0ICtDOyB0cmFwICJybSAtZiAvdG1wL2F1dG9wa2d0ZXN0X3Njcmlw
dF9waWQiIEVYSVQgSU5UIFFVSVQgUElQRTsgY2QgIiRidWlsZHRyZWUiOyBleHBvcnQgQVVU
T1BLR1RFU1RfTk9STUFMX1VTRVI9OyBleHBvcnQgQURUX05PUk1BTF9VU0VSPTsgY2htb2Qg
K3ggL3RtcC9hdXRvcGtndGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC9idWlsZC5mMkcvcmVh
bC10cmVlL2RlYmlhbi90ZXN0cy90aW1lZGF0ZWQ7IHRvdWNoIC90bXAvYXV0b3BrZ3Rlc3Qt
bHhjLmlzNG42eHhyL2Rvd250bXAvdGltZWRhdGVkLXN0ZG91dCAvdG1wL2F1dG9wa2d0ZXN0
LWx4Yy5pczRuNnh4ci9kb3dudG1wL3RpbWVkYXRlZC1zdGRlcnI7IC90bXAvYXV0b3BrZ3Rl
c3QtbHhjLmlzNG42eHhyL2Rvd250bXAvYnVpbGQuZjJHL3JlYWwtdHJlZS9kZWJpYW4vdGVz
dHMvdGltZWRhdGVkIDI+ID4odGVlIC1hIC90bXAvYXV0b3BrZ3Rlc3QtbHhjLmlzNG42eHhy
L2Rvd250bXAvdGltZWRhdGVkLXN0ZGVyciA+JjIpID4gPih0ZWUgLWEgL3RtcC9hdXRvcGtn
dGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC90aW1lZGF0ZWQtc3Rkb3V0KTsNCj4gDQo+IEZv
ciBzb21lIHJlYXNvbiB0aGlzIGlzIGNhdXNpbmcgdGhlIGZpbmFsIHR3byB0ZWUncyB0byBi
ZSBjcmVhdGVkDQo+IGFzIGNoaWxkcmVuIG9mIGRlYmlhbi90ZXN0cy90aW1lZGF0ZWQgcmF0
aGVyIHRoYW4gdGhlIGJhc2ggc2hlbGwuDQoNClRoaXMgaXMgYmVjYXVzZSBvZiB0aGUgc2Ft
ZSBvcHRpbWlzYXRpb24gdGhhdCBkYXNoIGFsc28gaGFzLCB3aGVyZSBpdCANCnRyaWVzIHRv
IGF2b2lkIGNyZWF0aW5nIGEgc3Vic2hlbGwgZm9yIHRoZSBsYXN0IGNvbW1hbmQgaW4gYSBs
aXN0IHdoZW4gDQppdCBjYW4ganVzdCBleGVjKCkgd2l0aG91dCBhIGZvcmsoKSBpbnN0ZWFk
LiBBIG1pbmltYWwgZXhhbXBsZSB3aXRob3V0IA0KYW4gZXhwbGljaXQgZXhlYyBpcw0KDQog
ICBiYXNoIC1jICdkYXNoIC1jICI6ICYgd2FpdCIgPChzbGVlcCAxZCknDQoNCkNoZWVycywN
CkhhcmFsZCB2YW4gRGlqaw0K
