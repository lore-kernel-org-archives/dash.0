From: David Binderman <dcb314@hotmail.com>
Subject: dash-0.5.8 bug report
Date: Fri, 21 Nov 2014 13:55:11 +0000
Message-ID: <DUB128-W26B546CDE4201C1F19CEC39C770@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from dub004-omc3s9.hotmail.com ([157.55.2.18]:51447 "EHLO
	DUB004-OMC3S9.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbaKUOAQ convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 21 Nov 2014 09:00:16 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

Hello there,

eval.c:273:19: warning: logical not is only applied to the left hand si=
de of comparison [-Wlogical-not-parentheses]

=A0=A0=A0=A0=A0=A0=A0 if (!exitstatus =3D=3D isor)

Maybe

=A0=A0=A0=A0=A0=A0=A0 if (exitstatus !=3D isor)

was intended.

Regards

David Binderman

 		 	   		  