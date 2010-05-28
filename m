From: Kris Maglione <maglione.k@gmail.com>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Fri, 28 May 2010 19:01:25 -0400
Message-ID: <20100528225321.GA11940@jg.home>
References: <20100528153423.GA3885@jg.home> <20100528224334.GA26879@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bKyqfOwhbdpXa4YI"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49258 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab0E1XB3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 19:01:29 -0400
Received: by vws9 with SMTP id 9so1618928vws.19
        for <dash@vger.kernel.org>; Fri, 28 May 2010 16:01:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100528224334.GA26879@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, May 29, 2010 at 08:43:34AM +1000, Herbert Xu wrote:
>Kris Maglione <maglione.k@gmail.com> wrote:
>>
>> I should have mentioned that I tested it with every revision 
>> upto and including that one (especially as it looked promising).
>> 
>> I definitely still have this problem as of 
>> 207e4c2a322fe: [JOBS] Fix wait regression where it does not wait for all jobs  master 
>
>Hmm, I can't reproduce this here at all.  Can you please run it
>with strace -f and send the result to us?

That's interesting. I've had three users complain about it so 
far. strace is attached.

-- 
Kris Maglione

Insane people are always sure that they are fine.  It is only the sane
people who are willing to admit that they are crazy.
	--Nora Ephron


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="strace-dash1.log"

