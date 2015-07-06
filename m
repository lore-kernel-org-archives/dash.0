From: Parke <parke.nexus@gmail.com>
Subject: dash unset idiosyncrasies
Date: Sun, 5 Jul 2015 19:18:15 -0700
Message-ID: <CAPxz1+Zuye=Oj=tWvto9_ir5XcgazBY=2asesR77qRrFuTbc2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:35178 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbGFCS4 convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 5 Jul 2015 22:18:56 -0400
Received: by lagh6 with SMTP id h6so137381640lag.2
        for <dash@vger.kernel.org>; Sun, 05 Jul 2015 19:18:54 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

The man page for dash says:

     unset [-fv] name ...
            The specified variables and functions are
            unset and unexported.  If -f or -v is speci=E2=80=90
            fied, the corresponding function or variable
            is unset, respectively.  If a given name cor=E2=80=90
            responds to both a variable and a function,
            and no options are given, only the variable is
            unset.

The man page does not say what happens if the given name corresponds
only to a function.

Based on experimentation, I have determined that in dash versions
0.5.7, 0.5.8, and git head, "unset name" (without -f) will only unset
variables and will never unset any function.

In addition, during my experiments, I discovered idiosyncrasies that
are demonstrated by the following script.

The script runs a series of tests.  Each test sets a variable and
function, both named "true" (so as to overshadow /bin/true).  The test
then tries to unset either the variable, or the function, or both.
The test then probes the existence of the variable and function, and
compares to the expected result.

----

#! /bin/dash

unit () {

  # $1 is an unset command
  # $2 is the expected result

  n=3D$(( $n + 1 ))    # $n counts each test

  # define a variable and function named "true".
  # we use "true" because /bin/true will still run
  # successfully even if the function is unset.
  true=3D'var '
  true ()  { echo 'fun' ; }

  # print the test number and the unset command
  printf "%2d  %-30s  "  "$n"  "$1"

  # run the unset command
  $1

  # probe the variable and function
  actual=3D"$true"`true`

  # compare actual to expected
  if [ "$actual" =3D "$2" ]; then
    printf "   pass\n"
  else
    printf ">> FAIL\n"
    printf "%37s  expect  %s\n" '' "$2"
    printf "%37s  actual  %s\n" '' "$actual"
  fi

}

n=3D0

unit    'unset'                         'var fun'
unit    'unset       true'              'fun'
unit    'unset -f    true'              'var '
unit    'unset -v    true'              'fun'
unit    'unset -fv   true'              ''
unit    'unset -vf   true'              ''
unit    'unset -f -v true'              ''
unit    'unset -v -f true'              ''
unit    'unset -f true -v true'         ''
unit    'unset -f true -f true'         'var '
unit    'unset -f true -f true -f true' 'var '
unit    'unset -f true -v true -f true' ''
unit    'unset -v true -v true'         'fun'
unit    'unset -v true -f true'         ''

----

Running the above script produces identical output with dash versions
0.5.7, 0.5.8 and git head.  The output is:

 1  unset                              pass
 2  unset       true                   pass
 3  unset -f    true                   pass
 4  unset -v    true                   pass
 5  unset -fv   true                >> FAIL
                                       expect
                                       actual  fun
 6  unset -vf   true                >> FAIL
                                       expect
                                       actual  var
 7  unset -f -v true                >> FAIL
                                       expect
                                       actual  fun
 8  unset -v -f true                >> FAIL
                                       expect
                                       actual  var
 9  unset -f true -v true           >> FAIL
                                       expect
                                       actual  var
10  unset -f true -f true              pass
11  unset -f true -f true -f true      pass
12  unset -f true -v true -f true   >> FAIL
                                       expect
                                       actual  var
13  unset -v true -v true           test.sh: 17: unset: -v: bad variabl=
e name

----

In tests 5 through 9, and in test 12, I expect both the variable named
"true" and the function named "true" to be unset.

Unexpectedly, in tests 5 and 7, the function named "true" remains set.

Also unexpectedly, in tests 6, 8, 9, and 12, the variable named "true"
remains set.

Very unexpectedly, the script exits due to a fatal error in the middle
of test 13.  Consequently, test 14 is never run.

Interestingly, there appears to be no way to unset both a variable and
a function with a single unset command.

The following link, apparently to "IEEE Std 1003.1, 2013 Edition", may
be relevant:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#unset

The current man page in git is here:
http://git.kernel.org/cgit/utils/dash/dash.git/tree/src/dash.1#n2195

Based on my experiments, I would recommend the dash man page be
changed as follows.  Changes are in capital letters.

     unset [-fv] name ...
            The specified VARIABLES OR FUNCITONS
            (BUT NOT BOTH) are
            unset and unexported.  If -f or -v is speci=E2=80=90
            fied, the corresponding functionS or variableS
            ARE unset, respectively.  IF NEITHER OPTION
            IS GIVEN, ONLY THE NAMED VARIABLES
            ARE UNSET.

Cheers,

Parke
