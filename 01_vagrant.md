---
layout: default
title: 使用 vagrant 安装 ubuntu 系统
---

我使用的是苹果笔记本，跑 Mac 系统，但是我的 rails 程序要跑在 ubuntu 系统上。那最简单的解决方案就是安装 virtualbox 虚拟机，载装上 vagrant 。 这样就很容易的把 ubuntu 装上了。当然如果你已经习惯了用其他的方式安装 ubuntu 也是可以的。

### 安装 virtualbox 和 vagrant

到相应的[下载页面](https://www.virtualbox.org/wiki/Downloads)，找到适合自己的包来安装就好了，和安装别的软件没啥区别，我这里就不演示了。
接下来你可以在 virtualbox 直接安装 ubuntu，以前的很多年里，我自己都是这么干的，所以没啥不可以的。但是还是用 vagrant 来装吧，不仅安装起来更方便快捷，而且后面真正开发中也会有很多好处。

到 [vagrant 的下载页面](https://www.vagrantup.com/downloads.html)，选择 Mac 版本下载，双击来安装。到终端中，执行

    vagrant -v

如果看到输出，表示已经装好了。

### 到 vagrantcloud 上找一个盒子

就找一个干净的 ubuntu14.04 系统就行。使用 <https://vagrantcloud.com/ubuntu/boxes/trusty64> 。

到终端里执行

    mkdir rails10-va
    cd rails10-va
    vagrant init ubuntu/trusty64

接下来执行

    vagrant up

安装过程就开始了，一般首次运行需要十几分钟时间。

### 基本操作

vagrant up 之后，系统就装好并启动起来了，可以运行

    vagrant ssh

登陆到虚拟机里面，默认的用户叫做 vagrant，可以用 `whoami` 查看一下。

比如可以敲

    sudo init 0

来关闭这个 ubuntu 系统。

我在系统上得到的是一个新建的 virtualbox 虚拟机。可以打开 virtualbox ，到 settings 中来给这个虚拟机条调一下内存大小。调到 2048 。添加下面几行到 Vagrantfile 文件

{% highlight ruby%}
config.vm.provider "virtualbox" do |v|
  v.memory = 2048
end
{% endhighlight %}


<!-- https://laracasts.com/search?q=vagrant -->
