Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DA7C433F5
	for <linux-dash@archiver.kernel.org>; Mon, 28 Mar 2022 04:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiC1Eq6 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 28 Mar 2022 00:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiC1Eq5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 28 Mar 2022 00:46:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C633EE023
        for <dash@vger.kernel.org>; Sun, 27 Mar 2022 21:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi+7uJqlRikJnjyXBc9uFGLlEl6v8pG+jbWx8z49T2MVTQWkW7PfL5Gx9QiiFxIPhA+JZ7m1FOXJqDrdmKfUl/eOugNXNjjuH8l2828BXanM4gnlAZs9hwfYO/NWb6to4Uy0cSKB9FGQ1KpmDZ4ewcQf8yKGbWJcnuG8tODd4j8mD3p1UfWUuoUvB4ay0nsGZhdpZSdL3Xa2E2zdzvWQZ/+Bc2HBC2V7Zpd8BN+11LJ778+g07xMuerzWwJfqa/eVllsc73mD4Ghf6cVCZkpXip3BxPxiSirT/0glQbRoPba7Mqiq2NRfej2OWLchWTPZJ49/n9ZVIfJSkmCN4gxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hCoLgid3vlw8h4i4h/DDnBcfOHkKSXJSGNdj1k6vlM=;
 b=ACcTXAxVp1LuL6Ewsc2Pm8T/8QoeVVmskiG6kZAlu8sM2Jp+0Atf0AhD0DYWuvaNbZPd8GaT4/kwAhJ2WaA9aOFAeAtYOuqX0a4pxdMXrRxaaZTv8NgJ5a9tPFsrZe0xYd4TD2A/YPuwmZY1yFtF6Fc/yjc9GW9GakzDeqXt5JT7goXhQ/MaVMCcGk4DyA/UuYsEUAUPt3fLmm8LtGqmzJrdhQ1QDBqOwLxDAlFtJcDSrFgjm9cRpvQE5s70gB2aTFacYnKbitojjW8WctoeJqeBsd4Av0l+IUd1BxeJ/75uZzkx9vLPm5sXRVc2SSpRYcM9Q26/AdbCcV+rJqRDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hCoLgid3vlw8h4i4h/DDnBcfOHkKSXJSGNdj1k6vlM=;
 b=qCfFBGxYOMF9b0VDPQRAQP82KJogAsdyYNcdkkQPW6K3pf3kmMJWVESkWo4lD+m/le3OTVL1o6F+IMIGsFdRz73+pQIbNk4kQJHLBfY8ujleCLR5rDTjbh16FENwiPHdMWDDoNu89fyDLC/N7vF4jWw0m8fWUhxAz0Xqixu8felPT3FXhrevat/x6dDzGOC76nOveg29xKmxkCrFhDtWX+lgWxZxDkToPwEXQCvupqPzgVtvSOFX1KWs9wX7n3eXbYETMr+ovGO39pe8aFVq4t+N8hYPl31tc2HDj1guJvvBfX3RNFoLMnh1PVMCzMs3NAFBqP4YDKD6RBuhj/ag3g==
