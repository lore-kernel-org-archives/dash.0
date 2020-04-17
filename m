From: "lunkov@gmail.com" <lunkov@gmail.com>
Subject: Maybe a mistake
Date: Fri, 17 Apr 2020 19:37:09 +0300
Message-ID: <CAGQt5nnH+ZBXbKreCFyEzqed8Yq_P6YqT0ideKVzd7OU_4bTAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDQQhr (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Apr 2020 12:37:47 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097DC061A0C
        for <dash@vger.kernel.org>; Fri, 17 Apr 2020 09:37:47 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z12so2692525ilb.10
        for <dash@vger.kernel.org>; Fri, 17 Apr 2020 09:37:46 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello! I encountered a script execution error using dash. Other shells
execute this script without error. Perhaps there is an error in dash.
Please execute my script in dash and in bash, for example.
-------------------------------------------------------------------------------------------------
#!/bin/dash

DATA='
1
2
${var}
4
5'

test1()
{
    local PATTERN='${var}'

    echo ${DATA} | while read i; do
        F=`echo "${i}" | grep "${PATTERN}"`
        if [ "$F" ]; then
            echo "FOUND"
            break
        fi
    done
}

test2()
{
    local PATTERN='${var}'

    echo ${DATA} | while read i; do
        local F=`echo "${i}" | grep "${PATTERN}"`        # local
        if [ "$F" ]; then
            echo "FOUND"
            break
        fi
    done
}

test3()
{
    local PATTERN='${var}'

    echo "${DATA}" | while read i; do                # quotes
        local F=`echo "${i}" | grep "${PATTERN}"`        # local
        if [ "$F" ]; then
            echo "FOUND"
            break
        fi
    done
}

echo "test1"
test1

echo "test2"
test2    # Only in dash: ./test.sh: 28: local: 2: bad variable name

echo "test3"
test3
-------------------------------------------------------------------------------------------------

Best regards.
