Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379C1FBCA7
	for <dash@vger.kernel.org>; Wed, 10 Dec 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381352; cv=none; b=jxCDB9jkkXluF+lEWwE5xDUuoMAo7P9wQH2k1q/4EGjA7QLcdDdYZxJg3d53RgJUAx9Y9kZuUjm/WnYxHTf817xY4qGawvmKi6vMlxpfMVYvRJU1KQlXTjJKb6ZwHZGd1lACSw70IHVykFgMw2Rjq3wtq//wGE/PCpCp1F8kGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381352; c=relaxed/simple;
	bh=9yTgUSUKJf7h5l/c3niETw8v0u9xzVCAq6u0LvDC5rw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TBlc1XdVtOC32R8bb2Xk+Vuv6T/HsXf3g4q0o7poP1QfOqsXRKskDiNTiP0OwaEdXrgkJFVXfupp/nS3yV1J4chGZoBLwq6h4eB7jTf+t1RdK0N5EtftuCy3Goqb1VuMq6Wslkob/elIZdOgbkjNt/u3ThNXpqaCjgz8i+uiPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRHvMydu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRHvMydu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2e40582eso4137387f8f.1
        for <dash@vger.kernel.org>; Wed, 10 Dec 2025 07:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765381348; x=1765986148; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9yTgUSUKJf7h5l/c3niETw8v0u9xzVCAq6u0LvDC5rw=;
        b=NRHvMyduwKZ2CC+UuZn8bNf7IQV/UXvylCsebQJ9TdPmyffwnZ9HFYAIk/RQhQTdJm
         3k5PjSl1sYDeM3mhEXE9Xay5baD3JelZRVD4t5Ukr6+/QqNkm7DAmGnk6vU5lj2toIuR
         NbR95Ovu6Jj8LxnP5/THZsJOU+epgMEIuE6DQd/4pi7ROkHME5SQr4FYnXMgSgq/vR+b
         32P+2nsezP3MzVdnzq0O+9wZOoW+TPD5ct09/mjpT1UYZj4UqImo6BnJa02jWt2YQ4yR
         Al5APgxDKrCVXVhdHZzp9AI90zldzOqr44uiF7XHxpCUWSNALOwMctV2ZU81zOlc1J6O
         x8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765381348; x=1765986148;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yTgUSUKJf7h5l/c3niETw8v0u9xzVCAq6u0LvDC5rw=;
        b=oZVTezK9LCojspcxHwrWE0R4ox8IUvcrz/ShfTmYyfxJLmlnFEotSmdSphQbKLKDBV
         YbvPsImoNihjD5mq3xtNrRKb81ECXGulOfNxJYmSfgU/VC0n3ej+gYTsJPBgVDiFc5Tv
         AW55yMAv6ZJZUr2mj9GuCzJ0ghe7eOw7DSS8c8PkRShSBThnolyaNNKZUoNlr8jEhj7g
         9FQPr8EH3Yw3CsAGr852Rqt58mewfp0OFnwWIYIxgKJzHJnHw/2y1P1x7O2KQNVFBZU0
         ZHX1fe9O4QLRu8P5FtHPob5HSBD75lOxtZuY7vMx5YmuZrd1VqNrF8T9hx5TO0wSDzQJ
         0ECA==
X-Gm-Message-State: AOJu0YxjTsZabpJRV1E/vIRr990ZmwCclvxXIrDQgcpbKTVcKBB3LaJa
	sKVVhtcE3QHIfJGRwVmvbTwrtoPA2/RzPgvkU3/ker9xuGyTGsvyKAxWr+0V0A==
X-Gm-Gg: AY/fxX4j93B4CX749zveEaWUlWsdxAT8zEZxOuW/rOXBSZ1yZd0XJm97iO/1bM0bcG4
	ttugcW2U/pKHlXpokyXh7H0yqdgyR4M/BEYwK2b3DV+Nalcy4a05ylZ5qEZwkkXsk88mX5B8oO6
	X1ilPyVLNTwNpDY2+vbJmVrdb6PXQyqsMgQ8VfYiSezlefWLfRAXtie9n8S/leVEBxkwBj5HJJA
	NbHscv1edw0iyRtm46MYJt/TsbASSGMkNE/U7C1VPpr+aw9DeDSZj6pU1REqqknlA21ujqPNK1z
	b4r1oT/UQd72H5cRm48girkjD0yQTF2TmVThGyUuX0K8mCmYEWX8GbWkeQMNnInHYh8kNxyeOA5
	HLflnBOTjMphns/0am0k4jsavyyWho/wuNZvqeetF4xZTgfHXdA6YbiD5fz1ecwwVe4N+iv68gp
	n6KFP2sgaQaKaY+UHXelIRcyfxlsdamGGx+He/1aU6AffhV3bTgoCjlP89Y5ESXxWqzvhyzaEJ/
	cP+MA==
X-Google-Smtp-Source: AGHT+IGc+zbq0up9m8u+GYHmYSRMNRiSCiKYQn/7KX/p2lMY2yFnc6v34y8WR1ms1OMj2WeNo7HZew==
X-Received: by 2002:a05:6000:612:b0:425:73c9:7159 with SMTP id ffacd0b85a97d-42fa3afe908mr2944771f8f.33.1765381348186;
        Wed, 10 Dec 2025 07:42:28 -0800 (PST)
Received: from [192.168.1.31] (86-44-211-146-dynamic.agg2.lod.rsl-rtd.eircom.net. [86.44.211.146])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeadesm38098721f8f.10.2025.12.10.07.42.27
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 07:42:27 -0800 (PST)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <6a95263b-9531-4ce4-b60a-e15dfb63e5ea@draigBrady.com>
Date: Wed, 10 Dec 2025 15:42:26 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: dash@vger.kernel.org
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
Subject: POSIX read -d option is not implemented
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It's especially useful to process NUL delimited input like:
find -print0 | while IFS= read -r -d'' file; do process "$file"; done

See https://pubs.opengroup.org/onlinepubs/9799919799/utilities/read.html

thanks,
Padraig
