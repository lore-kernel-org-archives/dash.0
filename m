From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Mon, 23 Apr 2012 21:53:21 +0200
Message-ID: <4F95B331.7070707@gmail.com>
References: <4F958907.9030508@gmail.com> <20120423170339.GA9635@burratino> <4F95AD25.3060200@case.edu> <20120423194453.GA13576@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43338 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab2DWTx2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 15:53:28 -0400
Received: by eekc41 with SMTP id c41so3366080eek.19
        for <dash@vger.kernel.org>; Mon, 23 Apr 2012 12:53:27 -0700 (PDT)
In-Reply-To: <20120423194453.GA13576@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Chet Ramey <chet.ramey@case.edu>, dash@vger.kernel.org

Hi Jonathan, Chet.

On 04/23/2012 09:44 PM, Jonathan Nieder wrote:
> Chet Ramey wrote:
> 
>> What are `conforming scripts'?  Scripts without syntax errors?
> 
> I meant "conforming POSIX applications".
> 
> A patch for this might even be welcome if it makes dash bigger, if
> that's what you're wondering.
>
I have no patch, but a little more information that might help anyone who
volunteers to write one:

  $ nl=$'\n'

  $ dash -c ":$nl fi" && echo NOERR
  dash: Syntax error: "fi" unexpected

  $ dash -c ":;$nl fi" && echo NOERR
  dash: Syntax error: "fi" unexpected

  $ dash -c ":&$nl fi" && echo NOERR
  dash: Syntax error: "fi" unexpected

  $ dash -c ": && fi" && echo NOERR
  dash: Syntax error: "fi" unexpected

The problem seems to only be present when a stray "fi" comes after a
'&' or ';' -- see:

  $ dash -c ":; fi" && echo NOERR
  NOERR

  dash -c ":& fi" && echo NOERR
  NOERR


The same goes for other loops/conditionals terminators:

  $ dash -c ":; done" && echo NOERR
  NOERR

  $ dash -c ":; esac" && echo NOERR
  NOERR

  $ dash -c ":& elif" && echo NOERR
  NOERR

HTH,
  Stefano
