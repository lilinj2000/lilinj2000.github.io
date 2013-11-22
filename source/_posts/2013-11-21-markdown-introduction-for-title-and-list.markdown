---
layout: post
title: "Markdown语法介绍-标题和列表"
date: 2013-11-21 22:30
comments: true
categories: Markdown介绍
tags: Markdown
published: true
---
## 标题

Markdown 支持两种标题的语法，类 Setext 和类 atx 形式。

类 Setext 形式是用底线的形式，利用 = （最高阶标题）和 - （第二阶标题），例如：

    This is an H1
    =============

    This is an H2
    -------------
任何数量的 = 和 - 都可以有效果。

类 Atx 形式则是在行首插入 1 到 6 个 # ，对应到标题 1 到 6 阶，例如：

    # 这是 H1

    ## 这是 H2

    ###### 这是 H6 

<!-- more -->

## 列表

Markdown 支持有序列表和无序列表。

无序列表使用星号、加号或是减号作为列表标记：

    *   Red
    *   Green
    *   Blue
等同于：

    +   Red
    +   Green
    +   Blue
也等同于：

    -   Red
    -   Green
    -   Blue
有序列表则使用数字接着一个英文句点：

    1.  Bird
    2.  McHale
    3.  Parish
很重要的一点是，你在列表标记上使用的数字并不会影响输出的 HTML 结果。

如果你的列表标记写成：

    1.  Bird
    1.  McHale
    1.  Parish
或甚至是：

    3. Bird
    1. McHale
    8. Parish

你都会得到完全相同的 HTML 输出。重点在于，你可以让 Markdown 文件的列表数字和输出的结果相同，或是你懒一点，你可以完全不用在意数字的正确性。

参考: 

[markdown语法说明（简体中文版）](http://wowubuntu.com/markdown/)

[献给写作者的 Markdown 新手指南](http://jianshu.io/p/q81RER)

[markdown-维基百科](http://zh.wikipedia.org/wiki/Markdown)

