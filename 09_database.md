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

每次都用命令行进数据库，不是特别美观。来安装一个小巧的数据库操作软件，叫 Sequel Pro 。

<http://www.sequelpro.com/download> 下载之后，放到桌面上，双击就可以打开了。

登录需要填写 Vagrantfile 中指定的 IP，mysql 的用户名 `root` 密码咱们没设置所以为空。要使用 ssh 链接，用户名和密码都是 `vagrant` 。 Port 不用填了。

![](http://media.happycasts.net/pic/rails10/sequel.png)

<!-- https://laracasts.com/lessons/vagrant-and-sequel-pro  -->

### 建立数据表结构
更改数据库的表结构，rails 给出的方法是 Miagration <http://guides.rubyonrails.org/> 。

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

插入需要的记录

    Issue.create(title: "Ruby Lover")
    Issue.create(title: "Rails and Laravel")
    Issue.all


现在在 controller 中使用数据

{% highlight ruby %}
- @issues  = [ { title: "Ruby lovers", comments: "4" }, { title: "Rails and Laravel", comments: "5" } ]
+ @issues = Issue.all
{% endhighlight %}

到 _issue_list.html.erb 中在稍作修改就好了。
