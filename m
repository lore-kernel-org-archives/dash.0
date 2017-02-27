From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] quote arguments in xtrace output
Date: Mon, 27 Feb 2017 22:34:31 +0100
Message-ID: <0ef1b102-a04c-f3ac-609e-5285d59904d0@gigawatt.nl>
References: <e50519c3-4055-ab2a-b9f3-0776369e4106@inlv.org>
 <f9c5d0a5-69bc-c543-7de8-59e5e9cb105b@gigawatt.nl>
 <6e8434e8-87e3-db2a-9d80-147f064c4793@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:59416 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdB0Vez (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 27 Feb 2017 16:34:55 -0500
In-Reply-To: <6e8434e8-87e3-db2a-9d80-147f064c4793@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, dash@vger.kernel.org

On 27/02/2017 21:08, Martijn Dekker wrote:
> Op 27-02-17 om 20:24 schreef Harald van Dijk:
>> If the modification to single_quote can handle all cases (perhaps
>> quoting unnecessarily if it's unclear), then the conditional
>> parameter could be removed and applied unconditionally: as far as I
>> can tell, there are no existing calls that require the single quotes
>> for simple words.
>
> True, but this would change the output of something like:
>
> $ dash -c 'alias stuff=xyz; trap true EXIT; alias; trap'
>
> from:
>
> stuff='xyz'
> trap -- 'true' EXIT
>
> to:
>
> stuff=xyz
> trap -- true EXIT
>
> While there is technically nothing wrong with this, I think it's nicer
> to leave those quoted unconditionally, because that facilitates editing
> the output of those commands to feed it back to the shell.

Fair point.

Looking at other shells:

             | bash | ksh93 | zsh | posh | dash | dash (patched)
    alias    | 2    | 1     | 1   | -    | 2    | 2
     trap    | 2    | 1     | 1   | 1    | 2    | 2
   export -p | 2    | 1     | 1   | 0    | 2    | 2
readonly -p | 2    | 1     | 1   | 0    | 2    | 2
      set    | 1    | 1     | 1   | -    | 2    | 2
      set -x | 1    | 1     | 1   | 0    | 0    | 1

Here, 0 means "never quoted", 1 means "quoted when containing special 
characters", and 2 means "always quoted".

Although there is a bit of variation in other shells, your approach 
brings dash closer to bash, which I believe is considered a goal for 
dash, all else being equal. My suggestion would bring dash closer to 
bash in one command, but further from bash in four others, so unless 
there is a good reason for it, I think I agree that that shouldn't be done.

Cheers,
Harald van Dijk
