From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: 'return' from subshell in function doesn't
Date: Sun, 8 Mar 2020 13:44:46 +0000
Message-ID: <98ce2d03-e647-48b2-e4dd-3ceb810f2b24@gigawatt.nl>
References: <S1726267AbgCHLof/20200308114435Z+1505@vger.kernel.org>
 <9b3a55fb-df00-8ac3-7a1e-b60e24aa2970@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:60928 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHNq7 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Mar 2020 09:46:59 -0400
In-Reply-To: <9b3a55fb-df00-8ac3-7a1e-b60e24aa2970@gmx.net>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dirk Fieldhouse <fieldhouse@gmx.net>, DASH mailing list <dash@vger.kernel.org>

On 08/03/2020 12:35, Dirk Fieldhouse wrote:
> POSIX
> <https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#return> 
> 
> says, and has since at least 2004:
> "The return utility shall cause the shell to stop executing the current
> function or dot script. If the shell is not currently executing a
> function or dot script, the results are unspecified."
>[...]
> As POSIX refers to subshells explicitly elsewhere (eg 'exit') it's
> difficult to believe that "subshell" was accidentally omitted from the
> list of contexts that 'return' should return from, but implementation
> behaviours consistently contradict the spec as written. Can they be made
> conformant without breaking existing scripts?

In the subshell, the shell should not be considered to still be 
executing a function or dot script. As such, the results should be 
unspecified, and any behaviour should be valid. The standard may be 
underspecified here, but any other interpretation is not reasonable.

Subshells work by starting a new process. The parent process waits for 
the subshell to finish and acts on its exit status. The child process 
has very little ways to influence its parent process other than that, 
and the parent process might not even still be running by the time the 
child process gets to the return statement.

Cheers,
Harald van Dijk
