Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8E142E83
	for <dash@vger.kernel.org>; Sat, 18 Apr 2026 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538498; cv=none; b=Hj0wRNrd1HSiKHNz0npD0bXLDu9VZdvYS5KUv6B83UnDQueSTht1byidfXNJunYi8iNPdC0RK+RLw2CiQfcpzqBpxKyyseEH5BM2P0VLkA9ORTthNafy0zi6J9ps8hhauQ0jj8ItrEnvEpkQnR8PbJFMIKW+AINtJIXTbwtKkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538498; c=relaxed/simple;
	bh=D0F+9+YKvaQPRlI4XbLzLHRU93yoLWwvZO71URI4l5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEZ1ylJ+23AekqTm6STcDRocc/+Ae4388R3wlgo0FBIOp26Rh7UpV05mDNWPFIb32O0uEcydDb2E8RtatLR+JkmfKEE4LY6YAkml4i34qTMVreh6+8xB5A1f2AwC5ybP8ERqWmodGpIbCOiXk3DawuqoM5KBKMr8SlCEmpkdlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6Q63ze+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Q63ze+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89f87257904so14753426d6.1
        for <dash@vger.kernel.org>; Sat, 18 Apr 2026 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776538496; x=1777143296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cep2/Jemmpx0qQevaFoMXorsaNU0NtrmJAEbq05lscw=;
        b=Y6Q63ze+9NX8wgCBgatGeHRvuN8CelAyetowSbs+JIg8bW/qTblbA7pHu1Z18906sw
         PFhRf4QqLA1tqbHpMk0LqjEzSTmIXaco5nKxXdyOYTHQjKjYiMBEuToy3gQard5lfYWM
         A481UcQCRETINeDmOqqTmw2BkMBruOUKDL+wD5y014LlqOmzWEO0b9TJlLSYjIEfUoh2
         TBMfkOtiCrXC88HRuNWEUIvUJOZe+FKXsPpvZR2Wv/fuhgWOWsz9O+WQh8gixwYooecd
         zspbUJMsKYreAbrZyA6zR6Z76SceYBsAPjje5YaArvlrhlqBKNyAwx/u29pFk99CYvxN
         Frrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776538496; x=1777143296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cep2/Jemmpx0qQevaFoMXorsaNU0NtrmJAEbq05lscw=;
        b=GJ9q6ppN/7tXkP3eX/+4WFLBtSYcIgVDtumZXRTb16tt72GJ9ICI1409p6rHCEQUE+
         bNvckgca5HfrZjOyoph0Z64bjwllMwum6XHnO0RpaOaVd1OMhoU/pi71CC5VwTouNeyI
         atYVJ0Dxk868isypboEwYDmBqcZac6uysSb0dKwK1KbaN1EfMHPEq6NGKPzZx6Za6o4x
         5ApyhkxsWB4izNx+v4OLA/5SO3bbT/O/EKPZ1xT4fCIFBHinnnR+GWJV2wQzQVUFl/kA
         VzC2tKWxZB4n7SlEQtXQiFxpCmtChyvoUo4HCYP/eSSg8Tx6xyHhZnKXkwmK8rL/czkH
         aqOg==
X-Gm-Message-State: AOJu0YxZK7+Ju8U+3tUhwmCEeFM/0UNRV0PgOOaqsg12SxU3Tjz+RAy6
	w4OokBp9UJTRNcVarnBBMWY8iLYd8q9cLfh3yJyFlK/47CaHb3dUWx4oeWUcBQ==
X-Gm-Gg: AeBDiescOX69EuAlisdeot5NTIXuuL9sy6hkLsRtTFoEcmZC7cQTY6WOmVIouPoBm77
	JWL3VQe++wJtGk1Aq0eWeUJOQC0qxAK3Y+At8F4k3kuqLJKCNpN6mLDriirAbRDLl7DAoucevIE
	GpyHMEigVOkDMgBVBgDUkpqVqtbGpHv/Ip/NwBHSW6pEuvo0YhbSzXRbMESmM5HOYkTrIvIgeRd
	gogySCyIMqUfRf+AjXowOoyHdcxUp58hiDnYGDS9+dIRo6BoCmvBQLRDf2j22y7fVMlgC18X2jF
	kPVWNUeF85o6rlkQStV+JEnC4CewGTYvnXPOLCRJ8GVmH6ux5zALOJJ7rbLNWt5Ez9KVttGPVzJ
	2O0OEhDuQljEPssV0E0lmFlm33tSYnT2jYs8ZIaVPLw/F7sYhEOXgP6Cdwh17taOKq24Q4IRYOU
	Z8j5z8oHHx5+py12iicUzUdHaasWXliBjgI6/yhtNI1+qU6QR1caprHADT/dxISsE5iDN6idxKv
	9hP2Eblc9BLFVVUsCwrjZ1i0Z5eh5e99DObEwpS1n1PONFqkZHCAg==
