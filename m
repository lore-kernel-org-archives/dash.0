From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [bug-diffutils] bug#24116: [platform-testers] new snapshot
 available: diffutils-3.3.50-0353
Date: Fri, 5 Aug 2016 19:15:02 +0200
Message-ID: <82552903-31e7-eeb1-948d-3bbac2288046@gigawatt.nl>
References: <CA+8g5KEOBs=AtZoBZw7CJ5wW8=Yw88KrvjJK1PeEqK3uj_1wEg@mail.gmail.com>
 <9C56E56C-4D31-46AB-AC75-1AA8A759BF4D@gmail.com>
 <CA+8g5KGack9X8ByfoJEtbQHj-44iG6bvQ0yhguVqQ4vqZh4geA@mail.gmail.com>
 <2e1ea9a1-278e-8979-023b-72f77d677f5f@intel.com>
 <90e016d1-e0be-83c8-d0ee-ecb5665318ef@gigawatt.nl>
 <57A4BD00.1080900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:58978
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161262AbcHERPM (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 5 Aug 2016 13:15:12 -0400
In-Reply-To: <57A4BD00.1080900@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, Dave Gordon <david.s.gordon@intel.com>, Jim Meyering <jim@meyering.net>, Assaf Gordon <assafgordon@gmail.com>
Cc: 24116@debbugs.gnu.org, dash@vger.kernel.org

On 05/08/2016 18:21, Eric Blake wrote:
> On 08/05/2016 07:13 AM, Harald van Dijk wrote:
>> Unfortunately, POSIX currently requires the export command to not have
>> any magic quoting, and any POSIX-conforming shell will make
>>
>>     a="b c=d"
>>     export a=$a
>>
>> set a to b, and c to d. Not so with bash, but that's because bash simply
>> isn't POSIX-conforming, even if invoked as sh.
>
> Not quite so fast.
>
>>
>> POSIX will require special quoting rules for the export command in the
>> future, similar to what bash does today. When it does, dash is likely to
>> change to match that, and the local command will likely be changed to
>> work the same way.
>
> POSIX has already issued an interpretation request, and therefore, any
> CURRENT implementations (including bash) that already behave as
> permitted by the interpretation ARE conforming. [...]

> http://austingroupbugs.net/view.php?id=351

An interpretation request doesn't automatically mean that all current 
implementations are conforming, does it? It only means that when the 
interpretation response says so. In this case, the response says that 
the standard does not allow bash/ksh's behaviour.

http://austingroupbugs.net/view.php?id=351#c865:

> Interpretation response
> ------------------------
> The standard states that the current behavior of ksh93 does not conform, and conforming implementations must conform to this. However, concerns have been raised about this which are being referred to the sponsor.

The fact that this is seen as a defect in the standard which will be 
fixed, rather than a defect in bash/ksh, doesn't make bash/ksh conform, 
it merely means that bash/ksh shouldn't be changed to conform.
