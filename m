From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash & IFS
Date: Mon, 23 Mar 2020 08:44:52 +0000
Message-ID: <0a54e6bd-07e7-80f0-a503-149473a19835@gigawatt.nl>
References: <dDYpzKRWD9p1jhFjsIjWZvAddv8e0CQYDq1UxXsV33DN8SvAxPj9gOakBk9LBcTu6j_qEZLUTIoebSKq3-yQ4LKNjGZG-jk-SMMy_RGE-hI=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:44424 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbgCWIoz (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 23 Mar 2020 04:44:55 -0400
In-Reply-To: <dDYpzKRWD9p1jhFjsIjWZvAddv8e0CQYDq1UxXsV33DN8SvAxPj9gOakBk9LBcTu6j_qEZLUTIoebSKq3-yQ4LKNjGZG-jk-SMMy_RGE-hI=@protonmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: n8dandy <n8dandy@protonmail.com>, "dash@vger.kernel.org" <dash@vger.kernel.org>

On 23/03/2020 08:20, n8dandy wrote:
> Good morning,
> 
> Few days ago, I noticed something strange with dash and IFS. It was
> verified with the following versions :
> 
> - 0.5.10.2 on Voidlinux
> - 0.5.10.2 on Debian Buster
> - 0.5.8 on Ubuntu 18.04.2 LTS (Bionic Beaver)
> 
> Here the issue :
> 
> $ ls
> file.sign  file1  file2  other.sign  whileifs*
> $ cat whileifs
> #!/bin/dash
> 
> find . -type f | sort -d | while IFS=$'\n' read -r F; do
> 	printf "%s\n" "$F"
> done

This isn't about IFS, this is just because dash does not support the use 
of $'\n' to indicate a newline. In dash, $'\n' is equivalent to '$\n' 
(in the same way that x'y' is equivalent to 'xy' in all shells). To 
portably get a string consisting of a single newline, either put a 
literal newline in your source:

   nl='
   '

or use command substitutions:

   nl=$(printf '\n.'); nl=${nl%.}

Currently, $'...' is not part of POSIX (although it has been accepted 
for the next version), and dash tends not to add new features that are 
not part of the standard.

Cheers,
Harald van Dijk
