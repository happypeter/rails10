---
layout: default
title: The Rails Way
---

开发 web 应用是个复杂的过程，同一个功能实现方式很多，其实有时候仅仅是选择太多，就是报新手搞晕的一个原因。rails 有自己认为的一套“最优的做法”，这就是 The Rails Way 。

上个视频里，搭建出一个简单的首页，现在把这些内容都拷贝到 meetup/public 目录之下

    cp -rf tmp/* meetup/public

这样访问 meetup.dev:3000 也还是能看到页面的，一样的风采照人。但是这样不是 rails 做事的方式，不是 The Rails Way 。

### The Rails Way

![](http://media.happycasts.net/pic/rail10/rails_way.png)

rails 的根本骨架是上面的 MVC 结构，不过这一集只来关注 route -> controller -> view 的这条线。


### 移动 welcome.html

到 route.rb 中添加

{% highlight ruby%}
root 'page#welcome'
{% endhighlight %}


添加 app/controllers/page_controller.rb

{% highlight ruby %}
class PageController < ApplicationController
  def welcome
  end
end
{% endhighlight %}

接下来，要到 app/views/page/welome.html 中添加内容。

### 移动 about.html 页面

到 route.rb 中，添加

{% highlight ruby %}
get '/about' => 'page#about'
{% endhighlight %}


好，这一集就到这里。
<!-- 用 generator 的时候避免生成太多用不到的文件：


config.generators do |g|
    g.assets false
    g.helper false
    g.test_framework false
end

 -->
