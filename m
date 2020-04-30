From: Michael Greenberg <michael.greenberg@pomona.edu>
Subject: Re: [BUG] one-shot variables aren't propagated past functions
Date: Thu, 30 Apr 2020 08:12:55 -0700
Message-ID: <m2sgglovm0.fsf@pomona.edu>
References: <20200430100001.GA30093@generichostname>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:6050
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbgD3PNS (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 30 Apr 2020 11:13:18 -0400
In-Reply-To: <20200430100001.GA30093@generichostname>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denton Liu <liu.denton@gmail.com>, dash@vger.kernel.org

On 2020-04-30 06:00:01, Denton Liu <liu.denton@gmail.com> wrote:

> Hi all,
>
> I believe that I've encountered a bug in dash 0.5.10.2. With the
> following input
>
>         f () {
>                 echo $var
>         }
>
>         var=test f
>         echo $var
>
> I would expect the output to be
>
>         test
>         test
>
> but the output is actually
>
>         test
>         <blank>
>
> It seems like this violates the POSIX spec.

Junio's reading of the spec isn't quite right. From Section 2.9.1
"Simple Commands":

  If the command name is a function that is not a standard utility
  implemented as a function, variable assignments shall affect the
  current execution environment during the execution of the function. It
  is unspecified:

  - Whether or not the variable assignments persist after the completion
    of the function

  - Whether or not the variables gain the export attribute during the
    execution of the function

  - Whether or not export attributes gained as a result of the variable
    assignments persist after the completion of the function (if
    variable assignments persist after the completion of the function)

I've seen only two ways that shells treat simple commands of the form
`VAR=VAL FUNC ARGS ...`. Shells with support for the (unspecified)
`local` command tend to have the behavior dash does, where the
assignment of `VAR` is local in scope. Other shells treat such
assignments globally.

You can find a summary of this issue in my recent paper from POPL 2020,
"Executable formal semantics for the POSIX shell", Section
8.3. (https://mgree.github.io/papers/popl2020_smoosh.pdf)

Cheers,
Michael


Quoting Junio C Hamano[1]:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>> > Tarmigan Casebolt schrieb:
>> >>         REQUEST_METHOD="GET" some_shell_function
>> >
>> >> I can't tell from my reading of the POSIX spec whether my usage was
>> >> wrong or if dash is wrong,
>> >
>> > According to POSIX, variables set as shown above for shell functions are
>> > not exported and retain their value after the function returns.
>>
>> I actually looked for this yesterday, but didn't find a relevant
>> definition.  But "2.9.5 Function Definition Command" [*1*] seems to
>> address the issue: "When a function is executed, it shall have the
>> syntax-error and variable-assignment properties described for special
>> built-in utilities...".
>>
>> And "2.14 Special Built-in Utilities" section [*2*] says "2. Variable
>> assignments specified with special built-in utilities remain in effect
>> after the built-in completes...".  Taking both together, it seems that
>> the assignment should be in effect after the function returns.
>>
> [...]
>>
>> [References]
>>
>> *1* https://nam01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.opengroup.org%2Fonlinepubs%2F9699919799%2Futilities%2FV3_chap02.html%23tag_18_09_05&amp;data=02%7C01%7CMichael.Greenberg%40pomona.edu%7Cb8c8aa7c728f4110ab8208d7eced43f4%7C817f590439044ee8b3a5a65d4746ff70%7C0%7C0%7C637238376114210837&amp;sdata=ZDuZDf%2B2fbEbehYK9DpFmHHhtFwEjUh51pQwdexANdk%3D&amp;reserved=0
>> *2* https://nam01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.opengroup.org%2Fonlinepubs%2F9699919799%2Futilities%2FV3_chap02.html%23tag_18_14&amp;data=02%7C01%7CMichael.Greenberg%40pomona.edu%7Cb8c8aa7c728f4110ab8208d7eced43f4%7C817f590439044ee8b3a5a65d4746ff70%7C0%7C0%7C637238376114210837&amp;sdata=2NGIBN2kWLb%2FwZRy5lh021vUd%2FVLXEh2IzNq0lpv0R4%3D&amp;reserved=0
>
> It also seems like on bash 5.0.16, running with --posix produces the
> expected output, although without --posix it produces the blank line.
>
> Originally discussed here[2].




> Thanks,
>
> Denton
>
> [1]: https://nam01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fgit%2F7vljfzz0yd.fsf%40alter.siamese.dyndns.org%2F&amp;data=02%7C01%7CMichael.Greenberg%40pomona.edu%7Cb8c8aa7c728f4110ab8208d7eced43f4%7C817f590439044ee8b3a5a65d4746ff70%7C0%7C0%7C637238376114210837&amp;sdata=bQcTgwa%2Bb%2FobsCT5L2laRqP%2BmhJQNJgCHllsVHNcwhw%3D&amp;reserved=0
> [2]: https://nam01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fgit%2F20200430092220.GA25331%40generichostname%2F&amp;data=02%7C01%7CMichael.Greenberg%40pomona.edu%7Cb8c8aa7c728f4110ab8208d7eced43f4%7C817f590439044ee8b3a5a65d4746ff70%7C0%7C0%7C637238376114220834&amp;sdata=cEpyKOzR6UB%2Bvdr%2FOK7zsex1aRj7Fqyng5ZpH9ZDvSc%3D&amp;reserved=0
> ________________________________
>
> [EXTERNAL EMAIL] Exercise caution before clicking on links or opening attachments.
