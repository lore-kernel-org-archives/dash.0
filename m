From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mac OS X support patch
Date: Fri, 11 Jul 2008 20:20:39 -0700
Message-ID: <48782307.8020900@zytor.com>
References: <4faa0b8b0807111420o36da862ahd17a4a7d06a781e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:52245 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbYGLDUn (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 11 Jul 2008 23:20:43 -0400
In-Reply-To: <4faa0b8b0807111420o36da862ahd17a4a7d06a781e7@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mark Mentovai <mmentovai@gmail.com>
Cc: dash@vger.kernel.org

Mark Mentovai wrote:
> - open64 is not present although the stat64 family is, separate the
>   autoconf checks

This seems like the Wrong Thing anyway; the right thing should be to add 
whatever option (like -D_FILE_OFFSET_BITS=64 on Linux) to do 
*everything* using the full-sized offsets.

	-hpa
