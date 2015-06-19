---
layout: default
title: 安装 rails
---

注意，操作系统是 ubuntu 14.04 。

### 先来安装 ruby 语言

![](http://media.haoduoshipin.com/pic/rails10/ruby.jpeg)

很多人直觉上认为要先学 ruby 再来看 rails，这个我不同意。第一，不用 rails 不作出点实际的东西，编程语言学习必然走纸上谈兵的弯路；第二，实际上，ruby 本身是一种非常人性化的语言，仅仅就我的这门课来讲，用到的 ruby 语句都是很简单的，可以看懂的。So take it esay!

更新一下系统软件仓库列表：

    sudo apt-get update

安装一些后面需要的库和软件：

    sudo apt-get install -y git-core curl zlib1g-dev build-essential \
                         libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
                         libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common

[rbenv](https://github.com/sstephenson/rbenv) 是一个安装 ruby 和管理控制多个 ruby 版本的工具

    cd
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL

现在可以真正安装 ruby 了

    rbenv install 2.1.2
    rbenv global 2.1.2

运行 `ruby -v` 命令，看到 2.1.2 的输出，那 ruby 安装就胜利完成了。

内容挺多，刚接触 rails 的人不用一下子都理解，记住我的这个页面的链接，以后慢慢研究就行。

### 安装 rails

有了 ruby 语言，系统上就会多出一个命令叫 gem 可以用来安装 ruby 的程序包，首先执行

    echo "gem: --no-ri --no-rdoc" > ~/.gemrc

这样可以让装包过程变得快一点。国内的机器也可以考虑使用国内的 [ruby 镜像](http://ruby.taobao.org/) 。

![](http://media.haoduoshipin.com/pic/rails10/rails.jpeg)

为了让你可以跟着我一起做，所以咱俩都把版本控制在 4.1.2 吧，尽管我的代码应该是用 rails 4.0 之上的版本都可以跑起来

    gem install rails -v 4.1.2
    rbenv rehash # 导出 gem 中提供的系统命令

<!-- bundler 会一并被装上 -->

完事后，查看一下 rails 版本

    rails -v

如果显示 4.1.2 那就一切就绪了。

安装 MySQL 数据库

    sudo apt-get install mysql-server  mysql-client  libmysqlclient-dev

因为是本地开发环境，就不设置密码了。



