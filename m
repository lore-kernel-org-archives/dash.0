From: Nikola Vladov <v20-malloctest@riemann.fmi.uni-sofia.bg>
Subject: malloctests.c
Date: Sun, 28 Jun 2009 09:11:08 +0300
Message-ID: <20090628061108.2930.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from riemann.fmi.uni-sofia.bg ([62.44.100.74]:1085 "HELO
	riemann.fmi.uni-sofia.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751430AbZF1GRv (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Jun 2009 02:17:51 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Bellow is a simple program wich test how malloc
allocates memory.  On my systems glibc malloc starts with 128K RAM

[diet -Os ] gcc -Os -Wall -W malloctest.c
usage:
	./a.out 1
	./a.out 4046
	./a.out 140000

	strace ./a.out 22000  2>&1 | sed -e 1,/ZYX4132/d
	strace ./a.out 200000 2>&1 | sed -e 1,/ZYX4132/d

In my next post I'll describe why I wrote this program!
It is designed to be as simple as possible...

Nikola

/* -- malloctest.c -- */
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  unsigned long u;
  unsigned char c, *x, *a, *b, buf[3*sizeof(unsigned long)];

  if (argc<2) { u=1; goto ready; }
  x = (unsigned char *)argv[1];
  for (u=0; (c=(*x - '0')) < 10; x++) u = u*10 + c;

 ready:
  write(2, "ZYX4132\n", 8);

  a = sbrk(0);
  x = malloc(u);
  if (x) free(x);
  b = sbrk(0);

  u = b-a;
  *--x = '\n';
  do { *--x = '0'+u%10; u/=10; } while(u);
  write(2, x, (buf + sizeof(buf)) -x);

  return 0;
}
