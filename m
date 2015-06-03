From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: [BUG] ${#var} returns length in bytes, not characters
Date: Wed, 3 Jun 2015 12:45:19 +0100
Message-ID: <20150603114519.GB4767@chaz.gmail.com>
References: <556EE51D.8080100@inlv.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51602 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbbFCLup (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 3 Jun 2015 07:50:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1Z07Bk-0002l9-Lt
	for dash@vger.kernel.org; Wed, 03 Jun 2015 13:50:28 +0200
Received: from 05448b1b.skybroadband.com ([5.68.139.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 03 Jun 2015 13:50:28 +0200
Received: from stephane.chazelas by 05448b1b.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 03 Jun 2015 13:50:28 +0200
Content-Disposition: inline
In-Reply-To: <556EE51D.8080100@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2015-06-03 13:29:33 +0200, Martijn Dekker:
> POSIX:
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
> > ${#parameter}
> > String Length. The length in characters of the value of parameter
> > shall be substituted. [...]
> 
> dash does not expand the length in characters; it expands the length in
> bytes instead. That is invalid for locales that include multi-byte
> characters, such as the now ubiquitous UTF-8 set.
[...]

See also:

http://thread.gmane.org/gmane.comp.standards.posix.austin.general/9972/focus=10040

For a few UTF-8 related variations in behaviour between shells
(including this one), though many of them are about "unspecified
behaviour".

The script mentioned there is also attached here.

-- 
Stephane

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=u8-tests

euro=$(printf '\342\202\254')
o342=$(printf '\342')
o202=$(printf '\202')
o254=$(printf '\254')

test_shell=$1

n=0
case $test_shell in
  zsh) emulate sh;;
  zsh5) setopt shwordsplit;;
  [lm]ksh) set -o utf8-mode;;
esac

if [ -n "$test_shell" ]; then
  printf '%8s:' "$test_shell"
  testing() {
    n=$(($n + 1))
    test
    ret=$?
    [ "$ret" -eq "$na" ] && ret=-
    printf ' %2s' "$ret"
    [ "$ret" = "$1" ] && printf '\342\203\235'
  }
else
  testing() {
    n=$(($n + 1))
    printf '%2d: %s (expected: %d)\n' "$n" "$2" "$1"
  }
fi

na=99
if_accept_invalid() { [ "$o254" ] || exit "$na"; }
if_printf_builtin() {
  case $(type printf 2> /dev/null) in
    *builtin*);;
    (*) exit "$na"
  esac
}

################################################################
test() (
  exit "${#euro}"
)
testing 1 '${#utf8-character}'
################################################################
test() (
  if_accept_invalid
  exit "${#o254}"
)
testing 1 '${#single byte, invalid char}'
################################################################
test() (
  if_accept_invalid
  t=$o342$o202
  exit "${#t}"
)
testing 2 '${truncated character, 2 bytes}'
################################################################
test() (
  if_accept_invalid
  case $euro in
    *"$o254"*) true;;
    *) false
  esac
)
testing 0 '$char contains byte component'
################################################################
test() (
  if_accept_invalid
  t=+$euro-
  [ "${t##*"$o254"}" = - ]
)
testing 0 '${##} matching with byte components of $mbchar'
################################################################
test() (
  if_accept_invalid
  t=+$o254$euro-
  [ "${t##*"$euro"}" = - ]
)
testing 0 '${##} works in invalid strings'
################################################################
test() (
  if_accept_invalid
  IFS=$o254
  t=+$euro+
  set -- $t
  exit "$#"
)
testing 2 'byte component found in $mbchar by IFS'
################################################################
test() (
  if_accept_invalid
  IFS=$o342$o202
  t=+$euro+
  set -- $t
  exit "$#"
)
testing 3 'byte component found in $mbchar by IFS'
################################################################
test() (
  if_accept_invalid
  IFS=$o254
  t=+$o254+
  set -- $t
  exit "$#"
)
testing 2 'IFS works with bytes'
################################################################
test() (
  IFS=$euro
  t=+$euro+
  set -- $t
  exit "$#"
)
testing 2 'IFS works with mbchars'
################################################################
test() (
  if_accept_invalid
  IFS=$euro
  t=+$o254$o342$euro+
  set -- $t
  exit "$#"
)
testing 2 'IFS works with mbchars in invalid strings'
################################################################
test() (
  if_accept_invalid
  IFS=$o342$o202
  set / /
  [ "$*" = "/$o342/" ]
)
testing 0 'Joining $* with byte forming invalid char'
################################################################
test() (
  IFS=$euro
  set / /
  [ "$*" = "/$euro/" ]
)
testing 0 'Joining $* with mbchar'
################################################################
test() (
  if_printf_builtin
  exit "$(printf '%4s' "$euro" | wc -c | tr -cd 0-9)"
)
testing 6 'byte length of 4-padded euro'
################################################################
test() (
  if_accept_invalid
  if_printf_builtin
  exit "$(printf '%4s' "$o342$o202" | wc -c | tr -cd 0-9)"
)
testing 4 'byte length of 4-padded truncated mbchar'
################################################################
test() (
  case $euro in
    ?) true;;
    (*) false
  esac
)
testing 0 '? matches mbchar'
################################################################
test() (
  if_accept_invalid
  case $o342$o202 in
    ??) true;;
    (*) false
  esac
)
testing 0 '?? matches 2-byte truncated mbchar'
################################################################


echo
if [ -z "$test_shell" ]; then
  printf '%8s:' tests
  i=1; while [ "$i" -le "$n" ]; do
    printf ' %2d' "$i"
    i=$(($i + 1))
  done
  printf '\n\n'
  for test_shell in dash zsh yash bash lksh mksh ksh93 zsh5 posh; do
    "$test_shell" "$0" "$test_shell"
  done
fi

--Nq2Wo0NMKNjxTN9z--