execve("/home/kris/code/dash.git/src/dash", ["/home/kris/code/dash.git/src/das"...], [/* 97 vars */]) = 0
brk(0)                                  = 0x174d000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b299768c000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=258429, ...}) = 0
mmap(NULL, 258429, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b299768d000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000\354\1\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1651953, ...}) = 0
mmap(NULL, 3521384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2b299788e000
mprotect(0x2b29979e0000, 2097152, PROT_NONE) = 0
mmap(0x2b2997be0000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x152000) = 0x2b2997be0000
mmap(0x2b2997be5000, 19304, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b2997be5000
close(3)                                = 0
open("/usr/lib/libedit.so.0", O_RDONLY) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000\266\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=199791, ...}) = 0
mmap(NULL, 2289024, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2b2997bea000
mprotect(0x2b2997c12000, 2097152, PROT_NONE) = 0
mmap(0x2b2997e12000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x28000) = 0x2b2997e12000
mmap(0x2b2997e15000, 15744, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b2997e15000
close(3)                                = 0
open("/lib/libncursesw.so.5", O_RDONLY) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0B\1\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=394095, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b2997e19000
mmap(NULL, 2456904, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2b2997e1a000
mprotect(0x2b2997e6e000, 2093056, PROT_NONE) = 0
mmap(0x2b299806d000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x53000) = 0x2b299806d000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b2998072000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b2998073000
arch_prctl(ARCH_SET_FS, 0x2b2998072700) = 0
mprotect(0x2b2997be0000, 16384, PROT_READ) = 0
mprotect(0x2b299788b000, 4096, PROT_READ) = 0
munmap(0x2b299768d000, 258429)          = 0
getpid()                                = 23948
rt_sigaction(SIGCHLD, {0x41384e, ~[RTMIN RT_1], SA_RESTORER, 0x2b29978c04e0}, NULL, 8) = 0
geteuid()                               = 1000
brk(0)                                  = 0x174d000
brk(0x176e000)                          = 0x176e000
getppid()                               = 23947
stat("/home/kris", {st_mode=S_IFDIR|0755, st_size=270336, ...}) = 0
stat(".", {st_mode=S_IFDIR|0755, st_size=270336, ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fff75f09bf0) = -1 ENOTTY (Inappropriate ioctl for device)
rt_sigaction(SIGINT, NULL, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, ~[RTMIN RT_1], SA_RESTORER, 0x2b29978c04e0}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, ~[RTMIN RT_1], SA_RESTORER, 0x2b29978c04e0}, NULL, 8) = 0
rt_sigaction(SIGTERM, NULL, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTERM, {SIG_DFL, ~[RTMIN RT_1], SA_RESTORER, 0x2b29978c04e0}, NULL, 8) = 0
read(0, "#!/bin/dash\n{\n\techo foo\n\tsleep 1"..., 8192) = 118
pipe([3, 4])                            = 0
clone(Process 23949 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b29980729d0) = 23949
[pid 23948] close(4)                    = 0
[pid 23948] clone( <unfinished ...>
[pid 23949] close(3)                    = 0
[pid 23949] dup2(4, 1)                  = 1
Process 23950 attached
[pid 23948] <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b29980729d0) = 23950
[pid 23949] close(4)                    = 0
[pid 23948] close(3 <unfinished ...>
[pid 23949] write(1, "foo\n", 4 <unfinished ...>
[pid 23950] dup2(3, 0 <unfinished ...>
[pid 23948] <... close resumed> )       = 0
[pid 23950] <... dup2 resumed> )        = 0
[pid 23948] close(4294967295 <unfinished ...>
[pid 23950] close(3 <unfinished ...>
[pid 23948] <... close resumed> )       = -1 EBADF (Bad file descriptor)
[pid 23950] <... close resumed> )       = 0
[pid 23948] wait4(-1,  <unfinished ...>
[pid 23949] <... write resumed> )       = 4
[pid 23950] read(0,  <unfinished ...>
[pid 23949] stat("./sleep",  <unfinished ...>
[pid 23950] <... read resumed> "f", 1)  = 1
[pid 23949] <... stat resumed> 0x7fff75f098e0) = -1 ENOENT (No such file or directory)
[pid 23950] read(0,  <unfinished ...>
[pid 23949] stat("/home/kris/bin/sleep",  <unfinished ...>
[pid 23950] <... read resumed> "o", 1)  = 1
[pid 23949] <... stat resumed> 0x7fff75f098e0) = -1 ENOENT (No such file or directory)
[pid 23950] read(0,  <unfinished ...>
[pid 23949] stat("/home/kris/wmiiinst/bin/sleep",  <unfinished ...>
[pid 23950] <... read resumed> "o", 1)  = 1
[pid 23949] <... stat resumed> 0x7fff75f098e0) = -1 ENOENT (No such file or directory)
[pid 23950] read(0,  <unfinished ...>
[pid 23949] stat("/home/kris/.gem/ruby/1.8/bin/sleep",  <unfinished ...>
[pid 23950] <... read resumed> "\n", 1) = 1
[pid 23949] <... stat resumed> 0x7fff75f098e0) = -1 ENOENT (No such file or directory)
[pid 23949] stat("/opt/wine/bin/sleep",  <unfinished ...>
[pid 23950] clone( <unfinished ...>
[pid 23949] <... stat resumed> 0x7fff75f098e0) = -1 ENOENT (No such file or directory)
[pid 23949] stat("/bin/sleep", {st_mode=S_IFREG|0755, st_size=28448, ...}) = 0
Process 23951 attached
[pid 23950] <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b29980729d0) = 23951
[pid 23949] clone( <unfinished ...>
[pid 23951] rt_sigaction(SIGINT, {SIG_IGN, [INT], SA_RESTORER|SA_RESTART, 0x2b29978c04e0}, Process 23952 attached (waiting for parent)
{SIG_DFL, ~[KILL STOP RTMIN RT_1], SA_RESTORER, 0x2b29978c04e0}, 8) = 0
[pid 23950] read(0, Process 23952 resumed (parent 23949 ready)
 <unfinished ...>
[pid 23949] <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b29980729d0) = 23952
[pid 23952] execve("/bin/sleep", ["sleep", "1"], [/* 97 vars */] <unfinished ...>
[pid 23951] rt_sigaction(SIGQUIT, {SIG_IGN, [QUIT], SA_RESTORER|SA_RESTART, 0x2b29978c04e0},  <unfinished ...>
[pid 23949] wait4(-1,  <unfinished ...>
[pid 23951] <... rt_sigaction resumed> {SIG_DFL, ~[KILL STOP RTMIN RT_1], SA_RESTORER, 0x2b29978c04e0}, 8) = 0
[pid 23951] close(0)                    = 0
[pid 23951] open("/dev/null", O_RDONLY) = 0
[pid 23951] clone( <unfinished ...>
[pid 23952] <... execve resumed> )      = 0
Process 23953 attached (waiting for parent)
Process 23953 resumed (parent 23951 ready)
[pid 23951] <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b29980729d0) = 23953
[pid 23953] close(0 <unfinished ...>
[pid 23952] brk(0 <unfinished ...>
[pid 23953] <... close resumed> )       = 0
[pid 23952] <... brk resumed> )         = 0x78f000
[pid 23953] open("/dev/null", O_RDONLY <unfinished ...>
[pid 23951] exit_group(0)               = ?
Process 23951 detached
[pid 23953] <... open resumed> )        = 0
[pid 23952] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
[pid 23950] <... read resumed> 0x7fff75f098b7, 1) = ? ERESTARTSYS (To be restarted)
[pid 23952] <... mmap resumed> )        = 0x2b185172f000
[pid 23950] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid 23952] access("/etc/ld.so.preload", R_OK <unfinished ...>
[pid 23950] rt_sigreturn(0x11 <unfinished ...>
[pid 23952] <... access resumed> )      = -1 ENOENT (No such file or directory)
[pid 23950] <... rt_sigreturn resumed> ) = -1 EINTR (Interrupted system call)
[pid 23953] write(1, "good\n", 5 <unfinished ...>
[pid 23952] open("/etc/ld.so.cache", O_RDONLY <unfinished ...>
[pid 23950] exit_group(0)               = ?
Process 23950 detached
[pid 23953] <... write resumed> )       = 5
[pid 23952] <... open resumed> )        = 3
[pid 23953] exit_group(0)               = ?
Process 23953 detached
[pid 23948] <... wait4 resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 23950
[pid 23948] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid 23952] fstat(3,  <unfinished ...>
[pid 23948] rt_sigreturn(0x11 <unfinished ...>
[pid 23952] <... fstat resumed> {st_mode=S_IFREG|0644, st_size=258429, ...}) = 0
[pid 23948] <... rt_sigreturn resumed> ) = 23950
[pid 23952] mmap(NULL, 258429, PROT_READ, MAP_PRIVATE, 3, 0 <unfinished ...>
[pid 23948] wait4(-1,  <unfinished ...>
[pid 23952] <... mmap resumed> )        = 0x2b1851730000
[pid 23952] close(3)                    = 0
[pid 23952] open("/lib/libc.so.6", O_RDONLY) = 3
[pid 23952] read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000\354\1\0\0\0\0\0"..., 832) = 832
[pid 23952] fstat(3, {st_mode=S_IFREG|0755, st_size=1651953, ...}) = 0
[pid 23952] mmap(NULL, 3521384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2b1851931000
[pid 23952] mprotect(0x2b1851a83000, 2097152, PROT_NONE) = 0
[pid 23952] mmap(0x2b1851c83000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x152000) = 0x2b1851c83000
[pid 23952] mmap(0x2b1851c88000, 19304, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b1851c88000
[pid 23952] close(3)                    = 0
[pid 23952] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b1851c8d000
[pid 23952] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b1851c8e000
[pid 23952] arch_prctl(ARCH_SET_FS, 0x2b1851c8db20) = 0
[pid 23952] mprotect(0x2b1851c83000, 16384, PROT_READ) = 0
[pid 23952] mprotect(0x2b185192e000, 4096, PROT_READ) = 0
[pid 23952] munmap(0x2b1851730000, 258429) = 0
[pid 23952] brk(0)                      = 0x78f000
[pid 23952] brk(0x7b0000)               = 0x7b0000
[pid 23952] open("/usr/lib/locale/locale-archive", O_RDONLY) = 3
[pid 23952] fstat(3, {st_mode=S_IFREG|0644, st_size=3196096, ...}) = 0
[pid 23952] mmap(NULL, 3196096, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b1851c8f000
[pid 23952] close(3)                    = 0
[pid 23952] nanosleep({1, 0}, NULL)     = 0
[pid 23952] close(1)                    = 0
[pid 23952] close(2)                    = 0
[pid 23952] exit_group(0)               = ?
Process 23952 detached
[pid 23949] <... wait4 resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 23952
[pid 23949] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid 23949] rt_sigreturn(0x11)          = 23952
[pid 23949] write(1, "foo\n", 4)        = -1 EPIPE (Broken pipe)
[pid 23949] --- SIGPIPE (Broken pipe) @ 0 (0) ---
Process 23949 detached
<... wait4 resumed> [{WIFSIGNALED(s) && WTERMSIG(s) == SIGPIPE}], 0, NULL) = 23949
--- SIGCHLD (Child exited) @ 0 (0) ---
rt_sigreturn(0x11)                      = 23949
write(1, "done\n", 5)                   = 5
read(0, "", 8192)                       = 0
exit_group(0)                           = ?

--bKyqfOwhbdpXa4YI--
