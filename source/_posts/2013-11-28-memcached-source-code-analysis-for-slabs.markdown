---
layout: post
title: "Memcached源码分析之slabs(初始化，分配，释放)"
date: 2013-12-6 15:14
comments: true
categories: Memcached源码分析 Memcached介绍
tags: Memcached
keywords: memcached slab
published: false
---

## slabclass之数据结构

```
typedef struct {
    unsigned int size;      // chunk大小
    unsigned int perslab;   // 每个slab的chunk个数，一个slab默认为1M

    void *slots;            // 空闲chunk列表
    unsigned int sl_curr;   // 当前空闲chunk个数

    unsigned int slabs;     // 总共有多少个slab

    void **slab_list;       // slab列表数组
    unsigned int list_size; // slab列表数组长度

    unsigned int killing;  /* index+1 of dying slab, or zero if none ??? */
    size_t requested;       // 当前使用的内存字节数
} slabclass_t;
```

```
static slabclass_t slabclass[MAX_NUMBER_OF_SLAB_CLASSES]; //slabclass数组
static size_t mem_limit = 0; //最大内存限制，如64m
static size_t mem_malloced = 0; //以分配的内存大小
static int power_largest;  //slabclass数据最大小标

static void *mem_base = NULL; //初始内存地址
static void *mem_current = NULL; //当前内存指针
static size_t mem_avail = 0; //可用的内存大小
```

## API

```
/**
 * @desc
 *  初始化slabclass数组
 * @limit: 内存最大值
 * @factor: chunk大小增长率，默认是1.25
 * @prealloc: 是否预分配
 */
void slabs_init(const size_t limit, const double factor, const bool prealloc);

/**
 *
unsigned int slabs_clsid(const size_t size);
```

<!-- more -->


