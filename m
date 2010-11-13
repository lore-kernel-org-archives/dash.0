From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Quoted closing brace in variable default expansion
Date: Sat, 13 Nov 2010 18:28:41 +0059
Message-ID: <4CDECAE1.9010607@gigawatt.nl>
References: <4CDEBC7B.5050805@gigawatt.nl> <20101113164147.GB5535@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:43320 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754988Ab0KMR1k (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 12:27:40 -0500
In-Reply-To: <20101113164147.GB5535@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>

On 13/11/10 17:41, Jonathan Nieder wrote:
> Harald van Dijk wrote:
>>    $ dash -c 'echo "${x:-"}"}"'
>>    dash: 1: Syntax error: Unterminated quoted string
>
>   http://austingroupbugs.net/view.php?id=221
>   note #399

Thanks, that helps to clarify. Unfortunately, the valid alternative 
given there:

   sh -c 'echo "${x:-\}}"'

seemingly incorrectly prints \} with dash and with bash, so that is a 
non-option at this time for me.
