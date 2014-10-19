---
layout: default
title: The Rails Way
---

开发 web 应用是个复杂的过程，rails 有自己的一套做法，这就是 The Rails Way 。

用 generator 的时候避免生成太多用不到的文件：

{% highlight ruby %}
config.generators do |g|
    g.assets false
    g.helper false
    g.test_framework false
end
{% endhighlight %}
