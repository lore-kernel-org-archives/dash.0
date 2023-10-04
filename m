Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B26E7C4F0
	for <linux-dash@archiver.kernel.org>; Wed,  4 Oct 2023 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjJDTpl (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjJDTpk (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Oct 2023 15:45:40 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BDBD8
        for <dash@vger.kernel.org>; Wed,  4 Oct 2023 12:45:36 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 394JC2a4024532
        for <dash@vger.kernel.org>; Wed, 4 Oct 2023 12:45:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=fymBQ9Y1svKATHgccQ2eTrfv2HfrSGQFTbezmFXJGEM=; b=
        fxNHBZETbAJSu2tUgGIMC0tzcN3FxEw7B8HKQ1vyP2t5WEbbM4TIJbWKlHaZXt/q
        n2cT2mI+hLMBVWmPIlbcdIPqY8hmv6+/O9aTYe2tywTQmZo0MVvCaZFY4JlEWxPH
        yFc+tlcXrIHu1JCOTV1AOWfgIn3VSjf/ue1Hp8Pn9SQExFr3ELnWKH5QqtA3nn4h
        TiuPUUpIIgfJ9VErvVKMZ6WPl+XmeGQNGwBX3qQJzM7mQkPoOYCviJU58WSCbvVE
        Ln2/DOqsmTWecz9tTnAigiveAD1CLooDpu/hci3EmUp7DHnGGQbGe+/IsRCOOSJj
        n8EOjDq0hOitTOb2wx9uDg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tek6g40xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <dash@vger.kernel.org>; Wed, 04 Oct 2023 12:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvsSdf8ZYBcPgxFtA618OZGCBhp4EDNtZ4gFPwu1B+L/VNR/1fj+xguvIg5ArN7qZdu6Q5s+y4QE5+AwtbGf4aK3IjmMvmPpPeJEdsmWjhqYxKYBVtqPjl3ZtF3D0rMinwcdCVZj47+PBXd7eWbu3hU1UwSprTqu4fh6gBpgHpesohaZhZpPO/goka9Uhr5As50n9VVM5kOnO0XgFoHNeoBQfc1hxikRIQLgwGR4YQjNRr62RoPUfWKN5aikx/P/JZYLwcSPU5WDEY/mXybDVO6wIRDnJGlT1PzQchEF2ppiZZO9hl7BG2WEG4unR/uMoVtjNuR/KwLgfopVM5GPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fymBQ9Y1svKATHgccQ2eTrfv2HfrSGQFTbezmFXJGEM=;
 b=QQZwQyqSWqHnvH6aYniwzsCQxCibrPDsCVp+TVNl6xoej9sbX6tl4E+XtdyPnBiSKuBRoRtMhMbQxnOc+Ai5b9jsET2kbxK5toZ1Y/bWUEXT5dS1Ri4QNhXQF3tslbmNjpwfCJORbUenTcdra4sJXNMeGoTS9cN9CdFiYlxxfTFrPnZ0xhpY+3W1Ow95flgtOrIHv1WApQYeJxST+y8zT6CmMsTOIfRxuOM72Jj7Eo1Ybcwgt6ggyRYYQT5XKAR+cGSGZm7kZVQsUggUWhQNVwD5GSqc3BlZIq7emZvkyOGp+5KcxzXO6cl8FY3e4yq0VLaEDA9o7kZ+bnWd0nLGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4108.namprd11.prod.outlook.com (2603:10b6:5:197::16)
 by SJ0PR11MB5055.namprd11.prod.outlook.com (2603:10b6:a03:2d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 4 Oct
 2023 19:45:17 +0000
Received: from DM6PR11MB4108.namprd11.prod.outlook.com
 ([fe80::b3:8311:f811:c854]) by DM6PR11MB4108.namprd11.prod.outlook.com
 ([fe80::b3:8311:f811:c854%5]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 19:45:17 +0000
From:   "Kuhl, Brian" <brian.kuhl@windriver.com>
To:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: RE: Signal names when cross-compiling
Thread-Topic: Signal names when cross-compiling
Thread-Index: AQHZ9utsW4dRkBpZVkK4aZYC4+AeXrA6B75A
Date:   Wed, 4 Oct 2023 19:45:17 +0000
Message-ID: <DM6PR11MB410813D5DE3610ABEB73C6F999CBA@DM6PR11MB4108.namprd11.prod.outlook.com>
References: <19502212.sIn9rWBj0N@earendil>
 <20231004174346.gkjIE%steffen@sdaoden.eu>
In-Reply-To: <20231004174346.gkjIE%steffen@sdaoden.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4108:EE_|SJ0PR11MB5055:EE_
x-ms-office365-filtering-correlation-id: 940e11eb-5efd-4168-404f-08dbc5126f63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8LoyDlmeBGzJ3WspIBF2YlO0PcJgYXjizCVLtpEEb/MTltKz/d3Ioe2FRt+51bTSTH9gmQo8vxBe39NzqajNftcAXW5wKv9uA9yt685KUXzHdjjkmAUgDv4Ffy5AZmQyJfUJEnhvBDr2brSwUsDv8vCF6+XvXaIlaPETVgla7qLoHCckYp7/BjrkMIqRaEmoMmbk7ZHtsDcvMcySM/4bLgSkVdzDNOIfPNJVXBah/lduqOJRwKVopqNZfg/xLOZSCQ8s/MVNYZ8xQknLhrRQLqwOpvn1hfzgx49g8NpX4Qzn9OusjJZ8yCyGJO27iJus47POgqitpQI5rAzkCxIJDbKl6CLkcCwyumC0NM9SINrbUTjyAGjam8ec2OL8LxlBnqNP43vfh2E1J8Q1LLji1FZjpVm6HBuh9NtcbseDH1qWYs4nipSTKX4YLfL7ZbMxSK284oZ8v1mbk5NVnlFYzUfOgDex1Z2QbtbnNxBuSRPQVWrOnF+hvaL2yPcs/NJYr3r+tTXPvHZoNnTlD+sHJfcWEFyWQ/UpHrWqmEJ1aMR2aU503HvMuvXlPV4XlqwkVh4vgLZGVssBoFvhu6R3QMNi0PchKIltvhwAbgTqjqltkYZ1RjPGgtfAyxq0we5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4108.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39850400004)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(76116006)(66476007)(52536014)(38100700002)(66946007)(66446008)(5660300002)(66556008)(41300700001)(316002)(8936002)(6916009)(8676002)(64756008)(2906002)(55016003)(122000001)(38070700005)(86362001)(71200400001)(7696005)(53546011)(83380400001)(26005)(9686003)(33656002)(478600001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1+DALfsS4jTA0oQs2uB3krpGeU+22mjconidMZUcwW02/Ga+eycvQ07k9WbR?=
 =?us-ascii?Q?ZMcbwi9CnzwdrwZE1wFBmAe1i7tbbcX08Zht5BXrHxwip1SEbbbbDCrzt+tt?=
 =?us-ascii?Q?D+eOo6n3cE/sxYfT5URBF/jQad6FYTnRNsaHrFZd9+JMf+l0g5toEGA44lCl?=
 =?us-ascii?Q?pAmt4Ewb8cRm7etkfJ0RhCXERVDTmJacB3RPtRpTbtRG71yvdxOs3vwIspVZ?=
 =?us-ascii?Q?QSnY3D9a6e0j4BvigkFfau9neaIrf7IDp9G7o7dsdcHDeeRLeqrysSJyej8c?=
 =?us-ascii?Q?+/7KCtooGhEVUnINoOQkWSx0rx3ORsIvOIjl7dCGKry6Ng881WZ9MvDFXQ+r?=
 =?us-ascii?Q?a4o8MplFvLWnetVCyMukXPmtczEHs+TNtXO1GN39pxT0yTaFYy1rE8VSeber?=
 =?us-ascii?Q?tnybq6c6xCFPYZeZzZEq3ksmaeQ5Gb9hWrkfP3uZ/ispRpwYFffc7iN0i39g?=
 =?us-ascii?Q?OwBkT9JsFAlDouX7Bs5Aw4iZB1loUidzCzcaxvZonPgDnCLhtDJShDJ1pyV0?=
 =?us-ascii?Q?jkthPgiMtqsnY17x3qdCOzvRzNY2/vLU82UA0SpD9VYYLtJjAJYMxZpBYS2d?=
 =?us-ascii?Q?0WGOM9vW0EepUhpWuoC9lFOBF7gGLPMaD/beSp5WD4njLcjEOz89hc6f7PxX?=
 =?us-ascii?Q?5OJkkH08FDb1ioXxtfebKsNlVXm02BjK7b/vmN633WU6q+nSYcSv+H4VY96D?=
 =?us-ascii?Q?uhK0paNOIXTPoRbw93Rgz6TfGF3dxGbEgQ/lTfhcMRqH0zbq8zyyI6wgrPbh?=
 =?us-ascii?Q?KirJxze3p8/py594kPhwf+M8JO/p7vIidFWPV09FmVT3xpCisAPS2Lc1pA/r?=
 =?us-ascii?Q?YQ1H3G6zEYJC3Zb0YufEcLyWmj/uivzxJZV2lnVHarcG36j+QxiYu6IOTdNN?=
 =?us-ascii?Q?dkPU9qgLqjieI0Oq8UnAb9ApgDavDiApw313tp22nBd3CP9AecIxmBuC93Wt?=
 =?us-ascii?Q?K/UI9EercHfLd8cgCojBdOiMgYgUmiYR+oYA01w+zu2kaICze0DaOoldOsZq?=
 =?us-ascii?Q?jN7ZzTWCEJirN9nh4vofA4ezribFzE7Zfbz0xI2ZG9aCTNrTkW3Ze8v6uvqi?=
 =?us-ascii?Q?oiqvCbYGQgKJJnC2aFDIMAVf0/WME+6/eOvi1tZdl4qhAjpLthzv19wCPRiF?=
 =?us-ascii?Q?RtNgD34OijHvxUaRuYMjcCYRVuE0U6REdJWIXZTE3/+tt7uAsQ1Yp379F8pQ?=
 =?us-ascii?Q?/wFdbyr9+zbXRh2QEnpH0f+3dBGZYIhRZhZi9zpFWi7rlVJICU9AmQIciEf6?=
 =?us-ascii?Q?psHzf+FKTBzvdfeazcg8wr9CT40M2JOT3JihMJCgsVfaoILMf4IrwxQskD8S?=
 =?us-ascii?Q?Y4w0uol0ycsCY/vzsBTCZY27Fjp8Btba1PnRi+XRC4Wk/EQdU79wDcXh6LIR?=
 =?us-ascii?Q?INR7n+focAmhRPdAz0rzWG0GrxEWBHU6pd+hMsOOIC9aLUTDBM5aGlWYG3cV?=
 =?us-ascii?Q?KCcnBTSRY9Y8DTjAXpd/+bfKkcvFBXcuOzfHcpg0lt/xnf9n1rMGwwlRESG3?=
 =?us-ascii?Q?W6oZuWzYnT7/qMOi5dPP4kl0gl6losJUeXJfhWLfPqxHk4jYDSISjYXO6WHN?=
 =?us-ascii?Q?HRbwO2JFoNuAh9T8Wd6PQZuwcQEIzsNzBz7pFMij?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4108.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940e11eb-5efd-4168-404f-08dbc5126f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 19:45:17.1303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5x+GmG2O7wOq2yKp1BdNQtKi6Pl5URW97NPg+fLhITEsZRdDt3v/7TzW+F1+cwojnjyTMHZjWFnLARqpl+E74h9fQW+HNluOopGJj1VubVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5055
X-Proofpoint-ORIG-GUID: iK4X7JyyKxyCZTFNsvFXjd4ZSj03u-nM
X-Proofpoint-GUID: iK4X7JyyKxyCZTFNsvFXjd4ZSj03u-nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxlogscore=504 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310040146
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

When cross compiling you need to break the mksignames compilation apart fro=
m the rule that runs it.
You run it against you sysroot for your target arch/platform and it grabs t=
he correct signals from the sysroot instead of the host.

Brian

-----Original Message-----
From: Steffen Nurpmeso <steffen@sdaoden.eu>=20
Sent: Wednesday, October 4, 2023 1:44 PM
To: Thorsten Otto <admin@tho-otto.de>
Cc: dash@vger.kernel.org
Subject: Re: Signal names when cross-compiling

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

Hello.

Thorsten Otto wrote in
 <19502212.sIn9rWBj0N@earendil>:
 |when cross-compiling dash, signames.c is generated by a mksignames \  |th=
at was  |compiled for the host. This will generate wrong signal mappings be=
cause  |obviously this will use the signal numbers of the build system, not=
 the  |target.
 |
 |I currently dont't have no idea how to solve that, other than populating =
\  |the  |signal_names array at runtime rather than compile time.

Actually i have no idea, but i do have a yet unused script for signals name=
s (that mirrors one for errors names that is in use for years.  I will atta=
ch it.  It is meant for the MUA i maintain (a future lib part of it) and do=
es lots of things you surely do not need, as it is for C and C++ and create=
s mapping tables for by-name etc lookups, the signal documentation strings =
etc etc.
You run it local to create the portable stuff (uses perl, and the MUA i mai=
ntain for creating hash values), and then during compile time.  This compil=
e_time() function is surely what you want, it requires some POSIX tools (aw=
k, sort, rm) and a C compiler ($CC), actually only the preprocessing stage =
(much easier to let the compiler to the C preprocessor part), which' output=
 is then parsed.  Eg

  TARGET=3D./output-file sh su-make-signals.sh compile_time

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off (By Robert Gernhardt)
