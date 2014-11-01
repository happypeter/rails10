---
layout: default
title: 静态页面
---

<!--
     - 也不一定非要再后面一集里面就把所有的巧妙机制都展示了，可以分几个视频逐步抽出，不足的素材部分也可以逐步添加进来的
 -->

rails 是用来做 web 应用的，功能多，使用的技术手段也多。在真正着手学习 rails 之前，建议你可以多多动手做一些静态网页，也就是多写写三种代码 html css 和 javascript ，然后再来接触 rails 程序，会发现其中一部分知识你已经清楚了，就不会因为一下子暴露在太多知识点之下而感到恐怖了。这一集，咱们先来写成一个静态网页，把首页搭起来。后续课程里会聊如何用 rails 的各种机制来重新拆分组织这些静态代码。我这里是假定你有一定的 html 基础的，不过如果你没有，也没有关系，也同样可以理解课程中的最核心内容。

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
{% endhighlight %}

header 和 footer，页面的头和脚都有了，下面主题部分也稍微添加一点内容。到 laracasts.com 借用一下它的这张大背景图。这里要声明一下，课程中得页面样式是完全借用 laracasts.com 的，因为我非常喜欢这个站点，模仿是最好的表达崇敬的方式了。

{% highlight diff %}
<body>
+ <img src="images/home-banner-bg.jpg" alt="home-banner">
</body>
{% endhighlight %}



我这里安装了一个插件叫做 livestyle ，这样每次我在 sublime 中修改 css 文件，浏览器中就可以直接看到效果了。

但是这样的背景图是随着页面的缩放会变得很那看的。所以这里引入一个 js 的插件 [Anystrech](https://github.com/danmillar/jquery-anystretch)

创建 public/js/vendor 目录，把压缩过的文件放进去

    wget https://raw.githubusercontent.com/danmillar/jquery-anystretch/master/jquery.anystretch.min.js

在 index.html 中添加

{% highlight diff%}
@@ -5,6 +5,7 @@
   <title>Document</title>
   <link rel="stylesheet" href="css/layout.css">
   <link rel="stylesheet" href="css/common.css">
+  <script src="js/vendor/jquery.anystretch.min.js"></script>
 </head>
 <body>
   <div class="navbar clearfix">
{% endhighlight %}


`<body>` 标签，改为 `<body class="welome">` 这样让这个 header 变成透明色。

现在在来添加一个 about.html 页面。这个就需要拷贝整个的这个页面过来才行。



后面，我会用 rails 的各种巧妙机制来解决这里动手遇到的这些麻烦。

---


这一集的内容不要太多，最重要的是为后面的“使用 rails 巧妙重构静态页面”的部分做素材准备。

- asset pipeline 的各种机制
  - css to sass -> 所以静态页面例子里面要有 brand-color 被复用到好几个地方的情况
  - js -> anystrech 的文件可以放到 vendor 下面，同时 jquery 可以删除，因为 rails 默认支持 jquery
  - 文件要从 public 中移除，放到 views 文件夹里
  - 同时后缀名改为 .html.erb
  - 给出 root: => "pages#welcome" 的 route


- 图片
  - 有固定的位置放文件
- css
  - 可以用 sass
- js
  - 可以分开 js 文件
  - 最后用 sprocket 合并成一个

{% highlight diff %}
def rest
-  @episodes = Episode.recent.page(1).per_page(6)
+  @episodes = Episode.recent.page(params[:page]).per_page(12)
end
{% endhighlight %}

{% highlight diff %}
nice
- minus this
+   add this
- minus tat
tile
{% endhighlight %}
