From: Mark Galeck <mark_galeck@pacbell.net>
Subject: why does dash save, dup, and restore redirected descriptor in the
 parent, rather than redirect in the child?
Date: Tue, 31 Jan 2017 20:00:34 +0000 (UTC)
Message-ID: <2132582962.805179.1485892834849@mail.yahoo.com>
References: <2132582962.805179.1485892834849.ref@mail.yahoo.com>
Reply-To: Mark Galeck <mark_galeck@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nm24-vm5.bullet.mail.ne1.yahoo.com ([98.138.91.246]:43654 "EHLO
        nm24-vm5.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751865AbdAaUAj (ORCPT
        <rfc822;dash@vger.kernel.org>); Tue, 31 Jan 2017 15:00:39 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

Hello,

a dash script like: 

date > foobar.txt 
date 

is (as an SSCCE) handled like this: 


int fd; 
int saved; 

fd = open64("foobar.txt", O_WRONLY|O_CREAT); 
saved = fcntl(1, F_DUPFD, 10); 
dup2(fd, 1); 
if (!fork()) { 
    execl("/bin/date", "date", (char *)NULL); 
} 

dup2(saved, 1); 
if (!fork()) { 
    execl("/bin/date", "date", (char *)NULL); 
} 



This is strange. Why save, dup and dup again to restore, descriptors in the parent, when it would be much simpler to just dup in the child, and not have to save and restore. This is simpler and I checked it works the same: 


int fd; 

if (!fork()) { 
    fd = open64("foobar.txt", O_WRONLY|O_CREAT); 
    dup2(fd, 1); 
    execl("/bin/date", "date", (char *)NULL); 
} 

if (!fork()) { 
    execl("/bin/date", "date", (char *)NULL); 
} 



I am sure there must be a good reason and I am not understanding something deeper. What is it?


Thank you,

Mark
