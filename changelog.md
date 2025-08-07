---
title: Changelog
date: 2025-08-01 12:00:00 -0700
---

# 🗂️ Changelog

<ul>
{% assign posts = site.devlog | sort: 'path' | reverse %}
{% for entry in posts %}
  <li><a href="{{ entry.url | relative_url }}">{{ entry.title }}</a></li>
{% endfor %}
</ul>
