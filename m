From: Martijn Dekker <martijn@inlv.org>
Subject: Inheriting IFS from environment
Date: Wed, 30 Dec 2015 18:06:42 +0100
Message-ID: <56840F22.6040302@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:37131 "EHLO kahlil.inlv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbbL3RGp (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Dec 2015 12:06:45 -0500
Received: from breedzicht.local (inlv.demon.nl [212.238.240.159])
	(authenticated bits=0)
	by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id tBUH6g7q012783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <dash@vger.kernel.org>; Wed, 30 Dec 2015 18:06:43 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Unlike bash, *ksh and zsh, dash allows inheriting IFS from the environment:

$ IFS=bla dash -c "x='hela hola'; echo \$x"
he  ho

This seems a bit dodgy from a security point of view. For instance, most
scripts don't bother to quote their variables in test commands such as [
$var -eq 0 ], making it possible to influence the program flow by
manipulating IFS from the outside.

- M.