X-Received: by 2002:a0c:f107:0:b0:8ac:9fc3:b9fb with SMTP id 6a1803df08f44-8b02812cc12mr99331786d6.45.1776538495879;
        Sat, 18 Apr 2026 11:54:55 -0700 (PDT)
Received: from HQ.hitronhub.home ([2607:fea8:ea1f:9fea::7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5ec2dsm39929716d6.29.2026.04.18.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 11:54:55 -0700 (PDT)
From: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Cc: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
Subject: [PATCH] Don't use groff(1) specific string syntax
Date: Sat, 18 Apr 2026 15:53:45 -0300
Message-ID: <20260418185421.28841-1-sebastien.peterson.boudreau@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's standard for troff(1)s to recognize \*( for 2 character
strings, but \*[] is a GNU extension. I don't see any reason to
use it.

groff_mdoc(7) also gives ``preferred'' alternatives to these uses
in the section _Predefined strings_, but I don't know if these
are portable; for some, it lists characters that are unique(?) to
groff (in groff_char(7), characters with widespread portability
are marked by a `+', and some of the preferred alternatives listed
in groff_mdoc(7) are not marked as such), but \*(Lt and \*(Gt have
preferred alternatives of simply the ASCII < and > characters.
---
 src/dash.1 | 58 +++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index dbc34c9..0fcb183 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -197,7 +197,7 @@ operand and the positional parameters ($1, $2, etc.)
 set from the remaining argument operands.
 .It Fl C Em noclobber
 Don't overwrite existing files with
-.Dq \*[Gt] .
+.Dq \*(Gt .
 .It Fl e Em errexit
 If not interactive, exit immediately if any untested command fails.
 The exit status of a command is considered to be
@@ -268,9 +268,9 @@ operators (their meaning is discussed later).
 Following is a list of operators:
 .Bl -ohang -offset indent
 .It "Control operators:"
-.Dl &  &&  \&(  \&)  \&;  ;; | || \*[Lt]newline\*[Gt]
+.Dl &  &&  \&(  \&)  \&;  ;; | || \*(Ltnewline\*(Gt
 .It "Redirection operators:"
-.Dl \*[Lt]  \*[Gt]  \*[Gt]|  \*[Lt]\*[Lt]  \*[Gt]\*[Gt]  \*[Lt]&  \*[Gt]&  \*[Lt]\*[Lt]-  \*[Lt]\*[Gt]
+.Dl \*(Lt  \*(Gt  \*(Gt|  \*(Lt\*(Lt  \*(Gt\*(Gt  \*(Lt&  \*(Gt&  \*(Lt\*(Lt-  \*(Lt\*(Gt
 .El
 .Ss Quoting
 Quoting is used to remove the special meaning of certain characters or
@@ -298,7 +298,7 @@ and backslash
 .Pq \e .
 The backslash inside double quotes is historically weird, and serves to
 quote only the following characters:
-.Dl $  `  \*q  \e  \*[Lt]newline\*[Gt] .
+.Dl $  `  \*q  \e  \*(Ltnewline\*(Gt .
 Otherwise it remains literal.
 .Ss Reserved Words
 Reserved words are words that have special meaning to the
@@ -391,25 +391,25 @@ is an optional number between 0 and 9, as in
 .Sq Bq 3 ) ,
 that refers to a file descriptor.
 .Bl -tag -width aaabsfiles -offset indent
-.It [n] Ns \*[Gt] file
+.It [n] Ns \*(Gt file
 Redirect standard output (or n) to file.
-.It [n] Ns \*[Gt]| file
+.It [n] Ns \*(Gt| file
 Same, but override the
 .Fl C
 option.
-.It [n] Ns \*[Gt]\*[Gt] file
+.It [n] Ns \*(Gt\*(Gt file
 Append standard output (or n) to file.
-.It [n] Ns \*[Lt] file
+.It [n] Ns \*(Lt file
 Redirect standard input (or n) from file.
-.It [n1] Ns \*[Lt]& Ns n2
+.It [n1] Ns \*(Lt& Ns n2
 Copy file descriptor n2 as stdin (or fd n1).
-.It [n] Ns \*[Lt]&-
+.It [n] Ns \*(Lt&-
 Close standard input (or n).
-.It [n1] Ns \*[Gt]& Ns n2
+.It [n1] Ns \*(Gt& Ns n2
 Copy file descriptor n2 as stdout (or fd n1).
-.It [n] Ns \*[Gt]&-
+.It [n] Ns \*(Gt&-
 Close standard output (or n).
-.It [n] Ns \*[Lt]\*[Gt] file
+.It [n] Ns \*(Lt\*(Gt file
 Open file for reading and writing on standard input (or n).
 .El
 .Pp
@@ -417,7 +417,7 @@ The following redirection is often called a
 .Dq here-document .
 .Bl -item -offset indent
 .It
-.Li [n]\*[Lt]\*[Lt] delimiter
+.Li [n]\*(Lt\*(Lt delimiter
 .Dl here-doc-text ...
 .Li delimiter
 .El
@@ -431,9 +431,9 @@ subjected to parameter expansion, command substitution, and arithmetic
 expansion (as described in the section on
 .Dq Expansions ) .
 If the operator is
-.Dq \*[Lt]\*[Lt]-
+.Dq \*(Lt\*(Lt-
 instead of
-.Dq \*[Lt]\*[Lt] ,
+.Dq \*(Lt\*(Lt ,
 then leading tabs in the here-doc-text are stripped.
 .Ss Search and Execution
 There are three types of commands: shell functions, builtin commands, and
@@ -567,7 +567,7 @@ Because pipeline assignment of standard input or standard output or both
 takes place before redirection, it can be modified by redirection.
 For example:
 .Pp
-.Dl $ command1 2\*[Gt]&1 | command2
+.Dl $ command1 2\*(Gt&1 | command2
 .Pp
 sends both the standard output and standard error of command1
 to the standard input of command2.
@@ -698,7 +698,7 @@ Grouping commands together this way allows you to redirect
 their output as though they were one program:
 .\".Pp
 .Bd -literal -offset indent
-{ printf \*q hello \*q ; printf \*q world\\n" ; } \*[Gt] greeting
+{ printf \*q hello \*q ; printf \*q world\\n" ; } \*(Gt greeting
 .Ed
 .Pp
 Note that
@@ -764,7 +764,7 @@ numeric.
 A parameter can also be denoted by a number or a special
 character as explained below.
 .Ss Positional Parameters
-A positional parameter is a parameter denoted by a number (n \*[Gt] 0).
+A positional parameter is a parameter denoted by a number (n \*(Gt 0).
 The shell sets these initially to the values of its command line arguments
 that follow the name of the shell script.
 The
@@ -1627,19 +1627,19 @@ Character escape sequences are in backslash notation as defined in
 The characters and their meanings are as follows:
 .Bl -tag -width Ds -offset indent
 .It Cm \ea
-Write a \*[Lt]bell\*[Gt] character.
+Write a \*(Ltbell\*(Gt character.
 .It Cm \eb
-Write a \*[Lt]backspace\*[Gt] character.
+Write a \*(Ltbackspace\*(Gt character.
 .It Cm \ef
-Write a \*[Lt]form-feed\*[Gt] character.
+Write a \*(Ltform-feed\*(Gt character.
 .It Cm \en
-Write a \*[Lt]new-line\*[Gt] character.
+Write a \*(Ltnew-line\*(Gt character.
 .It Cm \er
-Write a \*[Lt]carriage return\*[Gt] character.
+Write a \*(Ltcarriage return\*(Gt character.
 .It Cm \et
-Write a \*[Lt]tab\*[Gt] character.
+Write a \*(Lttab\*(Gt character.
 .It Cm \ev
-Write a \*[Lt]vertical tab\*[Gt] character.
+Write a \*(Ltvertical tab\*(Gt character.
 .It Cm \e\e
 Write a backslash character.
 .It Cm \e Ns Ar num
@@ -2062,13 +2062,13 @@ True if the strings
 and
 .Ar \&s\&2
 are not identical.
-.It Ar \&s\&1 Cm \&\*[Lt] Ar \&s\&2
+.It Ar \&s\&1 Cm \&\*(Lt Ar \&s\&2
 True if string
 .Ar \&s\&1
 comes before
 .Ar \&s\&2
 based on the ASCII value of their characters.
-.It Ar \&s\&1 Cm \&\*[Gt] Ar \&s\&2
+.It Ar \&s\&1 Cm \&\*(Gt Ar \&s\&2
 True if string
 .Ar \&s\&1
 comes after
@@ -2380,7 +2380,7 @@ unless you are the superuser, in which case it defaults to
 .Dq #\  .
 .It Ev PS2
 The secondary prompt string, which defaults to
-.Dq \*[Gt]\  .
+.Dq \*(Gt\  .
 .It Ev PS4
 Output before each line when execution trace (set -x) is enabled,
 defaults to
-- 
2.53.0

