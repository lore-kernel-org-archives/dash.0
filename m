Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9379C7EE29
	for <linux-dash@archiver.kernel.org>; Wed,  7 Jun 2023 14:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjFGOWf (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 7 Jun 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjFGOWb (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 7 Jun 2023 10:22:31 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 07:22:24 PDT
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1EB01FD7
        for <dash@vger.kernel.org>; Wed,  7 Jun 2023 07:22:24 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:404b:37aa:f9a:f0ea] (unknown [IPv6:2a02:8010:68a1:0:404b:37aa:f9a:f0ea])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id BAC2746E;
        Wed,  7 Jun 2023 15:13:01 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl BAC2746E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1686147181;
        bh=hrjD/xjJXUF7l3GwUS8POS3J7lD5drlWh6jdNyOIn8I=; l=3488;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=IkNyrslXMG+ETXCmBH9vNB8z4knQhmUSCHdF46DN92+ciJtp151bWVnMuQOHK27Pw
         2KW8D1+oOO3AjevQioV+HI3JbLvROpszOHOqxwldEhRIkt03ennT9IrgXBJRGZMiNL
         lDFOYnEzpOqn1onYYAR/lKL69wNfrN0sjO3pIPvs=
Message-ID: <56675584-c4b5-b064-0c13-82c0a1dd336c@gigawatt.nl>
Date:   Wed, 7 Jun 2023 15:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: [Debian#1037195] dash: $(here-doc in <<substitution) is always
 empty, must consume subsequent lines per POSIX?
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <7ygxq63mk22evfzirlilu4eexc2q44uul6zsade73om5hgbvj7@a6er2aqswli7>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <7ygxq63mk22evfzirlilu4eexc2q44uul6zsade73om5hgbvj7@a6er2aqswli7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 07/06/2023 14:26, наб wrote:
> Forwarding from Debian #1037195:
> 
> bullseye (0.5.11+git20200708+dd9ef66-5),
> sid (0.5.12-2) and
> git (b00288fd28c1b39d0f1531b6e6d86de59de4be8d)
> dash observe the following:
>    $ cat -n boment
>          1  echo "$(head -n1 <<EOF)"
>          2  # 2
>          3  # 3
>          4  EOF
>    $ sh boment
>    
>    boment: 4: EOF: not found
>    $ sh -x boment
>    + head -n1
>    + echo
>    
>    + EOF
>    boment: 4: EOF: not found
>    $
> This agrees with bullseye bash (5.1-2+deb11u1) but not sid bash
> (5.2.15-2+b2), which outputs "# 2" (and a warning);
> I believe that bash is correct here (sans the warning).

As far as I know, this is not intended to be valid. Shells are permitted 
but not required to accept it, and if they accept it, it need not behave 
in any particular way.

> POSIX Issue 7, XCU, 2. Shell Command Language says
>     2.7.4 Here-Document
>    
>    The redirection operators "<<" and "<<-" both allow redirection of subsequent lines read by the shell to the input of a command. The redirected lines are known as a "here-document".
>    
>    The here-document shall be treated as a single word that begins after the next <newline> and continues until there is a line containing only the delimiter and a <newline>, with no <blank> characters in between. Then the next here-document starts, if there is one. The format is as follows:
> and its counterpart in Issue 8 Draft 3
>    80601  2.7.4 Here-Document
>    80602  The redirection operators "<<" and "<<-" both allow redirection of subsequent lines read by
>    80603  the shell to the input of a command. The redirected lines are known as a ``here-document’’.
>    80604  The here-document shall be treated as a single word that begins after the next NEWLINE token
>    80605  and continues until there is a line containing only the delimiter and a <newline>, with no
>    80606  <blank> characters in between. Then the next here-document starts, if there is one. For the
>    80607  purposes of locating this terminating line, the end of a command_string operand (see sh) shall be
>    80608  treated as a <newline> character, and the end of the commands string in $(commands) and
>    80609  `commands` may be treated as a <newline>. If the end of input is reached without finding the
>    80610  terminating line, the shell should, but need not, treat this as a redirection error. The format is as
>    80611  follows:

The relevant bit here is "If the end of input is reached without finding 
the terminating line, the shell should, but need not, treat this as a 
redirection error."

The command substitution's command is head -n1 <<EOF. There is no 
terminator for the <<EOF heredoc in the command substitution's command. 
There is not even the newline to start the heredoc. Issue 8 says this 
should be (but needn't be) treated as a redirection error. If a shell 
does not treat it as a redirection error, the behaviour is implicitly 
unspecified.

Even in Issue 7, it says "continues until there is a line containing 
only the delimiter and a <newline>", with nothing to say what happens 
when no such line is found, also implicitly making the behaviour 
unspecified.

That said, this did use to work in dash as it does in bash, and both 
this and the otherwise equivalent form with `` (which never worked in 
bash or dash, as far as I know) are possible to support if dash so 
desires: I have implemented this in my own version a while ago. It 
works. It is possible for dash to do the same.

Cheers,
Harald van Dijk
