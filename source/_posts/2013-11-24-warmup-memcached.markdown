---
layout: post
title: "初识 Memcached"
date: 2013-11-24 16:13
comments: true
categories: Memcached介绍
tags: Memcached
keywords: memcached
published: true
---

## 什么是 Memcached？
>Free & open source, high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load.

>Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.

>Memcached is simple yet powerful. Its simple design promotes quick deployment, ease of development, and solves many problems facing large data caches. Its API is available for most popular languages.

>At heart it is a simple Key/Value store.

Memcached是一个**免费，开源，高性能，分布式**的内存对象cache系统。  

Memcached是一个**简单，强大**的key/value存储。

<!-- more -->

## Memcached的历史

official web site: <http://www.memcached.org/>

project home: <https://code.google.com/p/memcached/>

Memcached 是由 Brad Fitzpatrick 于2003年5月，为他的网站 LiveJournal 第一次开发的，后来由 Anatoly Vorobey 用 C 语言从写。

## Memcached 适合什么场合

![memcached general use case](/images/2013/11/memcached_general_use_case.png)

Memcached 是“分布式”的内存对象缓存系统，那些不需要“分布”的，不需要共享的，或者干脆规模小到只有一台服务器的应用， memcached 不会带来任何好处，相反还会拖慢系统效率，因为网络连接同样需要资源，即使是UNIX本地连接也一样。

Memcached 在很多时候都是**作为数据库前端 cache 使用的**。因为它比数据库少了很多 SQL 解析、磁盘操作等开销，而且它是使用内存来管理数据的，所以它可以提供比直接读取数据库更好的性能，在大型系统中，访问同样的数据是很频繁的， memcached 可以大大降低数据库压力，使系统执行效率提升。

Memcached 也经常作为**服务器之间数据共享的存储媒介**，例如在 SSO 系统中保存系统单点登陆状态的数据就可以保存在 memcached 中，被多个应用共享。

Memcached 使用内存管理数据，所以它是**易失**的，当服务器重启，或者 memcached 进程中止，数据便会丢失，所以 memcached 不能用来持久保存数据。很多人的错误理解，memcached 的性能非常好，好到了内存和硬盘的对比程度，其实 memcached 使用内存并不会得到成百上千的读写速度提高，它的实际瓶颈在于网络连接，它和使用磁盘的数据库系统相比，好处在于它本身非常“轻”，因为没有过多的开销和直接的读写方式，它可以轻松应付非常大的数据交换量，所以经常会出现两条千兆网络带宽都满负荷了，memcached 进程本身并不占用多少CPU资源的情况。

Memcached 最大的优点是**可以分布式的部署**，这对于大规模应用来说也是必不可少的要求。

## Memcached 的主要用户有

![memcached typical users](/images/2013/11/memcached_typical_users.png)

参考：

[Memcached-----memcached实现内存缓存](http://haoshenqi.blogchina.com/1538799.html)

[mecached 基础（一）--memcached介绍](http://blog.csdn.net/ldwtill/article/details/8167813)

[Memcached浅析](http://wenku.baidu.com/link?url=TuT7znQSC6wyQ-sVmuq7iWGXYSm9h7cOJ_XXqV9L164GhqC83Vf60OH1Bf_mwmekeuZrE0cP2sgnWXrJjc3kmz4OmlEQWHtnfZJaXtRH8LK)

