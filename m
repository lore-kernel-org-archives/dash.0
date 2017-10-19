From: "G.raud" <graud@gmx.com>
Subject: Re: [NO-BUG] quoted substring parameter expansion ignores
 single-quotes in the arg
Date: Thu, 19 Oct 2017 12:41:30 +0200
Message-ID: <20171019104103.7gzflupyi27artlg@gmx.com>
References: <20170926034148.ohemy3jubd2nskyj@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:50096 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbdJSKl4 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 19 Oct 2017 06:41:56 -0400
Received: from gmx.com ([176.121.10.44]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M54L0-1dI9Jn2xri-00zI6p for
 <dash@vger.kernel.org>; Thu, 19 Oct 2017 12:41:54 +0200
Content-Disposition: inline
In-Reply-To: <20170926034148.ohemy3jubd2nskyj@gmx.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Wrong bug report.

In fact the beahviour of dash on "a=\\'a\\'; echo \"\${a%'}\"" is that
of POSIX and of zsh 5.  However 'bash --posix', 'mksh -o posix' and
pdksh fail to parse the command and ksh does not remove the quote from
$a.

On Tue, Sep 26, 2017 at 05:41:48AM +0200, G.raud wrote:
> Subject: [BUG] quoted substring parameter expansion ignores single-quotes
>  in the arg
> 
> To test that the single quotes are considered ordinary chars when
> double-quoting the parameter expansion:
> 
> $ dash -c "a=\\'a\\'; echo \"\${a%'}\""
> 
> The result is surprising and non consistent with a non double-quoted
> expansion where the single-quotes act as quotes:
> 
> $ dash -c "a=a%; echo \${a%'%'}"
> 
> Additionally the manual states that the arg to substring processing is
> processed as an ordinary word (as probably POSIX too).

-- 
G.raud Meyer
graud@gmx.com
