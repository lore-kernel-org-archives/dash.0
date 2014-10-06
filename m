From: Christian =?ISO-8859-1?Q?P=E9lissier?=
	<Christian.Pelissier@onera.fr>
Subject: dash security bug
Date: Mon, 06 Oct 2014 12:30:46 +0200
Message-ID: <1412591446.2690.634.camel@ptah>
Reply-To: Christian.Pelissier@onera.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from onera.onera.fr ([144.204.65.4]:56515 "EHLO onera.onera.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbaJFKmu convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 6 Oct 2014 06:42:50 -0400
Received: from ptah.onera (ptah [125.1.1.115])
	by onera.onera.fr (8.14.4/8.14.4/1.6) with ESMTP id s96AUkVk006031
	for <dash@vger.kernel.org>; Mon, 6 Oct 2014 12:30:46 +0200
Received: from ptah.onera (localhost [127.0.0.1])
	by ptah.onera (8.14.7+Sun/8.14.7) with ESMTP id s96AUkSQ005748
	for <dash@vger.kernel.org>; Mon, 6 Oct 2014 12:30:46 +0200 (CEST)
Received: (from peli@localhost)
	by ptah.onera (8.14.7+Sun/8.14.7/Submit) id s96AUkDM005747
	for dash@vger.kernel.org; Mon, 6 Oct 2014 12:30:46 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I've found a security bug in dash permitting to change shell behaviour.
I don't know if impact could be same as the recent bash bug but it seem=
s
to be serious.

Are you able to close a bug very quickly ?

PS.
Same bug exist inside ash and busybox. I have to contact ash and busybo=
x
maintainers before bug disclosure.
=20
--=20
Christian P=C3=A9lissier
Office National d'=C3=89tudes et de Recherches A=C3=A9rospatiales
BP 72 92322 Chatillon
Tel: 33 1 46 73 44 19, Fax: 33 1 46 73 41 50

