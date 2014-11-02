---
layout: default
title: Asset Pipleline
---


> The asset pipeline is technically no longer a core feature of Rails 4, it has been extracted out of the framework into the sprockets-rails gem.


- https://www.reinteractive.net/posts/116-12-tips-for-the-rails-asset-pipeline

>Two options, precompile OR include, not both

什么叫 asset ？ 图片，css 和 js 这些文件就叫做

### erb 和 helper

首先要理解什么是 Embedded RuBy，如果你给一个文件，例如 html template 文件但是不局限于这种文件，加上 .html.erb 后缀，这样就可以在里面写 erb 语句了，也就是在 `<%= %>` 中，可以写 ruby 了。例如 `<%= 1+1 %>` 或者 `<%= link_to "google", "google.com" %>`，`link_to` 是 Rails 自带的函数。用于简化 html 代码的书写，类似的自带函数还有很多，都叫做 helper 。

可以对 welcome.html.erb 做下面的修改

{% highlight diff %}
- <a href="./about.html">About</a>
+ <li><%= link_to "about", "/about" %></li>
{% endhighlight %}

### 抽出 layout

写程序有一个原则，就是不重复，因为重复的代码，你改动一一个地方，就要有两倍的工作量了。现在 about.html 之中有一大部分内容都是和 welcome.html 中一样的。所以这是个问题，看看 rails 怎么来解决。

这就涉及到一个概念，叫做 layout 文件。

application.html.erb 之中的内容一下子不太好理解，所以先把他们全部删除，一会儿一步一步的我还会把这些内容都写会来。


### 重新安装 anystretch 的相关文件


Rails 自带了 jquery 所以只要把 anystretch 的 js 添加到它的下面就行。

{% highlight diff %}

  //= require jquery
  //= require jquery_ujs
  //= require turbolinks
+ //= require vendor/jquery.anystretch.min

{% endhighlight %}



把图片放到 `app/assets/images` 下面，这样在 view 模板中就可以通过 `<%= image_tag "home-banner-bg.jpg" %>` 来使用了。

{% highlight diff %}
- <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
- <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
- <script src="js/jquery.anystretch.min.js"></script>
+ <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
{% endhighlight %}

### sass
