---
layout: default
title: 瞄准一个东东，来 CRUD
---

<!-- 这一集的主要思路就是把 form_for 涉及到得太多知识，均匀摊开一部分到这里 -->

现在有了 issue 也就是活动信息这个东东，后面就开始对他 Create Read Update Delete 了。这一集只是开始，瞄准读取展示 issue 还有删除 issue 。
关于 CRUD 比较详细的解释，参考 <http://railsforzombies.org/levels/1>

### 添加 content 到 issue

首先运行一下 migration

    rails g migration AddContentToIssues content:text
    rake db:migrate

下面打开 rails console 插入一下数据

    i = Issue.find(1)
    i.content = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod"
    i.save
    i = Issue.find(2)
    ...


添加路由

{% highlight ruby %}
get '/issues/:id' => "issues#show"
{% endhighlight %}

到 _issue_list.html.erb 中添加指向 `issues#show` 页面的链接

{% highlight diff %}
- <%= link_to i.title, "#" %>
+ <%= link_to i.title, "/issues/#{i.id}" %>
{% endhighlight %}

打开 welcome 页面，点击链接之前想想，是不是应该报错了？想不出来报啥错就证明你前面没好好听，哈。

    uninitialized constant IssuesController

前面是手动创建 controller，熟悉一点之后了，现在可以用 rails generator 来自动生成

用 generator 的时候避免生成太多用不到的文件，到 application.rb 中添加

{% highlight ruby %}
config.generators do |g|
    g.assets false
    g.helper false
    g.test_framework false
end
{% endhighlight %}

然后运行

    rails g controller issues show # 注意是 issues 不是 issue

停一停，看一看，都生出了那些文件，route.rb 中这句是没用的，先删掉。不仅 issues_controller.rb 有了，还声称了 show action 对应的模板，还真是省事不少。


下面就是要填充 views/issues/show.html.erb 中的内容了。先得到 issues_controller.rb 中

{% highlight diff %}
def show
+  render plain: params[:id].inspect
end
{% endhighlight %}

这样敲链接 `http://meetup.dev:3000/issues/1` 页面上就显示 `1`，敲 `http://meetup.dev:3000/issues/2` 的时候页面就显示 `2` 那这个 params[:id] 的作用也就清楚了。当然这只是处于调试目的，所以这一行可以删掉

{% highlight ruby %}
def show
  @issue = Issue.find(params[:id])
end
{% endhighlight %}

这样 show 页面中再添加合适的 erb 语句就可以展示清楚了。issues/show.html.erb 中放入

{% highlight html %}
<div class="issue-heading">
  <div class="container">
    <%= @issue.title %>
  </div>
</div>
<div class="container">
  <div class="replies">
    <article class="reply clearfix">
      <div class="avatar">
        <img src="http://gravatar.com/avatar/a92785d8d68f1d1d83b008574f8b5dba.png?s=512&amp;d=retr" alt="" class="image-circle">
      </div>
      <div class="body">
        <div class="heading">
          <h5 class="name"><a href="#">happypeter</a></h5>
        </div>
        <%= @issue.content %>
      </div>
    </article>
  </div>
</div>
{% endhighlight %}

再来创建一个对应的 app/assets/stylesheets/sections/issue_show.css.scss

{% highlight css %}
.issue-heading {
  border-bottom: 1px solid #ddd;
  padding-bottom: 30px;
  padding-top: 30px;
  margin-top: 0;
  margin-bottom: 35px;
  background: #7EB6AD;
  color: #fff;
  font-size: 2em;
}

.reply {
  position: relative;
  overflow: hidden;
  margin-bottom: 30px;
  width: 91%;
  .heading {
    margin-bottom: 5px;
    .name {
      font-size: 18px;
      display: inline;
      font-weight: normal;
    }
  }
  .body {
    padding: 15px;
    border-radius: 5px;
    position: relative;
    overflow: visible;
    float: left;
    width: 87%;
    border: 1px solid #ddd;
    line-height: 26px;
    &::before {
      content: "";
      display: block;
      position: absolute;
      top: 21px;
      left: -6px;
      width: 10px;
      height: 10px;
      background: #fff;
      border-left: 1px solid #cad5e0;
      border-top: 1px solid #cad5e0;
      -moz-transform: rotate(-45deg);
      -webkit-transform: rotate(-45deg);
    }
  }
  .avatar {
    float: left;
    margin-right: 29px;
    position: relative;
    overflow: visible;
    text-align: center;
    .image-circle {
      width: 75px;
      border-radius: 50%;
    }
  }
}
{% endhighlight %}


但是再来稍微优化一些代码。到 _issue_list.html.erb

{% highlight erb %}
- <%= link_to i.title, "/issues/#{i.id}" %>
+ <%= link_to i.title, issue_path(i) %>
{% endhighlight %}

这样当然会报错，但是 rails 提供了给路由起名字的机制，叫 "named route"，需要做的就是到 route.rb 中

{% highlight diff %}
- get '/issues/:id' => "issues#show"
+ get '/issues/:id' => "issues#show", :as => "issue"
{% endhighlight %}

现在就行了。

### 删除一个资源

现在就来看如果删除一个资源。还是从 view 中的链接开始写。在 issues/show.html.erb 中添加一个删除的链接。

{% highlight erb %}
gita
{% endhighlight %}


issue#destroy


