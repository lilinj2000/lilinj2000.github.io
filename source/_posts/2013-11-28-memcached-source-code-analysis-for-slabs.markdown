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
/* powers-of-N allocation structures */

typedef struct {
    unsigned int size;      /* sizes of items */
    unsigned int perslab;   /* how many items per slab */

    void *slots;           /* list of item ptrs */
    unsigned int sl_curr;   /* total free items in list */

    unsigned int slabs;     /* how many slabs were allocated for this class */

    void **slab_list;       /* array of slab pointers */
    unsigned int list_size; /* size of prev array */

    unsigned int killing;  /* index+1 of dying slab, or zero if none */
    size_t requested; /* The number of requested bytes */
} slabclass_t;

static slabclass_t slabclass[MAX_NUMBER_OF_SLAB_CLASSES];
static size_t mem_limit = 0;
static size_t mem_malloced = 0;
static int power_largest;

static void *mem_base = NULL;
static void *mem_current = NULL;
static size_t mem_avail = 0;
```

## API & Interface

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


