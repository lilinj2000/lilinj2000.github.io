---
layout: post
title: "Markdown语法介绍 - 标题和列表"
date: 2013-11-21 22:30
comments: true
categories: Markdown介绍
tags: Markdown
keywords: Markdown
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

列表项目标记通常是放在最左边，但是其实也可以缩进，最多 3 个空格，项目标记后面则一定要接着至少一个空格或制表符。

要让列表看起来更漂亮，你可以把内容用固定的缩进整理好：

    *   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
        Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,
        viverra nec, fringilla in, laoreet vitae, risus.
    *   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.
        Suspendisse id sem consectetuer libero luctus adipiscing.

列表项目可以包含多个段落，每个项目下的段落都必须缩进 4 个空格或是 1 个制表符：

    1.  This is a list item with two paragraphs. Lorem ipsum dolor
        sit amet, consectetuer adipiscing elit. Aliquam hendrerit
        mi posuere lectus.

        Vestibulum enim wisi, viverra nec, fringilla in, laoreet
        vitae, risus. Donec sit amet nisl. Aliquam semper ipsum
        sit amet velit.

    2.  Suspendisse id sem consectetuer libero luctus adipiscing.

如果要在列表项目内放进引用，那 > 就需要缩进：

    *   A list item with a blockquote:

        > This is a blockquote
        > inside a list item.

如果要放代码区块的话，该区块就需要缩进两次，也就是 8 个空格或是 2 个制表符：

    *   一列表项包含一个列表区块：

            <代码写在这>

当然，项目列表很可能会不小心产生，像是下面这样的写法：

    1986. What a great season.

换句话说，也就是在行首出现数字-句点-空白，要避免这样的状况，你可以在句点前面加上反斜杠。

    1986\. What a great season.

如果要用嵌套列表，那么下一级列表就要缩进，也就是4个空格或者1个制表符。

    + list1
        - list2
            *   list3

参考: 

[markdown语法说明（简体中文版）](http://wowubuntu.com/markdown/)
