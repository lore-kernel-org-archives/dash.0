From: jca+dash@wxcvbn.org (=?utf-8?Q?J=C3=A9r=C3=A9mie_Courr=C3=A8ges-Angl?=
	=?utf-8?Q?as?=)
Subject: Re: [PATCH] implement privmode support in dash
Date: Fri, 23 Aug 2013 13:40:31 +0200
Message-ID: <87txig63f4.fsf@shannon.wxcvbn.org>
References: <20130822175936.GA1260@google.com> <52166DA8.1000201@gigawatt.nl>
	<20130822203500.GA21467@stack.nl>
	<CAJ_zFkJEb02d8Xs=RcWnRT7JbgDUYiAwMUUc3WFAfXr1ZN-0DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from coloc.wxcvbn.org ([80.67.177.44]:44131 "EHLO coloc.wxcvbn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599Ab3HWLkv (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 07:40:51 -0400
In-Reply-To: <CAJ_zFkJEb02d8Xs=RcWnRT7JbgDUYiAwMUUc3WFAfXr1ZN-0DQ@mail.gmail.com>
	(Tavis Ormandy's message of "Thu, 22 Aug 2013 13:42:32 -0700")
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tavis Ormandy <taviso@google.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, oss-security@lists.openwall.com


Also,

Tavis Ormandy <taviso@google.com> writes:

[...]

>> Apart from that, it is better to check the return value from setuid()
>> and similar functions. In particular, some versions of Linux may fail
>> setuid() for [EAGAIN], leaving the process running with the same
>> privileges.
>
> I don't think this is true anymore, but I have no strong objection to
> adding it, so long as it's noted that bash and pdksh do not do this.

Just for reference, from mksh:

[...]

#ifdef SETUID_CAN_FAIL_WITH_EAGAIN
/* we don't need to check for other codes, EPERM won't happen */
#define DO_SETUID(func, argvec) do {					\
	if ((func argvec) && errno == EAGAIN)				\
		errorf("%s failed with EAGAIN, probably due to a"	\
		    " too low process limit; aborting", #func);		\
} while (/* CONSTCOND */ 0)
#else
#define DO_SETUID(func, argvec) func argvec
#endif

[...]

	  if (f == FPRIVILEGED && oldval && !newval) {
		/* Turning off -p? */

		/*XXX this can probably be optimised */
		kshegid = kshgid = getgid();
#if HAVE_SETRESUGID
		DO_SETUID(setresgid, (kshegid, kshegid, kshegid));
#if HAVE_SETGROUPS
		/* setgroups doesn't EAGAIN on Linux */
		setgroups(1, &kshegid);
#endif
		DO_SETUID(setresuid, (ksheuid, ksheuid, ksheuid));
#else
		/* seteuid, setegid, setgid don't EAGAIN on Linux */
		ksheuid = kshuid = getuid();
#ifndef MKSH__NO_SETEUGID
		seteuid(ksheuid);
#endif
		DO_SETUID(setuid, (ksheuid));
#ifndef MKSH__NO_SETEUGID
		setegid(kshegid);
#endif
		setgid(kshegid);
#endif
	} [...]


> Tavis.

-- 
jca | PGP: 0x06A11494 / 61DB D9A0 00A4 67CF 2A90  8961 6191 8FBF 06A1 1494
