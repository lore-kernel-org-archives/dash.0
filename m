From: Ron Yorston <rmy@pobox.com>
Subject: Bug#541544: [PATCH] ash: reset tokpushback before prompting while parsing heredoc
Date: Fri, 23 Nov 2018 14:55:17 +0000
Message-ID: <5bf814d5.rBl48YwM+5YpenMJ%rmy@pobox.com>
References: <20181111125958.8282-1-develop@kristov.de> <20181120192142.Horde.sRKu4zTrClxweN4nccD6CkI@localhost> <5bf482fd.f2mWn8/w5XhV9NAO%rmy@pobox.com> <1789278.1EysXevFyG@ada> <20090814183723.7281.91998.reportbug@localhost.localdomain>
Reply-To: Ron Yorston <rmy@pobox.com>, 541544@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.541544.B541544.15429853124643@bugs.debian.org>
In-Reply-To: <1789278.1EysXevFyG@ada>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: busybox@busybox.net, ada@thorsis.com
Cc: vda.linux@googlemail.com, ms419@freezone.co.uk, develop@kristov.de, dash@vger.kernel.org, 541544@bugs.debian.org
List-Id: dash@vger.kernel.org

Alexander Dahl wrote:
>By chance, is that old Debian Bug here referencing the same problem?
>
>https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=541544

It's not the same.  The Debian bug is fixed by dash commit 51e2d88
(parser: Save/restore here-documents in command substitution) from
19 May 2018.

Ron
