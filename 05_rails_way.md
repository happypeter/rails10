---
layout: default
title: The Rails Way
---

开发 web 应用是个复杂的过程，同一个功能实现方式很多，其实有时候仅仅是选择太多，就是报新手搞晕的一个原因。rails 有自己认为的一套“最优的做法”，这就是 The Rails Way 。

上个视频里，搭建出一个简单的首页，现在把这些内容都拷贝到 meetup/public 目录之下

    mv tmp/* meetup/public

这样访问 meetup.dev:3000 也还是能看到页面的，一样的风采照人。但是这样不是 rails 做事的方式，不是 The Rails Way 。


![](http://media.happycasts.net/pic/rail10/rails_way.png)

{% highlight ruby%}
root 'pages#welcome'
{% endhighlight %}

刷新页面会看到，没有 controller 的报错 ...

使用 link_to 引出 helper 的概念，然后就是大招 partial 和 layout 了

用 generator 的时候避免生成太多用不到的文件：

{% highlight ruby %}
config.generators do |g|
    g.assets false
    g.helper false
    g.test_framework false
end
{% endhighlight %}
