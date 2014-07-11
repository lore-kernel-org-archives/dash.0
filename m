From: Luigi Tarenga <luigi.tarenga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: bug in dash compile with buildroot
Date: Fri, 11 Jul 2014 10:44:54 +0200
Message-ID: <53BFA406.7080408@gmail.com>
References: <53BBFECB.6070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <buildroot-bounces-9GAsQqxh4YTR7s880joybQ@public.gmane.org>
In-Reply-To: <53BBFECB.6070003-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.busybox.net/mailman/options/buildroot>,
 <mailto:buildroot-request-9GAsQqxh4YTR7s880joybQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.busybox.net/pipermail/buildroot>
List-Post: <mailto:buildroot-9GAsQqxh4YTR7s880joybQ@public.gmane.org>
List-Help: <mailto:buildroot-request-9GAsQqxh4YTR7s880joybQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.busybox.net/mailman/listinfo/buildroot>,
 <mailto:buildroot-request-9GAsQqxh4YTR7s880joybQ@public.gmane.org?subject=subscribe>
Errors-To: buildroot-bounces-9GAsQqxh4YTR7s880joybQ@public.gmane.org
Sender: buildroot-bounces-9GAsQqxh4YTR7s880joybQ@public.gmane.org
To: buildroot-9GAsQqxh4YTR7s880joybQ@public.gmane.org, dash-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dash@vger.kernel.org

Hi lists,
for the buildroot mailing list: I tried to post this bug report but I 
wasn't subscribed.
Below you can see my original bug report.

I did some more test and the dash source looks good, the longjmp 
destination is
correct (actually it jump to main()). The problem seems the longjmp 
implementation.
In the case of command like dash -c "(echo ciao; /bin/true)&" a longjmp 
is not
performed and so no segfault is triggered.

as a POC I tried this little c code:
[vortex@lizard ~]$ cat longjmptest.c
#include <stdio.h>
#include <setjmp.h>

static jmp_buf env1;

long int func2 () {
    long int b;
    b=1000;
    longjmp(env1,1);
    return b;
}

long int func1 () {
    long int a;
    a = func2 () ;
    return a;
}

int main() {
     long int num;
     num=0;

     printf("\nstart jump test\n");

     if (setjmp(env1)) {
        printf("jumped to env1\n");
     } else {
         num = func1 ();
     }

     printf("check 1 num=%ld\n",num);
     printf("finish\n");
     return 0;
}


If I compile with my stock gcc on centos 6.5 (64bit):
[vortex@lizard ~]$ gcc -Wall -static longjmptest.c
[vortex@lizard ~]$ ./a.out

start jump test
jumped to env1
check 1 num=0
finish

while if I compile with the crosscompile in buildroot (32bit):
[vortex@lizard ~]$ 
/data/misc/buildroot-2014.05/output/host/usr/bin/i686-buildroot-linux-uclibc-gcc 
-Wall -static longjmptest.c
[vortex@lizard ~]$ ./a.out

start jump test
Segmentation fault


looks like some stack problem... I never learned to use gdb (my bad!) so 
I cannot check the stack
status... Is there any known problem with the longjmp in uclibc?

thank you in advance
Luigi


On 07/08/2014 04:23 PM, Luigi Tarenga wrote:
> hi,
> I send this bug report to both list because I'm not sure who will find 
> this relevant.
>
> I compiled a buildroot image for a laptop with atom so the build is 
> for x86_64
> architecture. In the build configuration I flagged to include dash and 
> this get
> compiled as static (this let me test the bug even on the host system).
>
> While writing some test script (actually a init process written in 
> dash) I hit this
> strange bug:
>
> # dash -c "( echo ciao) &)"
> ciao
> Segmentation fault
>
> # dash -c "(echo ciao; /bin/true)&"
> ciao
>
> # dash -c "(echo ciao; /bin/true; echo ciao)&"
> ciao
> ciao
> Segmentation fault
>
>
> As you see if I put a subshell in background it dump. If in the same 
> subshell I execute
> an external command as last command it works.
> I write this bug even to the buildroot team because if I rebuild dash 
> from the same source
> without using the crosscompile the same bug do not happen.
>
> I enable DEBUG in the dash source and tried to narrow it a little , 
> this is what I found:
>
> this is the trace with some little more messages inserted by me:
> Tracing started.
> token "("
> pipeline: entered
> reread token "("
> reread token "("
> pipeline: entered
> token word echo
> reread token word echo
> reread token word echo
> token word ciao
> token ")"
> reread token ")"
> reread token ")"
> reread token ")"
> reread token ")"
> token "&"
> reread token "&"
> reread token "&"
> reread token "&"
> token end of file
> reread token end of file
> evaltree called
> pid 1006, evaltree(0x806b438: 3, 1) called
> evalsubshell called
> check 2
> evaltree called
> pid 1006, evaltree(0x806b3e0: 4, 1) called
> evalsubshell called
> check nofork
> check 2
> evaltree called
> pid 1006, evaltree(0x806b420: 0, 1) called
> evalcommand(0x806b420, 1) called
> evalcommand arg: echo
> evalcommand arg: ciao
> redirectsafe after setjmp
> check 4
> check 6
>
>
> I modified exraise with 2 check:
>
> void
> exraise(int e)
> {
> #ifdef DEBUG
>         if (handler == NULL)
>                 abort();
> #endif
>         INTOFF;
>
>         exception = e;
>         TRACE(("check 6\n"));
>         longjmp(handler->loc, 1);
>         TRACE(("check 7\n"));
> }
>
> as you can see check 7 is never reached (ok it's obvious), but I 
> cannot find
> if the longjmp land correctly somewhere or it's the function that 
> trigger the
> segfault (I suspect the handler->loc point to nowhere...).
> I tried to put a TRACE after every setjmp but didn't find the one that 
> is the
> target of that longjmp...
>
> maybe the correct one is the one in exitshell() ???
>
> here some info on my setup:
>
> host:
> centos 6.5
>
> buildroot version 2014.05
>
> buildroot configuration:
> BR2_x86_atom=y
> BR2_UCLIBC_CONFIG="board/pinky/uclibc.config"
> BR2_TARGET_GENERIC_HOSTNAME="pinky"
> BR2_TARGET_GENERIC_GETTY_PORT="tty1"
> BR2_TARGET_GENERIC_GETTY_TERM="linux"
> BR2_ROOTFS_OVERLAY="board/pinky/overlay"
> BR2_LINUX_KERNEL=y
> BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
> BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/pinky/linux.config"
> BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
> BR2_PACKAGE_HOSTAPD=y
> BR2_PACKAGE_HOSTAPD_EAP=y
> BR2_PACKAGE_IW=y
> BR2_PACKAGE_OPKG=y
> BR2_PACKAGE_OPKG_GPG_SIGN=y
> BR2_PACKAGE_DASH=y
> BR2_PACKAGE_JOE=y
> BR2_TARGET_GRUB=y
>
> (dash version 0.5.7, downloaded from buildroot, some patches from debian,
> it seems version 0.5.7-3)
> I hope you can reproduce this bug on your system with those info.
>
> regards
> Luigi
