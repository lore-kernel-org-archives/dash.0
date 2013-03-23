From: "Chris F.A. Johnson" <dash@cfajohnson.com>
Subject: OPTIND
Date: Fri, 22 Mar 2013 21:46:20 -0400 (EDT)
Message-ID: <alpine.LMD.2.00.1303222137440.10619@cfa.johnson>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:6109 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422648Ab3CWBnr (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 22 Mar 2013 21:43:47 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


   According to both the dash man page and the POSIX spec, "When the
   shell is invoked, OPTIND is initialized to 1."

   However, it actually takes the value of the environment variable
   if it exists:

$ OPTIND=4 dash -c 'echo "$OPTIND"'
4
$ OPTIND=4 bash -c 'echo "$OPTIND"'
1
$ OPTIND=4 ksh -c 'echo "$OPTIND"'
1
$ OPTIND=4 ksh93 -c 'echo "$OPTIND"'
1

-- 
    Chris F.A. Johnson, <http://cfajohnson.com/>
    Author:
    Pro Bash Programming: Scripting the GNU/Linux Shell (2009, Apress)
    Shell Scripting Recipes: A Problem-Solution Approach (2005, Apress)
