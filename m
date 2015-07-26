From: Rusty Bird <rustybird@openmailbox.org>
Subject: Ignored alias inside for loop
Date: Sun, 26 Jul 2015 09:23:52 +0000
Message-ID: <55B4A728.9080303@openmailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp10.openmailbox.org ([62.4.1.44]:58453 "EHLO
	smtp10.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbbGZJba convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 26 Jul 2015 05:31:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail2.openmailbox.org (Postfix) with ESMTP id 9007E20220C
	for <dash@vger.kernel.org>; Sun, 26 Jul 2015 11:24:44 +0200 (CEST)
Received: from mail2.openmailbox.org ([62.4.1.33])
	by localhost (mail.openmailbox.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PwrAFTGpi3R5 for <dash@vger.kernel.org>;
	Sun, 26 Jul 2015 11:24:43 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

Why does this ...

#!/bin/sh
for i in 1; do
    alias foobarbaz='echo ok'
    foobarbaz
done

... result in "foobarbaz: not found", but without the for loop it works?
Maybe I'm missing something in the spec, because bash-as-sh behaves
the same.

Rusty
-----BEGIN PGP SIGNATURE-----

iQJ8BAEBCgBmBQJVtKcoXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQ4NEI1OUJDRkM2MkIxMjlGRTFCMDZEMDQ0
NjlENzhGNDdBQUYyQURGAAoJEEadePR6ryrfWacQAI0/zf4f4K0oJ+xM0wprmtiq
4aj5UfOasXZji6cPvc0VGZcSK+rVFdT8EW6XIoMlkU8Lxp9aVLuaQtjcez9JhwIM
k0V7cNhAGuyIAPNL/t6CHPb92MXSfHXf0SFZ6oDilMMtc9i38GDvAeA1RuS0bhrl
W2kolIWeaaeQk2q5bMN66Mj86509NC9aXVBXatvCUHgqpNNDu2elgGOs/Isd2KVC
TDk4qqDgm5wTLuQ0DMZ6KF4Odut8pW7HDhJMO82Y2ghqp5WH3OTgcgR+XTXeN/9Y
Kp1Rix3Lse+7q6cMq7CdYhcGTh0eiDJxGaCNY7ho0klOH3MAvoQmEjJucXUpRB9T
wOCliQOtppyA9rvsDqLfHbPFp8EHYUaLc9vpNUatURa44GyU/ks2LPexrMDg9mgC
CmttZZVjDIe8L8mJ4Ot99dLmCsB2dIcJfM8lMTufFaWr5CrYNDCXx85dDHNYP416
3t4FHPh3WNk43KbAVfc4VvXn77Ao1HUVRhambxmux4B0fudqTFERtZv+u2EmHE5a
krp42fho4G65BC9Gewsy1lwUj3FRum5gXYzEoMV3gWFyLFVa1v+v8sC3DQbk8waq
cvv9XuUUTky1Ksudpo7WJboY50H36hlbdHVwrhQIX8SWN44IvAW6ceJ4r+VBBq+C
heQEjK/iUn0hkhtt8MdZ
=H2bf
-----END PGP SIGNATURE-----
