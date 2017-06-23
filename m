From: Larry Hynes <larry@larryhynes.com>
Subject: Re: Small cleanup to src/dash.1 - Command Line Editing
Date: Fri, 23 Jun 2017 17:42:50 +0100
Message-ID: <a1tv1e-9m11.ln1@sabon.larryhynes.com>
References: <6csf1e-9n5.ln1@sabon.larryhynes.com> <20170623144128.GA15837@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:33368 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbdFWRAP (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 23 Jun 2017 13:00:15 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcsd-dash@m.gmane.org>)
        id 1dORwE-0006Ob-E1
        for dash@vger.kernel.org; Fri, 23 Jun 2017 19:00:06 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> On Sat, Jun 17, 2017 at 03:53:26PM +0100, Larry Hynes wrote:
>> src/dash.1, under Command Line Editing, states:

>>       It's similar to vi: typing <ESC> will throw you into command
>>       VI command mode.

>> - There appears to be no need for both occurrences of 'command'
>> - I can't see a reason for VI to be capitalised
>> - 'will throw you into' seems a little... enthusiastic

>> Following diff changes it to

>>       It's similar to vi: typing <ESC> enters vi command mode.

>> diff --git a/src/dash.1 b/src/dash.1
>> index 8b8026d..f35d89d 100644
>> --- a/src/dash.1
>> +++ b/src/dash.1
>> @@ -2232,7 +2232,7 @@ enabled, sh can be switched between insert mode and command mode.
>>  The editor is not described in full here, but will be in a later document.
>>  It's similar to vi: typing
>>  .Aq ESC
>> -will throw you into command VI command mode.
>> +enters vi command mode.
>>  Hitting
>>  .Aq return
>>  while in command mode will pass the line to the shell.

> I agree. If you're changing things here anyway, I suggest getting rid of
> the contraction as well (changing It's to It is). The fairly formal
> style of man pages avoids contractions, just like it avoids "you".

> The reference to the "later document" can probably be removed as well,
> since said document does not exist yet after many years.

Hi

Revised diff, below, expands the contraction, deletes reference to
'later document' and changes 'place' to 'places' in the following:

	The command ‘set -o vi’ enables vi-mode editing and place sh
	into vi insert mode.

diff --git a/src/dash.1 b/src/dash.1
index 8b8026d..1056285 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2226,13 +2226,12 @@ This mode uses commands, described below,
 similar to a subset of those described in the vi man page.
 The command
 .Ql set -o vi
-enables vi-mode editing and place sh into vi insert mode.
+enables vi-mode editing and places sh into vi insert mode.
 With vi-mode
 enabled, sh can be switched between insert mode and command mode.
-The editor is not described in full here, but will be in a later document.
-It's similar to vi: typing
+It is similar to vi: typing
 .Aq ESC
-will throw you into command VI command mode.
+enters vi command mode.
 Hitting
 .Aq return
 while in command mode will pass the line to the shell.

