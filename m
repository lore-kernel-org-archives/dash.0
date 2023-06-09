Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE02C7EE29
	for <linux-dash@archiver.kernel.org>; Fri,  9 Jun 2023 23:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjFIXqU (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 9 Jun 2023 19:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjFIXqT (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 9 Jun 2023 19:46:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2038.outbound.protection.outlook.com [40.92.23.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70245359E
        for <dash@vger.kernel.org>; Fri,  9 Jun 2023 16:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEfcDSljgOGW3w9tQJiXZPTVYHL5q3+3meMeuUAPa9Dz1e1nFMWCVTX9UfxQib4/WEvy0AaM7S3QzShXQHm3l2CVU7HOQsA89AlCaaJk5Ty/mE9zJ1hmpgq2cWa7czckn1PeN8tdxrJpWNydJYTGexOpddKACv3yQj/P8lJh4ALVu+KIF+kWURuZd4mkQj+9wOLnwkQwauVaiNedjMF1kc5U5lDQ/aTHu+GRJmjnS2b1T8v83/mc7K+AEKJh81x0yDBAbQfHyxFZ34A289hFb85unEn/Dq7C8qXc97VVA8h0L6HyE/56MfALt0hTvFbIrbbnzKzphnJDeVXslAXOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7+rRiIKMpQlzGE/1Ub6oenNTb0MHdVF/uquyU7G3co=;
 b=N5eZbopeofoRMcAKdtDQ7eLce+jkZH3TnIAjnvb6wE2VgN5JoJAzi6stxcUIvI/xbjwENNB5o/LWzbLbKsDRbOHbjGEoYKjiU7RUA4FE/WTP3hJgrQgrgRRS18YuQBV2HFFr32krNoOFTWvvwIuXy963LZgEbD6SVBXiBdxC1tdAvFGKl4faeeTZJ1zokZhRGkTp8EnKygqMfFonunSztnrIcVJ758CyXqJks8GsVXzGhNnSdO128st+wd9p6mfeCbaPuaWRzxnbe4KZHlLYr4k3fuhGrAMLHcKVsNYlFdkZ5yRdW+1nOT9F9hKNC1lP4zooC1KBaBEAEdY+ER3IbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7+rRiIKMpQlzGE/1Ub6oenNTb0MHdVF/uquyU7G3co=;
 b=EfieG2HGo74N/KTdT6H7uHwln/Ux8DM25P4+hPjZpIEj4Twxec8LuJHt4Mw13CDpm2Y9NLYXPsEe4fsvkDwkM0gBQP26W0yhzHDDRyjCF25bL7EgySJXvNiw2jPhPZCPJxEAYaRr0V2Ro4CI6VOFAs7ZbvA/6NpZFc4hQAlbs4uA6jvBaHpJPwiFrtAmKlR89VdhhakA+TJSRluagZQHxgIJ6igEbSdSyqwQdzbgmxHLrKph1qaarMrX4Fvn9MadKv1pJDpHhGX4DAmFZjq4zOe7F4J6isJj5ivyyomrVxR8/m0cAcH93R4XvRO7564v2Z34bEJWbZdufqwKZSImCA==
Received: from DS7PR19MB4456.namprd19.prod.outlook.com (2603:10b6:5:2c6::20)
 by CH3PR19MB7873.namprd19.prod.outlook.com (2603:10b6:610:159::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.17; Fri, 9 Jun
 2023 23:46:01 +0000
Received: from DS7PR19MB4456.namprd19.prod.outlook.com
 ([fe80::e204:692f:e30b:deee]) by DS7PR19MB4456.namprd19.prod.outlook.com
 ([fe80::e204:692f:e30b:deee%5]) with mapi id 15.20.6500.012; Fri, 9 Jun 2023
 23:46:01 +0000
Date:   Fri, 9 Jun 2023 18:45:51 -0500
From:   S M <mythrowy777@hotmail.com>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: Interested in porting Dash to Readline
Message-ID: <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.outlook.com>
References: <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outlook.com>
 <20230609212915.WlLQf%steffen@sdaoden.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609212915.WlLQf%steffen@sdaoden.eu>
X-TMN:  [xO9cbFGSuJD5aPWTmcyFskfoNJqT+mQx]
X-ClientProxiedBy: SCYP215CA0015.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:300:31::6) To DS7PR19MB4456.namprd19.prod.outlook.com
 (2603:10b6:5:2c6::20)
X-Microsoft-Original-Message-ID: <ZIO5rz248gPsXV2V@betamon.home.arpa>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB4456:EE_|CH3PR19MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c19420-d3b4-4837-a1de-08db6943ae99
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrfvOssWbT04M8Mh7CJatxUbF7BitgCUy5psfuvLVEH93xQkua7Jm/iX67PfZgjNgNDjKSbTdjJT79/Sg+8BbnQyIkaR7Fenv7NDU5haxoyBxvloYrUzKrbLNbU+5h9DikGG6J5lJPViw0Ml7oGkUmVC7lVDO63O20L/VKvs/jbasxWS+rV4RhR4qjH7cU2cDGxn4/bU5hGqxIMGG9US2U4a7ruVRU3AXukmuU5wp1WovULB2Zlbf4MjK0LxJF65XM415q3YQmybzVXUAM42XU6eTa0LyvBmD3YtKhYz0MjIFCLKLk5XNAkV4HBv/ptc5qlgQ96BSUyWSh0varZWa95DCDVk5kVi3SXwNnQ8Iszm+/c6mdLjkTU7yxIEQcOJ5SuVac0f+RhCz3z0tKR8XkcIjTSyW3tkLEbe+ZvF4yye6CRPhIzePZHxm2py5r/JZakodqc6lEdzr0w3zR5QfImrYNmLGbmXxirKThUsH8bW3nv63ma1iYaEU/1pM552zm5PrdGvghRO8+asxEpcTN4PDlv/wOtzMV5Ps765sJp0VUlAM4NNZqcK4Qg7uch2N2cN47734S2U4WcszSUkIg0srFBLtqtR+yJmdVyoG5zrJOtNX7FHzkEcD174TzAj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8LcwT+UCfdpo3yg1cc86EXv40c1Wu/wjrnUrpv+EfLKtKZxL92DStzINjdo?=
 =?us-ascii?Q?aJZKPXl0t5etjYpj04PElix5HFSeGcJv/PxE009bPJHwQkKgZTIuOlMRxvSh?=
 =?us-ascii?Q?dl47dGjHM7PvLiSRfm8pRP+IyT1g+1S1QBJtbzT8s2kLfCLEavBtH4jj8dZa?=
 =?us-ascii?Q?+LqeBzc/pbXeQCdxS0kOxLYZZUj9OmU3bWd5hNYxiueEOCdj4xmQcLHXUpAD?=
 =?us-ascii?Q?ZP09DmQN0gJEtZpwiPWXp6r7AOBJgahM2eHmRve8aVDsW2ozAHTYWsg+Cwr6?=
 =?us-ascii?Q?EgSa+8rly7J6kUfdllx+JjCCLYQq1ml7J6tUqwrzA+hLOcOjuvb27buGGL79?=
 =?us-ascii?Q?J55FCkCAmgV/7P+6ulRXX0yoRgVvpsAYO9AdGF936btsFLq1bZNFUn1Z/ueL?=
 =?us-ascii?Q?wuNVtretRgymKN1Kq2yKzR1qQkeCZfF6tiZGz2PM/6uZGP6YjClIUxrXE9AD?=
 =?us-ascii?Q?uAp3tuIjo9al8Pje25zMywxISTcUaPlXvxmZPEiJDLQm/7OH9xRrvEa34i4M?=
 =?us-ascii?Q?1gZIMBIrsWCKDXblAG82jW9C+CW54xwYJdbxP7QxPzcN0WWhpKfMNXzYY7+n?=
 =?us-ascii?Q?P7FBUu/2eqzRLSxaw/rzWOgduBB50jbklyH5BlpmNtq+xONcZYKDK0ub8z5P?=
 =?us-ascii?Q?WKSQN7mS8IRkJj8mGPrO89KNp7qS17PJ9TMmZk5itmjeuiJrDb4ldakM6uEG?=
 =?us-ascii?Q?xtzUbc23CD3azuDn7tKB+rR2tvunWgneB2PwpjLDvtB2BFa8oQ1A823tMpDH?=
 =?us-ascii?Q?YUB1X9cxb7TGUmFIjub4eSKVPaT9Da+34YkXmS3TGN8dGY9Ni6aZdh8R1GSg?=
 =?us-ascii?Q?56R+2ZUeuDm8zbVWXgf/mOewWJdT7LeyhBO9Q3urO54+8v1rv+AfGW14SDYg?=
 =?us-ascii?Q?1UWfk/TaS1USizg6VLSG1yp9iyOvdcTV5qoRDB38GDVMD8fAj9y6o/Y5/f3m?=
 =?us-ascii?Q?i9730tsXJzrLw9cdQlcxXvXZSZU24aVPhiGfaicE8O9gX5I6W0QFhTu7qB3q?=
 =?us-ascii?Q?8gUaEdX3K2psVCVNsACgAn95Hfa793uVqYf0MQzGzz9vdTiTfVFfmYv98fBh?=
 =?us-ascii?Q?VwKMLIr/jBToSApAdAOLcbGZ5iU7TYzd/cmc9uIJQfHjZEp515fp4hXkJ97m?=
 =?us-ascii?Q?GHWpU+Ia3pOKQg0xmoQHpQfAhEhaDRsiZoCnX7LwixIISKNP9Q7/bi3kvE90?=
 =?us-ascii?Q?IySz21SGunZnWmYmAvSiiCIp1pvs2vugvKXBqRJO+asW0o+3eRd67WCA8mM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c19420-d3b4-4837-a1de-08db6943ae99
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB4456.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 23:46:01.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7873
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, Jun 09, 2023 at 11:29:15PM +0200, Steffen Nurpmeso wrote:

> Quoting Dalai Lama (50 years in India jubilee) "it is all there".
> FreeBSD bin/sh/histedit.c:sh_matches() as well as :sh_complete()
> (all BSD licensed).

So is it a licensing concern? I still think Readline is more
featureful as I have worked with both. I did poke around NetBSD's
ash code and remember that it used an internal Libedit header
"filecomplete.h" or something along those lines to implement
filename completion. Not that porting or re-implementing such
internal routines would be particularly hard. If I recall correctly
there is a publicfunction in libedit named "_el_fn_complete"
that implements something along those lines.

If it's a licensing problem then there's no way around it, though
I thought that GPL restrictions of this kind would only apply to
redistributed binaries linked against readline and not to the 
source code itself.
