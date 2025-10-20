Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CF2FD1AA
	for <dash@vger.kernel.org>; Mon, 20 Oct 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963474; cv=none; b=hOf0h73mlcA0vJNC8bREu5lszHvKYpW8SxneUZppJwmVFchHqWmdag/uh5/OlWu5WVCmoRk4WuPch/wwkER8slKqN8INfIQTnmzDJAaNWqHtf8f4Xa0oMG9dale0k5KZclKmXw20NqTdQVThjdde40jDnYqNyiN5OU4vb/x5tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963474; c=relaxed/simple;
	bh=gra9CAy+wNpKkuAuGSpMEBjykRz1IjXMpd/0sg6qmVw=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=QOuXA0D1aWeBaiGt4BInrIMpmLxYWXIF2nueDp9ZhzBJ/ZFpmlOXVUMYECdMqpg4njlXjq4wEMXJtlqgYmBNF4UyNbGhIpPEwdOM4BnzcNWiaNSF4b7G06Ym1a9NTrB8EdWMyBTq2TGvQNzp8qvTnPOFzIvq4Gup2kXjHMb/c2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=nbS1CDev; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="nbS1CDev"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 142AC240101
	for <dash@vger.kernel.org>; Mon, 20 Oct 2025 14:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760963464; bh=DhiABKBB84iD3ZUSd8oRQHCmEnE+vj+ozhFyrLk5XZI=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=nbS1CDevzFRJVZ/YMGdfx8VP4jTkYqjhwtHHDZFPbn4KIuEtvbFkrcnPYxUjIkVQV
	 IEbUd6z1tL8/b1cqQFUYe0y01DdB9SjZQ7ThNdMaNvhShlO3YWs0uJKvgz1c3l7x8R
	 VkFbAIVemmVAS7iBlvsUmQPUY+twns8B7s02B7IQLkZS9UaVVYq5oupuaZhjQkaL3d
	 CUPIPczDXKKC9ZJeQNpYJ5/0OLA1Lse9VPymbbvFtL/7+jNk40yiKB/T9MqP1vz3J2
	 HXVSQIwErmWB+gv6WWWZeN+OW06J9bhguNqfvzRHJ4PXdF7pIkX1eHcKvnpIpTknKs
	 uDOgtVr8u8qaA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cqvsz5NDQz9rxd
	for <dash@vger.kernel.org>; Mon, 20 Oct 2025 14:31:03 +0200 (CEST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Oct 2025 12:31:03 +0000
From: j.daubert@posteo.de
To: Dash <dash@vger.kernel.org>
Subject: dash 0.5.13.1: problems with dash as /bin/sh on ARM64
Message-ID: <df9d5e861c3fc9bf6754fecc113616c1@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

We are using dash 0.5.13.1 as /bin/sh and running into several build 
problems on ARM64,
for example curl:

...
+ make
Making all in lib
make[1]: Entering directory '/home/pkgmk/work/curl/src/curl-8.16.0/lib'
make  all-am
make[2]: Entering directory '/home/pkgmk/work/curl/src/curl-8.16.0/lib'
   CC       libcurl_la-altsvc.lo
   CC       libcurl_la-amigaos.lo
   CC       libcurl_la-asyn-ares.lo
   CC       libcurl_la-asyn-base.lo
   CC       libcurl_la-asyn-thrdd.lo
../libtool: 371: Syntax error: "}" unexpected
make[2]: *** [Makefile:2400: libcurl_la-altsvc.lo] Error 2
make[2]: *** Waiting for unfinished jobs....
   CC       libcurl_la-bufq.lo
../libtool: 371: Syntax error: "}" unexpected
make[2]: *** [Makefile:2407: libcurl_la-amigaos.lo] Error 2
../libtool: 371: Syntax error: "}" unexpected
make[2]: *** [Makefile:2414: libcurl_la-asyn-ares.lo] Error 2
../libtool: 371: Syntax error: "}" unexpected
   CC       libcurl_la-bufref.lo
make[2]: *** [Makefile:2421: libcurl_la-asyn-base.lo] Error 2
../libtool: 371: Syntax error: "}" unexpected
make[2]: *** [Makefile:2428: libcurl_la-asyn-thrdd.lo] Error 2
../libtool: 371: Syntax error: "}" unexpected
make[2]: *** [Makefile:2435: libcurl_la-bufq.lo] Error 2
../libtool: 371: Syntax error: "}" unexpected
make[2]: *** [Makefile:2442: libcurl_la-bufref.lo] Error 2
make[2]: Leaving directory '/home/pkgmk/work/curl/src/curl-8.16.0/lib'
make[1]: *** [Makefile:1658: all] Error 2
make[1]: Leaving directory '/home/pkgmk/work/curl/src/curl-8.16.0/lib'
make: *** [Makefile:620: all-recursive] Error 1
=======> ERROR: Building '/home/pkgmk/pkg/curl#8.16.0-1.pkg.tar.xz' 
failed.


similar errors for libuv, libpcre2 and probably others. On x86_64 
everything woks fine.
Here's a diff between the libtool file created with x86_64 and ARM64:


--- /tmp/libtool	2025-10-15 13:39:32.088306752 +0200
+++ /tmp/libtool_arm64	2025-10-15 13:39:11.089769791 +0200
@@ -56,7 +56,7 @@
  build_old_libs=yes

  # What type of objects to build.
-pic_mode=yes
+pic_mode=default

  # Whether or not to optimize for fast installation.
  fast_install=yes
@@ -68,19 +68,19 @@
  SHELL="/bin/sh"

  # An echo program that protects backslashes.
-ECHO="printf %s\\n"
+ECHO="printf %s\n"

  # The PATH separator for the build system.
  PATH_SEPARATOR=":"

  # The host system.
  host_alias=
-host=x86_64-pc-linux-gnu
+host=aarch64-unknown-linux-gnu
  host_os=linux-gnu

  # The build system.
  build_alias=
-build=x86_64-pc-linux-gnu
+build=aarch64-unknown-linux-gnu
  build_os=linux-gnu

  # A sed program that does not truncate output.
@@ -117,10 +117,10 @@
  lt_unset=unset

  # turn spaces into newlines.
-SP2NL="tr \\040 \\012"
+SP2NL="tr \040 \012"

  # turn newlines into spaces.
-NL2SP="tr \\015\\012 \\040\\040"
+NL2SP="tr \015\012 \040\040"

  # convert $build file names to $host format.
  to_host_file_cmd=func_convert_file_noop
@@ -135,7 +135,7 @@
  deplibs_check_method="pass_all"

  # Command to use when deplibs_check_method = "file_magic".
-file_magic_cmd="\$MAGIC_CMD"
+file_magic_cmd="$MAGIC_CMD"

  # How to find potential files when deplibs_check_method = "file_magic".
  file_magic_glob=""
@@ -144,7 +144,7 @@
  want_nocaseglob="no"

  # Command to associate shared and link libraries.
-sharedlib_from_linklib_cmd="printf %s\\n"
+sharedlib_from_linklib_cmd="printf %s\n"

  # The archiver.
  AR="/usr/bin/ar"
@@ -163,7 +163,7 @@

  # Commands used to install an old-style archive.
  RANLIB="ranlib"
-old_postinstall_cmds="chmod 644 \$oldlib~\$RANLIB \$tool_oldlib"
+old_postinstall_cmds="chmod 644 $oldlib~$RANLIB $tool_oldlib"
  old_postuninstall_cmds=""

  # Whether to use a lock for old archive extraction.
@@ -173,22 +173,22 @@
  LTCC="gcc"

  # LTCC compiler flags.
-LTCFLAGS="-O2 -march=x86-64 -pipe -Werror-implicit-function-declaration 
-Wno-system-headers"
+LTCFLAGS="-O2 -pipe -Werror-implicit-function-declaration 
-Wno-system-headers"

  # Take the output of nm and produce a listing of raw symbols and C 
names.
-global_symbol_pipe="/bin/sed -n -e 's/^.*[	 
]\\([ABCDGIRSTW][ABCDGIRSTW]*\\)[	 ][	 
]*\\([_A-Za-z][_A-Za-z0-9]*\\)\$/\\1 \\2 \\2/p' | /bin/sed '/ 
__gnu_lto/d'"
+global_symbol_pipe="/bin/sed -n -e 's/^.*[	 
]\([ABCDGIRSTW][ABCDGIRSTW]*\)[	 ][	 ]*\([_A-Za-z][_A-Za-z0-9]*\)$/\1 \2 
\2/p' | /bin/sed '/ __gnu_lto/d'"

  # Transform the output of nm in a proper C declaration.
