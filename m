From: n8dandy <n8dandy@protonmail.com>
Subject: Re: dash & IFS
Date: Wed, 25 Mar 2020 07:08:24 +0000
Message-ID: <9au65XzbFl5yRpX3pvtNOgED-D-908ns7VDH_Oa_yHmFQ25z-_CXc3vhR1nwR0KZd5fQRYPhst_8FtNXFniVHjizHiXYP9XpVUEYhhpyD40=@protonmail.com>
References: <dDYpzKRWD9p1jhFjsIjWZvAddv8e0CQYDq1UxXsV33DN8SvAxPj9gOakBk9LBcTu6j_qEZLUTIoebSKq3-yQ4LKNjGZG-jk-SMMy_RGE-hI=@protonmail.com>
 <0a54e6bd-07e7-80f0-a503-149473a19835@gigawatt.nl>
Reply-To: n8dandy <n8dandy@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail4.protonmail.ch ([185.70.40.27]:59886 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCYHIb (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 25 Mar 2020 03:08:31 -0400
In-Reply-To: <0a54e6bd-07e7-80f0-a503-149473a19835@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Monday, 23 March 2020 09:44, Harald van Dijk <harald@gigawatt.nl> wrote:

> On 23/03/2020 08:20, n8dandy wrote:
> This isn't about IFS, this is just because dash does not support the use
> of $'\n' to indicate a newline. In dash, $'\n' is equivalent to '$\n'
> (in the same way that x'y' is equivalent to 'xy' in all shells). To
> portably get a string consisting of a single newline, either put a
> literal newline in your source:
>
> nl=3D'
> '
>
> or use command substitutions:
>
> nl=3D$(printf '\n.'); nl=3D${nl%.}
>
> Currently, $'...' is not part of POSIX (although it has been accepted
> for the next version), and dash tends not to add new features that are
> not part of the standard.

Thanks for your help. Even if $'...' is not POSIX, I thought dash already
supports it. I'll stick with IFS=3D instead.

Sincerely
