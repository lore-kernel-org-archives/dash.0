From: jca+dash-oD5z7zAif+Mdnm+yROfE0A@public.gmane.org (=?utf-8?Q?J=C3=A9r=C3=A9mie_Courr=C3=A8ges-Angl?=
 =?utf-8?Q?as?=)
Subject: Re: [PATCH] implement privmode support in dash
Date: Fri, 23 Aug 2013 13:13:07 +0200
Message-ID: <874nag7j98.fsf@shannon.wxcvbn.org>
References: <20130822175936.GA1260@google.com> <52166DA8.1000201@gigawatt.nl>
	<20130822203500.GA21467@stack.nl>
	<CAJ_zFkJEb02d8Xs=RcWnRT7JbgDUYiAwMUUc3WFAfXr1ZN-0DQ@mail.gmail.com>
Reply-To: oss-security-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <oss-security-return-10982-gcsos-oss-security=m.gmane.org-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>
List-Post: <mailto:oss-security-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>
List-Help: <mailto:oss-security-help-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <mailto:oss-security-unsubscribe-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>
List-Subscribe: <mailto:oss-security-subscribe-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>
In-Reply-To: <CAJ_zFkJEb02d8Xs=RcWnRT7JbgDUYiAwMUUc3WFAfXr1ZN-0DQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Tavis Ormandy's message of "Thu, 22 Aug 2013 13:42:32 -0700")
To: Tavis Ormandy <taviso-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Jilles Tjoelker <jilles-bQi0YA1h5vk@public.gmane.org>, Harald van Dijk <harald-8ZdJMhgJluOEVqv0pETR8A@public.gmane.org>, dash-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oss-security-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org
List-Id: dash@vger.kernel.org

Tavis Ormandy <taviso-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> writes:

> On Thu, Aug 22, 2013 at 1:35 PM, Jilles Tjoelker <jilles-bQi0YA1h5vk@public.gmane.org> wrote:
>> I think there is no reason to deviate from other shells here. Therefore,
>> please call it "privileged".
>>
>
> Agreed.
>
>>> In bash and FBSD, after starting with -p, set +p can be used to drop
>>> privileges. With your patch, dash accepts set +p, but silently ignores it.
>>
>>> How does something like the attached, to be applied on top of your
>>> patch, look?
>>
>>> [snip]
>>> +     if (!on && (uid != geteuid() || gid != getegid())) {
>>> +             setuid(uid);
>>> +             setgid(gid);
>>> +             /* PS1 might need to be changed accordingly. */
>>> +             choose_ps1();
>>> +     }
>>> +}
>>
>> This code tries to use setuid() and setgid() to drop all privilege,
>> which is only correct if the privilege to be dropped is UID 0, or on BSD
>> systems. It would be better to use setresuid() or setreuid(), and change
>> the GID before changing the UID.
>
> This is logic duplicated from pdksh and bash, I'm slightly reluctant
> to do things differently, unless it's not going to get committed
> otherwise.

pdksh is only maintained by OpenBSD, afaik (mksh syncs regularly).
The current code rather looks like this:

	if (f == FPRIVILEGED && oldval && !newval) {
		gid_t gid = getgid();

		setresgid(gid, gid, gid);
		setgroups(1, &gid);
		setresuid(ksheuid, ksheuid, ksheuid);
	} ...

> You can see some code snippets here:
> http://blog.cmpxchg8b.com/2013/08/security-debianisms.html
>
>> Apart from that, it is better to check the return value from setuid()
>> and similar functions. In particular, some versions of Linux may fail
>> setuid() for [EAGAIN], leaving the process running with the same
>> privileges.
>
> I don't think this is true anymore, but I have no strong objection to
> adding it, so long as it's noted that bash and pdksh do not do this.
>
> Tavis.

-- 
jca | PGP: 0x06A11494 / 61DB D9A0 00A4 67CF 2A90  8961 6191 8FBF 06A1 1494
