From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: 'set' leaks garbage from environment
Date: Tue, 30 Sep 2014 19:07:36 +0200
Message-ID: <542AE358.7060900@gigawatt.nl>
References: <542AC5C7.5090307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:51703 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752479AbaI3Rak (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 30 Sep 2014 13:30:40 -0400
In-Reply-To: <542AC5C7.5090307@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On 09/30/2014 05:01 PM, Eric Blake wrote:
> Here's the behavior I observe with dash 0.5.7 (as built for Fedora 20):
>
> $ env 'a|b=' dash -c 'set | grep a"."b'
> a|b=''

You were one of the people to reply to the first thread about that. :)

http://comments.gmane.org/gmane.comp.shells.dash/704

This is already fixed, and the fix has been released as part of 0.5.8.

Cheers,
Harald van Dijk
