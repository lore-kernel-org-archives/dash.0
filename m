Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazolkn19010003.outbound.protection.outlook.com [52.103.38.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5131A9B3E
	for <dash@vger.kernel.org>; Sat,  5 Apr 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.38.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743890727; cv=fail; b=h52cfTE0YkkgvsTjDYDZ5gPhrDeQzgZMC3Io4dWYx3Y/pyhxrxiDi30/1hGa8+hbGONDzsSD1P2dkh/4YE1aTqN5QBMZFS2g/B11AQXLr66Nk2PaPjoiWSQyUgUHcWtPWDjmIwZnq6pl1fWpBsU2xCSzGa7deER/wBbsxgrWUXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743890727; c=relaxed/simple;
	bh=dqo6zw49DLbuw/Lv5bzLXe2OXRROjrsEIsAcm3JdXrw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X74JSo6dmkISw6xGUwxaX6rsXPZcB3Y79asOlQ34hfndxOA62jgfg1zEDUi8a6Zk44xSk9FRpzyCC4ZnNf8Ph/VvXe3wYqng18DRmHQeoOGRYLn2NEwTAH1G4elMuRc0ATwAN6SGvVXZ3RuhHrkPeC/woO9exzeqmFHtuNIpdKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oupakTQz; arc=fail smtp.client-ip=52.103.38.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oupakTQz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUCP/NSuIiE2iguM9BmPY4IveVqBL3Mwrt9MjFz5cja02AWmKoDDaKI+D3l8MzpKT1IYnr5lFdn0bJIcMvcjm3lx3vh4w/82+IgIlQNTrYi9DCtRnBxIWhctJELHfAX+bmvBTRV4YZX98oqq0hsRE/1r1KwJ+exwCpXaOTS41KzXGEXIbPtXfkNslNOp4HWyTONpFOcrTcvVQGfrV0nFrue3EtbOayoQaRVXBpp7vPpizgiqEpkO6NBudRC5ITgIuIQQwy7nKcEb6byI0tz0OP7mBGdYPYafMXN4KL66odueVldUSikLYJO+UuWvRyFRDWUCin3R3WAxPtkIpodYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqo6zw49DLbuw/Lv5bzLXe2OXRROjrsEIsAcm3JdXrw=;
 b=LWHQbzyi0fX0pKqwhj8OCvAcnAmZezJYRyOtss5oUxI7eH9TXf53XULx6dBWyZTW74vbUsZG/3Gp1rcfqy1JxUp4bgJUZqOrubyjKikc1au5m25RWu0EbJhT3rAXyAyRYIR4uRF3xP2KVBvB12Lmk8yih+8N86OXLQXZ6VfOyBO1D9oa/9OxvWSsnl04oWhqwWymLFqkRmPDR7KxcGy1YMvLciM2FOsocym0zd260mvZKq6X6kG2VvaDOKRd2rbDoH/eLPnL+HqdLWpjTLvILZRvlEp0JC4Ag699zUSOuF5gEPqOWrh3E8JORCtTVNCmosPV6YYmuOPsKA6eOONrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqo6zw49DLbuw/Lv5bzLXe2OXRROjrsEIsAcm3JdXrw=;
 b=oupakTQzNDEx6rMTOgPMgstjdoOvFPdj26KJM//lK90qGsSYnUoFQ6CQM2skdxYTPMkbNAS7ddmwaMBRkm6t0aQzYhpmyyp6Jw2wpH0ciyDSOXnSwnLj0Ho/7TGTz7Ol97j8xoTTkWw81Y5p35fVLY/nghkh0p4TkJxMIbVWd1WKmT3CoDyLGye0n6AK9jXgzoc2twTanmKV+1/HNOmdEK3eBiYA8Cmge+pB5Q0Zvt0eA9Ye5XJmC0HTDa2BAu3oXI16SwGDP+rXM8fqXg54HlTdjy7DpIKKpk3lI9gTzwmO1u8XtWk8F1JbnGbwXu30ieskeUCIXfZSiNFLIN6Ujw==
Received: from CWLP265MB4157.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:12c::9)
 by CWLP265MB6468.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.11; Sat, 5 Apr
 2025 22:05:21 +0000
Received: from CWLP265MB4157.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4f37:8f32:e4a6:e624]) by CWLP265MB4157.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4f37:8f32:e4a6:e624%7]) with mapi id 15.20.8632.016; Sat, 5 Apr 2025
 22:05:21 +0000
From: Kate Deplaix <kit-ty-kate@outlook.com>
To: "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: [BUG] dash -c 'echo test > "${1%.in}"' sh /tmp/META.in segfaults on
 master
