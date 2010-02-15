From: Eric Blake <ebb9@byu.net>
Subject: Re: test -x should use faccessat, not stat
Date: Mon, 15 Feb 2010 06:31:14 -0700
Message-ID: <4B794CA2.1080707@byu.net>
References: <20100214061137.GA9882@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:48470
	"EHLO qmta15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751240Ab0BONgU (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 15 Feb 2010 08:36:20 -0500
In-Reply-To: <20100214061137.GA9882@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

According to Herbert Xu on 2/13/2010 11:11 PM:
> Eric Blake <ebb9@byu.net> wrote:
>> This report was originally raised on the cygwin list:
>>
>> http://cygwin.com/ml/cygwin/2010-02/msg00239.html
>>
>> In short, in the presence of ACLs, dash's implementation of test -r, test -w, 
>> and test -x gives incorrect answers, when the current user has permissions to 
>> access a file that were granted by ACLs but not by the current stat() 
>> permissions.  dash should be using faccessat(,AT_EACCESS) (or 
>> eaccess/euidaccess) if available, rather than stat(), to determine whether a 
>> file is accessible.
> 
> What does bash to in this case?

The bash source code shows the following:

In test.c, unary_test() calls sh_eaccess for test -r, -w, and -x.

In lib/sh/eaccess.c, bash currently uses:

int
sh_eaccess (path, mode)
     char *path;
     int mode;
{
  if (path_is_devfd (path))
    return (sh_stataccess (path, mode));

#if defined (HAVE_EACCESS)		/* FreeBSD */
  return (eaccess (path, mode));
#elif defined (EFF_ONLY_OK)		/* SVR4(?), SVR4.2 */
  return access (path, mode|EFF_ONLY_OK);
#else
  if (mode == F_OK)
    return (sh_stataccess (path, mode));

#  if HAVE_DECL_SETREGID
  if (current_user.uid != current_user.euid || current_user.gid !=
current_user.egid)
    return (sh_euidaccess (path, mode));
#  endif

  if (current_user.uid == current_user.euid && current_user.gid ==
current_user.egid)
    return (access (path, mode));

  return (sh_stataccess (path, mode));
#endif
}

But this could probably be improved to take advantage of the standardized
faccessat(path,mode,AT_EACCESS) in the case where that exists.

Furthermore, the link to the post on the cygwin list shows that bash, zsh,
and pdksh all honored ACLs, and that dash is the odd man out for not
recognizing when the current user has rights due to ACLs that are not
visible through the stat mode bits.

Finally, it is worth pointing out that on at least cygwin, faccessat and
friends are faster than stat.  Do you want me to prepare the patch?

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
