---
layout: default
title: 运行第一个 rails 程序
---

这一集的任务是跑一个 rails 的 hello world 。

### 共享文件夹和设置 IP

![](http://media.haoduoshipin.com/pic/rails10/shared_folder.png)

不过需要先来搞清楚一个简单的机制，共享文件夹。把程序代码放到共享文件夹之中，这样，Mac 机器作为写代码的平台，上面配置好的 sublimtText vim 和 git 还有搜狗输入法等等都能直接用。 虚拟机里的 ubuntu 是程序的运行平台，这样的好处是不用担心在 Mac 上安装很多软件，把系统搞坏；同时 Rails 部署到服务器上，一般都是运行在 Linux 系统之上的，本地开发环境和未来的部署环境一样，会省去很多麻烦。

为了方便访问这个虚拟机，给它一个固定的局域网 IP，到 Vigrantfile 中添加

{% highlight ruby%}
config.vm.network :private_network, ip: "192.168.10.10"
{% endhighlight %}

不要忘记执行 `vagrant reload` 命令。然后

    sudo vim /etc/hosts

添加

    192.168.10.10  meetup.dev

### 新建项目

ssh 登录 ubuntu ，进入共享文件夹，新建一个项目，使用 mysql 作为数据库

    cd /vagrant
    rails new meetup -d mysql

`meetup` 就是项目的名称。

最后的 bundle 这条命令是要等一会儿的。它的作用就是安装 Gemfile 之中的这些 gem 包。

现在试图启动这个项目：

    cd meetup
    rails s

报错，`Could not find a JavaScript runtime.` 解决方法

    sudo apt-get install -y nodejs

安装成功之后，再次 `rails s` 到浏览器中访问 `meetup.dev:3000` 又报错，”找不到数据库“。执行

    rake db:create db:migrate

问题就解决了。浏览器中刷新，就能看到 rails 程序的默认首页了。

### 摸一下老虎屁股

用 sublime 打开 meetup 这个项目。可以看到生成了很多文件，不过这次只关注 public/ 。到 public/ 目录中看一下，已经自动有了几个静态页面。一个 html 放到 public 下是可以直接访问的。例如浏览器中访问 meetup.dev:3000/404.html 就可以打开这里的 404.html 这个页面了。

动手新建一个页面 index.html，就可以直接在 meetup.dev:3000/ 看到我自己的痕迹了，yeahh。
