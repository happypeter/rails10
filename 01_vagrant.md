---
layout: default
title: 使用 vagrant 安装 ubuntu 系统
---

我使用的是苹果笔记本，跑 Mac 系统，但是我的 rails 程序要跑在 ubuntu 系统上。那最简单的解决方案就是安装 virtualbox 虚拟机，再装上 vagrant 。 这样就很容易的把 ubuntu 装上了。当然如果你已经习惯了用其他的方式安装 ubuntu 也是可以的。

![](http://media.happycasts.net/pic/rails10/vagrant.png)

### 安装 virtualbox 和 vagrant

到相应的 [下载页面](https://www.virtualbox.org/wiki/Downloads)，找到适合自己的包来安装就好了，和安装别的软件没啥区别，我这里就不演示了。
接下来你可以在 virtualbox 直接安装 ubuntu，以前的很多年里，我自己都是这么干的，所以没啥不可以的。但是还是用 vagrant 来装吧，不仅安装起来更方便快捷，而且后面真正开发中也会有很多好处。

到 [vagrant 的下载页面](https://www.vagrantup.com/downloads.html) ，选择 Mac 版本下载，双击来安装。到终端中，执行

    vagrant -v

如果看到输出，表示已经装好了。

### 到 vagrantcloud 上找一个 box

更新： vagrantcloud.com 现在已经合并到了 <https://atlas.hashicorp.com> .

就找一个干净的 ubuntu14.04 系统就行。使用 <https://vagrantcloud.com/ubuntu/boxes/trusty64> 。

这个就是我要的64位 ubuntu14.04 系统。到终端里执行

    mkdir rails10-va
    cd rails10-va
    vagrant init ubuntu/trusty64

接下来执行

    vagrant up

安装过程就开始了，一般首次运行需要十几分钟时间。

### 基本操作

`vagrant up` 之后，系统就装好并启动起来了，可以运行

    vagrant ssh

登陆到虚拟机里面，默认的用户叫做 vagrant，可以用 `whoami` 查看一下。再查看一下内存，用 `free -m` 命令，发现默认内存大小还不到500M，所以敲 Ctrl-D 退出来。添加下面几行到 Vagrantfile 文件。

{% highlight ruby%}
config.vm.provider "virtualbox" do |v|
  v.memory = 2048
end
{% endhighlight %}

然后执行

    vagrant reload

来加载设置就可以了。

关于 vagrant 的更为丰富的使用方法，参考 <http://happycasts.net/episodes/105>
