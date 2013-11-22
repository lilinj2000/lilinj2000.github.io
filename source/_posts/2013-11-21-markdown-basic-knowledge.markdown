---
layout: post
title: "Markdown简介"
date: 2013-11-21 22:15
comments: true
categories: Markdown介绍
tags: Markdown
keywords: Markdown
published: true
---

## 简介

Markdown是一种轻量级标记语言，创始人为约翰·格鲁伯（John Gruber）和亚伦·斯沃茨（Aaron Swartz）。它允许人们“使用易读易写的纯文本格式编写文档，然后转换成有效的XHTML(或者HTML)文档”。

Markdown同时还是一个由Gruber编写的Perl脚本：Markdown.pl。它把用markdown语法编写的内容转换成有效的、结构良好的XHTML或HTML内容，并将左尖括号('<')和&号替换成它们各自的字符实体引用。它可以用作单独的脚本，Blosxom和Movable Type的插件又或者BBEdit的文本过滤器.

<!-- more -->

Markdown也已经被其他人用Perl和别的编程语言重新实现，其中一个Perl模块放在了CPAN(Text::Markdown)上。它基于一个BSD风格的许可证分发并可以作为几个内容管理系统的插件。

这是一种[电子邮件风格]的标记语言，其主要目标就是实现[易读易写]。

Markdown的优点有：

* 纯文本，所以兼容性极强，可以用所有文本编辑器打开。
* 让你专注于文字而不是排版。
* 格式转换方便，Markdown 的文本你可以轻松转换为 html、电子书等。
* Markdown 的标记语法有极好的可读性。 


## 兼容 HTML

Markdown 语法的目标是：**成为一种适用于网络的书写语言**。

Markdown 不是想要取代 HTML，甚至也没有要和它相近，它的语法种类很少，只对应 HTML 标记的一小部分。Markdown 的构想不是要使得 HTML 文档更容易书写。

Markdown 的理念是，能让文档更容易读、写和随意改。HTML 是一种发布的格式，Markdown 是一种书写的格式。就这样，**Markdown 的格式语法只涵盖纯文本可以涵盖的范围**。

不在 Markdown 涵盖范围之内的标签，都可以直接在文档里面用 HTML 撰写。不需要额外标注这是 HTML 或是 Markdown；只要直接加标签就可以了。

要制约的只有一些 HTML 区块元素――比如 `<div>、<table>、<pre>、<p>` 等标签，必须在前后加上空行与其它内容区隔开，还要求它们的*开始标签与结尾标签不能用制表符或空格来缩进*。Markdown 的生成器有足够智能，不会在 HTML 区块标签外加上不必要的 `<p>` 标签。

例子如下，在 Markdown 文件里加上一段 HTML 表格：

    这是一个普通段落。

    <table>
        <tr>
            <td>Foo</td>
        </tr>
    </table>

    这是另一个普通段落。

请注意，在 HTML 区块标签间的 Markdown 格式语法将不会被处理。比如，你在 HTML 区块内使用 Markdown 样式的*强调*会没有效果。

HTML 的区段（行内）标签如 `<span>、<cite>、<del>` 可以在 Markdown 的段落、列表或是标题里随意使用。依照个人习惯，甚至可以不用 Markdown 格式，而直接采用 HTML 标签来格式化。举例说明：如果比较喜欢 HTML 的 `<a>` 或 `<img>` 标签，可以直接使用这些标签，而不用 Markdown 提供的链接或是图像标签语法。

和处在 HTML 区块标签间不同，**Markdown 语法在 HTML 区段标签间是有效的**。

参考: 

[markdown语法说明（简体中文版）](http://wowubuntu.com/markdown/)

[献给写作者的 Markdown 新手指南](http://jianshu.io/p/q81RER)

[markdown-维基百科](http://zh.wikipedia.org/wiki/Markdown)

