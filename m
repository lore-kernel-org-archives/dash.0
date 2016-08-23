From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: declaration utilities (was: [bug-diffutils] bug#24116:
 [platform-testers] new snapshot available: diffutils-3.3.50-0353)
Date: Wed, 24 Aug 2016 00:04:47 +0200
Message-ID: <20160823220447.GB57473@stack.nl>
References: <CA+8g5KEOBs=AtZoBZw7CJ5wW8=Yw88KrvjJK1PeEqK3uj_1wEg@mail.gmail.com>
 <9C56E56C-4D31-46AB-AC75-1AA8A759BF4D@gmail.com>
 <CA+8g5KGack9X8ByfoJEtbQHj-44iG6bvQ0yhguVqQ4vqZh4geA@mail.gmail.com>
 <2e1ea9a1-278e-8979-023b-72f77d677f5f@intel.com>
 <90e016d1-e0be-83c8-d0ee-ecb5665318ef@gigawatt.nl>
 <57A4BD00.1080900@redhat.com>
 <82552903-31e7-eeb1-948d-3bbac2288046@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:16336 "EHLO mx1.stack.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758127AbcHWWEv (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 23 Aug 2016 18:04:51 -0400
Content-Disposition: inline
In-Reply-To: <82552903-31e7-eeb1-948d-3bbac2288046@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Eric Blake <eblake@redhat.com>, dash@vger.kernel.org

[Cc trimmed]
On Fri, Aug 05, 2016 at 07:15:02PM +0200, Harald van Dijk wrote:
> On 05/08/2016 18:21, Eric Blake wrote:
> > On 08/05/2016 07:13 AM, Harald van Dijk wrote:
> >> Unfortunately, POSIX currently requires the export command to not have
> >> any magic quoting, and any POSIX-conforming shell will make

> >>     a="b c=d"
> >>     export a=$a

> >> set a to b, and c to d. Not so with bash, but that's because bash simply
> >> isn't POSIX-conforming, even if invoked as sh.

> > Not quite so fast.

> >> POSIX will require special quoting rules for the export command in the
> >> future, similar to what bash does today. When it does, dash is likely to
> >> change to match that, and the local command will likely be changed to
> >> work the same way.

> > POSIX has already issued an interpretation request, and therefore, any
> > CURRENT implementations (including bash) that already behave as
> > permitted by the interpretation ARE conforming. [...]

> > http://austingroupbugs.net/view.php?id=351

> An interpretation request doesn't automatically mean that all current 
> implementations are conforming, does it? It only means that when the 
> interpretation response says so. In this case, the response says that 
> the standard does not allow bash/ksh's behaviour.

> http://austingroupbugs.net/view.php?id=351#c865:

> > Interpretation response
> > ------------------------
> > The standard states that the current behavior of ksh93 does not
> > conform, and conforming implementations must conform to this.
> > However, concerns have been raised about this which are being
> > referred to the sponsor.

> The fact that this is seen as a defect in the standard which will be 
> fixed, rather than a defect in bash/ksh, doesn't make bash/ksh conform, 
> it merely means that bash/ksh shouldn't be changed to conform.

Although it is certainly true that the current standard forbids special
quoting rules for export and readonly, making this change sooner rather
than later will be helpful to users.

Looking at ChangeLog.O, I can see dash had special quoting rules for
export, readonly and local between 1997 and 2001. They were removed,
basically, because there was no specification guidance. The
specification guidance is now available in the form of Austin group bug
#351.

Users of FreeBSD sh have likewise liked having these new rules
available.

-- 
Jilles Tjoelker
