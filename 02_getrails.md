---
layout: default
title: 安装 rails
---

安装 ruby 语言和 rails 基本上都是在命令行里完成的，主要咱们的系统是 ubuntu 14.04 。

### 先来安装 ruby 语言

更新一下系统软件仓库列表：

    sudo apt-get update

安装一些后面需要的库和软件：

    sudo apt-get install -y git-core curl zlib1g-dev build-essential \
                         libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
                         libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common

rbenv 是一个安装 ruby 和管理控制多个 ruby 版本的工具

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

Install bundler

    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
    gem install bundler
    rbenv rehash

Install MySQL

    sudo apt-get install mysql-server  mysql-client  libmysqlclient-dev

内容挺多，刚接触 rails 的人不用一下子都理解，记住我的这个页面的链接，以后慢慢研究就行。

### install rails

为了让你可以跟着我一起做，所以咱俩都把版本控制在 4.1.2 吧，经管我的代码应该是用 rails 4.0 只上的版本都可以跑起来

    gem install rails -v 4.1.2


### 运行 rails

如果看到这样的默认页面，表示 rails 项目已经正常运行啦。

