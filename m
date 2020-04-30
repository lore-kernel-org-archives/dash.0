From: Denton Liu <liu.denton@gmail.com>
Subject: [BUG] one-shot variables aren't propagated past functions
Date: Thu, 30 Apr 2020 06:00:01 -0400
Message-ID: <20200430100001.GA30093@generichostname>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbgD3KAG (ORCPT
        <rfc822;dash@vger.kernel.org>); Thu, 30 Apr 2020 06:00:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92968C035494
        for <dash@vger.kernel.org>; Thu, 30 Apr 2020 03:00:04 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h26so4405738qtu.8
        for <dash@vger.kernel.org>; Thu, 30 Apr 2020 03:00:04 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c6sm1469248qka.58.2020.04.30.03.00.02
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 03:00:03 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi all,

I believe that I've encountered a bug in dash 0.5.10.2. With the
following input
	
	f () {
		echo $var
	}

	var=test f
	echo $var

I would expect the output to be
	
	test
	test

but the output is actually

	test
	<blank>

It seems like this violates the POSIX spec. Quoting Junio C Hamano[1]:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Tarmigan Casebolt schrieb:
> >>         REQUEST_METHOD="GET" some_shell_function
> >
> >> I can't tell from my reading of the POSIX spec whether my usage was
> >> wrong or if dash is wrong,
> >
> > According to POSIX, variables set as shown above for shell functions are
> > not exported and retain their value after the function returns.
> 
> I actually looked for this yesterday, but didn't find a relevant
> definition.  But "2.9.5 Function Definition Command" [*1*] seems to
> address the issue: "When a function is executed, it shall have the
> syntax-error and variable-assignment properties described for special
> built-in utilities...".
> 
> And "2.14 Special Built-in Utilities" section [*2*] says "2. Variable
> assignments specified with special built-in utilities remain in effect
> after the built-in completes...".  Taking both together, it seems that
> the assignment should be in effect after the function returns.
> 
[...]
> 
> [References]
> 
> *1* http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_05
> *2* http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_14

It also seems like on bash 5.0.16, running with --posix produces the
expected output, although without --posix it produces the blank line.

Originally discussed here[2].

Thanks,

Denton

[1]: https://lore.kernel.org/git/7vljfzz0yd.fsf@alter.siamese.dyndns.org/
[2]: https://lore.kernel.org/git/20200430092220.GA25331@generichostname/
