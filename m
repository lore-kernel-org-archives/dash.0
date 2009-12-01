From: William Immendorf <will.immendorf@gmail.com>
Subject: Dash fails to compile on UTF-8 with the Coreutils i18n patch
Date: Mon, 30 Nov 2009 19:27:17 -0600
Message-ID: <62234dc60911301727o2c54e66bhae2969dd434d59@mail.gmail.com>
References: <62234dc60911291654k6a4fc375o131af7460db907e4@mail.gmail.com>
	 <20091130063621.GA9950@gondor.apana.org.au>
	 <62234dc60911300509n7c7b28b5n9b668c28e01b431e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:65153 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbZLAB1M convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 30 Nov 2009 20:27:12 -0500
Received: by ewy19 with SMTP id 19so4436975ewy.21
        for <dash@vger.kernel.org>; Mon, 30 Nov 2009 17:27:18 -0800 (PST)
In-Reply-To: <62234dc60911300509n7c7b28b5n9b668c28e01b431e@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, Nov 30, 2009 at 12:36 AM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> If you can reproduce the problem, please
>
> 1) Confirm that setting LC_CTYPES on the sed command only in
> mkbuiltins also fixes the issue;
> 2) See if [[:lower:]] instead of [a-z] fixes the problem without
> LC_CTYPES.
Herbert,

I'm not talking about sed. I'm talking about the sort commands in
mkbuiltins. The known fix is to change both of the LC_COLLATE=3DC stuff
to LC_CTYPE=3DC, and that works.

--
William Immendorf
The ultimate in free computing.
Messages in plain text, please, no HTML.

--------------

"Every nonfree program has a lord, a master --
and if you use the program, he is your master." =A0Richard Stallman



--=20
William Immendorf
The ultimate in free computing.
Messages in plain text, please, no HTML.

--------------

"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman
