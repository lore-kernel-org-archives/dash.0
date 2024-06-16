Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE32572
	for <dash@vger.kernel.org>; Sun, 16 Jun 2024 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718500095; cv=none; b=nivySFGjMShzisAVdx1pquUExThMagwLi/q/UrFqkOT+BUkXH1mc86v5CwHkGvkysR8D7v1R8nZChi+gXHmw3KjUR9cexNio/tH3Afr+gIASSIxFz9G9XTfAzCQRh/MkGUdwpoB3u+VUagsoxRzwpQccFsCkyYf3jT48W7UEIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718500095; c=relaxed/simple;
	bh=rpHagJMqCDOfHdJM9IOyvW3hNWvEobbI3kzpdCWP2/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GHH4hMlQ2RuHepwzlVFF0a87QRDlzU44E12CQJOO8gf4d7lHm9jyKUnLJAQuFipY9wep2tNjie1674Zox27f5u97x9lJKfoxzgntMY9nDoGJcwZt3EWz+BjzpID20c+G7VC+XWbyWd9N+B+uxhL7Zn0ex1JGxx6TR0+Lsfy4Hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com; spf=pass smtp.mailfrom=jetbrains.com; dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b=c/Z5qIBQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="c/Z5qIBQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a0050b9aso27935365ad.2
        for <dash@vger.kernel.org>; Sat, 15 Jun 2024 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps; t=1718500093; x=1719104893; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1y5yz8Zzoo8WQNaW5DC/wI/Z3wNf3l9GuOaqvFS0mc=;
        b=c/Z5qIBQq+OvMYutPQlSMovpR60ldoXTsRkUP6Cf3S/eYY1EN3CFI/ZiCdJxt/RNqJ
         7+FC/ryvTzgo8i3UPp8jhsE/7Q7Iybfku8fwcx0wUQVaCjt2a4fP30KmDwJFAfewq48v
         i99wvE5Ckir18Kl4tgx+C3tJWtItW0boeCt5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718500093; x=1719104893;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1y5yz8Zzoo8WQNaW5DC/wI/Z3wNf3l9GuOaqvFS0mc=;
        b=h2ljFfPTECAYzK3QUKI5hGoveCY8t9zi+A4/qrR6GL9fSwEs9i616587gWKFvkLJ/m
         OCFN8Vll7dp2JgJfNZgioEnwwMKZgvacawTdBPMncK5hFY3lXQyYuX2m0icnf4j5dMRd
         jZF9F02aN6l5P5rkaw95SWTXlirvE2ckrGjR16KPcMf8PjzXugnBT0RtqZyu9A4Cql/m
         Nvr5EKs89exmran673+JpU1uaTKWkTI1jsUyqIJ42XUIEZ9XiPUlQYPSDzIm0bh8Fqnd
         Jk27sVDWt8QUJlYr/DjLW2+YbDaKekATFLOcSY6l41FLc3MbSO2lWNVsP/3ShDkVaTUD
         UIhw==
X-Gm-Message-State: AOJu0YzCqXUHuIGMk5H4XtAqW6JrWRI3FrS1CJ+1oFJt6a0qzz5k85sJ
	62Of5XAJ58A0yJvSInADghdV5JqGv6CBPbjQcAtx2n2BNDr7WGWegiMt5/hcs8jzanM3+8JUoqX
	ekK8H+AMukXnN7KH/vDxUO9UemjqJi0OggIoddsqO6MDUlRGxug==
X-Google-Smtp-Source: AGHT+IEqDti32X2b45MEHkFL2cAkEuzdH1R2Nks3t863yh4JvaBRCgPs3K06oItKd+7zVhFOGwdKoih3LrDrNx9hdI8=
X-Received: by 2002:a17:902:ebc4:b0:1f6:62cb:7c22 with SMTP id
 d9443c01a7336-1f862a16ba4mr75101685ad.46.1718500093330; Sat, 15 Jun 2024
 18:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMQsgbTFXNBrEixLSzAjgUBQyMWdFQF-ioKj1or5zUzom8HwRA@mail.gmail.com>
In-Reply-To: <CAMQsgbTFXNBrEixLSzAjgUBQyMWdFQF-ioKj1or5zUzom8HwRA@mail.gmail.com>
From: Ilya Kazakevich <ilya.kazakevich@jetbrains.com>
Date: Sun, 16 Jun 2024 03:08:02 +0200
Message-ID: <CAMQsgbSZnEac=ETYnR6a_ysnAysaHThwY03pnoDxC=p5FqtAag@mail.gmail.com>
Subject: Subprocess doesn't get stdin sometimes.
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am not sure if it is a `dash` bug or my scenario isn't correct (it
works with `bash`, however).

I execute command that reads N bytes and send this bytes directly
after execution, i.e `head -c 2 \n ab`

Here is a showcase: it forks shell , sends data and reads output
```
#include <stdio.h>
#include <unistd.h>
#include <string.h>


static void child(int read_pipe, int write_pipe) {
    dup2(write_pipe, STDOUT_FILENO);
    dup2(read_pipe, STDIN_FILENO);
    execlp("/bin/bash", "/bin/bash", NULL);
}


static void parent(int read_pipe, int write_pipe) {
    char buf[] = "head -c 2\n";
    write(write_pipe, buf, sizeof buf - 1);

    char buf2[] = "ab\n";
    write(write_pipe, buf2, sizeof buf2 - 1);


    char answer[112] = {0};
    read(read_pipe, answer, sizeof answer);
    answer[sizeof answer - 1] = 0;
    printf("%s", answer);
}

int main() {
    int to_process[2];
    pipe(to_process);
    int to_process_read_pipe = to_process[0];
    int to_process_write_pipe = to_process[1];

    int from_process[2];
    pipe(from_process);
    int from_process_read_pipe = from_process[0];
    int from_process_write_pipe = from_process[1];


    if (fork() == 0) {
        close(from_process_read_pipe);
        close(to_process_write_pipe);
        child(to_process_read_pipe, from_process_write_pipe);
    } else {
        close(to_process_read_pipe);
        close(from_process_write_pipe);
        parent(from_process_read_pipe, to_process_write_pipe);
    }
}
```

It works perfectly for `bash`.

If I use `dash` -- it freezes. In `strace` I see that `dash` calls
`vfork` followed by `execve`.
`head` then calls `read` and waits forever.

However: when I insert `sleep(1);` after the first `write(..."head..)` it works!

It seems that we have a race condition here: I should have "waited"
before stdin got connected to the new child. If I write data too
early, it simply drops and never reaches the child.

A couple of questions:
1. Is it a bug or do I simply misuse shell? Should it work? I haven't
found any POSIX statement that confirms so.
2. I am curious: why use `vfork` nowadays? `bash` uses `close`.

Thank you.

Ilya.
