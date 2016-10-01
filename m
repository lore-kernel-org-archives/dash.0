From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: dash tested against ash testsuite: 17 failures
Date: Sat, 1 Oct 2016 19:17:12 +0200
Message-ID: <CAK1hOcMma=uH2R=vWX1Z6r2xf9PcW7MPSEPYOk76Zn97LD-7Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c042fbeefc1ef053dd0e297
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36838 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbcJARRe (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 1 Oct 2016 13:17:34 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so133129559qkc.3
        for <dash@vger.kernel.org>; Sat, 01 Oct 2016 10:17:34 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, busybox <busybox@busybox.net>, Ron Yorston <rmy@pobox.com>, dash@vger.kernel.org

--94eb2c042fbeefc1ef053dd0e297
Content-Type: text/plain; charset=UTF-8

ash-signals/savetrap.tests
While trying to port some fixes from dash,
one of them broke some signal handling testcases.

I guess some of things we test for are not tested
by dash developers.

I ran entire ash testsuite against dash, deleted failing
things which dash does not support (some bashisms),
and false positives caused by differences in error
messages.

What's left is:

ash-glob/glob2.tests:
    Evidently, dash supports \f -> ^L escape.
    This test uses \f as invalid backslash escape,
    hence differences.

ash-misc/echo_write_error.tests
    EPIPE errors in echo are not reported

ash-misc/func2.tests
    $((i++)) not supported

ash-misc/local1.tests
    Doesn't unset as described:
        local a
        # the above line unsets $a
        echo "A2:'$a'"

ash-misc/shift1.tests
    "shift N" fails if fewer than N argv[i] exists
    (likely not a bug, but bash does it differently)

ash-redir/redir.tests
    echo errors due to closed stdout are not reported

ash-redir/redir3.tests
    "echo foo >&9" correctly says "9: Bad file descriptor"
    and exitcode is 2 (in bash, it is 1).

ash-redir/redir7.tests
ash-redir/redir8.tests
    uni\x81code filename is not found by uni?code glob pattern.

ash-signals/reap1.tests
    Builtins never wait for children. This loop will not ever stop:
    sleep 1 &
    PID=$!
    while kill -0 $PID >/dev/null 2>&1; do
        true
    done

ash-signals/savetrap.tests
    `trap` does not work as expected

ash-signals/sigint1.tests
    trap "exit 0" SIGINT - does not like name "SIGINT". "INT" works.

ash-signals/signal4.tests
    trap "echo Trapped" BADNAME TERM - abort seeing BADNAME.
    bash complains, but sets the trap for the second signal.

ash-signals/signal8.tests
    "kill %1" in non-interactive shell does not find
    previously backgrounded task.

ash-vars/var-utf8-length.tests
    ${#VAR} counts unicode chars in bash

ash-vars/var_unbackslash.tests
    b=-$a-\t-\\-\"-\`-\--\z-\*-\?-
    b="-$a-\t-\\-\"-\`-\--\z-\*-\?-"
    b='-$a-\t-\\-\"-\`-\--\z-\*-\?-'
    b1=$b
    "b1=$b"
    You can imagine... not everything went well here...

ash-vars/var_unbackslash.tests
    echo Forty two:$\
    (\
    (\
    42\
    )\
    )
    dash says: Syntax error: Missing '))'


The tarball is attached. Unpack, add an ash -> /path/to/your/dash
symlink, then run ./run-all

--94eb2c042fbeefc1ef053dd0e297
Content-Type: application/x-gzip; name="ash_test.tar.gz"
Content-Disposition: attachment; filename="ash_test.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itrgmxbv0

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
--94eb2c042fbeefc1ef053dd0e297--
