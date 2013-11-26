---
layout: post
title: "玩转memcached by telnet之获取Command"
date: 2013-11-26 16:06
comments: true
categories: Memcached
tags: Memcached
keywords: memcached
published: true
---

## 获取Command - Retrieval commands

### Command格式：

    get <key>*\r\n
    gets <key>*\r\n

- <key\>\* 一个或者多个key，由空白符分隔。

在零个或者多个key/value被返回后，server端会返回字符串"END\r\n"指示返回结束。

<!-- more -->

### 返回信息：

    VALUE <key> <flags> <bytes> [<cas unique>]\r\n
    <data block>\r\n

- <key\> 发送的key值

- <flags\> 在数据被存储时，设置的flags信息

- <bytes\> 存储的数据长度，不包括分隔符 `\r\n`

- \[\<cas unique\>\] 唯一标识的64位整数，在Command `cas` 中被使用

- \<data block\> 数据块

数据不能被获取的情况有：

- 数据从来没有被存储

- 数据被存储，但是获取时已经过期
 
- 数据被存储，数据已经显示被删除了
 
- 数据被存储，由于内存原因，基于LRU算法，数据已经被系统删除

### Command get

获取一个或者多个key的值，**不返回**`<cas unique>`

    get key1
    VALUE key1 0 2
    ab
    END
    get key1 key2
    VALUE key1 0 2
    ab
    VALUE key2 0 3
    abc
    END
    get key1 key3  #without stored key3
    VALUE key1 0 2
    ab
    END

### Command gets

获取一个或者多个key的值，**返回**`<cas unique>`

    gets key1
    VALUE key1 0 2 7
    ab
    END
    gets key1 key2
    VALUE key1 0 2 7
    ab
    VALUE key2 0 3 3
    abc
    END
    gets key1 key3
    VALUE key1 0 2 7
    ab
    END


[更详细信息请参考这里](https://github.com/lilinj2000/memcached/blob/master/doc/protocol.txt)