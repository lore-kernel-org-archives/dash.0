From: n8dandy <n8dandy@protonmail.com>
Subject: dash & IFS
Date: Mon, 23 Mar 2020 08:20:23 +0000
Message-ID: <dDYpzKRWD9p1jhFjsIjWZvAddv8e0CQYDq1UxXsV33DN8SvAxPj9gOakBk9LBcTu6j_qEZLUTIoebSKq3-yQ4LKNjGZG-jk-SMMy_RGE-hI=@protonmail.com>
Reply-To: n8dandy <n8dandy@protonmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="b1_0d02899544f73aca8e687e50ae76b655"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-40130.protonmail.ch ([185.70.40.130]:50459 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCWIUe (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 23 Mar 2020 04:20:34 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

This is a multi-part message in MIME format.

--b1_0d02899544f73aca8e687e50ae76b655
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Good morning,

Few days ago, I noticed something strange with dash and IFS. It was
verified with the following versions :

- 0.5.10.2 on Voidlinux
- 0.5.10.2 on Debian Buster
- 0.5.8 on Ubuntu 18.04.2 LTS (Bionic Beaver)

Here the issue :

$ ls
file.sign  file1  file2  other.sign  whileifs*
$ cat whileifs
#!/bin/dash

find . -type f | sort -d | while IFS=3D$'\n' read -r F; do
=09printf "%s\n" "$F"
done
$ ./whileifs
./file1
./file2
./file.sig
./other.sig
./whileifs

file.sig and other.sig are returned instead of file.sign and other.sign.

Here the result with bash :
$ bash whileifs
./file1
./file2
./file.sign
./other.sign
./whileifs

Here the result with mksh :
$ mksh whileifs
./file1
./file2
./file.sign
./other.sign
./whileifs

Here the result with lksh :
$ lksh whileifs
./file1
./file2
./file.sign
./other.sign
./whileifs

Here the result with busybox ash (1.31.0) :
$ /tmp/busybox-x86_64 ash whileifs
./file1
./file2
./file.sign
./other.sign
./whileifs

I attached the test directory. Can you reproduce it ?

Sincerely
Y


--b1_0d02899544f73aca8e687e50ae76b655
Content-Type: application/gzip; name="dashifs.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=dashifs.tar.gz

H4sIAAAAAAAAA+3Uu07DMBQG4KzkKQ6hqFMa27kNiDUSM2uXoDgkEjiVbYSQeHicQCtVDFErnA78
3xDnJh1bv4+tNLapTZcE/jCnzPNx5GXOpmeeZdP4I+BpkRasyLKUB4xzIYqAco9zOngzttZEQfc6
95/UZokJLcvu83/v+hfZtz6WOJc/T8t9/kUqhMtflCULiHmYyy//PP+b6+SpV8m4BcKw7VVDG4rt
x05SS59kBm0pbtzdtD3ooXq8X623ak1a1g3Fmqo7aobwaqd7ZVuKbs1WRRStqihsBiXDSy8PZhz6
f7Cd1BvTP6s/rzH2ePHd73Pnv7u699ydAin6fwmH/FvX337iPyd/JjjyX8JR/sJPjdPzF+Nn5L+A
o/y5nxpn5Y/zHwAAAAAAAAAAAAAAAOBkXxmVJnEAKAAA


--b1_0d02899544f73aca8e687e50ae76b655--
