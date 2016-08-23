From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash 0.5.9: break and continue bug
Date: Tue, 23 Aug 2016 22:41:50 +0200
Message-ID: <377a8f04-2ecb-0171-7fb4-5baeacefab26@gigawatt.nl>
References: <c8a328b0-1ed7-cb35-5a9c-95b7f592cb9e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:37690
        "EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753964AbcHWUmA (ORCPT
        <rfc822;dash@vger.kernel.org>); Tue, 23 Aug 2016 16:42:00 -0400
In-Reply-To: <c8a328b0-1ed7-cb35-5a9c-95b7f592cb9e@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Zdenek Kaspar <zkaspar82@gmail.com>, dash@vger.kernel.org

On 23/08/16 22:23, Zdenek Kaspar wrote:
> Hi, I've noticed 0.5.9 does ignore break and continue statements, here
> is simple reproducer:
>
>
> one() {
>     echo "  one"
>     break
> }
>
> two() {
>     echo "  two"
> }
>
> for i in 1 2
> do
>     echo "loop $i:"
>     one
>     two
> done
>
>
> dash-0.5.9:
> $ dash dash-break-test
> loop 1:
>   one
>   two
> loop 2:
>   one
>   two
>
> dash-0.5.8-4.fc24.x86_64:
> $ dash dash-break-test
> loop 1:
>   one

break and continue now need to appear in the loop directly, they cannot 
be wrapped in a function any more. Although this is a visible change in 
behaviour, it is intentional:
   <https://www.mail-archive.com/dash%40vger.kernel.org/msg00929.html>

The standard is a bit unclear on how break and continue are meant to 
behave in these situations, as it refers to the "enclosing loop" without 
defining what counts and doesn't count as the enclosing loop, but the 
next version of the standard will make it clear that your script is not 
required to behave the way you expect:
   <http://austingroupbugs.net/view.php?id=842>

That said, shells are still allowed to treat your script the way you expect.

> HTH, Z.
