From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH 1/2] [INPUT] exit 127 if command_file is given but does
	not exist
Date: Fri, 19 Mar 2010 17:20:22 +0100
Message-ID: <20100319162022.5937.qmail@af5ed70b983223.315fe32.mid.smarden.org>
References: <20090929111555.19359.qmail@de3d04e6be5ad4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:33535 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252Ab0CSQ1G (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 19 Mar 2010 12:27:06 -0400
Content-Disposition: inline
In-Reply-To: <20090929111555.19359.qmail@de3d04e6be5ad4.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi Herbert,

if you find some spare time, can you please take a look at these
patches, and see whether they're suitable for master?

 http://article.gmane.org/gmane.comp.shells.dash/198
 http://article.gmane.org/gmane.comp.shells.dash/199
 http://article.gmane.org/gmane.comp.shells.dash/200
 http://article.gmane.org/gmane.comp.shells.dash/201
 http://article.gmane.org/gmane.comp.shells.dash/196

Thanks, Gerrit.


On Tue, Sep 29, 2009 at 11:15:55AM +0000, Gerrit Pape wrote:
> This commit makes dash exit with return code 127 instead of 2 if
> started as non-interactive shell with a non-existent command_file
> specified as argument, as documented in
>  http://www.opengroup.org/onlinepubs/009695399/utilities/sh.html#tag_04_128_14
> 
> The wrong exit code was reported by Clint Adams through
>  http://bugs.debian.org/548743
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  src/input.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/src/input.c b/src/input.c
> index e57ad76..c1e3e54 100644
> --- a/src/input.c
> +++ b/src/input.c
> @@ -101,6 +101,7 @@ MKINIT struct parsefile basepf;	/* top level input file */
>  MKINIT char basebuf[IBUFSIZ];	/* buffer for top level input file */
>  struct parsefile *parsefile = &basepf;	/* current input file */
>  int whichprompt;		/* 1 == PS1, 2 == PS2 */
> +extern int exitstatus;
>  
>  #ifndef SMALL
>  EditLine *el;			/* cookie for editline package */
> @@ -408,7 +409,9 @@ setinputfile(const char *fname, int flags)
>  	if ((fd = open(fname, O_RDONLY)) < 0) {
>  		if (flags & INPUT_NOFILE_OK)
>  			goto out;
> -		sh_error("Can't open %s", fname);
> +		sh_warnx("Can't open %s", fname);
> +		exitstatus = 127;
> +		exraise(EXEXIT);
>  	}
>  	if (fd < 10)
>  		fd = savefd(fd, fd);
> -- 
> 1.6.0.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dash" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
