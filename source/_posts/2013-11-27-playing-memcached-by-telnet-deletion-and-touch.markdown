---
layout: post
title: "玩转Memcached by telnet之Deletion and Touch Command"
date: 2013-11-27 10:52
comments: true
categories: Memcached介绍
tags: Memcached
keywords: memcached
published: true
---

## Deletion

从memcached中删除数据项.

格式：

    delete <key> [noreply]\r\n

- <key\> 被删除的数据项的唯一标识符

- [noreply\] 可选项，指示server不需要返回

返回信息：

- "DELETED\r\n" 删除成功

- "NOT_FOUND\r\n" 唯一标识符key没有找到

<!-- more -->

    get key2
    VALUE key2 0 3
    abc
    END
    delete key2
    DELETED
    delete key1
    NOT_FOUND

## Touch

更新已经存在数据项的过期时间\(expiration time\)

格式：

    touch <key> <exptime> [noreply]\r\n

- <key\> 被更新数据项的唯一标识符

- <exptime\> 过期时间
    
    + 数据项已经过期了， 不能被设置过期时间
        
            add key1 0 5 2
            ab
            STORED
            
            #after 5 seconds, the key1 is deleted by system
            get key1
            END
            touch key1 10
            NOT_FOUND

    + 数据项未过期，但是已经过了一段时间，新的过期时间，是从当前时间开始计算，或者是一个新的绝对时间。

            > cat touch_test.sh
            #! /usr/bin/sh
            {
            echo "add key1 0 30 2"
            sleep 1
            echo "ab"
            sleep 20
            echo "touch key1 60"
            sleep 40
            echo "get key1"
            sleep 20
            echo "get key1"
            } | telnet localhost 11211
            
            > ./touch_test.sh
            Trying 127.0.0.1...
            Connected to localhost.
            Escape character is '^]'.
            STORED          #add key1 successful
            TOUCHED         #after 20s, the touch key1 is successful
            VALUE key1 0 2  #after 40s again, the key1 is fetched.
            ab
            END             
            END             #after 20s again, the key1 is deleted
            Connection closed by foreign host.
         
    + 此过期时间与storage commands(set, add, replace, append, prepend, cas)选项中的过期时间，是同一个意思。

- [noreply\] 可选项，指示server不需要返回

返回信息：

- "TOUCHED\r\n" 更新成功

- "NOT_FOUND\r\n" 唯一标识符key没有找到


[更详细信息请参考这里](https://github.com/lilinj2000/memcached/blob/master/doc/protocol.txt)
