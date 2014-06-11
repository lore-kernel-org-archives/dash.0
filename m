From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] [MAN] 0 and EXIT both work for exit traps.
Date: Wed, 11 Jun 2014 16:17:38 -0700
Message-ID: <20140611231738.GH8557@google.com>
References: <1402528126-27427-1-git-send-email-adam.buchbinder@gmail.com>
 <20140611231305.GG8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54985 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbaFKXRl (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Jun 2014 19:17:41 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so315358pad.9
        for <dash@vger.kernel.org>; Wed, 11 Jun 2014 16:17:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140611231305.GG8557@google.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Buchbinder <abuchbinder@google.com>
Cc: dash@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>

Jonathan Nieder wrote:
> Adam Buchbinder wrote:

>> Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
>> ---
>>  ChangeLog  | 4 ++++
>>  src/dash.1 | 4 +++-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Mph, on second thought this still seems to have a trailing tab
for some reason.  Patch 2 seems to be missing the change to
src/dash.1.  Here are the same patches again with that fixed.

Thanks,

Adam Buchbinder (1):
  [MAN] 0 and EXIT both work for exit traps.

Jonathan Nieder (1):
  [MAN] Clarify "trap '' signals" syntax in manual page

 ChangeLog  | 4 ++++
 src/dash.1 | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)
