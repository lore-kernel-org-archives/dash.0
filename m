From: Rusty Bird <rustybird@openmailbox.org>
Subject: Re: Ignored alias inside for loop
Date: Sun, 26 Jul 2015 16:09:12 +0000
Message-ID: <55B50628.5090901@openmailbox.org>
References: <55B4A728.9080303@openmailbox.org> <20150726152602.GA4346@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3.openmailbox.org ([62.4.1.37]:42429 "EHLO
	smtp3.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbbGZQKA convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 26 Jul 2015 12:10:00 -0400
In-Reply-To: <20150726152602.GA4346@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Jilles,

> Aliases are expanded during parsing, not during execution (like 
> functions are). The for loop is parsed completely before it is
> executed.

Ah, what confused me was that I wrongly remembered it working inside
an if (instead of for) block. But looking again now, only the alias
*definition* was inside.

> Using a function instead of an alias, or using eval will do what
> you want.

Do you mean replacing the line with: eval "alias foobarbaz='echo ok'"
That doesn't seem to work either (in dash or bash).

> Note that some parts of the parse/execute split are not specified
> by POSIX. In particular, ksh93 and the real Bourne shell parse dot
> scripts completely before executing anything, while most other
> shells parse as needed. Example: given the file alias1.sh below:
> 
> alias foobarbaz='echo ok' foobarbaz
> 
> The result is ok when running  dash -c '. ./alias1.sh'  but a
> command not found error message when running  ksh93 -c '.
> ./alias1.sh'.
> 
> Similarly, a string as passed to the -c option or eval or trap
> builtins may or may not be parsed fully before execution.

Interesting, thanks!

Rusty
-----BEGIN PGP SIGNATURE-----

iQJ8BAEBCgBmBQJVtQYoXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQ4NEI1OUJDRkM2MkIxMjlGRTFCMDZEMDQ0
NjlENzhGNDdBQUYyQURGAAoJEEadePR6ryrfCwUP/AtBWQpOEajCsghiYrkDmVpS
FuDMMo9s+uUTwJ6zrVviuj4cCfaigDBr1hlmc5ETjIMxbqgXYmG0o1GDkUvohKDR
4apjVRXATe8Xuia+E94rZTqv1iAv+udCD1BVhH9SB0Hbc9Jf9bxAqY6JI+GxoPRc
ea4tGDAPdPl9NJ69pPXP5AuDplqQOuap8BKzG00bu422z4CkIorvsg0W4+Ya+k+j
KZetjxj6N8vF17gOLpWNuxtJKbDEokNhHCGuf3hS1+7SEibJKYhb3GkyDGJ5EPYv
m3AocOlfSEuhZR8Dt5bK4gPNByrxl03PabBGmXVQaBzqjn+vIfykcuESXSHcl5SA
02FVY3pWAZKPCGWnG2JcGZpn6jQJQt5fNtM5ooixmzvFM/f0ItOL3EFKwHzIZxh1
ic+qIZcO8RrwfKktM3vytZ3fkSAVWJMcflj34+ce5A/LyfdrrqAkJGI3AbEul+Q6
mQoYZGBL7Uq2tgBWNveWzAByaewiW/+nlLhUXQh69L3X1cjkkrULGDTSaV+EYZ+z
mJP3qQcAB2DVnr757XgIh4kkDX8MDY4ZYVB+8ApgImUnBoklSSJeWXnBt+KwZgk7
Rok5FxIde3OgyYB9tjzDF/EAZXKTKNLrXFkhhat9j2c8+8VptVNcw77HP2bbcgOE
78H1zJW4UF8ntB5SGLTd
=qogf
-----END PGP SIGNATURE-----
