---
layout: default
title: 运行第一个 rails 程序
---

这一集的任务是跑一个 rails 的 hello world 。

### 新建项目

新建一个项目，使用 mysql 作为数据库

    rails new meetup -d mysql

`meetup` 就是项目的名称。

最后的 bundle 这条命令是要等一会儿的。它的作用就是安装 Gemfile 之中的这些依赖包。可以把 rails 也添加进去，后面如果有朋友拿到你的代码，执行

    bundle

就可以连 rails 一同装上了。

### 配置一下 vagrant

给虚拟机一个固定的局域网 IP，到 Vigrantfile 中添加

{% highlight ruby%}
config.vm.network :private_network, ip: "192.168.10.10"
{% endhighlight %}

不要忘记执行 `vagrant reload` 命令。然后

    sudo vim /etc/hosts

添加

    192.168.10.10  meetup.dev

访问 meetup.dev:3000 可以看到真正运行的程序了。

### public 中可以放静态页面

到 public/ 目录中看一下，已经创建了几个静态页面，是可以直接访问的，浏览器中访问 meetup.dev:3000/404.html 就可以打开这里的 404.html 这个页面了。

新建一个页面 index.html

修改了内容之后可以用 git 版本控制工具做成一个新的版本，保存到 github 网站之上。github 上我已经创建了一个项目叫 rails10 配置一下

    git remote add origin master git@githuh.com:happypeter/rails10.git

然后
    git push

以后你如果到我这个页面，点开历史，就能看到这个项目的演进历史了。由于这门课不是讲 git 的，所以后面虽然我会一直都用 git 来控制源代码，但是就不细讲了。

![](http://media.happycasts.net/pic/rails10/git.png)
