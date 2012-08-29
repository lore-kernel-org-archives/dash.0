From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [EXPAND] Nested parameter expansion results in an empty string
 when quoted
Date: Wed, 29 Aug 2012 09:35:28 -0700
Message-ID: <20120829163528.GC168@mannheim-rule.local>
References: <CAAv6kGS+Cgg2JmRqCeWNZtxpoUuJ0wBSLac0BJJGW8kuiqUgwQ@mail.gmail.com>
 <20120828230024.GA51967@stack.nl>
 <CAAv6kGQue_cKF9h6bC0FRZi1t4uD2r+tob05fw-5Aj3xWT5ZFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51754 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab2H2Qee (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 29 Aug 2012 12:34:34 -0400
Received: by pbbrr13 with SMTP id rr13so1508911pbb.19
        for <dash@vger.kernel.org>; Wed, 29 Aug 2012 09:34:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAv6kGQue_cKF9h6bC0FRZi1t4uD2r+tob05fw-5Aj3xWT5ZFA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Todor Vlaev <t.vlaev@gmail.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org

Todor Vlaev wrote:

> A bit worrying not to have regression tests, indeed.

Yes, I'd also like functional tests in the dash.git repo.

In the meantime, I think Herbert runs tests that are not in that repo,
and others reviewing patches use other test suites if I understand
correctly.

Jonathan
