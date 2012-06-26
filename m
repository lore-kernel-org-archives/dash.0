From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] fifo: Do not restart open() if it already found a
 partner
Date: Tue, 26 Jun 2012 16:58:20 -0500
Message-ID: <20120626215820.GA18624@burratino>
References: <1340712298-4583-1-git-send-email-andersk@mit.edu>
 <20120626202009.GA382@burratino>
 <alpine.DEB.2.00.1206261656000.3236@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206261656000.3236@dr-wily.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dash@vger.kernel.org
List-Id: dash@vger.kernel.org

Anders Kaseorg wrote:

> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
> Changes from v1:
> =E2=80=A2 Change wait_for_partner return from true/false to 0/-ERESTA=
RTSYS.
> =E2=80=A2 Mention that the demo program doesn=E2=80=99t always work f=
or some.
> =E2=80=A2 Remove some unneeded braces from the demo program=E2=80=99s=
 CHECK() macro.

Yep, I don't have anything left to complain about.  Looks obviously
correct to my inexpert eyes.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
