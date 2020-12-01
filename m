Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D822C64E7A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A932120809
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="lL7gJBkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgLAKvC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:51:02 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:33064 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbgLAKvC (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 05:51:02 -0500
Received: from [192.168.1.7] (hvdijk.plus.com [81.174.157.28])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id CD54D739;
        Tue,  1 Dec 2020 11:50:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl CD54D739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1606819820;
        bh=8y5yA8Bh4uHMNqDntDMyapxF20x3EVvPb5CNlvsb3YA=; l=5312;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lL7gJBkEWE5/hKHw2DVurA5t34b23AFdlTB1/LnhDHuPTrD3snHWRygfuNT9L/By4
         MGIbGPHqR6U4uJkgprcFtYy9qp6eo12lc1JkPAo6v12n5rfHKBE3VaioKaTXb1dQqX
         Ru+v3bKL5kioTvrYIhWWgLsC4hNQljjcRNQ/B/Kg=
Subject: Re: Changes to job handling cause hangs in wait
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
 <20201201103448.GA28234@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <861e7a14-3dfc-83f7-8872-714b333d4246@gigawatt.nl>
Date:   Tue, 1 Dec 2020 10:50:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201103448.GA28234@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

T24gMDEvMTIvMjAyMCAxMDozNCwgSGVyYmVydCBYdSB3cm90ZToNCj4gT24gVHVlLCBEZWMg
MDEsIDIwMjAgYXQgMTA6MTQ6MDRBTSArMDAwMCwgSGFyYWxkIHZhbiBEaWprIHdyb3RlOg0K
Pj4NCj4+IFBPU0lYIHNheXM6DQo+Pg0KPj4gICAgIklmICB0aGUgIHdhaXQgdXRpbGl0eSBp
cyBpbnZva2VkIHdpdGggbm8gb3BlcmFuZHMsIGl0IHNoYWxsIHdhaXQgdW50aWwNCj4+IGFs
bCBwcm9jZXNzIElEcyBrbm93biB0byB0aGUgaW52b2tpbmcgc2hlbGwgaGF2ZSB0ZXJtaW5h
dGVkIGFuZCBleGl0IHdpdGggYQ0KPj4gemVybyBleGl0IHN0YXR1cy4iDQo+Pg0KPj4gSSB3
b3VsZCBzYXkgdGhhdCBjaGlsZCBwcm9jZXNzZXMgdGhhdCB3ZXJlIGNyZWF0ZWQgYmVmb3Jl
IGRhc2ggd2FzIHN0YXJ0ZWQNCj4+IGRvIG5vdCBoYXZlIHByb2Nlc3MgSURzIGtub3duIHRv
IGRhc2guDQo+IA0KPiBXZWxsIEkgZGlzYWdyZWUNCg0KVGhlbiBkYXNoIHN0aWxsIGhhcyBh
IGJ1ZyByZWdhcmRsZXNzOg0KDQogICBiYXNoIC1jICdkYXNoIC1jICJ3YWl0IiA8KHNsZWVw
IDFkKScNCg0KSGVyZSwgZGFzaCBkb2VzIG5vdCB3YWl0IGZvciB0aGUgY2hpbGQgcHJvY2Vz
cy4NCg0KVGhlIHNsZWVwIHByb2Nlc3MgaXMgZWl0aGVyIGtub3duIHRvIGRhc2gsIGluIHdo
aWNoIGNhc2UgZGFzaCBtdXN0IHdhaXQgDQppbiBib3RoIGV4YW1wbGVzLCBvciBub3Qga25v
d24gdG8gZGFzaCwgaW4gd2hpY2ggY2FzZSBkYXNoIG11c3Qgd2FpdCBpbiANCm5laXRoZXIg
ZXhhbXBsZS4NCg0KPiAgICAgICAgICAgICAgICAgYW5kIHRoZSBmYWN0IHRoYXQgdGhlIG9y
aWdpbmFsIGtzaCBkb2VzIHRoZSBzYW1lDQo+IHRoaW5nIGlzIGFuIGltcG9ydGFudCBmYWN0
Lg0KDQpUaGUgb3JpZ2luYWwga3NoIGlzIHdlbGwta25vd24gbm90IHRvIGNvbmZvcm0gdG8g
dGhlIGN1cnJlbnQgUE9TSVggDQpyZXF1aXJlbWVudHMsIGluIHNvbWUgY2FzZXMgYmVjYXVz
ZSBQT1NJWCBjaGFuZ2VkIHJlcXVpcmVtZW50cywgaW4gc29tZSANCmNhc2VzIGJlY2F1c2Ug
a3NoJ3MgYmVoYXZpb3VyIHdhcyBjbGVhcmx5IGJ1Z2d5IGFuZCBub3Qgd29ydGggc3RhbmRh
cmRpc2luZy4NCg0KPj4+IGJhc2ggLWMgc2V0IC1lOyBleHBvcnQgVVNFUj1gaWQgLW51YDsg
LiAvZXRjL3Byb2ZpbGUgPi9kZXYvbnVsbCAyPiYxIHx8IHRydWU7ICAuIH4vLnByb2ZpbGUg
Pi9kZXYvbnVsbCAyPiYxIHx8IHRydWU7IGJ1aWxkdHJlZT0iL3RtcC9hdXRvcGtndGVzdC1s
eGMuaXM0bjZ4eHIvZG93bnRtcC9idWlsZC5mMkcvcmVhbC10cmVlIjsgbWtkaXIgLXAgLW0g
MTc3NyAtLSAiL3RtcC9hdXRvcGtndGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC90aW1lZGF0
ZWQtYXJ0aWZhY3RzIjsgZXhwb3J0IEFVVE9QS0dURVNUX0FSVElGQUNUUz0iL3RtcC9hdXRv
cGtndGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC90aW1lZGF0ZWQtYXJ0aWZhY3RzIjsgZXhw
b3J0IEFEVF9BUlRJRkFDVFM9IiRBVVRPUEtHVEVTVF9BUlRJRkFDVFMiOyBta2RpciAtcCAt
bSA3NTUgIi90bXAvYXV0b3BrZ3Rlc3QtbHhjLmlzNG42eHhyL2Rvd250bXAvYXV0b3BrZ3Rl
c3RfdG1wIjsgZXhwb3J0IEFVVE9QS0dURVNUX1RNUD0iL3RtcC9hdXRvcGtndGVzdC1seGMu
aXM0bjZ4eHIvZG93bnRtcC9hdXRvcGtndGVzdF90bXAiOyBleHBvcnQgQURUVE1QPSIkQVVU
T1BLR1RFU1RfVE1QIjsgZXhwb3J0IERFQklBTl9GUk9OVEVORD1ub25pbnRlcmFjdGl2ZTsg
ZXhwb3J0IExBTkc9Qy5VVEYtODsgZXhwb3J0IERFQl9CVUlMRF9PUFRJT05TPXBhcmFsbGVs
PTI7IHVuc2V0IExBTkdVQUdFIExDX0NUWVBFIExDX05VTUVSSUMgTENfVElNRSBMQ19DT0xM
QVRFICAgTENfTU9ORVRBUlkgTENfTUVTU0FHRVMgTENfUEFQRVIgTENfTkFNRSBMQ19BRERS
RVNTICAgTENfVEVMRVBIT05FIExDX01FQVNVUkVNRU5UIExDX0lERU5USUZJQ0FUSU9OIExD
X0FMTDtybSAtZiAvdG1wL2F1dG9wa2d0ZXN0X3NjcmlwdF9waWQ7IHNldCAtQzsgZWNobyAk
JCA+IC90bXAvYXV0b3BrZ3Rlc3Rfc2NyaXB0X3BpZDsgc2V0ICtDOyB0cmFwICJybSAtZiAv
dG1wL2F1dG9wa2d0ZXN0X3NjcmlwdF9waWQiIEVYSVQgSU5UIFFVSVQgUElQRTsgY2QgIiRi
dWlsZHRyZWUiOyBleHBvcnQgQVVUT1BLR1RFU1RfTk9STUFMX1VTRVI9OyBleHBvcnQgQURU
X05PUk1BTF9VU0VSPTsgY2htb2QgK3ggL3RtcC9hdXRvcGtndGVzdC1seGMuaXM0bjZ4eHIv
ZG93bnRtcC9idWlsZC5mMkcvcmVhbC10cmVlL2RlYmlhbi90ZXN0cy90aW1lZGF0ZWQ7IHRv
dWNoIC90bXAvYXV0b3BrZ3Rlc3QtbHhjLmlzNG42eHhyL2Rvd250bXAvdGltZWRhdGVkLXN0
ZG91dCAvdG1wL2F1dG9wa2d0ZXN0LWx4Yy5pczRuNnh4ci9kb3dudG1wL3RpbWVkYXRlZC1z
dGRlcnI7IC90bXAvYXV0b3BrZ3Rlc3QtbHhjLmlzNG42eHhyL2Rvd250bXAvYnVpbGQuZjJH
L3JlYWwtdHJlZS9kZWJpYW4vdGVzdHMvdGltZWRhdGVkIDI+ID4odGVlIC1hIC90bXAvYXV0
b3BrZ3Rlc3QtbHhjLmlzNG42eHhyL2Rvd250bXAvdGltZWRhdGVkLXN0ZGVyciA+JjIpID4g
Pih0ZWUgLWEgL3RtcC9hdXRvcGtndGVzdC1seGMuaXM0bjZ4eHIvZG93bnRtcC90aW1lZGF0
ZWQtc3Rkb3V0KTsNCj4+Pg0KPj4+IEZvciBzb21lIHJlYXNvbiB0aGlzIGlzIGNhdXNpbmcg
dGhlIGZpbmFsIHR3byB0ZWUncyB0byBiZSBjcmVhdGVkDQo+Pj4gYXMgY2hpbGRyZW4gb2Yg
ZGViaWFuL3Rlc3RzL3RpbWVkYXRlZCByYXRoZXIgdGhhbiB0aGUgYmFzaCBzaGVsbC4NCj4+
DQo+PiBUaGlzIGlzIGJlY2F1c2Ugb2YgdGhlIHNhbWUgb3B0aW1pc2F0aW9uIHRoYXQgZGFz
aCBhbHNvIGhhcywgd2hlcmUgaXQgdHJpZXMNCj4+IHRvIGF2b2lkIGNyZWF0aW5nIGEgc3Vi
c2hlbGwgZm9yIHRoZSBsYXN0IGNvbW1hbmQgaW4gYSBsaXN0IHdoZW4gaXQgY2FuIGp1c3QN
Cj4+IGV4ZWMoKSB3aXRob3V0IGEgZm9yaygpIGluc3RlYWQuIEEgbWluaW1hbCBleGFtcGxl
IHdpdGhvdXQgYW4gZXhwbGljaXQgZXhlYw0KPj4gaXMNCj4+DQo+PiAgICBiYXNoIC1jICdk
YXNoIC1jICI6ICYgd2FpdCIgPChzbGVlcCAxZCknDQo+IA0KPiBJJ20gbm90IHN1cmUgYWJv
dXQgdGhhdCBiZWNhdXNlIGJhc2ggaXRzZWxmIGlzIHN0aWxsIGhhbmdpbmcgYXJvdW5kLA0K
PiBpZiBpdCB3ZXJlIHJlYWxseSB0aGUgLWMgb3B0aW1pc2F0aW9uIHRoZW4gYmFzaCBzaG91
bGQgbm90IGFwcGVhciBpbg0KPiB0aGUgcHMgb3V0cHV0IGF0IGFsbC4NCg0KR29vZCBwb2lu
dCwgaXQncyBhIGJpdCBtb3JlIGNvbXBsaWNhdGVkLiBDYW4gdGFrZSBhIG1vcmUgaW4tZGVw
dGggbG9vayANCmF0IHRoYXQgZXhhbXBsZSBsYXRlci4NCg0KSGVyZSdzIGEgc2ltcGxlciBl
eGFtcGxlIHdpdGhvdXQgYmFzaCBhdCBhbGwsIHRoZW4sIHdoZXJlIGl0IGlzIGZhciANCmNs
ZWFyZXIgdGhhdCB0aGUgLWMgb3B0aW1pc2F0aW9uIGlzIHJlc3BvbnNpYmxlOg0KDQogICBk
YXNoIC1jICdzbGVlcCAxZCAmIGRhc2ggLWMgIjogJiB3YWl0IicNCg0KVGhpcyB1c2VkIHRv
IGV4aXQgaW1tZWRpYXRlbHksIGxlYXZpbmcgdGhlIHNsZWVwIHByb2Nlc3MgcnVubmluZyBp
biB0aGUgDQpiYWNrZ3JvdW5kIHdpdGhvdXQgd2FpdGluZyBmb3IgaXQuIE9uIHRoZSBkYXNo
IHRoYXQncyBjdXJyZW50bHkgcHJvdmlkZWQgDQpieSBVYnVudHUsIGJhc2VkIG9uIDAuNS4x
MC4yLCBpdCBzdGlsbCBiZWhhdmVzIHRoYXQgd2F5LiBXaXRoIGN1cnJlbnQgDQpkYXNoIGZy
b20gR2l0LCBpdCBkb2VzIG5vdC4gVGhpcyBpcyBjbGVhcmx5IGEgY2hhbmdlIGluIGJlaGF2
aW91ciBpbiANCmRhc2ggbm90IGluIHJlc3BvbnNlIHRvIGFueSBidWcgKHJlYWwgb3Igbm90
KSBpbiBiYXNoLg0KDQpDaGVlcnMsDQpIYXJhbGQgdmFuIERpamsNCg==
