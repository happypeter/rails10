---
layout: default
title: 静态页面
---

<!-- 一个硬要求，静态页面涉及的代码要在这一页文档上可以贴得下，步骤也不能太多，太多了大家就疲劳了 -->

rails 是用来做 web 应用的，功能多，使用的技术手段也多。在真正着手学习 rails 之前，建议你可以多多动手做一些静态网页，也就是多写写三种代码 html css 和 javascript ，这三种语言会了再来接触 rails 程序，会发现其中一部分知识你已经清楚了，就不会因为一下子暴露在太多知识点之下而感到恐怖了。rails10 这套课程里面不会专门去讲解这三种语言的基本使用。但是这一集，咱们先来写成一个静态网页，把首页搭起来。后续课程里会聊如何用 rails 的各种机制来重新拆分组织这些静态代码。

来到 rails 项目的 public 目录之下，可以看到这里已经放了几个 html 页面了，如果

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
