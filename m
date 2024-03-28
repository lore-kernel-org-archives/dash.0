Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.31.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6880BE0
	for <dash@vger.kernel.org>; Thu, 28 Mar 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668648; cv=none; b=fu5KTrs6Mg+BRqWAFyC/K0YCZsMydzJ1XtbAT0FQj2y6IIRs3vMR7zcwSTQ3mFGDni4S2pwkZ1j6QkBeUsbrhDZu2V1sqvhontd7PpE2zzBSwVrye5aeNIKJkc4mwv/Cmc5y0vyq7XI2giDG1CsY79ynrsBeTrOd6m1oeWHveDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668648; c=relaxed/simple;
	bh=Hpyr2OB3wAW/e33iZmQ/geAbyrXC3WsNqZ7cN7rCWJ8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=ploy35YGcJo49LgREHxmqBxH9wXx+itRmMgqvjQxI4RBj+9frAWrE+L2JCBoVw9vu6PIw/dPJQ/dZaMYhMeNsPwkr9EzOcOfMaFkkUV+lWysWclPvrqlzyMnFG0BrSYkfpwwhPOcdKVWYzsU0Y0XJ/QC7j0rnd15JiANyaxevwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ryandesign.com; spf=pass smtp.mailfrom=ryandesign.com; arc=none smtp.client-ip=80.67.31.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ryandesign.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryandesign.com
Received: from [67.198.113.253] (helo=untitled-mac.internal.macports.net)
	by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <dash@ryandesign.com>)
	id 1rpz5R-000000008B5-3jSt
	for dash@vger.kernel.org;
	Fri, 29 Mar 2024 00:23:10 +0100
From: Ryan Schmidt <dash@ryandesign.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Compatibility implementation of stpncpy for older systems
Message-Id: <858410A4-AFD5-4DBF-83BD-232C6F4B33AD@ryandesign.com>
Date: Thu, 28 Mar 2024 18:23:07 -0500
To: dash@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Df-Sender: MzY4ODE4

Hello! dash 0.5.12 and the latest code in your git repository fails to =
build on older versions of macOS (Mac OS X 10.6.x and older). Using its =
default compiler (Apple's gcc 4.2.1) first this warning appears:

jobs.c: In function 'sprint_status':
jobs.c:434: warning: implicit declaration of function 'stpncpy'
jobs.c:434: warning: incompatible implicit declaration of built-in =
function 'stpncpy'

Then it fails at link time:

Undefined symbols:
  "_stpncpy", referenced from:
      _sprint_status in jobs.o
ld: symbol(s) not found

Using a newer compiler (llvm.org's clang 11.1.0) the warning is:

jobs.c:434:7: warning: implicitly declaring library function 'stpncpy' =
with type 'char *(char *, const char *, unsigned long)' =
[-Wimplicit-function-declaration]
                s =3D stpncpy(s, strsignal(st), 32);
                    ^
jobs.c:434:7: note: include the header <string.h> or explicitly provide =
a declaration for 'stpncpy'

And then a similar failure at link time:

Undefined symbols for architecture x86_64:
  "_stpncpy", referenced from:
      _sprint_status in jobs.o
ld: symbol(s) not found for architecture x86_64

The newer clang suggests including <string.h> because it knows the =
standard says that stpncpy would be declared there, but it won't help on =
Mac OS X 10.6.x and earlier because stpncpy was introduced in Mac OS X =
10.7.

Would it be reasonable to add a compatibility implementation of stpncpy =
to dash? This and other changes were proposed here:

=
https://lore.kernel.org/dash/6cacf608-326e-211a-7d37-164041710980@knaff.lu=
/

