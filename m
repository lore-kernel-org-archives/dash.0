From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH 2/2] histedit: Remove non-glibc fallback code
Date: Mon, 8 Aug 2016 17:50:11 +0200
Message-ID: <20160808155011.GA29197@stack.nl>
References: <20160804055411.23558-1-somasissounds@gmail.com>
 <20160804055411.23558-2-somasissounds@gmail.com>
 <20160804155908.GA94936@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:56503 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752143AbcHHPuO (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Aug 2016 11:50:14 -0400
Content-Disposition: inline
In-Reply-To: <20160804155908.GA94936@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kylie McClain <somasissounds@gmail.com>
Cc: dash@vger.kernel.org, Kylie McClain <somasis@exherbo.org>

On Thu, Aug 04, 2016 at 05:59:08PM +0200, Jilles Tjoelker wrote:
> >From 23da600dcff616662a93f307420d9142598e2cae Mon Sep 17 00:00:00 2001
> From: Jilles Tjoelker <jilles@stack.nl>
> Date: Thu, 4 Aug 2016 17:51:12 +0200
> Subject: [PATCH 1/2] [HISTEDIT] Stop depending on getopt reset feature.

> Instead, use our own nextopt() function.
> ---
>  src/histedit.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/src/histedit.c b/src/histedit.c
> index 94465d7..ec45065 100644
> --- a/src/histedit.c
> +++ b/src/histedit.c
> @@ -214,13 +214,8 @@ histcmd(int argc, char **argv)
>  	if (argc == 1)
>  		sh_error("missing history argument");
>  
> -#ifdef __GLIBC__
> -	optind = 0;
> -#else
> -	optreset = 1; optind = 1; /* initialize getopt */
> -#endif
>  	while (not_fcnumber(argv[optind]) &&
> -	      (ch = getopt(argc, argv, ":e:lnrs")) != -1)
> +	      (ch = nextopt(":e:lnrs")) != '\0')
>  		switch ((char)ch) {
>  		case 'e':
>  			editor = optionarg;

This is clearly wrong; not_fcnumber() should be passed *argptr instead
of something bogus depending on optind.

The fixed version is what FreeBSD sh has as of SVN r240541 but I have
not tested it in dash.

In any case, a side effect of this change is a small code size
reduction.

-- 
Jilles Tjoelker
