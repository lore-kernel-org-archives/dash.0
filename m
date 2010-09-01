From: Steve Schnepp <steve.schnepp@gmail.com>
Subject: Bug#595063: read() builtin doesn't read integer value /proc files but bash's does
Date: Wed, 1 Sep 2010 10:06:15 +0200
Message-ID: <AANLkTik=n34_rWB+1S5zKf4fUL3Jq7AxaC9-9_oGwcDr@mail.gmail.com>
Reply-To: Steve Schnepp <steve.schnepp@gmail.com>, 595063@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001485e5c09c515e2c048f2e2ed8
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.595063.B595063.128332842622122@bugs.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: dash@vger.kernel.org
Cc: 595063@bugs.debian.org
List-Id: dash@vger.kernel.org

--001485e5c09c515e2c048f2e2ed8
Content-Type: text/plain; charset=UTF-8

Hi, I opened bug 595063 on the debian BTS [1] and I was suggested to resend
the email upstream.

So I copied the body of the bug below :

dash's read() builtin seems to read the underlying file 1 char at a
time. This doesn't work with some files under /proc, since procfs isn't
fully POSIX compliant.

With bash it works :

$ bash -c 'read MAX < /proc/sys/kernel/pid_max; echo $MAX'
32768

With dash it only reads the first character :

$ dash -c 'read MAX < /proc/sys/kernel/pid_max; echo $MAX'
3

If we use the cat(1) external program it works :

$ dash -c 'MAX=$(cat /proc/sys/kernel/pid_max); echo $MAX'
32768

After a little digging, it only appears on files that contains just an
integer value. When asked to read with a non-null offset (*ppos != 0),
__do_proc_dointvec() just returns 0 (meaning an EOF) as shown on [2].

I'm aware that the issue isn't strictly a dash one, since it has the
right to read one character at a time. But since fixing procfs to be
conforming to POSIX isn't a realistic option, would it be possible to
have a workaround that doesn't involve an external tool like cat(1) ?

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=595063
[2] http://lxr.linux.no/#linux+v2.6.32/kernel/sysctl.c#L2371

-- 
Steve Schnepp
http://blog.pwkf.org/

--001485e5c09c515e2c048f2e2ed8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, I opened bug 595063  on the debian BTS [1] and I was suggested to resen=
d the email upstream.<br><br>So I copied the body of the bug below :<br><br=
>dash&#39;s read() builtin seems to read the underlying file 1 char at a<br=
>


time. This doesn&#39;t work with some files under /proc, since procfs isn&#=
39;t<br>
fully POSIX compliant.<br>
<br>
With bash it works :<br>
<br>
$ bash -c &#39;read MAX &lt; /proc/sys/kernel/pid_max; echo $MAX&#39;<br>
32768<br>
<br>
With dash it only reads the first character :<br>
<br>
$ dash -c &#39;read MAX &lt; /proc/sys/kernel/pid_max; echo $MAX&#39;<br>
3<br>
<br>
If we use the cat(1) external program it works :<br>
<br>
$ dash -c &#39;MAX=3D$(cat /proc/sys/kernel/pid_max); echo $MAX&#39;<br>
32768<br>
<br>
After a little digging, it only appears on files that contains just an<br>
integer value. When asked to read with a non-null offset (*ppos !=3D 0),<br=
>
__do_proc_dointvec() just returns 0 (meaning an EOF) as shown on [2].<br>
<br>
I&#39;m aware that the issue isn&#39;t strictly a dash one, since it has th=
e<br>
right to read one character at a time. But since fixing procfs to be<br>
conforming to POSIX isn&#39;t a realistic option, would it be possible to<b=
r>
have a workaround that doesn&#39;t involve an external tool like cat(1) ?<b=
r><br>[1] <a href=3D"http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D595=
063">http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D595063</a><br>[2] <=
a href=3D"http://lxr.linux.no/#linux+v2.6.32/kernel/sysctl.c#L2371" target=
=3D"_blank">http://lxr.linux.no/#linux+v2.6.32/kernel/sysctl.c#L2371</a><br=
>

<br clear=3D"all">-- <br>Steve Schnepp<br><a href=3D"http://blog.pwkf.org/"=
>http://blog.pwkf.org/</a><br>

--001485e5c09c515e2c048f2e2ed8--
