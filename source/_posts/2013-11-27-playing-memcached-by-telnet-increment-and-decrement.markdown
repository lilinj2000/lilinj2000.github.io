---
layout: post
title: "玩转Memcached by telnet之Increment and Decrement Command"
date: 2013-11-27 13:21
comments: true
categories: Memcached介绍
tags: Memcached
keywords: memcached
published: true
---

## Increment/Decrement

命令"incr" 和 "decr" 是用来增加或者减少相应的数据项， 数据项作为64位无符号的10进制数来对待。

如果当前此数据项，不是一个10进制的数据，则"incr"和"decr"将返回错误。

当然，如果当前的数据项不存在，也将返回错误。

<!-- more -->

格式：

    incr <key> <value> [noreply]\r\n

    or

    decr <key> <value> [noreply]\r\n

- <key\> 数据项的唯一标识符

- <value\> 增量或者减量的值，如在当前值上增加100，或者减少100

- [noreply\] 可选项，指示server不需要返回

返回信息：

- "NOT_FOUND\r\n" 数据项没发现

- "<value\>\r\n"  更新成功后的新的值

"decr" 减少到小于0时，新的值将被设为0

"incr" 增加到超过了64位无符号的最大值，将会溢出

    add key1 0 0 2
    10
    STORED
    incr key1 100
    110
    get key1
    VALUE key1 0 3
    110
    END
    decr key1 50
    60
    get key1
    VALUE key1 0 2
    60
    END
    decr key1 70
    0
    get key1
    VALUE key1 0 1
    0
    END
    add key2 0 0 2
    ab
    STORED
    incr key2 2
    CLIENT_ERROR cannot increment or decrement non-numeric value


[更详细信息请参考这里](https://github.com/lilinj2000/memcached/blob/master/doc/protocol.txt)