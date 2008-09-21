From: maximilian.bernoecker@lrz.tum.de (Maximilian =?iso-8859-1?Q?Bern=F6c?=
	=?iso-8859-1?Q?ker?=)
Subject: dash, ash for loop oddity
Date: Sun, 21 Sep 2008 16:33:59 +0200
Message-ID: <87myi1r2js.fsf@ID-132527.user.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mout0.freenet.de ([195.4.92.90]:57697 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbYIUOeF (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 21 Sep 2008 10:34:05 -0400
Received: from [195.4.92.25] (helo=15.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID agabuga@freenet.de) (port 25) (Exim 4.69 #65)
	id 1KhQ0h-0006Sl-Ny
	for dash@vger.kernel.org; Sun, 21 Sep 2008 16:34:03 +0200
Received: from p5498f82c.dip.t-dialin.net ([84.152.248.44]:50899 helo=linmax.dahoam)
	by 15.mx.freenet.de with esmtpsa (ID agabuga@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.69 #65)
	id 1KhQ0h-0007Ns-CV
	for dash@vger.kernel.org; Sun, 21 Sep 2008 16:34:03 +0200
Received: from max by linmax.dahoam with local (Exim 4.63)
	(envelope-from <maximilian.bernoecker@lrz.tum.de>)
	id 1KhQ0d-0005k1-Eg
	for dash@vger.kernel.org; Sun, 21 Sep 2008 16:33:59 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

according to the grammar
<http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_10_02>

| for_clause       : For name linebreak                            do_group
|                  | For name linebreak in          sequential_sep do_group
|                  | For name linebreak in wordlist sequential_sep do_group
| [...]
| linebreak        : newline_list
|                  | /* empty */

the following script should be legal:

#####
#!/bin/dash
for i
in a b c
do
echo $i
done
#####

but it fails with:

| ./a.sh: 3: Syntax error: "in" unexpected (expecting "do").

bash, zsh and NetBSDs ksh are doing fine while NetBSDs sh, based on ash
fails, too.

Max


