From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] [PARSER] Remove backslash before } in double-quotes in
 variable
Date: Tue, 23 Nov 2010 19:45:13 +0059
Message-ID: <4CEC0BD1.2070908@gigawatt.nl>
References: <20101119135406.GA24391@gondor.apana.org.au> <4CE71991.3020108@gigawatt.nl> <20101121134222.GC17293@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:55668 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab0KWSoU (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Nov 2010 13:44:20 -0500
In-Reply-To: <20101121134222.GC17293@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>, Herbert Xu <herbert@gondor.apana.org.au>, jrnieder@gmail.com

On 21/11/10 14:41, Jilles Tjoelker wrote:
> The backslash prevents the closing brace from terminating the
> substitution, therefore it should be removed.

Thanks, that works great.

> Example:
>    printf "%s\n" ${$+\}} ${$+"\}"} "${$+\}}"
> should print } three times, without backslashes.

Some tests with different a few shells:

                                                     "${$+'\}'}"
                                              "${$+"\}"}"
                                       "${$+\}}"
                                ${$+'\}'}
                         ${$+"\}"}
                  ${$+\}}

bash           | }      \}     \}     \}     }      '\}'
pdksh          | }      \}     \}     }      \}     \}
ksh            | }      }      \}     }      }      '}'
dash (current) | }      \}     \}     \}     \}     '\}'
dash (patched) | }      }      \}     }      }      '}'

The one thing that I was a bit confused about was the difference between 
${$+'\}'} and ${$+"\}"}, but I do think that is correct: the backslash 
is used to see that the immediately following } is not a terminator, but 
the special rule allowing backslash before } to be removed in 
double-quoted strings in parameter expansions does not apply (there is 
no double-quoted string), so the backslash appears in the output as 
well. And since the last form uses a double-quoted string, the backslash 
gets removed there.

Cheers,
Harald
