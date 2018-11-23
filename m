From: Alexander Dahl <ada@thorsis.com>
Subject: Bug#541544: [PATCH] ash: reset tokpushback before prompting while parsing heredoc
Date: Fri, 23 Nov 2018 15:09:06 +0100
Message-ID: <1789278.1EysXevFyG@ada>
References: <20181111125958.8282-1-develop@kristov.de> <20181120192142.Horde.sRKu4zTrClxweN4nccD6CkI@localhost> <5bf482fd.f2mWn8/w5XhV9NAO%rmy@pobox.com> <20090814183723.7281.91998.reportbug@localhost.localdomain>
Reply-To: Alexander Dahl <ada@thorsis.com>, 541544@bugs.debian.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.541544.B541544.154298254313620@bugs.debian.org>
In-Reply-To: <5bf482fd.f2mWn8/w5XhV9NAO%rmy@pobox.com>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: busybox@busybox.net
Cc: Ron Yorston <rmy@pobox.com>, vda.linux@googlemail.com, develop@kristov.de, 541544@bugs.debian.org, Jack Bates <ms419@freezone.co.uk>, dash@vger.kernel.org
List-Id: dash@vger.kernel.org

Hei hei,

I just stumbled over an old entry in the Debian Bug tracker.

Am Dienstag, 20. November 2018, 21:56:13 CET schrieb Ron Yorston:
> Christoph Schulz wrote:
> >I could not reproduce the problem with dash, neither with git dash nor
> >with older versions (0.5.8, 0.5.9.1, 0.5.10.2, to name a few).
> >Something must be handled differently. But I haven't compared busybox
> >ash and dash sources thoroughly either.
> 
> The same issue is present in dash and has been discussed in a mailing
> list thread starting here:
> 
>    https://www.spinics.net/lists/dash/msg01652.html

By chance, is that old Debian Bug here referencing the same problem?

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=541544

Maybe someone could tell Debian, then?

o.O
Alex