Thread-Topic: [BUG] dash -c 'echo test > "${1%.in}"' sh /tmp/META.in segfaults
 on master
Thread-Index: AQHbpnR4c4ujNLPKWkqmgFFdx9SJ9Q==
Date: Sat, 5 Apr 2025 22:05:21 +0000
Message-ID:
 <CWLP265MB4157446AD56C013BB88575CFBCA82@CWLP265MB4157.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB4157:EE_|CWLP265MB6468:EE_
x-ms-office365-filtering-correlation-id: 35c7f392-b81f-4598-d88c-08dd748df55f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15030799003|8062599003|8060799006|15080799006|461199028|440099028|3412199025|26104999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4Fc6yxT3edZ+urMApi9wcByY9MfOhsZIxLeAxsUMCyQ1522/9k6sgrd1wE?=
 =?iso-8859-1?Q?3/Da+UxK78gp/G41PlvPJ9VNwiLI/Z+rCtqAWODAAi1R56bqpUKD0zJ5AC?=
 =?iso-8859-1?Q?ychP5v+u93M1okh/cH2Ez7GmnSSG53wLZ9ZQczVEAoebxLTIN61cd6fV9d?=
 =?iso-8859-1?Q?p+OSNzsYJBQpy9Evrs8eXVbhYqJWcIjyLzPjfizcMd6SinYCQoe3UZPYj9?=
 =?iso-8859-1?Q?bBpwhnNP4DDK0V30DkHfMkADjpO5h2EKs+SWFb6Hp04YBCfIIIkflzpCuK?=
 =?iso-8859-1?Q?JAIQf7qREywtfxHW30DdVn4EzvkxJgfTx9MR/Eno7OVTfQB4nePr5pFY7P?=
 =?iso-8859-1?Q?BhE7lWWQiCMXR8SmS9+Oeeed+ukIHUPT9NLj1fXjTdek34oJPwcbtnWhqm?=
 =?iso-8859-1?Q?t+W9VYfVVaJgLmBCSslsN6N6JHTKtDPxZNLWurnIGjrtCj6DoM2QvlNhvn?=
 =?iso-8859-1?Q?wc7jb9Nx92vJD0Bt9Hi/a/KkY9fLb3vC+2VO9qasZ4EEkG0BrvCyV5sdpB?=
 =?iso-8859-1?Q?2vee8NKunbG9tpxcvU1v8C81Uv4fQm7mMb+szz1UrSo0sy7ikZnAjpsW0q?=
 =?iso-8859-1?Q?rRAQqB1AVCW6Sd9yK0Ro9Pn8WGUjWgqIKa+PYucu80PwKIeAXL36Iw+3PN?=
 =?iso-8859-1?Q?vDp4uWexDSRwfF02UAjWQyLz4azv6jogRMkLRzfOsW3WX5ywi+gUT5HJw/?=
 =?iso-8859-1?Q?rLmPlWFVqiUT/vZjthv8G+k/QYD8cbZ39WL1UiXp10SKbFTukGSqS3fPoj?=
 =?iso-8859-1?Q?vggDuPGTkjvZ6iA4s5SjhJJlxpfRa+mmPbFT2C8INSUz9Ma3SNzkkm2QLC?=
 =?iso-8859-1?Q?da0tcM1a6KpG1QrAM2aHKhmHrZinA9VLaeDpdbX47W+4LXZDkOG3CLx/s4?=
 =?iso-8859-1?Q?Y9v1elAemEPkKVBFqFRTogAlCzkZyDGr2nQZCc2JG7mvz3Xm6SxcUNFPG/?=
 =?iso-8859-1?Q?W3aBsVcf7+O2fLdOl2T9egSPvZIjakSpKbxp9yYmqy1h5oDu001O2P5etY?=
 =?iso-8859-1?Q?680/OPcezz9jcdQp4kpqYZa0vHdh65Tkqiq7SxsDc8FHqKi2xX3RiP+6Uk?=
 =?iso-8859-1?Q?7P7wHd/0Mqa63NAICcJQca/aPciNwFBtHSx6Lt4iMkmstnJdww2tIsMoWl?=
 =?iso-8859-1?Q?tGqGTZ1nH6RHIcekTo/XNg9AWAxdss96dFJDN1Hl5/GAByDevsqOhYoX6E?=
 =?iso-8859-1?Q?SidLj6SswAA9Lw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LJRhruzdMyDgp6ArbpEJHDbPBTwEkRIkqy09qryu+Dgx1V1yt4H7c5+B2g?=
 =?iso-8859-1?Q?qo4q128Ff9VI1Xs8XJQVEMelBoRNqDrj/fDJEOe4aahT4oJ4AO7oLKjw0/?=
 =?iso-8859-1?Q?kDoQ96ZQNg7aNAP5NcfDb+Bshs8ZhxYBFCG1JdqXkoflV0EYZRvKpclyLy?=
 =?iso-8859-1?Q?Lz2jStwXMLSJKjCH4ghOdOhMF2knilI3ULJnD+mdnjGbLQjwUJx+/2Em0n?=
 =?iso-8859-1?Q?QSdUo/Bz60cWTkzYRRb576K60XqFIHHxT3QCB4v6SglhG9aY4Mbgs1s9IU?=
 =?iso-8859-1?Q?67816TKjA9+dy2MIy1tILLVoZHIi5hUSxpc9pQqQQaMbPE7epyZknzdYA7?=
 =?iso-8859-1?Q?SMaAv2A9ncsZoUczvG5GVYcZNfgoZDEaAtxF/i0Rs8AOoa7Obq7dXyC7UY?=
 =?iso-8859-1?Q?2gzX7vBuHTvW0KWbiezPDvowZqaQJBTwqV+kjI0paqI6By41D3B8A5Vs4q?=
 =?iso-8859-1?Q?/yNeTzjzkXbnuvqyzXCCmzKDm9EESfpK50ve2SknRjFivtTaQIjVWKxifa?=
 =?iso-8859-1?Q?r1IAaPunjUwNsKVl4ZNGRYKHGw0Mm8W+injgux7x/cHKV26aOalHRy0HuX?=
 =?iso-8859-1?Q?28cu+kMMXCgTQt6u1V6k7uRr05z8O4zf1bE3I6yrDVKkXGncp1sCXn3hx/?=
 =?iso-8859-1?Q?8UPiKydPz7wTZpjhpT5vWKGM7QaQzYC1Z2YLJ5okZEQzXeVtOwaLT93lDn?=
 =?iso-8859-1?Q?mEcG4PtP9gglwHDp9l+kDhREOmbSDwjDiYc9Icskx1Fg6kXOLEAJwHYk9t?=
 =?iso-8859-1?Q?PgM62Twbyx5O3kmHJNF2DKy9LJGPQ01U17PcnG6gWdQxmIMW80aR9rgDeS?=
 =?iso-8859-1?Q?aYHpHLEIam+racImMeLsxU7UcieVtkp4C1ICWUoTKxZd8jDJ45KbuTv0Yx?=
 =?iso-8859-1?Q?o7xy9q/pdhPnoDq0UvyU8qd2uftU/HBCfSYtrzbXYrHJcnRTuwi87UMAEK?=
 =?iso-8859-1?Q?9Z5Cx2FahMmL2DagEOzAx2YPPeOjkTSpuh/gw5Nb1UkGt/A1hpJUD6tR2S?=
 =?iso-8859-1?Q?PDRk7yxwsW7ISyTNdaqH5l6VODah9q+DGiTXb8Rh66Q9kYHeL0xJ6Fo2aQ?=
 =?iso-8859-1?Q?Le2BzOWQ/N8FZ85XUI4OKIfnls5eylNR07d+OE2OQmPcPVva+n1KJI0ecF?=
 =?iso-8859-1?Q?EPeJYOggHdiC10DKGpl75DINFCmCKWb3fhIrd5mIw/DbXBcKMlhO97ScZB?=
 =?iso-8859-1?Q?kMxMow8W8rdKrST1P3/oNigTJe3qvhRLYJCCslb26Ar0AP116RsLPfcRsG?=
 =?iso-8859-1?Q?79Wnp1KOs0vcSawl8OyWFC0hlb/daz5o4fpkcL2xFm4bvyX6wCVKgnzV4a?=
 =?iso-8859-1?Q?us+dJsbIjdJXHV8hSLEtVl/lyzeP8hW7xbvuJQZ9kGE1GTo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB4157.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c7f392-b81f-4598-d88c-08dd748df55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2025 22:05:21.2251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6468

Hi,=0A=
=0A=
using dash master (currently b3e38adf6718801e7f06267b438c45caec9523bb), the=
 following test case:=0A=
=0A=
$ dash -c 'echo test > "${1%.in}"' sh /tmp/META.in=0A=
=0A=
segfaults.=0A=
=0A=
Launching it in a quick gdb, it appears that the segfault occurs in subeval=
var (src/expand.c line 768).=0A=
=0A=
This behaviour is consistently reproducible on different hardware owned by =
different people. The segfault disappears if the string doesn't contain any=
 slashes (e.g. dash -c 'echo test > "${1%.in}"' sh META.in works fine).=0A=
=0A=
Cheers,=0A=
Kate Deplaix=
