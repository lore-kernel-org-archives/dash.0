From: "Rocky Bernstein" <rocky.bernstein@gmail.com>
Subject: LINENO patch
Date: Mon, 23 Jun 2008 21:34:05 -0400
Message-ID: <6cd6de210806231834w634fb15ai4e86e658890e44e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8684_15542792.1214271245671"
Return-path: <dash-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:2130 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYFXBeG (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Jun 2008 21:34:06 -0400
Received: by py-out-1112.google.com with SMTP id p76so1184217pyb.10
        for <dash@vger.kernel.org>; Mon, 23 Jun 2008 18:34:06 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

------=_Part_8684_15542792.1214271245671
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks like in contrast to what the dash.1 manual page says, expansion
of PS{1,2,4} does work.

Here is a little patch to set LINENO. The ways in that it is less than
ideal mirror the ways that the line number error reporting is also
less than ideal.

For example if you run this:

(
    x=$((1/0))
    # Just to add another line
    # And another
) # error reports this line

The error reported will be  the closing parenthesis even though I
think most people would prefer the error to be the one where x was
set.

On 6/23/08, Rocky Bernstein <rocky.bernstein@gmail.com> wrote:
> I have been looking at dash recently and notice in the manual page:
>
>  BUGS: PS1, PS2, and PS4 should be subject to parameter expansion
>  before being displayed.
>
>  Also I notice that there isn't a builtin LINENO which POSIX suggests
>  (e.g. http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html)
>
>  I've been considering rectifying this. What's the protocol for
>  submitting a patch, and/or the likelihood this would get into a
>  release assuming the patch is reasonable.
>
>  Is there currently a schedule for the next release?
>
>  Thanks.
>

------=_Part_8684_15542792.1214271245671
Content-Type: application/octet-stream; name=lineno.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhtto6z4
Content-Disposition: attachment; filename=lineno.diff

ZGlmZiAtLWdpdCBhL3NyYy9wYXJzZXIuYyBiL3NyYy9wYXJzZXIuYwppbmRleCBlODkxZDMxLi4x
Y2ZlZTBhIDEwMDY0NAotLS0gYS9zcmMvcGFyc2VyLmMKKysrIGIvc3JjL3BhcnNlci5jCkBAIC03
NzUsNyArNzc1LDggQEAgeHhyZWFkdG9rZW4odm9pZCkKIAkJCWNvbnRpbnVlOwogCQljYXNlICdc
XCc6CiAJCQlpZiAocGdldGMoKSA9PSAnXG4nKSB7Ci0JCQkJc3RhcnRsaW5ubyA9ICsrcGxpbm5v
OworCQkJICAJc2V0dmFyaW50KCJMSU5FTk8iLCBwbGlubm8rKywgMCk7CisJCQkgICAgICAgIHN0
YXJ0bGlubm8gPSBwbGlubm87CiAJCQkJaWYgKGRvcHJvbXB0KQogCQkJCQlzZXRwcm9tcHQoMik7
CiAJCQkJY29udGludWU7CkBAIC03ODMsNyArNzg0LDcgQEAgeHhyZWFkdG9rZW4odm9pZCkKIAkJ
CXB1bmdldGMoKTsKIAkJCWdvdG8gYnJlYWtsb29wOwogCQljYXNlICdcbic6Ci0JCQlwbGlubm8r
KzsKKwkJICAJc2V0dmFyaW50KCJMSU5FTk8iLCBwbGlubm8rKywgMCk7CiAJCQluZWVkcHJvbXB0
ID0gZG9wcm9tcHQ7CiAJCQlSRVRVUk4oVE5MKTsKIAkJY2FzZSBQRU9GOgpAQCAtODg1LDcgKzg4
Niw3IEBAIHJlYWR0b2tlbjEoaW50IGZpcnN0YywgY2hhciBjb25zdCAqc3ludGF4LCBjaGFyICpl
b2ZtYXJrLCBpbnQgc3RyaXB0YWJzKQogCQkJCWlmIChzeW50YXggPT0gQkFTRVNZTlRBWCkKIAkJ
CQkJZ290byBlbmR3b3JkOwkvKiBleGl0IG91dGVyIGxvb3AgKi8KIAkJCQlVU1RQVVRDKGMsIG91
dCk7Ci0JCQkJcGxpbm5vKys7CisJCQkJc2V0dmFyaW50KCJMSU5FTk8iLCBwbGlubm8rKywgMCk7
CiAJCQkJaWYgKGRvcHJvbXB0KQogCQkJCQlzZXRwcm9tcHQoMik7CiAJCQkJYyA9IHBnZXRjKCk7
CkBAIC0xMDY1LDcgKzEwNjYsNyBAQCBjaGVja2VuZDogewogCiAJCWlmIChjID09ICdcbicgfHwg
YyA9PSBQRU9GKSB7CiAJCQljID0gUEVPRjsKLQkJCXBsaW5ubysrOworCQkJc2V0dmFyaW50KCJM
SU5FTk8iLCBwbGlubm8rKywgMCk7CiAJCQluZWVkcHJvbXB0ID0gZG9wcm9tcHQ7CiAJCX0gZWxz
ZSB7CiAJCQlpbnQgbGVuOwpAQCAtMTMxNSw3ICsxMzE2LDcgQEAgcGFyc2ViYWNrcTogewogCiAJ
CQljYXNlICdcXCc6CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgocGMgPSBw
Z2V0YygpKSA9PSAnXG4nKSB7Ci0JCQkJCXBsaW5ubysrOworCQkJCSAgICAgICAgc2V0dmFyaW50
KCJMSU5FTk8iLCBwbGlubm8rKywgMCk7CiAJCQkJCWlmIChkb3Byb21wdCkKIAkJCQkJCXNldHBy
b21wdCgyKTsKIAkJCQkJLyoKQEAgLTEzNDAsNyArMTM0MSw3IEBAIHBhcnNlYmFja3E6IHsKIAkJ
CQlzeW5lcnJvcigiRU9GIGluIGJhY2txdW90ZSBzdWJzdGl0dXRpb24iKTsKIAogCQkJY2FzZSAn
XG4nOgotCQkJCXBsaW5ubysrOworCQkJICAgICAgICBzZXR2YXJpbnQoIkxJTkVOTyIsIHBsaW5u
bysrLCAwKTsKIAkJCQluZWVkcHJvbXB0ID0gZG9wcm9tcHQ7CiAJCQkJYnJlYWs7CiAKZGlmZiAt
LWdpdCBhL3NyYy92YXIuYyBiL3NyYy92YXIuYwppbmRleCA3ZjlhZjljLi5lZTU0MmEwIDEwMDY0
NAotLS0gYS9zcmMvdmFyLmMKKysrIGIvc3JjL3Zhci5jCkBAIC05MCw2ICs5MCw3IEBAIHN0cnVj
dCB2YXIgdmFyaW5pdFtdID0gewogCXsgMCwJVlNUUkZJWEVEfFZURVhURklYRUQsCQkiUFMyPT4g
IiwJMCB9LAogCXsgMCwJVlNUUkZJWEVEfFZURVhURklYRUQsCQkiUFM0PSsgIiwJMCB9LAogCXsg
MCwJVlNUUkZJWEVEfFZURVhURklYRUQsCQkiT1BUSU5EPTEiLAlnZXRvcHRzcmVzZXQgfSwKKwl7
IDAsCVZTVFJGSVhFRHxWVEVYVEZJWEVEfFZVTlNFVCwJIkxJTkVOT1wwIiwJMCB9LAogI2lmbmRl
ZiBTTUFMTAogCXsgMCwJVlNUUkZJWEVEfFZURVhURklYRUR8VlVOU0VULAkiVEVSTVwwIiwJMCB9
LAogCXsgMCwJVlNUUkZJWEVEfFZURVhURklYRUR8VlVOU0VULAkiSElTVFNJWkVcMCIsCXNldGhp
c3RzaXplIH0sCg==
------=_Part_8684_15542792.1214271245671--
