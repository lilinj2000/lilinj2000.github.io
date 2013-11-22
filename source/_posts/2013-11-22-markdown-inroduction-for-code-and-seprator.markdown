---
layout: post
title: "Markdown语法介绍 - 代码区块和分隔线"
date: 2013-11-22 13:54
comments: true
categories: Markdown介绍
tags: Markdown
published: true
---

## 代码区块

和程序相关的写作或是标签语言原始码通常会有已经排版好的代码区块，通常这些区块我们并不希望它以一般段落文件的方式去排版，而是照原来的样子显示，Markdown 会用 <pre> 和 <code> 标签来把代码区块包起来。

要在 Markdown 中建立代码区块很简单，只要**简单地缩进 4 个空格或是 1 个制表符**就可以，例如，下面的输入：

这是一个普通段落：

    这是一个代码区块。

Markdown 会转换成：

    <p>这是一个普通段落：</p>

    <pre><code>这是一个代码区块。
    </code></pre>

这个每行一阶的缩进（4 个空格或是 1 个制表符），都会被移除，例如：

    Here is an example of AppleScript:

        tell application "Foo"
            beep
        end tell

会被转换为：

    <p>Here is an example of AppleScript:</p>

    <pre><code>tell application "Foo"
        beep
    end tell
    </code></pre>

一个代码区块会一直持续到没有缩进的那一行（或是文件结尾）。

在代码区块里面， *& 、 < 和 > 会自动转成 HTML 实体*，这样的方式让你非常容易使用 Markdown 插入范例用的 HTML 原始码，只需要复制贴上，再加上缩进就可以了，剩下的 Markdown 都会帮你处理，例如：

    <div class="footer">
        &copy; 2004 Foo Corporation
    </div>

会被转换为：

    <pre><code>&lt;div class="footer"&gt;
        &amp;copy; 2004 Foo Corporation
    &lt;/div&gt;
    </code></pre>

代码区块中，一般的 Markdown 语法不会被转换，像是星号便只是星号，这表示你可以很容易地以 Markdown 语法撰写 Markdown 语法相关的文件。

## 分隔线

你可以在**一行中用三个以上的星号、减号、底线**来建立一个分隔线，*行内不能有其他东西*。你*也可以在星号或是减号中间插入空格*。下面每种写法都可以建立分隔线：

    * * *

    ***

    *****

    - - -

    ---------------------------------------

---

参考: 

[markdown语法说明（简体中文版）](http://wowubuntu.com/markdown/)

