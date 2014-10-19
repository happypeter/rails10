---
layout: default
title: 静态页面
---

这一集的内容不要太多，最重要的是为后面的“使用 rails 巧妙重构静态页面”的部分做素材准备。

- asset pipeline 的各种机制
  - css to sass -> 所以静态页面例子里面要有 brand-color 被复用到好几个地方的情况
  - js -> anystrech 的文件可以放到 vendor 下面，同时 jquery 可以删除，因为 rails 默认支持 jquery
  - 文件要从 public 中移除，放到 views 文件夹里
  - 同时后缀名改为 .html.erb
  - 给出 root: => "pages#welcome" 的 route


参考 railsforzombies view
介绍一下 asset pipeline 的基本功能。

- 图片
  - 有固定的位置放文件
- css
  - 可以用 sass
- js
  - 可以分开 js 文件
  - 最后用 sprocket 合并成一个

静态页面是不能呢用下面的机制的，下一课引入 erb 和 controller 这样可以用

image_tag link_to 和 layout partial 来优化这个页面。

把 rails 当 middleman 用用。
