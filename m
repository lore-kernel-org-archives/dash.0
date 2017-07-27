From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 19:26:36 +0200
Message-ID: <6d70fb7f-ab21-8675-350a-218f2db3ba6e@gigawatt.nl>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
 <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:49658 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdG0R0m (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 13:26:42 -0400
In-Reply-To: <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, Bosco <jbosco.gg@gmail.com>, dash@vger.kernel.org

On 27/07/2017 16:24, Eric Blake wrote:
> On 07/27/2017 08:13 AM, Bosco wrote:
>> On 27 July 2017 at 12:54, Eric Blake <eblake@redhat.com> wrote:
>>> Which man pages?  Echo is one of those programs that varies widely, and
>>> you are MUCH better off using printf(1) instead of echo(1) if you are
>>> trying to get newline suppression, trying to print something that might
>>> begin with -, or trying to print something that might contain \.
>>
>> Sorry, maybe I did't explain it correctly, I mean the man pages of the
>> dash source:
>> https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/dash.1#n1202
>>
>> And because of this, I got an error compiling zziplib, you may see
>> https://github.com/gdraheim/zziplib/blob/v0.13.67/configure#L17542
> 
> Eww - storing generated files in git - that forces everyone that checks
> out your project to use the EXACT same version of autotools to avoid
> changing the generated files unintentionally.
> 
> Looking at those lines:
> 
>>    if test -f $ac_prefix_conf_INP ; then
>>      echo "s/^#undef  *\\([ABCDEFGHIJKLMNOPQRSTUVWXYZ_]\\)/#undef $ac_prefix_conf_UPP""_\\1/" > conftest.prefix
> 
> ac_prefix_conf_INP is not defined anywhere in autoconf 2.69 sources (and
> you really shouldn't use the ac_ prefix if you are writing code that is
> not part of autoconf proper).  I couldn't find mention of it at
> https://github.com/gdraheim/zziplib/blob/v0.13.67/configure.ac, but it
> may be in one of your other included files.  Can you pinpoint which part
> of your configure.ac results in that part of the generated configure
> file?  In all likelihood, you are using a buggy macro that is using
> autoconf primitives incorrectly, and thus resulting in non-portable
> code.  But without seeing the true source, I can't help you debug your
> problem.

This is coming from zziplib's outdated copy of ax_prefix_config_h.m4, 
for which I submitted a patch to make it work in dash, and which was 
accepted, back in 2010 (!): <https://savannah.gnu.org/patch/?7317>

zziplib should update to a current version of this file.

>>> Arguably, since it is not required by POSIX, we don't have to do it. But
>>> I also can't argue that POSIX forbids us to support \1 as an extension
>>> (it says nothing about whether implementations can have additional
>>> escape sequences).  So I'll argue that it is intentional as a dash
>>> extension.  But if you can make dash smaller by getting rid of the
>>> extension, that might be an acceptable patch.
>>
>> In that case, I think, the man page of dash should be modified with
>> that extension.
> 
> Indeed, or the fact that it is NOT documented means that it is an
> unintentional bug for providing the extension.

The man page of dash states:

   All other backslash sequences elicit undefined behaviour.

Implementation-wise, POSIX gives the same requirements for escape 
sequences for echo as for printf %b, therefore it makes sense to share 
the code between the two. Neither echo nor printf %b requires \1 to be 
treated as an escape sequence, but both allow it.

bash treats \1 as an escape sequence with printf %b. For compatibility 
with bash, it sort of makes sense to implement this in dash as well. Yet 
for some reason, bash *doesn't* treat \1 as an escape sequence with 
echo, not even with echo -e.

Keeping dash small, continuing to share the code between the two cases, 
can only mean behaving differently from bash in at least one of them.

Cheers,
Harald van Dijk
