From: Nikolai Merinov <n.merinov@inango-systems.com>
Subject: Re: [PATCH] expand: Fix trailing newlines processing in backquote
 expanding
Date: Mon, 13 Jan 2020 14:08:05 +0200 (IST)
Message-ID: <130240790.41627.1578917285464.JavaMail.zimbra@inango-systems.com>
References: <20190429141337.6804-1-n.merinov@inango-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.inango-systems.com ([178.238.230.57]:38232 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMRG (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 13 Jan 2020 07:17:06 -0500
In-Reply-To: <20190429141337.6804-1-n.merinov@inango-systems.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, herbert@gondor.apana.org.au
Cc: os <os@inango-systems.com>

Hi Herbert,

Do you want any changes to this patch from us? This patch in state "Under Review" more then 8 months.

Regards,
Nikolai

----- Original Message -----
> From: "n merinov" <n.merinov@inango-systems.com>
> To: dash@vger.kernel.org
> Cc: "os" <os@inango-systems.com>, "n merinov" <n.merinov@inango-systems.com>
> Sent: Monday, April 29, 2019 7:13:37 PM
> Subject: [PATCH] expand: Fix trailing newlines processing in backquote expanding

> According to POSIX.1-2008 we should remove newlines only at the end of
> the substitution. Newlines-only substitions causes dash to remove
> newlines before beggining of the substitution. The following code:
> 
>    cat <<END
>    1
>    $(echo "")
>    2
>    END
> 
> prints "1<newline>2" instead of expected "1<newline><newline>2".
> 
> This patch fixes trailing newlines processing in backquote expanding.
> 
> Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
> ---
> src/expand.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/expand.c b/src/expand.c
> index af9cac9..1b1f95e 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -525,7 +525,7 @@ read:
> 
> 	/* Eat all trailing newlines */
> 	dest = expdest;
> -	for (; dest > (char *)stackblock() && dest[-1] == '\n';)
> +	for (; dest > ((char *)stackblock() + startloc) && dest[-1] == '\n';)
> 		STUNPUTC(dest);
> 	expdest = dest;
> 
> --
> 2.17.1
