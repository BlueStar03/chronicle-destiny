---
title: Chronicle Destiny - Alpha
---

# Chronicle Destiny - Alpha

<div class="gm4html5_div_class" id="gm4html5_div_id">
  <canvas id="canvas" width="640" height="360" >
    <p>Your browser doesn't support HTML5 canvas.</p>
  </canvas>
</div>
<script type="text/javascript" src="html5game/chronicle-destiny.js?cachebust=758016685"></script>
<script>window.onload = GameMaker_Init;</script>  

---

<nav class="sidebar">
  <ul>
    {%- assign grouped = site.docs | group_by_exp:"doc", "doc.path | split: '/' | slice: 1, 1" -%}
    {%- for folder in grouped -%}
      <li>
        <strong>{{ folder.name | capitalize }}</strong>
        <ul>
          {%- assign sorted = folder.items | sort: "path" -%}
          {%- for doc in sorted -%}
            <li>
              <a href="{{ doc.url }}">{{ doc.data.title | default: doc.name }}</a>
            </li>
          {%- endfor -%}
        </ul>
      </li>
    {%- endfor -%}
  </ul>
</nav>
