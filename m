From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: --with-libedit as default
Date: Sun, 04 Aug 2013 19:18:11 +0200
Message-ID: <51FE8CD3.6000900@gigawatt.nl>
References: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com> <20130804010244.GL2893@elie.Belkin> <CAA4sSt=7K=GXZFnQ741ZBfcUtj3xZ45ir0TCfg9dtekga-DahQ@mail.gmail.com> <20130804114350.fc97c50b21f4a63ad5f089d3@tuxfamily.org> <CAA4sStnUN0gQD0anxuTyqGrpa3nUAY2zndJBkVUkqa4=x8N=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:45226 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751794Ab3HDRSS (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 4 Aug 2013 13:18:18 -0400
In-Reply-To: <CAA4sStnUN0gQD0anxuTyqGrpa3nUAY2zndJBkVUkqa4=x8N=qA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mauricio Antunes <mauricio.antunes@gmail.com>
Cc: dash@vger.kernel.org

On 04/08/13 18:21, Mauricio Antunes wrote:
>>> I would like to use dash as an interactive shell.
> 
>> The problem is that enabling the libedit support does not provide you
>> with auto-completion, AFAIK.
> 
> You're right, just tested it.
> 
> What would it take to have auto-completion in dash
> (even if disabled by default)?

libedit does provide auto completion hooks, but it is up to the end
program to make use of that, and determine whether completion should
search for commands, files, variables, anything else. libedit includes
an example called fileman, that includes path-based completion. It might
be interesting to see if that is easily adaptable to dash.

(My apologies for removing the accent from your name. My mail server is
corrupting the message with non-ASCII characters in a way that causes
the mailing list server to reject it. I will attempt to get that fixed.)

Cheers,
Harald
