---
layout: post
title: "玩转memcached by telnet之存储Command"
date: 2013-11-26 14:14
comments: true
categories: Memcached
tags: Memcached
keywords: memcached
published: true
---

## 环境

+ memcahced 帮助信息

        > memcahched -h
        memcached 1.4.15_6_g87e2f36
        -p <num>      TCP port number to listen on (default: 11211)
        -U <num>      UDP port number to listen on (default: 11211, 0 is off)
        ...

+ start memcached
        
        > memcached 

+ telnet to memcached server by default port 11211
        
        > telnet localhost 11211

<!-- more -->

## 存储Command - Storage commands

### Command格式：

    <command name> <key> <flags> <exptime> <bytes> [noreply]\r\n  
    <data block>\r\n

- <key\> memcached存储数据的唯一标识符。key是一个字符串，目前它的长度被限制在**250**个字符；key**不能包括控制字符或者空白字符**。

- <flags\> 一个16位的无符号整数（十进制格式），server只是存储它，当client获取数据时返回同样的值。client可以用这个字段作为特殊的标记使用。  
    在memcached版本1.2. 1或以后，这个字段是一个32位，但是最好你还是限制使用16位，为了兼容以前的版本。

- <exptime\> 数据过期时间。  
    值为0时，表示永远不过期，当然也可能会被删除，因为LRU算法。  
    非0时，表示一个有效的系统时间，或者是一个当前时间的offset，单位是秒；它确保client不能获取数据当达到这个过期时间（由server段的时间决定）时。
    
- <bytes\> 数据的字节数，不包括分隔符，`\r\n`，字节数也可以为0，表示空数据。

- \[noreply\] 可选项，指示server端可以不返回信息。  
    注意，当命令格式不对时，server不能可靠地解析此选项 _noreply_ ，此时，server会返回错误给客户端，如果客户端没有处理错误信息，可能会有些问题。当用这个选项时，最好确保客户端永远只构造有效的命令请求。

- <data block\> 一块任意8位组的数据，其长度应该是前面给到的 `<byters>`值。

### 返回信息描述：

- "STORED\r\n" 存储数据成功.

- "NOT_STORED\r\n" 此数据没有被存储。

### Command set

设置数据，如果key已经存在，就更新数据，如果key不存在，就增加数据。
    
    set key1 0 0 2
    12
    STORED

### Command add

新增数据，如果key已经存在，会返回失败。

    add key2 0 0 3
    abc
    STORED
    add key1 0 0 3
    abc
    NOT_STORED

### Command replace

更新数据，如果key不存在，则返回失败。

    replace key1 0 0 2
    12
    STORED
    replace key3 0 0 2
    ab
    NOT_STORED

### Command append

在已经存在的数据后面追加数据，如果key不存在，则返回失败。

    append key1 0 0 2
    ab
    STORED
    append key3 0 0 2
    ab
    NOT_STORED

### Command prepend

在已经存在的数据前面追加数据，如果key不存在，则返回失败。

    prepend key1 0 0 2
    cd
    STORED
    prepend key3 0 0 3
    abc
    NOT_STORED

### Command cas

check and set, 只有此数据自上次获取以后没有被更新，才设置数据。

格式：
    
    cas <key> <flags> <exptime> <bytes> <cas unique> [noreply]\r\n
    <data block>\r\n

- <cas unique> 一个64位的唯一的已经存在的entry, 此值是通过`gets`命令获得的.

返回信息：

- "EXISTS\r\n" 指示要存储的数据自从上次获取以来已经被修改了，命令存储失败。

- "NOT_FOUND\r\n" 指示试图存储的数据不存在，命令存储失败.

示例：

    gets key1
    VALUE key1 0 6 6 #最后一项是<cas unique>值
    cd12ab
    END

    cas key1 0 0 2 6
    ab
    STORED

    cas key1 0 0 2 6
    cd
    EXISTS

    gets key1
    VALUE key1 0 2 7 #<cas unique>值已经变成7
    ab
    END

    cas key3 0 0 2 8
    12
    NOT_FOUND

参考：

[memcached potocol text](https://github.com/lilinj2000/memcached/blob/master/doc/protocol.txt)