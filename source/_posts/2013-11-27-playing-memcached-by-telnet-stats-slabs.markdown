---
layout: post
title: "玩转Memcached by telnet之Stats Slabs"
date: 2013-11-27 22:28
comments: true
categories: Memcached介绍
tags: Memcached Slab
keywords: memcached slab
published: true
---

## Slab statistics

格式：
    
    stats slabs

返回信息：

    STAT <slabclass>:<stat> <value>\r\n
    STAT <stat> <value>\r\n
    END\r\n

<!-- more -->

具体各项解释：

    chunk_size: 块大小
    chunks_per_page: 一页有多少块，默认一页是1M    
    total_pages: 一个slab class共有多少页  
    total_chunks: 一个slab class共有多少块                      
    get_hits: 获取命中次数在这个slab class上                 
    cmd_set: 设置次数在这个slab class上                     
    delete_hits: 删除命中次数在这个slab class 上   
    incr_hits: 增量修改次数在这个slab class 上             
    decr_hits: 减量修改次数在这个slab class上              
    cas_hits: cas修改成功次数在这个slab class上           
    cas_badval: cas修改失败次数在这个slab class上         
    touch_hits: touch修改成功次数在这个slab class上       
    used_chunks: 被使用了的块数                          
    free_chunks: 没有被使用的块数                        
    free_chunks_end: 除了本页以外的空闲chunk个数，当前只有一页，所以，看到的值位0                
    mem_requested: 请求存储在这个slab class中的实际字节数         
    active_slabs: 当前已经分配了slab class数                 
    total_malloced: 总共被使用了的内存字节数                  

浪费的空间计算为：

    (total_chunks * chunk_size) - mem_requested

如果看到浪费的的很厉害，要考虑调整slab factor.

## 具体示例

最大内存是1m, 最小空间分配单元是32Bytes, 页大小是1k，默认fractor是1.25

    > ./memcached -vvv -I 1k -m 1m -n 32
    slab class   1: chunk size        80 perslab      12
    slab class   2: chunk size       104 perslab       9
    slab class   3: chunk size       136 perslab       7
    slab class   4: chunk size       176 perslab       5
    slab class   5: chunk size       224 perslab       4
    slab class   6: chunk size       280 perslab       3
    slab class   7: chunk size       352 perslab       2
    slab class   8: chunk size       440 perslab       2
    slab class   9: chunk size       552 perslab       1
    slab class  10: chunk size       696 perslab       1
    slab class  11: chunk size      1024 perslab       1

Memcached初始化了11个slab classes.

增加一个字节数为2的key1：

    add key1 0 0 2
    ab
    STORED

内存使用情况：

    stats slabs
    STAT 1:chunk_size 80
    STAT 1:chunks_per_page 12
    STAT 1:total_pages 1
    STAT 1:total_chunks 12
    STAT 1:used_chunks 1
    STAT 1:free_chunks 11
    STAT 1:free_chunks_end 0
    STAT 1:mem_requested 71 #实际存储占用了71字节, 浪费了9个字节
    STAT 1:get_hits 0
    STAT 1:cmd_set 1
    STAT 1:delete_hits 0
    STAT 1:incr_hits 0
    STAT 1:decr_hits 0
    STAT 1:cas_hits 0
    STAT 1:cas_badval 0
    STAT 1:touch_hits 0
    STAT active_slabs 1
    STAT total_malloced 960 #总共分配了960字节为这个slab class
    END

增加一个字节数位15的key2：

    add key2 0 0 15
    123456789012345
    STORED

内存使用情况：

    stats slabs
    STAT 1:chunk_size 80
    STAT 1:chunks_per_page 12
    STAT 1:total_pages 1
    STAT 1:total_chunks 12
    STAT 1:used_chunks 1
    STAT 1:free_chunks 11
    STAT 1:free_chunks_end 0
    STAT 1:mem_requested 71
    STAT 1:get_hits 0
    STAT 1:cmd_set 1
    STAT 1:delete_hits 0
    STAT 1:incr_hits 0
    STAT 1:decr_hits 0
    STAT 1:cas_hits 0
    STAT 1:cas_badval 0
    STAT 1:touch_hits 0
    STAT 2:chunk_size 104
    STAT 2:chunks_per_page 9
    STAT 2:total_pages 1
    STAT 2:total_chunks 9
    STAT 2:used_chunks 1
    STAT 2:free_chunks 8
    STAT 2:free_chunks_end 0
    STAT 2:mem_requested 85 #实际存储时85字节，浪费了104 - 85 = 19 字节
    STAT 2:get_hits 0
    STAT 2:cmd_set 1
    STAT 2:delete_hits 0
    STAT 2:incr_hits 0
    STAT 2:decr_hits 0
    STAT 2:cas_hits 0
    STAT 2:cas_badval 0
    STAT 2:touch_hits 0
    STAT active_slabs 2 #当前共有2个slab class
    STAT total_malloced 1896 #当前已经分配内存1896字节
    END


[更详细信息请参考这里](https://github.com/lilinj2000/memcached/blob/master/doc/protocol.txt)