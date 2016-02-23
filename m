From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] Illegal function names are accepted after being used as
 aliases
Date: Tue, 23 Feb 2016 19:44:09 +0100
Message-ID: <56CCA879.1070208@gigawatt.nl>
References: <56CCA25E.5020809@openmailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:49685
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753605AbcBWSoO (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 23 Feb 2016 13:44:14 -0500
In-Reply-To: <56CCA25E.5020809@openmailbox.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jan Verbeek <ring@openmailbox.org>, dash@vger.kernel.org

On 23/02/2016 19:18, Jan Verbeek wrote:
> Function definitions that use a bad function name (such as "-" and "=")
> are accepted if the function name already exists as an alias. For example:
>
> $ -
> dash: 1: -: not found
> $ - () { echo hello; }
> dash: 2: Syntax error: Bad function name
> $ -
> dash: 2: -: not found
> $ alias -=true
> $ -
> $ - () { echo hello; }
> $ -
> hello
> $

After alias -=true, - () { echo hello; } is treated as a use of that 
alias. It doesn't define a function with a name of -, it defines a 
function with a name of true, which consists only of valid characters.

$ alias -=true
$ -() { echo hello; }
$ type -
- is an alias for true
$ type true
true is a shell function
$ true
hello

This matches bash's behaviour, aside from bash requiring -- to prevent 
detection of invalid flags to the alias command:

bash-4.3$ alias -- -=true
bash-4.3$ -() { echo hello; }
bash-4.3$ type -
- is aliased to `true'
bash-4.3$ type true
true is a function
true ()
{
     echo hello
}
bash-4.3$ true
hello

Cheers,
Harald van Dijk
