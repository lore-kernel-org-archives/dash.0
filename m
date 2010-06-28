From: Malcolm Kay <malcolm.kay@internode.on.net>
Subject: if then elif then else fi -- Problem report
Date: Mon, 28 Jun 2010 22:26:21 +0930
Message-ID: <201006282226.22001.malcolm.kay@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:38601 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284Ab0F1NB3 (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 28 Jun 2010 09:01:29 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I notice that 'dash' fails on many scripts that ran okay with
the traditional Bourne shell 'sh'.

On closer examination I find that it does not conform to any
of the man pages that I've been able to find for 'dash'.

Should I create a problem report? Where should I send it?

The particular version is dash-0.5.5.1 running on
FreeBSD xi.home 8.0-RELEASE FreeBSD 8.0-RELEASE #0: 
Sat Nov 21 15:48:17 UTC 2009 

I have a report that the same trouble occurs in the 'dash'
as shipped with Ubuntu 10.04 Lucid Lynx.

The problem is that 'dash' bombs out with an empty list in:

if ...
then
  list
elif ...
then
  list
fi

or in:

if ...
then
  list
else
  list
fi

The latter gives for example:
  Syntax error: "else" unexpected.

Yet the man pages clearly state that a list consists of zero 
or more commands --
<quote>
Lists -- Generally Speaking
     A list is a sequence of zero or more commands separated by 
newlines,
     semicolons, or ampersands, and optionally terminated by one 
of these
     three characters.
</quote>

Should I create a problem report? Where should I send it?

Cheers,

Malcolm

