From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Maybe a mistake
Date: Fri, 17 Apr 2020 17:51:01 +0100
Message-ID: <617c7c35-e605-6042-a11c-ee8541979079@gigawatt.nl>
References: <CAGQt5nnH+ZBXbKreCFyEzqed8Yq_P6YqT0ideKVzd7OU_4bTAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:54036 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgDQQvd (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Apr 2020 12:51:33 -0400
In-Reply-To: <CAGQt5nnH+ZBXbKreCFyEzqed8Yq_P6YqT0ideKVzd7OU_4bTAg@mail.gmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "lunkov@gmail.com" <lunkov@gmail.com>, dash@vger.kernel.org

On 17/04/2020 17:37, lunkov@gmail.com wrote:
> Hello! I encountered a script execution error using dash. Other shells
> execute this script without error. Perhaps there is an error in dash.
> Please execute my script in dash and in bash, for example.
> -------------------------------------------------------------------------------------------------
[...]
>          local F=`echo "${i}" | grep "${PATTERN}"`        # local

Hi,

The latest release version of dash does not support assignment syntax in 
command arguments. Assignment syntax is special in that it prevents 
field splitting. A shorter example is

   x="1 y=2"
   export x=$x
   echo y=$y

This prints y=2 in the latest release version, but prints y= in other 
shells (unless you had previously set y yourself): without special 
assignment syntax, x=$x is split into x=1 and y=2 before it is passed to 
the export command, but with special assignment syntax x=$x is preserved 
as a single word.

You can work around this by adding quoting:

   local F="`...`"

The current git version of dash does support assignment syntax in 
command arguments (like other shells, only for specific commands) and 
accepts your script without modifications.

Cheers,
Harald van Dijk
