---
layout: default
title: Code Beauty
---

Beauty tames complexity >代码的美丽程度也显示你驾驭复杂问题的能力。

### 更新一个资源
来添加一个 edit 按钮，到 views/issues/show.html.erb

{% highlight erb %}
<%= link_to 'edit', edit_issue_path(@issue), class: "btn btn-primary" %>
{% endhighlight %}

route.rb 中添加

{% highlight ruby %}
get 'issues/:id/edit' => 'issues#edit', :as => 'edit_issue'
{% endhighlight %}

issues_controller.rb 中添加

{% highlight ruby %}
def edit
  @issue = Issue.find(params[:id])
end
{% endhighlight %}

最重要的是要有 views/issues/edit.html.erb 把 views/issues/new.html.erb 中的内容原封不动搬过来，页面中提交一下，这次的报错是

    No route matches [PATCH] "/issues/2"

这里可以看出 `form_for` 是很智能的，如果传递给他的是一个新对象，就行在 issues#new 中，那他就会提交到 `POST issues/` 而如果给他的时已经赋值过的对象，那他就会提交到 `PATCH issues/`，而这个也正好是可以写到 route.rb 中，这样

{% highlight ruby %}
patch 'issues' => 'issues#update'
{% endhighlight %}

那这样看来，issues/new.html.erb 中，和 issues/edit.html.erb 中公用同样的代码就可以了。新建一个 views/issues/_form.html.erb 文件

{% highlight erb %}
<div class="new-issue-form-container clearfix">
  <div class="new-issue-form clearfix">
    <%= form_for issue do |f| %>
      <dl class="form">
        <dt><%= f.label :title %></dt>
        <dd><%= f.text_field :title %></dd>
      </dl>
      <dl class="form">
        <dt><%= f.label :content %></dt>
        <dd><%= f.text_area :content %></dd>
      </dl>
      <p><%= f.submit :class => "submit-issue-button btn btn-primary" %></p>
    <% end %>
  </div>
</div>
{% endhighlight %}

然后，把 views/issues/edit.html.erb 和 views/issues/new.html.erb 的内容都删除，共同改为

{% highlight erb %}
<%= render partial: 'form', locals: {issue: @issue} %>
{% endhighlight %}

实验一下，没有任何问题，甚至提交按钮上的文字都会自动变化。

### resources

<!-- 不要太絮叨，给出简约的代码，让大家体会到高效实用是最重要的。 -->
好，到这里任务就完成了，依旧是看看代码能否重构一下。

到 route.rb 中，所有的指向 issues_controller.rb 的语句都可以删除，而用一行代替

{% highlight ruby %}
resources :issues
{% endhighlight %}

这一行到底起什么作用。到终端中

    rake routes

一看便知。具体参考文档 <http://guides.rubyonrails.org/routing.html> 。

一个小点需要调整，首页的 Issue 都没有时间。

_issue_list.html.erb 中添加

{% highlight erb %}
<%= time_ago_in_words(i.created_at) %> ago
{% endhighlight %}

最好是最新的 issue 在上面。到 weclome_controller.rb 中稍作调整就好了。

{% highlight diff %}
def welcome
- @issues  = Issue.all
+ @issues  = Issue.all.reverse
end
{% endhighlight %}

### RubyGems

现在我想要用 <http://fontawesome.io/> 那我可以直接下载它的代码来直接实用。但是更好的办法是添加 font-awesome 这个 gem 。很多第三方的代码，你可以放到你自己的项目代码中，但是如果恰好有人把代码打包成了 gem 那最好是来装包。人家的代码和你的分开，升级维护起来都方便的多。

到 Gemfile 中添加

{% highlight ruby %}
gem 'font-awesome-rails'
{% endhighlight %}

不要忘了运行 bundle 命令和重启服务器。来使用一下，到 application.css 中添加

{% highlight css %}
 *= require font-awesome
{% endhighlight %}

_issue_list.html.erb 中添加

{% highlight erb %}
<i class="fa fa-comments icon-muted"></i>
{% endhighlight %}

到 welcome.css.scss 添加

{% highlight sass %}
.icon-muted {
  font-size: 25px;
  position: relative;
  top: -20px;
  color: #c9c9c9;
}
{% endhighlight %}

这样图标就出来了。


