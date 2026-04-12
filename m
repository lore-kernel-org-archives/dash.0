Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9F31717E
	for <dash@vger.kernel.org>; Sun, 12 Apr 2026 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776037512; cv=pass; b=idJdyVYpjpj4AWho5xzr5q3Z8o11zwFAaGUfMaTa7RCEK/NTQlsonuLXJ14bbk8ABarm73CihW//9sHIwB6a2FDiZD83OtCnNdkdWHBOlfWVSwawz5Fa+R8ro/S0tBhuGPGP5yXaotQFlP6THeW9mS4rKDQq109sH9krckFeyDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776037512; c=relaxed/simple;
	bh=BV7PgnwzcEI4gvCfSSMlI6XFDlzY/ohYMZNAvyfS5Vg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Dj80/TfGWHEfCG4Pd7PhouE05wTGyANgsYE17HPHGN6VI+kcerSkPd3dGfe2G3tAEx5OAO4Z85EF2Bns+aptcWzW3/e2hSF8Nrk8GlGCLcs/wGRtTH5jYK4oZmJIVFymgulls3RojEYhYqxc2nausKmOw4Qk97/vjUhpDPX7P8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCgAs4sU; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCgAs4sU"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2b081e87eso598143e87.3
        for <dash@vger.kernel.org>; Sun, 12 Apr 2026 16:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776037509; cv=none;
        d=google.com; s=arc-20240605;
        b=Tl3hh30OhdluZu2gQFc4bwsTNFWkancuaqwcr8ElBzFLmNaZqUcy0lHstZ+Xbysqux
         YeXWcJMjMifN4PeZyQz1NMAp0LO0mVwXEgTvmTk14CitLHKAtD/q8MpzL/umYT43KrlV
         cvd8N30PX06X0zrkpNn5N0OLXYr+4NgdB8yCdod0vtfqfqz+3YMoGbtJXdR7bC8JyMHt
         FgfQBHtjEIoEhTkgvN/HgHmwGPQ+KO26POqgmPSIGXcKa4i5cd/ThcBHX/Oyma/kubMd
         bJMTlW+fpAauWPgiMm+rPhw9qFjqlWly8gtk+MW+LXxzmL+VPzElZP2VZFTjEIIs8vQO
         9FJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=BV7PgnwzcEI4gvCfSSMlI6XFDlzY/ohYMZNAvyfS5Vg=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=TGYLWQSBWsEnRCczHojjTUXDOKYgMP5MOr0VvoGFSgKY03+jD2t+9jJHQkef2/sVOy
         x7K6KSq0F/Dsqv0In0+mjqF5ncLKxRQ1CAEYh2NH1jipk301EnR8hZ9uGYjqd2D2Bjjp
         qNrHzKrtz0ms+Ilky74pfhgRMDfQXw+oILcScVAtGbLYkSXgowDn5yumvunmyEIgjahc
         UNLOTlXjVty8e8bwG6wg7HnIjgpBGtey8nhyDeWpGYvq/ZmLzxjcyaF0KcuBIAH5KM+9
         WfQNS1KvUCpmrDNpq7chEvAItKCTqUV5A9vYGksW0BjmDozmzCRAX1pPjW6J6El2+JOR
         0K8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776037509; x=1776642309; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BV7PgnwzcEI4gvCfSSMlI6XFDlzY/ohYMZNAvyfS5Vg=;
        b=JCgAs4sUHCVRJdLmoWp2MphrNGZzJRpJkE2gqhjrw2yWNQDmNJ+TcdGkpkc2Z83I+N
         UYBprILtn99FzqXTs7+jJA+3HbKMwJiN0g85sElCVCT/BEcJmTl4HSCxkcAmsX9zTUxF
         dvghoY57swoCWaAz2m3Gm3n8TukNQRnxIoQUhBK8SwaYAX8iz4uYoQ96Q+gWOLubVLtH
         MSdPeYWBTAhKwztDjzIDtU89JuSgdG2DhvfVWZi+eXttihitHC7rJ80kUuNUJ2E+cd+0
         bmkBkzu4N4iquXVP5IiS/KZ8diBKRfeGE1mtVLl7oVt0H3EdmV3OIe77oHguR/6IWuvJ
         x5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776037509; x=1776642309;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV7PgnwzcEI4gvCfSSMlI6XFDlzY/ohYMZNAvyfS5Vg=;
        b=IQPuR+1EaIlqHJ8p/u2FChkfQGrJ958/EaLIQlSTWSekfSwSka57dIPANiSj3/gbCN
         AdWOCombnGZJYPYZp9omzGxsDvOCzkThHaw3TXxiYFHwNs8MHQqs+L8cOgg45/enNPcF
         sGQEtohmgqb6FzurPh4BODEhb0FWQnA2EVqlr7bbYwC9Gs+iFvYCmmI9F+BcWsvuAbCD
         KhqIv4NEGiRtxO68/4ZNGp+QYjfD13Qc/1bKuJFgoHKQ66aUQICXqz4vNuwRlnBT4Die
         SwNu9Yradkj/M9cjB5okHFcJ3fF5U23HkfIP72Rt+Zy+Mb6Rc8yb9PPTPGBbtl77j/HB
         QwBg==