Received: from HE1PR06MB3017.eurprd06.prod.outlook.com (2603:10a6:7:21::28) by
 PAXPR06MB7455.eurprd06.prod.outlook.com (2603:10a6:102:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 04:45:14 +0000
Received: from HE1PR06MB3017.eurprd06.prod.outlook.com
 ([fe80::e8e0:4442:d29e:7160]) by HE1PR06MB3017.eurprd06.prod.outlook.com
 ([fe80::e8e0:4442:d29e:7160%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 04:45:13 +0000
From:   =?iso-8859-1?Q?Bj=F6rn_Bidar?= <bjorn.bidar@jolla.com>
To:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Printf %q
Thread-Topic: Printf %q
Thread-Index: AQHYQl6djVaqWuk84Ey7uakJOofncQ==
Date:   Mon, 28 Mar 2022 04:45:13 +0000
Message-ID: <6343726.ZXKkvaxoqQ@odin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 660587a4-85d1-43a2-9e10-08da1075bfb3
x-ms-traffictypediagnostic: PAXPR06MB7455:EE_
x-microsoft-antispam-prvs: <PAXPR06MB74552D5AF64C6BB992658D15F81D9@PAXPR06MB7455.eurprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqP6OlxEu7QiaHeF0Mq6C6dldkfXZGDroQZW/WZQ/bpZVdaXQezkdqUpzhWFMkba9iAsIglIwHakLUzf/nau2LK+7BXaNt6iWQovHSGj7d9TxTlDXdUIJazlw+67mTNwZaTVMDUFVuIcVbMtO5Dm1wzRyXcIWMFJQuV4rwEGrqFQM+EF/5F4bM+oxbZRvTEsrC3HkRHjAANpplFmkqa8AVjvETFHc6eXewX6TOe8+eC/4MNlK4jLblTbzUiXxO98ujMnCkRZNmPJcXCuVzaj1rZ65UZw4GWH7AkATomvILA6wTei2qLdussaSHVBgkvXqXrTkReddZ6XSUokeaYfb/chQ0MKrEAkKD0RXggsFSH1QVurycsvN03qFPVPjDHrBI4bIKyQ5PCqta6aXvtCI7ejv23BKT7kQSezhe0MBXir0QkgxVju8zL3zhl5pHfWfK9x47Z2cLoVq5/TmBC657IM5dWQTGhznkHxEb8HydGmBf1++V9N19j+9U1nBbxQpsf/j7LhIf8OS67pYuGfsTYaKRas6Ruxovu3lOOb/nDOWEjyvTlY+PO5LfX2tcVES9XMOjTR83xsVyylJ++jA3YgqHFkgK8UIB7IBG50SUrmd3FErBZwmzoLq34amkcd+0qcfH8oAeFSGMaZMQHCjz9menNGRLIfy61GJRS7UgB1XHHXeqEwZ8mTXL99fjJzZPAMiHNQEsfSFd8kwap/Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR06MB3017.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(346002)(376002)(136003)(39830400003)(366004)(396003)(6486002)(91956017)(71200400001)(6916009)(316002)(26005)(508600001)(76116006)(122000001)(86362001)(66556008)(66946007)(186003)(6506007)(38100700002)(9686003)(2906002)(5660300002)(64756008)(8936002)(38070700005)(4744005)(33716001)(8676002)(66446008)(66476007)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6KB4Dbfejh8NI+JO2PsVNcluzOBzw95X15vYMRxqtYQuITI/INBBRRIdWX?=
 =?iso-8859-1?Q?xNUThNYTsJKog1jIOStzR+wymLH1uR50bPj2xgoHmE2f33q89v7o0GBKVe?=
 =?iso-8859-1?Q?wk53hI7AAkvJFTIKT1+huLFxFY80dONosmSl543Zg1sBVghXS8SNzdPvxt?=
 =?iso-8859-1?Q?4qNgl0gsfyM2uJEjHNW0bybxKTtXokOUgSfXds1uFKlfLbsLqxbI3y+BMD?=
 =?iso-8859-1?Q?+/Crx7bZ/F7nIJ0WOWGxrgJ6tePPyUk2n44Ymw9+lQsR8bqKWb1/iPXSl3?=
 =?iso-8859-1?Q?jW3MsyOwP+J8vq4EwXfi5SSDQlqOb6m08XSNnx56U4CSWYqStDRonCgkhL?=
 =?iso-8859-1?Q?YYEJuXcKJzriIObzZm/ogbQx+IOwDGQnwFIt/mhFO9yICWsx1M8r5cp5t5?=
 =?iso-8859-1?Q?eqz5fsqFEJMPud1cc2jCJLCAHK4MIXszk5geVeSKWgs7sTGThc1tctUZcc?=
 =?iso-8859-1?Q?2EBTdmHjhrCeQTuEO7tsKXTYGqNlrxb+ENF7Y+/5VKwwHhQiTtn/WvhmFO?=
 =?iso-8859-1?Q?qdQNaDKTbDQw+PrMfQT0GwbZI1SaITpdoP0wYvwnt2Rbc0OeEfNP12K2Z3?=
 =?iso-8859-1?Q?5rNwpL7yzcVaWPulkR7H+lFQfm3cEK7i4d+/Jr5ew5U6stBobPSli7VmBj?=
 =?iso-8859-1?Q?JHFCHjuOTvy66OHh/tQZW7v4KDoYQpVMDBbuc1UN5/YqYJLhbpw8pUoTbq?=
 =?iso-8859-1?Q?1/YUuaXgF/2ZKl+EY3VKdoD50E3QaFuj89sJ2NxwdGPOnVAXKMPr0t6mkG?=
 =?iso-8859-1?Q?JEhUvtoQ6mE1XfiBwiRYPwq+0V/w9PMK3+7kPi2dIPdxcMVBx656zSQ6yI?=
 =?iso-8859-1?Q?OcjVFBiiJ6bbwhSop/kHxQ9kuuolCC6irIcdbdpTZ3qleqw+eHDOqqwpwD?=
 =?iso-8859-1?Q?roE4Jf11s7sEM416hSpX6sWeXJgRy33Q0OaQhVqkYcIDJquPvO/KE4UX1v?=
 =?iso-8859-1?Q?4M8YhsEf/KBnB1O1OtTwXuHYsaV4RDhlgxoOasIe7627PVtzvGFk78qAoG?=
 =?iso-8859-1?Q?mue1yHsXuDNUQKBz7mM1cySlIjC2L69QyVEw6M73CoDLpsy2JpP2hBp5lL?=
 =?iso-8859-1?Q?sOKi5XewInIpLL4FRIUVCJz+20DswX6aarQZq8MAKjoyDka3Vu/CGpuQOG?=
 =?iso-8859-1?Q?L9F22Vz2vtFLrohwCecEt1POSeSmyd6AMT1MK1KyeUJ88cmD6oia9MRrgM?=
 =?iso-8859-1?Q?W5sApT48Nu05PvexMbRXagbiIwKZYqP+31s7ODU2LCMUU50kJzb7v0P6ic?=
 =?iso-8859-1?Q?F6vLNkePvAGvM87NbtQQ+1nh1FAlW4DVL4bRfrkThVXtCz0t7BsoOL9QmH?=
 =?iso-8859-1?Q?rJy53ZlNY1y1leJWqzqvjjLTJmtojygkk1cd92KArvhc41tumdFhOEKI65?=
 =?iso-8859-1?Q?luJ33/TXylJz9MHJ1g84e8GZOJ6Ul+5HT2Al3EmcTp4z2Yl3+vAFlFKDfr?=
 =?iso-8859-1?Q?/akRObDrKG6EE4I4q0BsEZPPHiqqxZL68tYMSG1iVGLGI89r4k8bA6jsMk?=
 =?iso-8859-1?Q?ygQMgKyfUnyQxdqtDtCNUHmlx7Kzwv/x5WQRwPM3E3NtFOGilT6d744Kis?=
 =?iso-8859-1?Q?tXCmsKgX5HzYyN/OuyDwLgW/NeJ/c9+qBHvLy5ORwB30ZOheQQ9ZZ33+Uc?=
 =?iso-8859-1?Q?InBlyPBC3RAZE5NbLGm9WSjr+ddhIUxa652MLCTc1y6IfFdvzMIJjOSC4P?=
 =?iso-8859-1?Q?rDzHY4UNj/6XnBUhreWXpuEQv4hQ8gHGB9FRV31GqO/DOnYVPai2BGJkQI?=
 =?iso-8859-1?Q?6m24ExOoHfZ2pLBVG4NxYMaOviLBC37idUBTuyKvoZL83WFuGma5kI5vGG?=
 =?iso-8859-1?Q?RqH9tZDnKkE38WIWKI/KnPvajqCg6XA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <97C3563247D9C440AE9AB4D423CD8A59@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR06MB3017.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660587a4-85d1-43a2-9e10-08da1075bfb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 04:45:13.7596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrQ9s03gWwFggy+8+IvetsvbqY7K5yO/2XtWTM+/07CCbSuQ8C8mwFRHHcEmQjwnd+TIz6VQ3ScEm+4JxgsJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7455
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey,=0A=
=0A=
Bash and Coreutils support print %q to quote a string for it to be used as =
=0A=
shell input.=0A=
=0A=
"%q     ARGUMENT is printed in a format that can be reused as shell input, =
=0A=
escaping non-printable characters with the proposed POSIX $'' syntax."=0A=
=0A=
Dash also supports the $' ' syntax used by this. Where was this proposed to=
 =0A=
POSIX?=0A=
=0A=
Would it make sense to also support printf %q dash already supports $' '.=
=0A=
=0A=
=0A=
Br,=0A=
=0A=
Bj=F6rn Bidar=0A=
