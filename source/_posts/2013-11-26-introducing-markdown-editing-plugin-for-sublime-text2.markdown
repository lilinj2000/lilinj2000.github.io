---
layout: post
title: "Markdown editing介绍 - sublime text 2插件"
date: 2013-11-26 10:50
comments: true
categories: Markdown介绍
tags: Markdown
published: true
---

## 简介
MarkdownEditing是ttscoff编写的一个Sublime Text 2插件，用于在ST2中进行Markdown文件的编写。插件中添加一系列的快捷键和自动处理，方便大家在ST2中进行MD的编写。

[Markdown Editing for Sublime Text 2: humble beginnings](http://brettterpstra.com/2012/05/17/markdown-editing-for-sublime-text-2-humble-beginnings/)

Source code: <https://github.com/ttscoff/MarkdownEditing>

<!-- more -->

## MarkdownEditing的功能

### 语法增强类

+ 星号\*、下划线\_和反引号\`自动配对

+ 如输入的自动配对符号中间内容为空时，删除第一个符号时将直接删除整对符号

+ 如输入自动配对符号后直接输入空格，则自动删除后面自动配对的符号

+ 波浪线 ~ 包围的内容将转换为HTML中的 标签

+ 当创建了列表后，回车将自动添加一个列表项。如列表项为空，再次回车将删除该列表项.

### MarkdownEditing在Windows下面的快捷键

+ Ctrl+Win+V _选中的内容_将自动转换为**行内式超链接**，链接到剪贴板中的内容

+ Ctrl+Win+R _选中的内容将_自动转换为**参考式超链接**，链接到剪贴板中的内容

+ Ctrl+Win+K 插入一个**标准的行内式超链接**

+ Shift+Win+K 插入一个**标准的行内式图片**（此快捷键可能与输入法有冲突）

+ Ctrl+1 至 Ctrl+6 插入一级至六级标题

+ Ctrl+I 选中的内容转换为_斜体_

+ Ctrl+B 选中的内容转换为**粗体**

+ Ctrl+Shift+6 自动插入一个脚注，并跳转到该脚注的定义中。

+ Alt+Shift+F 查找没有定义的脚注并自动添加其定义链接

+ Alt+Shift+G 查找没有定义的参考式超链接并自动添加其定义链接

+ Ctrl+Alt+S 脚注排序

+ Ctrl+Shift+. 缩进当前内容

+ Ctrl+Shift+, 提前当前内容

参考：

[在Windows下面使用MarkdownEditing](http://blog.edi-c.com/post/mod-mdediting-for-win)