-global_symbol_to_cdecl="/bin/sed -n -e 's/^T .* \\(.*\\)\$/extern int 
\\1();/p' -e 's/^[ABCDGIRSTW][ABCDGIRSTW]* .* \\(.*\\)\$/extern char 
\\1;/p'"
+global_symbol_to_cdecl="/bin/sed -n -e 's/^T .* \(.*\)$/extern int 
\1();/p' -e 's/^[ABCDGIRSTW][ABCDGIRSTW]* .* \(.*\)$/extern char \1;/p'"

  # Transform the output of nm into a list of symbols to manually 
relocate.
  global_symbol_to_import=""

  # Transform the output of nm in a C name address pair.
-global_symbol_to_c_name_address="/bin/sed -n -e 's/^: \\(.*\\) .*\$/  
{\"\\1\", (void *) 0},/p' -e 's/^[ABCDGIRSTW][ABCDGIRSTW]* .* 
\\(.*\\)\$/  {\"\\1\", (void *) \\&\\1},/p'"
+global_symbol_to_c_name_address="/bin/sed -n -e 's/^: \(.*\) .*$/  
{"\1", (void *) 0},/p' -e 's/^[ABCDGIRSTW][ABCDGIRSTW]* .* \(.*\)$/  
{"\1", (void *) \&\1},/p'"

  # Transform the output of nm in a C name address pair when lib prefix 
is needed.
-global_symbol_to_c_name_address_lib_prefix="/bin/sed -n -e 's/^: 
\\(.*\\) .*\$/  {\"\\1\", (void *) 0},/p' -e 
's/^[ABCDGIRSTW][ABCDGIRSTW]* .* \\(lib.*\\)\$/  {\"\\1\", (void *) 
\\&\\1},/p' -e 's/^[ABCDGIRSTW][ABCDGIRSTW]* .* \\(.*\\)\$/  
{\"lib\\1\", (void *) \\&\\1},/p'"
+global_symbol_to_c_name_address_lib_prefix="/bin/sed -n -e 's/^: \(.*\) 
.*$/  {"\1", (void *) 0},/p' -e 's/^[ABCDGIRSTW][ABCDGIRSTW]* .* 
\(lib.*\)$/  {"\1", (void *) \&\1},/p' -e 's/^[ABCDGIRSTW][ABCDGIRSTW]* 
.* \(.*\)$/  {"lib\1", (void *) \&\1},/p'"

  # The name lister interface.
  nm_interface="BSD nm"
@@ -261,14 +261,14 @@
  shlibpath_overrides_runpath=no

  # Format of library name prefix.
-libname_spec="lib\$name"
+libname_spec="lib$name"

  # List of archive names.  First name is the real one, the rest are 
links.
  # The last name is the one that the linker finds with -lNAME
-library_names_spec="\$libname\$release\$shared_ext\$versuffix 
\$libname\$release\$shared_ext\$major \$libname\$shared_ext"
+library_names_spec="$libname$release$shared_ext$versuffix 
$libname$release$shared_ext$major $libname$shared_ext"

  # The coded name of the library, if different from the real name.
-soname_spec="\$libname\$release\$shared_ext\$major"
+soname_spec="$libname$release$shared_ext$major"

  # Permission mode override for installation of shared libraries.
  install_override_mode=""
@@ -280,7 +280,7 @@
  postuninstall_cmds=""

  # Commands used to finish a libtool library installation in a 
directory.
-finish_cmds="PATH=\\\"\\\$PATH:/sbin\\\" ldconfig -n \$libdir"
+finish_cmds="PATH="\$PATH:/sbin" ldconfig -n $libdir"

  # As "finish_cmds", except a single script fragment to be evaled but
  # not shown.
@@ -290,10 +290,10 @@
  hardcode_into_libs=yes

  # Compile-time system search path for libraries.
-sys_lib_search_path_spec="/usr/lib/gcc/x86_64-pc-linux-gnu/14.3.0 
/usr/lib /lib "
+sys_lib_search_path_spec="/usr/lib/gcc/aarch64-unknown-linux-gnu/14.3.0 
/usr/lib /lib "

  # Detected run-time system search path for libraries.
-sys_lib_dlsearch_path_spec="/lib /usr/lib /lib32 /usr/lib32 
/usr/lib/openmpi "
+sys_lib_dlsearch_path_spec="/lib /usr/lib "

  # Explicit LT_SYS_LIBRARY_PATH set during ./configure time.
  configure_time_lt_sys_library_path=""
@@ -313,14 +313,14 @@


  # The linker used to build libraries.
-LD="/usr/bin/ld -m elf_x86_64"
+LD="/usr/bin/ld"

  # How to create reloadable object files.
  reload_flag=" -r"
-reload_cmds="\$LD\$reload_flag -o \$output\$reload_objs"
+reload_cmds="$LD$reload_flag -o $output$reload_objs"

  # Commands used to build an old-style archive.
-old_archive_cmds="\$AR \$AR_FLAGS \$oldlib\$oldobjs~\$RANLIB 
\$tool_oldlib"
+old_archive_cmds="$AR $AR_FLAGS $oldlib$oldobjs~$RANLIB $tool_oldlib"

  # A language specific compiler.
  CC="gcc"
@@ -350,10 +350,10 @@
  allow_libtool_libs_with_static_runtimes=no

  # Compiler flag to allow reflexive dlopens.
-export_dynamic_flag_spec="\$wl--export-dynamic"
+export_dynamic_flag_spec="$wl--export-dynamic"

  # Compiler flag to generate shared objects directly from archives.
-whole_archive_flag_spec="\$wl--whole-archive\$convenience 
\$wl--no-whole-archive"
+whole_archive_flag_spec="$wl--whole-archive$convenience 
$wl--no-whole-archive"

  # Whether the compiler copes with passing no objects directly.
  compiler_needs_object="no"
@@ -365,11 +365,11 @@
  old_archive_from_expsyms_cmds=""

  # Commands used to build a shared archive.
-archive_cmds="\$CC -shared \$pic_flag \$libobjs \$deplibs 
\$compiler_flags \$wl-soname \$wl\$soname -o \$lib"
-archive_expsym_cmds="echo \\\"{ global:\\\" > 
\$output_objdir/\$libname.ver~
-            cat \$export_symbols | \$SED -e 
\\\"s/\\\\(.*\\\\)/\\\\1;/\\\" >> \$output_objdir/\$libname.ver~
-            echo \\\"local: *; };\\\" >> \$output_objdir/\$libname.ver~
-            \$CC -shared \$pic_flag \$libobjs \$deplibs 
\$compiler_flags \$wl-soname \$wl\$soname \$wl-version-script 
\$wl\$output_objdir/\$libname.ver -o \$lib"
+archive_cmds="$CC -shared $pic_flag $libobjs $deplibs $compiler_flags 
$wl-soname $wl$soname -o $lib"
+archive_expsym_cmds="echo "{ global:" > $output_objdir/$libname.ver~
+            cat $export_symbols | $SED -e "s/\(.*\)/\1;/" >> 
$output_objdir/$libname.ver~
+            echo "local: *; };" >> $output_objdir/$libname.ver~
+            $CC -shared $pic_flag $libobjs $deplibs $compiler_flags 
$wl-soname $wl$soname $wl-version-script $wl$output_objdir/$libname.ver 
-o $lib"

  # Commands used to build a loadable module if different from building
  # a shared archive.
@@ -387,7 +387,7 @@

  # Flag to hardcode $libdir into a binary during linking.
  # This must work even if $libdir does not exist
-hardcode_libdir_flag_spec="\$wl-rpath \$wl\$libdir"
+hardcode_libdir_flag_spec="$wl-rpath $wl$libdir"

  # Whether we need a single "-rpath" flag with a separated argument.
  hardcode_libdir_separator=""
@@ -426,7 +426,7 @@
  always_export_symbols=no

  # The commands to list exported symbols.
-export_symbols_cmds="\$NM \$libobjs \$convenience | 
\$global_symbol_pipe | \$SED 's/.* //' | sort | uniq > \$export_symbols"
+export_symbols_cmds="$NM $libobjs $convenience | $global_symbol_pipe | 
$SED 's/.* //' | sort | uniq > $export_symbols"

  # Symbols that should not be listed in the preloaded symbols.
  exclude_expsyms="_GLOBAL_OFFSET_TABLE_|_GLOBAL__F[ID]_.*"


We can see that on ARM64 lot of '\' are missing.
The problem is fixed it we build dash with the '--enable-fnmatch' 
configure option!
Hope this helps, if you need additional information, please ask.

Thanks for dash and best regards
Juergen
