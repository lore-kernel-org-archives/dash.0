From: Dirk Fieldhouse <fieldhouse@gmx.net>
Subject: 'return' from subshell in function doesn't
Date: Sun, 8 Mar 2020 12:35:17 +0000
Message-ID: <9b3a55fb-df00-8ac3-7a1e-b60e24aa2970@gmx.net>
References: <S1726267AbgCHLof/20200308114435Z+1505@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgCHMfT (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Mar 2020 08:35:19 -0400
Received: from [192.168.77.222] ([51.6.64.192]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1izbAX0Jfb-00Q8UL for
 <dash@vger.kernel.org>; Sun, 08 Mar 2020 13:35:18 +0100
In-Reply-To: <S1726267AbgCHLof/20200308114435Z+1505@vger.kernel.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: DASH mailing list <dash@vger.kernel.org>

POSIX
<https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html=
#return>
says, and has since at least 2004:
"The return utility shall cause the shell to stop executing the current
function or dot script. If the shell is not currently executing a
function or dot script, the results are unspecified."

Clear enough, one would think, but consider this example:

foo() {
  echo "$1" |
    while read -r xx _; do
      if [ "$xx" =3D fum ]; then
        echo EQ
        return 0
      fi
    done
  echo NE
  return 1
}

According to the spec we expect:

$ foo fum || echo WTF
EQ
$

What actually happens, with DASH-0.5.8-2.1ubuntu2 and -0.5.9.1 built
from source:

$ foo fum || echo WTF
EQ
NE
WTF
$ foo baz || echo OK
NE
OK
$

Same with bash-4.3-14ubuntu1.4, busybox-static-1:1.22.0-15ubuntu1.4.

A simpler test case shows that the issue is 'return' not breaking out of
a subshell:

bar() {
( if [ "$1" =3D fum ]; then
        echo EQ
        return 0
      fi )
  echo NE
  return 1
}

barbar() {
  if [ "$1" =3D fum ]; then
    echo EQ
    return 0
  fi
  echo NE
  return 1
}

$ bar fum || echo WTF
EQ
NE
WTF
$ bar baz || echo OK
NE
OK
$ barbar fum || echo WTF
EQ
$

As POSIX refers to subshells explicitly elsewhere (eg 'exit') it's
difficult to believe that "subshell" was accidentally omitted from the
list of contexts that 'return' should return from, but implementation
behaviours consistently contradict the spec as written. Can they be made
conformant without breaking existing scripts?

A work-around is to make any subshell explicit and 'exit' from it:

foo_wa() {
  echo "$1" |
    ( while read -r xx _; do
      if [ "$xx" =3D fum ]; then
        echo EQ
        exit 0
      fi
    done; exit 1 ) && return
  ret=3D$?
  echo NE
  return $ret
}

$ foo_wa fum || echo WTF
EQ
$


=2D-
London SW6
UK
