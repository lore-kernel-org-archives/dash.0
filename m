From: Ibrahim Ghazal <imgx64@gmail.com>
Subject: Status of set -o pipefail
Date: Tue, 30 Jun 2020 14:16:09 +0300
Message-ID: <CADfnUUJuvx_oeFqnoiLZHnVAHepDg9v2fUB_N3rf08HzPrU8DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgF3LQr (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 30 Jun 2020 07:16:47 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF78C061755
        for <dash@vger.kernel.org>; Tue, 30 Jun 2020 04:16:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id q22so8696368qtl.2
        for <dash@vger.kernel.org>; Tue, 30 Jun 2020 04:16:47 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Back in December 2019, there was a thread on this mailing list about
set -o pipefail [1]. Two patches implementing it were posted [2][3].
However, there was no activity afterwards and it was never merged into
dash.

Could a committer look into the patches and apply either of them
please? From the last thread, there was no objection to adding the
feature since it will be in the next POSIX standard.

[1] https://www.spinics.net/lists/dash/msg01879.html
[2] https://www.spinics.net/lists/dash/msg01886.html
[3] https://www.spinics.net/lists/dash/msg01888.html
