From: Martijn Dekker <martijn@inlv.org>
Subject: [PATCH] parseheredoc: fix alias expansion: save and restore checkkwd
Date: Sat, 25 Jan 2020 13:19:56 +0100
Message-ID: <0c506ff6-6da5-f117-b0b3-d3cf7cc008ed@inlv.org>
References: <40db0aa1-195b-f29e-5068-01fa101affd9@inlv.org>
 <8b48cd04-b85f-1086-55c8-8e17800f5693@gigawatt.nl>
 <f40ce455-afd8-05f4-e594-4395bb2a8ed0@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B9807BD62B9E3F3866BA8E8F"
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:58604 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAYMUD (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 25 Jan 2020 07:20:03 -0500
In-Reply-To: <f40ce455-afd8-05f4-e594-4395bb2a8ed0@gigawatt.nl>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, DASH shell mailing list <dash@vger.kernel.org>

This is a multi-part message in MIME format.
--------------B9807BD62B9E3F3866BA8E8F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 25-01-20 om 02:38 schreef Harald van Dijk:
> On 25/01/2020 01:13, Harald van Dijk wrote:
>> On 24/01/2020 23:48, Martijn Dekker wrote:
>>> There is a regression involving alias expansion, a here-document, and 
>>> a command substitution. The following worked fine until dash 0.5.8; 
>>> it throws a syntax error as of dash 0.5.9.
>>>
>>> alias BEGIN='{' END='}'
>>> BEGIN
>>> cat <<eof
>>> $(echo hi)
>>> eof
>>> END
>>
>> Nice find.
>>
>> When the newline after cat <<eof is seen, checkkwd is changed to 
>> indicate that the shell is in a state where aliases can be expanded. 
>> Then, parseheredoc() is called, which in turn calls readtoken1() to 
>> parse the here-document. readtoken() re-sets checkkwd once it is done, 
>> but readtoken1() does not, so normally this preserves the "can expand 
>> aliases" state. However, nested command substitutions do reset 
>> checkkwd, so things break.
>>
>> Until 0.5.8, parseheredoc() was called first, and only after that did 
>> checkkwd get changed.
>>
>> Either parseheredoc() needs to save and restore checkkwd, or the code 
>> calling parseheredoc() needs to ensure that it sets checkkwd as 
>> appropriate afterwards.

Saving and restoring checkkwd in parseheredoc() seems the simplest and 
the most future-proof, so here's a patch to do that.

> There is another place that parseheredoc() can be called from where 
> checkkwd was not being corrected afterwards:
> 
>    alias BEGIN='{' END='}'
>    : <<EOF &&
>    $(echo hi)
>    EOF
>    BEGIN
>    echo ok
>    END
> 
> This has been failing for longer.

The patch fixes this as well.

-- 
modernish -- harness the shell
https://github.com/modernish/modernish

--------------B9807BD62B9E3F3866BA8E8F
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="parseheredoc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="parseheredoc.patch"

ZGlmZiAtLWdpdCBhL3NyYy9wYXJzZXIuYyBiL3NyYy9wYXJzZXIuYwppbmRleCBiMzE4YjA4
Li44ODQwMjYyIDEwMDY0NAotLS0gYS9zcmMvcGFyc2VyLmMKKysrIGIvc3JjL3BhcnNlci5j
CkBAIC02NjEsNiArNjYxLDcgQEAgcGFyc2VmbmFtZSh2b2lkKQogU1RBVElDIHZvaWQKIHBh
cnNlaGVyZWRvYyh2b2lkKQogeworCWludCBzYXZlY2hlY2trd2QgPSBjaGVja2t3ZDsKIAlz
dHJ1Y3QgaGVyZWRvYyAqaGVyZTsKIAl1bmlvbiBub2RlICpuOwogCkBAIC02ODMsNiArNjg0
LDggQEAgcGFyc2VoZXJlZG9jKHZvaWQpCiAJCWhlcmUtPmhlcmUtPm5oZXJlLmRvYyA9IG47
CiAJCWhlcmUgPSBoZXJlLT5uZXh0OwogCX0KKworCWNoZWNra3dkID0gc2F2ZWNoZWNra3dk
OwogfQogCiBTVEFUSUMgaW50Cg==
--------------B9807BD62B9E3F3866BA8E8F--
