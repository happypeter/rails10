---
layout: default
title: Have A Good REST!
---

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


好，到这里任务就完成了，依旧是看看代码能否重构一下。

- resources http://guides.rubyonrails.org/routing.html 2.2