X-Gm-Message-State: AOJu0YzGfFKsVQq8O7CU/tp2ojx6K6ItTGdZwMaenHt2KX06v/6t2RKQ
	VHhdrTaA3/GxLSW/1OZtqGBuI2rpxuQbOOI9PTJae4Nwdrg8hgx5VEvCtDSsP2eKoxdoV9EVoZa
	xAq9MS6wqhNBQ9AhhED+vnfS6SWSOq0WNkHIw3llMbw==
X-Gm-Gg: AeBDiev/RTu1oLsACY0z733UTakBb8yQxr9cDVnid9e0ZywTEWZEnzMeGyLArRuwkqv
	YbDGAX6XLy685iVmWv2JtVICcd28c5qyc2u7LYEf4IJoUQM1pU1n+G3zXHV5NmO3MjV2gpPhlfa
	i6UKr1bCKCPpSKtX2+bNH00R7J9CCDBUX32B6UdzWNy7zJEd0OUXEp3DKxB3odfi3L1l61AoEh4
	eGNg+9+BH9phodREkULlTU3hqg4jpjPz5wS7T4hU05b9mWGFQk8y2BoTkEQb2d9A0u6ULf68osN
	5AH2fIQhT0/uNXYa2UmC9iRLnIEmfL2T0QIer5vVX0ECyiy+/f2JqLUrqMs2VZKIikeQUcXktQ0
	ufpGYfxG2RYaTXM0qXvDsHV5lFQ==
X-Received: by 2002:a2e:bc0a:0:b0:38e:3510:5b6b with SMTP id
 38308e7fff4ca-38e4bf28052mr15580741fa.7.1776037508428; Sun, 12 Apr 2026
 16:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Marks <samuelmarks@gmail.com>
Date: Mon, 13 Apr 2026 11:44:56 +1200
X-Gm-Features: AQROBzCK43IBIG-FwWCHbnNHjpt2VJNcCjmB6PO3g45zrNNTCFvCcUMLWqwhdrs
Message-ID: <CAMfPbcbH6C6vd8Cp-sWfpZL5ih_q=2pTMcDbZ9PidQFjzc+3hg@mail.gmail.com>
Subject: WASM + dash (again!)
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

http://samuelmarks.github.io/dash/
https://github.com/SamuelMarks/dash/tree/wasm

**How it works:**
Running a traditional Unix shell in the browser presents a unique
challenge: the browser's JavaScript event loop is strictly
non-blocking, but tools like `dash` expect to perform synchronous,
blocking reads from `stdin` (and use `fork`/`exec` for process
management).

Instead of relying on `SharedArrayBuffer` (which has strict CORS
requirements and isn't supported everywhere), I utilized Emscripten's
`Asyncify` pass.

1. **Fully Non-blocking I/O:** When `dash` calls `read()` on file
descriptor 0 and the JS input buffer is empty, Asyncify automatically
saves the C execution stack and yields to the browser. Once the user
types a character (via an `xterm.js` frontend), the worker resumes the
exact C call stack perfectly.
2. **Web Worker Isolation:** The entire `dash` engine and its Virtual
File System (VFS) run in a background Web Worker, ensuring the main
browser UI thread never hangs, even during infinite loops.
3. **No `fork()`:** Since WASM can't truly `fork`, the codebase
leverages a patched `vforkexec` to intercept process creation. It
currently executes built-ins directly and passes external command
requests (like `ls`, `cat`, `grep`) out to JavaScript to execute
against the Emscripten VFS.
4. **Canonical Line Editing:** Basic terminal interactions=E2=80=94like
`Backspace`, `Ctrl+W` (Erase Word), and `Ctrl+U` (Clear Line)=E2=80=94are
handled locally in the frontend buffer before being flushed to the
WASM shell on `Enter`.

The port successfully passes a headless Node.js adaptation of the
`dash` test suite.

I'd love to hear any thoughts, feedback, or ideas from the community!

PS: My next steps are to bring along `curl` and `jq` for my headless
compiler efforts; for both my OpenAPI =E2=9F=B7 /bin/sh and my new multiclo=
ud
devops system; but that's for another post!

Best,

Samuel Marks
https://github.com/SamuelMarks
https://linkedin.com/in/samuelmarks
