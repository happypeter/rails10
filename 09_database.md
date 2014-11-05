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

每次都等命令行进数据库，不是特别美观。来安装一个小巧的数据库操作软件，叫 Sequel Pro 。

<http://www.sequelpro.com/download> 下载之后，放到桌面上，双击就可以打开了。

登录需要填写 Vagrantfile 中指定的 IP，mysql 的用户名 `root` 密码咱们没设置所以为空。要使用 ssh 链接，用户名和密码都是 `vagrant` 。 Port 不用填了。

![](http://media.happycasts.net/pic/rails10/sequel.png)

<!-- https://laracasts.com/lessons/vagrant-and-sequel-pro  -->

### 建立数据表结构
更改数据库的表结构，rails 给出的方法是 Miagration <http://guides.rubyonrails.org/> 。

生成一个 migration，展示一下，告诉观众 id 会被自动加载，created_at update_at 都自动处理了，被光说，展示一下 schema.rb 和 sequel
http://guides.rubyonrails.org/migrations.html

     rails g migration CreateIssues

生成的文件名的前面是时间戳，20141105... 今天就是 2014年11月5号。里面可以添加需要的字段。

{% highlight ruby %}
class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.timestamps
    end
  end
end
{% endhighlight %}

运行

    rake db:migrate

来把修改内容真正写进 mysql 数据库。会生成 db/schema.rb 文件。


### 建立 model

model 文件要放在 app/models 下面，名字叫 issue.rb

{% highlight ruby %}
class Issue < ActiveRecord::Base
end
{% endhighlight %}

这里的 class 命名是很关键的，如果数据库中的表名是 `issues` 那这里的 class 名就必须是 `Issue`，也就是首字母大写，同时变成单数。为啥要这样？
因为这样 Rails 就可以建立自动的 class 到 table 的映射关系了，以后要操作 issues 这张表，就无比的方便。



这样就可以打开 `rails console` 来真正对这样表进行操作了，具体可以参考 <http://guides.rubyonrails.org/active_record_basics.html>

<http://happycasts.net/episodes/54> 8：00 的图很精彩。

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
