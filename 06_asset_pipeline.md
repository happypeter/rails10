---
layout: default
title: Asset Pipeline
---

其实有一个秘密我还没告诉你，就是放在 views 目录下的所谓的模板文件，其实一般后缀不是 .html 而是 .html.erb 。

### erb 和 helper
erb 是 Embedded RuBy 的简写，文件加上 .html.erb 后缀，这样就可以在里面写 erb 语句了，也就是在 `<%= %>` 中，可以写 ruby 了。例如 `<%= 1+1 %>` 或者 `<%= link_to "google", "google.com" %>`，`link_to` 是 Rails 自带的函数。用于简化 html 代码的书写，类似的用在模板中函数还有很多，都叫做 helper 。

可以对 about.html.erb 做下面的修改

{% highlight diff %}
- <li><a href="./about.html">About</a></li>
+ <li><%= link_to "about", "/about" %></li>
{% endhighlight %}

### 抽出 layout

写程序有一个原则，就是不重复，因为重复的代码，你改动一个地方，就要有两倍的工作量了。现在 about.html 之中有一大部分内容都是和 welcome.html 中一样的。所以这是个问题，看看 rails 怎么来解决。

这就涉及到一个概念，叫做 layout 文件。到 layouts/application.html.erb 之中,这里的内容一下子不太好理解，所以先把他们全部删除，一会儿一步一步的我还会把这些内容都写会来。

为了区分各个页面，对 application.html.erb 中的 body 标签做下面的操作

{% highlight html %}
<body class="<%= params[:controller] + '-' + params[:action] %>">
{% endhighlight %}

### 重新安装 anystretch 的相关文件

Rails 自带了 jquery 所以只要把 anystretch 的 js 添加到它的下面就行。

{% highlight diff %}
//= require jquery
+ //= require vendor/jquery.anystretch.min
{% endhighlight %}

把图片放到 `app/assets/images` 下面，这样在 view 模板中就可以通过 `<%= image_url "home-banner-bg.jpg" %>` 来使用了。

{% highlight diff %}
-  <div class="home-banner" data-stretch="images/home-banner-bg.jpg"></div>
+  <div class="home-banner" data-stretch="<%= image_url "home-banner-bg.jpg" %>"></div>
{% endhighlight %}

js 文件在页面中的导入也就简单多了，layouts/application.html.erb 之中

{% highlight diff %}
- <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
- <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
- <script src="js/jquery.anystretch.min.js"></script>
+ <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
{% endhighlight %}

css 的处理和 js 很类似。移动文件到 app/assets/stylesheets/ 下之后，在 applicaiton.html.erb 中，就只需要

{% highlight erb %}
<%= stylesheet_link_tag "application" %>
{% endhighlight %}

总结一下，对于 css 图片和 js 的控制，涉及到的是 rails asset pipeline 这部分的知识，其实内容还不只是我们刚刚介绍的这点，后面还有。


