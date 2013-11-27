---
layout: post
title: "Memcached之内存存储方式介绍"
date: 2013-11-27 21:45
comments: true
categories: Memcached介绍
tags: Memcached Slab
keywords: Memecached Slab
published: true
---

## Memcached中的内存管理

Memcached中保存的数据都存储在memcached内置的内存存储空间中。

数据仅存在于内存中，因此重启memcached、重启操作系统会导致全部数据消失。

内存容量达到指定值之后，会基于LRU(Least Recently Used)算法自动删除不使用的缓存，当然这个可以通过配置项来禁止，默认是删除。

<!-- more -->

Memcached本身是为缓存而设计的服务器，并没有过多考虑数据的永久性问题。但是可以利用memcacheDB实现事务恢复、持久化和分布式复制等功能。

Memcached默认情况下采用了名为Slab Allocator的机制分配、管理内存。

## Slab分配器简介

slab是Linux操作系统的一种内存分配机制。

其主要是针对一些**经常分配并释放的对象**，如进程描述符等，这些对象的大小一般比较小，如果直接采用伙伴系统来进行分配和释放，不仅会造成大量的内碎片，而且处理速度也太慢。

slab分配器是基于**对象进行管理**的，相同类型的对象归为一类(如进程描述符就是一类)，每当要申请这样一个对象，slab分配器就从一个slab列表中分配一个这样大小的单元出去，而当要释放时，将其重新保存在该列表中，而不是直接返回给伙伴系统，从而避免内存碎片。

slab分配器并不丢弃已分配的对象，而是释放并把它们保存在内存中。当以后又要请求新的对象时，就可以从内存直接获取而不用重复初始化。

其基本原理是按照预先规定的大小，将分配的内存分割成特定长度的块（chunk），并把尺寸相同的块分成组（chunk的集合）如图。

![Slab Allocator 示例图](/images/2013/11/slab_allocate_overview.png)

分配给slab的所有内存空间叫做Page，在Memcached中，它默认是1MB。

## 在Memcached中，数据是如何被存入slab，并最终缓存到chunk

Memcached根据数据的大小，选择最适合数据大小的slab。

Memcached中保存着slab内空闲chunk的列表，根据该列表选择chunk，然后将数据缓存于其中。

![Slab Allocate 选择算法](/images/2013/11/slab_allocate_select_method.png)

这种机制也给memcached带来了新的问题：由于分配的是特定长度的内存，因此无法有效利用分配的内存。例如，将100字节的数据缓存到128字节的chunk中，剩余的28字节就浪费了（如下图）。

![Slab Allocate 数据存储方式](/images/2013/11/slab_allocate_storage.png)

针对此问题还没有完美的解决方案，但是memcached文档中给出一种思路：
如果预先知道存储的数据的公用大小，或者仅缓存大小相同的数据的情况下，只要使用适合数据大小的组的列表，就可以减少浪费。

另外，也可以通过使用Growth Facor 进行调优，在某种程度上控制slab之间的差异。

因此，在使用memcached前最好能够重新计算一下数据的预期平均长度，调整growth factor ，以获得最恰当的设置。


参考：

[mecached 基础（一）--memcached介绍](http://blog.csdn.net/ldwtill/article/details/8167813)

[百度百科 - slab](http://baike.baidu.com/view/5870164.htm)