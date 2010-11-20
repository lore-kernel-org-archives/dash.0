From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: Quoted closing brace in variable default expansion
Date: Sat, 20 Nov 2010 21:57:43 +0100 (CET)
Message-ID: <1011202153390.11055@somehost>
References: <20101119135406.GA24391@gondor.apana.org.au> <4CE71991.3020108@gigawatt.nl>
Reply-To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from ra.se.axis.com ([195.60.68.13]:54385 "EHLO ra.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab0KTVHi (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 20 Nov 2010 16:07:38 -0500
In-Reply-To: <4CE71991.3020108@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, jrnieder@gmail.com

On Sat, 20 Nov 2010, Harald van Dijk wrote:
> On 19/11/10 14:53, Herbert Xu wrote:
> > Harald van Dijk<harald@gigawatt.nl>  wrote:
> > >    sh -c 'echo "${x:-\}}"'
> >
> > If you need to print anything involving a backspace you should
> > use printf and not echo.
>
> It's true that backslashes should not be passed to echo, but assuming
> unset or empty x, "${x:-\}}" should expand to "}", and that is all echo
> should see.

You seem to have a point there:

,----[ http://opengroup.org/onlinepubs/007908799/xcu/chap2.html ]
| single-quotes cannot be used to quote the "}" within ${...}; for
| example:
|
| unset bar
| foo="${bar-'}'}"
|
| is invalid because the ${...} substitution contains an unpaired
| unescaped single-quote. The backslash can be used to escape the "}" in
| this example to achieve the desired result:
|
| unset bar
| foo="${bar-\}}"
`----


Cheers,

-- 
Cristian
