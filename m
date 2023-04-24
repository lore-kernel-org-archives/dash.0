Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7599C7618E
	for <linux-dash@archiver.kernel.org>; Mon, 24 Apr 2023 12:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjDXMPP (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 24 Apr 2023 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDXMPO (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 24 Apr 2023 08:15:14 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C561985
        for <dash@vger.kernel.org>; Mon, 24 Apr 2023 05:15:13 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-42e3ceafd7cso3468723137.1
        for <dash@vger.kernel.org>; Mon, 24 Apr 2023 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682338512; x=1684930512;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rONpg0e48ikbY7dSVTJlzianDxMB0xJ6fHXEDl4JEdY=;
        b=NIlrJzgEVgLh7XZaY9oszDU4id3nL4M1cesbojbljnVDmju9BK9awpC2MBqpPzIn8C
         MGGlM2OUWcHEGO6wFeGoiruogr6Nh2LAzFL9eoNBuo7is98YKUhl4YZEDR4wbAyncseq
         0ET6yvHyd55NcTGPdWSX7CRaCo9Yxu01r5IoIaIZGD6/cMvoy6IsIF2SGZM1eEPgDxMr
         n7qnIXnVD15isUwTXKcnPA0Tl2uTKg3YTb62AHcXyrCtFB6MuW3V4GfWyF6SFFuQVhM2
         dZ1InnwKQGXOZwY+///cmtuNfCV2uWbq4P4ikX588jkxFDSuNi2FRWx/lUdsGrzgcHBf
         1srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682338512; x=1684930512;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rONpg0e48ikbY7dSVTJlzianDxMB0xJ6fHXEDl4JEdY=;
        b=OJqqlUSpXWrAfdRc0WZ5uq30bDS3eU/KWvnAFAJv5NwprnS9Avql3B2NiQZ6U8JxM4
         D1co+eGYmSlJBOhiv3sVCFRWXRMXgLFRkWTVf0uehHL673RtJZxyQCF1+uvAveIdWS0r
         LpT7xzkw/ergKDE5Bfr4D8+eWXWdqjQ8ThuKoHMgS8SiqR08Z1s85o7cpT8N2fJo6QT9
         e09KSQ/tOhdwpvyJgT/LqIFNnjh2/EO1WQpzn/DBJjmOO/tUq3VJ9RToRmzI7IBdhHoq
         bl6PqGc9M6vIv6ZmOSnwRyXC1E3HGna6RnSPQmDf8r7Z39OGg2188ZrkMuyG+p4stjP7
         GmHQ==
X-Gm-Message-State: AAQBX9cNuEyYVQ2k6cHI75xG1ibC6er24QTHExBDc0Ad7g/HfZRNPW44
        G+OP/PqV5WP8/EziTVcvCC+NmLzLlOvkrvu9WRjKy14devQ=
X-Google-Smtp-Source: AKy350auChfzt1locd9JBJom8/Skepe0btWCVjo5dHXoANgPYfO5/aaWUXEgMOaPepstSH3xv6g9lL1UymzrsuMATxo=
X-Received: by 2002:a67:b914:0:b0:42f:fb01:ba37 with SMTP id
 q20-20020a67b914000000b0042ffb01ba37mr6377618vsn.5.1682338511729; Mon, 24 Apr
 2023 05:15:11 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Lewart <lewart3@gmail.com>
Date:   Mon, 24 Apr 2023 07:15:00 -0500
Message-ID: <CALE_k2Ezm3AM2ea2ikVACiORw1XGGcOw1NiOegiteJUFQm9j0w@mail.gmail.com>
Subject: [PATCH] Alphabetize dash(1) Builtins
To:     dash@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000627eae05fa13f56d"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

--000000000000627eae05fa13f56d
Content-Type: text/plain; charset="UTF-8"

dash maintainers,

The attached patch alphabetizes dash(1) Builtins by:
  1) moving "command" after "ch|chdir"
  2) moving "printf" before "pwd"

Thank you!
Daniel Lewart
Urbana, Illinois

--000000000000627eae05fa13f56d
Content-Type: application/gzip; name="dash.1.diff.gz"
Content-Disposition: attachment; filename="dash.1.diff.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_lgusvhk00>
X-Attachment-Id: f_lgusvhk00

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
xf9HTJNC/CF+aAQdfMtz8Wf2F5Yg8czAGAAA
--000000000000627eae05fa13f56d--
