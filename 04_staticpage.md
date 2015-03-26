---
layout: default
title: 静态页面
---


rails 是用来做 web 应用的，功能多，使用的技术手段也多。在真正着手学习 rails 之前，建议你可以多多动手做一些静态网页，也就是多写写三种代码 html css 和 javascript ，然后再来接触 rails 程序，会发现其中一部分知识你已经清楚了，就不会因为一下子暴露在太多知识点之下而感到恐怖了。这一集，咱们先来写成一个静态网页，把首页搭起来。后续课程里会聊如何用 rails 的各种机制来重新拆分组织这些静态代码。我这里是假定你有一定的 html 基础的，不过如果你没有，也没有关系，也同样可以理解课程中的最核心内容。


### header 和 footer
首先新建一个临时目录叫 tmp，用 subl 打开这个位置，tmp 中新建一个文件叫做 index.html，里面敲

     ！

然后跟上一个 tab ，就可以补齐成一个基本的 html5 页面了。

{% highlight html%}
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
</head>
<body>

</body>
</html>
{% endhighlight %}

`<title>` 标签中填入 `meetup` 敲 tab 跳转进 `<body>` 标签。

现在一个问题是如何在浏览器中打开我正在编辑的这个 html 文件。可以到 tools -> build system -> new build system 创建一个文件

{% highlight javascript %}
{
    "cmd": ["/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", "$file"],
    "selector": "source.html"
}
{% endhighlight %}

保存，文件名为 browse.sublime-build 。这样回到 index.html ，敲 Cmd-B 就可以在浏览器中打开这个文件了。

来到 head 之中，添加对 css/common.css 的引用

{% highlight html %}
<link rel="stylesheet" href="css/common.css">
{% endhighlight %}

再来创建 css/common.css 文件

{% highlight css %}
body {
  font-family: sans-serif;
  margin: 0;
  font-size: 14px;
  color: #666;
}

.container {
  width: 1170px;
  margin: 0 auto;
}

*, *:before, *:after {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

.clearfix:before,
.clearfix:after {
  content: " ";
  display: table;
}
.clearfix:after {
  clear: both;
}
.clearfix {
  *zoom: 1;
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
{% endhighlight %}

在 index.html 中添加页首导航栏

{% highlight html %}
<div class="navbar clearfix">
  <div class="container">
    <a class="navbar-brand" href="/">
      Meetup
    </a>
    <ul class="nav left">
      <li><a href="/#about">About</a></li>
      <li><a href="#">placeholder</a></li>
    </ul>
    <ul class="nav right">
      <li><a href="#">login</a></li>
      <li><a href="#">signup</a></li>
    </ul>
  </div>
</div>
{% endhighlight %}

再到 index.css 之中，添加相应的样式：

{% highlight css %}
.navbar {
  background: #222;
  position: relative;
  z-index: 1000;
}
.navbar a {
  color: #fff;
}
.navbar a:hover {
  color: #c0865e;
}
.navbar-brand {
  float: left;
  padding-left: 0;
  line-height: 80px;
  font-size: 40px;
}
.nav.left {
  float: left;
  margin-left: 40px;
  font-size: 15px;
}
.nav.right {
  float: right;
}
.nav  li {
  float: left;
}
.nav  li  a {
  display: block;
  font-size: 1.1em;
  line-height: 40px;
  padding: 5px 10px;
  margin: 15px 10px;
}
.nav  li  a:hover {
  color: #000;
  background: #fff;
}
{% endhighlight %}


到页面中发现美中不足的是链接是有下划线的，为了修正这个问题，到 common.css 之中，添加

{% highlight css %}
a {
  text-decoration: none;
  color: #c0865e;
}
a:hover {
  color: #845534;
}
{% endhighlight %}


这样 header 部分就有了，现在如法炮制，来添加 footer 。index.html 中添加

{% highlight html %}
<div class="footer">
  <div class="container">
    footer
  </div>
</div>
{% endhighlight %}

再来到 index.css

{% highlight css %}
.footer {
  border-top: 1px solid #c5c5c5;
  min-height: 200px;
  margin: 3em 0;
  padding-top: 3em;
  padding-bottom: 3em;
  background: #f8f5f0;
}
{% endhighlight %}

### 使用 anystretch 添加背景图
header 和 footer，页面的头和脚都有了，下面主题部分也稍微添加一点内容。到 laracasts.com 借用一下它的这张大背景图。这里要声明一下，课程中的页面样式是完全借用 laracasts.com 的，因为我非常喜欢这个站点，模仿是最好的表达崇敬的方式了。

把大图放到 images 目录下，然后到 index.html 中添加对它的使用：

{% highlight diff %}
<body>
+ <img src="images/home-banner-bg.jpg" alt="home-banner">
</body>
{% endhighlight %}

但是这样的背景图是随着页面的缩放会变得很难看的。所以这里引入一个 js 的插件 [Anystrech](https://github.com/danmillar/jquery-anystretch)

创建 public/js/ 目录，把压缩过的文件放进去

    wget https://raw.githubusercontent.com/danmillar/jquery-anystretch/master/jquery.anystretch.min.js

在 index.html 中添加

{% highlight diff%}
   <link rel="stylesheet" href="css/common.css">
+  <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
+  <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
+  <script src="js/jquery.anystretch.min.js"></script>
 </head>
{% endhighlight %}

在 `</body>` 的上方添加

{% highlight js %}
<script>
  $('.home-banner').anystretch();
</script>
{% endhighlight %}

最后到 index.css 中去给 div 设置一下高度

{% highlight css %}
.home-banner {
  height: 600px;
}
{% endhighlight %}

这样，大背景图就设置好了。


### 创建 about 页面

需要拷贝整个 index.html 过来，然后 body 部分改为

{% highlight html %}
<h1>about</h1>
{% endhighlight %}


`<body>` 标签，改为 `<body class="index">` 这样让这个 header 变成透明色。

{% highlight css %}
.index .navbar {
  background: transparent;
}
{% endhighlight %}

而 about 页面的 navbar 依然是黑的。

好了，这一集就写到这里，其实也是有点写不下去了，因为内容已经变得臃肿，各个页面间也有了重复的内容。这样继续写下去，肯定会麻烦不断。

