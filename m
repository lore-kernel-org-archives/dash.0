Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0EF1B87F5
	for <dash@vger.kernel.org>; Sun, 15 Dec 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300821; cv=none; b=UQK/VhQKoMULGkmWyDJ+wjcV0UEYkLjK75eqytQ/GH3eQVXRfnvDqFlOkf9dRVU9Tjk5ZV5s43b5LLQgQpEPx8REvEDmx1XQ7JFAVGFiV+QfIO7640OOFT/VYXBAdUnDBLk4wZAkeyzEs7FL70KKi/ET4Zh5jzlN89IWAn7C5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300821; c=relaxed/simple;
	bh=kDBnqR0oKvAPdbcz6FFAgKhw9iP0b2FwFVrSE4f4Uwk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BpQLoLJpa+lLLtXew5+/mZo775WTNu0u06fuI3vZIBUomxZN0Mih12OLYXXkJ9Wi6RArx6R0m4Bv7jkjI8uIjVUyzCVOz8crDzhPrGe31J0mis2yFowMVevA4wXMKdbTaTqzq68epYiMW7m8u9Twk8mTrwOC3C70OyaC3gwrhXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHuT84S9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHuT84S9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e3621518so1590534f8f.1
        for <dash@vger.kernel.org>; Sun, 15 Dec 2024 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734300818; x=1734905618; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kDBnqR0oKvAPdbcz6FFAgKhw9iP0b2FwFVrSE4f4Uwk=;
        b=AHuT84S9bvJqy8fyuAQfiQzpKjCOnaD/BeR2DoNfwSy65FoWv9yu+KqmvM02FQGToc
         zmtPt7MPMPrKeJ2w9GbOEDzEZtBhLJbknOeXn0f7R0qD8b5g8TkmaejMAcwcBTQ35Dxg
         10+9/5jYpG+If6LG3aysxOfm689ea8lmzejt2m5OZBLfF1ClRTtGTKlcobOaEyaXsaVt
         6WpCH8xiCCvhn++TP8w8mCVKwQDqGe8jMkPcWD73dRXs6Zju3ztPmCl8RMk/PqS3l9ro
         /qP2vwcqkJNd0Auont54NFOsXrLWJGvliuouoBqUqzWyewt9TRAYkgGb26WVmDBxDcdR
         RxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734300818; x=1734905618;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDBnqR0oKvAPdbcz6FFAgKhw9iP0b2FwFVrSE4f4Uwk=;
        b=sly5IhEN1+NXQ7oxrCZGOsDFjjiXkSPkrpjkLsh415Vf/pE6LCDrdtfA9WdHMyfLws
         CmuMc9BxgWY0wQP179uwz97jQhzjOfCLjRXLzwwKMCHEV8YXa9UTBxeHiP6yqpwjapIv
         wa3hPgwod9iPIc7vhtwL7I+/pXHm6x/6uO52tDLhMyUVwvYJeEktH4btmcXFDKmuFI8s
         faZXm28NqbiJEut9fLZ8GqFa4dKmcM03Ki7CbdSrFcg3/tJ1Ka8n9EchfrPt/Q5kOzzj
         nULqR97FXeQEmgK04NsQwthZB6JUQ7PQNuDJz3tSK6IsQgZGbKDO/ugUJfGGmzZLClSN
         E26g==
X-Gm-Message-State: AOJu0Yy1aCHMDsW/OmBWZ4cAW6QogULFw31cOYwJ7WxiD4DiNX8vWTjO
	CPi0EqAB3z4n7iyhPNY9AZvt5lN9Tc4EEN5wKddC6aOMsFFIn7xdtTAJQ3tHzieCHEvL8TKituq
	kJxSGlSC32K4hsuA0GR8DizhLKbLLcwXg
X-Gm-Gg: ASbGncsA1tERkMsHRMKx2gt6Jq8U0cXoxUW5alDDvrtpMS0j+cgIBTNGduZbS29mjg5
	jhjyWw7UdC2uV46DGOlM6LwjJiYUqpIWQVey/NGI=
X-Google-Smtp-Source: AGHT+IG8V7u2wZuELRUheszj46mUgDZpRnEKPVKtl0gtxseb5KZLT7o0Q6BoC3UvbhqmeR+LmFRBNF6DMqI5LMGzkLU=
X-Received: by 2002:a5d:5984:0:b0:385:fc32:1ec6 with SMTP id
 ffacd0b85a97d-3888e0c081bmr7434475f8f.50.1734300817514; Sun, 15 Dec 2024
 14:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pablo Repetto <pablo.ernesto.repetto@gmail.com>
Date: Sun, 15 Dec 2024 19:16:15 -0300
Message-ID: <CAFKqKCrEXCkyFTx8SqOHx=LHYyKpfa6scjcrMCxA=Hoo0p9yMA@mail.gmail.com>
Subject: bug: background jobs have their inputs bound to `/dev/null`, even in
 the face of explicit redirection
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

# AFFECTED VERSION
`apt show dash` returns `Version:
0.5.11+git20210903+057cd650a4ed-3build1`, several other versions
likely affected



# PROBLEM DESCRIPTION
Background jobs have their inputs bound to `/dev/null`, even in the face
of explicit redirection

```
# the following produces no output, both are erroneous
echo x | { cat & wait; }
echo x | { <&0 cat & wait; }
```

```
# the following (correctly) produces no output
echo x | /bin/dash -c "cat & wait"
```



# SUPPORTING EXCERPTS FROM POSIX.1-2024

Relevant sections in the POSIX standard:
- shell & utilities, 2.9.3 Lists, Asynchronous lists
- shell & utilities, 2.13 Shell Execution Environment
- shell & utilities, 2.9.4 Compound Commands

('08 version has different section numbers, but the cotent seems equivalent=
)



> Utilities [...] shall be invoked in a separate environment that consists =
of the following. The initial value of these objects shall be the same as t=
hat for the parent shell, except as noted below.
>
> - Open files inherited on invocation of the shell, open files controlled =
by the exec special built-in plus any modifications, and additions specifie=
d by any redirections to the utility
> - [...]
>
> shell & utilities, 2.13



> [...] asynchronous AND-OR lists shall be executed in a subshell environme=
nt. Additionally, each command of a multi-command pipeline is in a subshell=
 environment; as an extension, however, any or all commands in a pipeline m=
ay be executed in the current environment. [...]
>
> shell & utilities, 2.13



> If, and only if, job control is disabled, the standard input for the subs=
hell in which an asynchronous AND-OR list is executed shall initially be as=
signed to an open file description that behaves as if /dev/null had been op=
ened for reading only. This initial assignment shall be overridden by any e=
xplicit redirection of standard input within the AND-OR list.
>
> shell & utilities, 2.9.3

(both `<&0` and `|` should count as explicit redirection, see "Other
Supporting Evidence")



> [...] Each redirection shall apply to all the commands within the compoun=
d command that do not explicitly override that redirection. [...]
>
> shell & utilities, 2.9.4

(so in `echo x | { cat & cat & wait; }` both instances of `cat` should
have their stdin bound to the stdout of `echo`, resulting in contention
and possible input interleaving. the question of IO atomicity is
also discussed in the standard, but irrelevant to the current issue)



# OTHER SUPPORTING EVIDENCE

bash received a closely related bug report in 2016. Both the discussion
on whether a pipeline into a compound command counts as explicit redirectio=
n
and the ultimate patch applied are extremely relevant.

https://groups.google.com/g/gnu.bash.bug/c/bgTSFM8UAek
