---
layout: post
title: "plantuml_plugin_test"
date: 2013-12-05 15:20
comments: true
categories: 
tags: 
keywords: 
published: false
---

{% plantuml %}
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response
Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
{% endplantuml %}

<!-- more -->
