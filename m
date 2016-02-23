From: Jan Verbeek <ring@openmailbox.org>
Subject: [BUG] Illegal function names are accepted after being used as aliases
Date: Tue, 23 Feb 2016 19:18:06 +0100
Message-ID: <56CCA25E.5020809@openmailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp16.openmailbox.org ([62.4.1.50]:37067 "EHLO
	smtp16.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbcBWSYN (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 13:24:13 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Function definitions that use a bad function name (such as "-" and "=") 
are accepted if the function name already exists as an alias. For example:

$ -
dash: 1: -: not found
$ - () { echo hello; }
dash: 2: Syntax error: Bad function name
$ -
dash: 2: -: not found
$ alias -=true
$ -
$ - () { echo hello; }
$ -
hello
$
