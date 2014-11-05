---
layout: default
title: 数据的仓库
---
前面把要展示的数据都放在了 controller 里，肯定不是长久之计。那来欢迎今天的重量级嘉宾吧，数据库 mysql 。

### 建立数据库
这次相关的配置文件是 config/database.yml 里面写明了要使用哪个数据库，对应我当前的情况是 Mysql 。 Rails 会默认给每个项目创立一个数据库，你说这不是三个吗？不是的，这个是三种不同的运行环境。默认处于开发环境下，所以数据库的名字就是 meetup_development。还记的前面安装 mysql 的时候吗？没有用密码对吧，所以这里也就不用填写密码了。

先登录到 mysql 里面看一眼

    mysql -uroot
    show databases;

目前还没有这个数据库，我可以在这里敲 SQL 语句来创建它。但是注意，有了 rails 之后，操作数据库是有一套更简便的方式的。

执行

    rake db:create

在登上来看一下，meetup_development 已经建立好了。

每次都等命令行进数据库，不是特别美观。来安装一个小巧的数据库操作软件，叫 Squeal Pro 。

<http://www.sequelpro.com/download> 下载之后，放到桌面上，双击就可以打开了。

登录需要填写 Vagrantfile 中指定的 IP，mysql 的用户名 `root` 密码咱们没设置所以为空。要使用 ssh 链接，用户名和密码都是 `vagrant`

![](http://media.happycasts.net/pic/rails10/squeal.png)

<!-- https://laracasts.com/lessons/vagrant-and-sequel-pro  -->

### 建立数据表结构


生成一个 migration，展示一下，告诉观众 id 会被自动加载，created_at update_at 都自动处理了，被光说，展示一下 schema.rb 和 squeal
http://guides.rubyonrails.org/migrations.html

@issues = Issue.all
@issue = Issue.find(3)

取出的数据到底是什么格式，要让大家看到。

何时引入 model 比较合适？ Issue 自动对应 issues 这张表。
- 没有 model 也就根本不能进行 crud
- 所以就是，建表就用 migration，然后就建立 model, 二者缺一都不能真正往里面插入数据
- 数据插入完毕，就是从 controller 中读出来，然后传给 view
- 这样这一集的任务就完了

- crud
  - create
    - t = Tweet.new; t.title = "Ruby" ; t.save
      - Tweet.create(:title => "Ruby", ...)
    - t = Tweet.find(3)
    - same as create
      - t.update_attributes(...)
    - t.destory

Issue.destroy_all
