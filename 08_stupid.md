---
layout: default
title: 笨办法发消息
---

进入网站实际功能部分，思路一样，先用笨办法来做事情，再引入 rails 的巧妙机制。

###  大声吆喝

<!-- 做一个发布活动信息的站点。先考虑简单情况，发消息的人，就我自己。我可以去后台敲 console 命令去创建 issue 。但是也还是要
     创建数据库之前，先写死一个 issue 的 html，让后看到这样发布信息也不是办法。
 -->

我先粘贴几行 html 和 css 过来，让页面上显示，大字 “It's Party Time” 小字 "到时聚聚，聊聊程序"。右侧一个 “发布新活动” 按钮。这样就可以看出我下面要做一个什么功能了。

在 welcome.html.erb 中， `class="home-banner"` 的 div 之内粘贴

{% highlight html %}
<div class="banner-inner container clearfix">
  <h1>It's Party Time!</h1>
  <p class="subheading">到时聚聚，聊聊程序</p>
  <div class="home-banner-links">
    <%= link_to “发布新活动” “#”, class: "banner-btn btn" %>
  </div>
</div>
{% endhighlight %}

对应的 css

#### 写 html 来发布活动很麻烦
现在假设我是站长，也只有我自己来发布新活动，那我可以把新活动的信息直接写成 html。每次活动写成一个 partial 。




- 建立 issue 表
  - 首先要确保 config/database.yml 中指定了正确的数据库，必要的话要填写密码。
  - 虽然安装的是 mysql 数据库，但是要操作他不需要自己敲 sql 了，rails 有着自己的更为人性化的语句
- 有 model
- controller 中读取 model 数据，并且用实例变量传递到 view 之中去。
- 有 partial
