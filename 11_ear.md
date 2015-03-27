---
layout: default
title: 网站的耳朵
---

当代的网站不仅能够向访问者展示新型，也能去倾听访问者的声音。这个主要是通过 form 实现的。

### form 提交

首页的 “创建新活动” 的按钮，链接改为

{% highlight erb %}
<%= link_to "发布新活动", "/issues/new", class: "banner-btn btn" %>
{% endhighlight %}

routes.rb 中添加

{% highlight ruby %}
get '/issues/new' => "issues#new" # 主要这一行要写在 get '/issues/:id' 的上面
{% endhighlight %}


issues_controller.rb 中添加

{% highlight ruby %}
def new
  @issue = Issue.new
end
{% endhighlight %}

然后创建 app/view/issues/new.html.erb

{% highlight erb %}
<%= form_for @issue do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :content %>
  <%= f.text_area :content %>
  <%= f.submit %>
<% end %>
{% endhighlight %}

刷新页面之前，你还是不要拦着我，让我添加几行 html 标签进来，你不用看

{% highlight html %}
<div class="new-issue-form-container clearfix">
  <div class="new-issue-form clearfix">
    <%= form_for @issue do |f| %>
      <dl class="form">
        <dt><%= f.label :title %></dt>
        <dd><%= f.text_field :title %></dd>
      </dl>
      <dl class="form">
        <dt><%= f.label :content %></dt>
        <dd><%= f.text_area :content %></dd>
      </dl>
      <p><%= f.submit "发布新活动", :class => "submit-issue-button btn btn-primary" %></p>
    <% end %>
  </div>
</div>
{% endhighlight %}

再来补充几行 css...到 common.css.scss

{% highlight css %}

// form.css
form {
  input {
    font-size: 21px;
    width: 100%;
    padding: 10px 12px;
    color: #555;
  }
  textarea {
    height: 180px;
    font-size: 21px;
    width: 100%;
    padding: 10px 12px;
    color: #555;
  }
  label {
    display: inline-block;
    margin-bottom: 5px;
  }
  dd {
    margin: 0;
  }
}
{% endhighlight %}

创建 sections/issue_new.css.scss

{% highlight sass %}
.new-issue-form-container {
  width: 800px;
  background: white;
  margin: 30px auto;
  .new-issue-form {
    width: 600px;
    margin: 10px auto;
  }
}
.submit-issue-button {
  height: 50px;
  width: 100%;
}
{% endhighlight %}

这样，刷新页面会报错

    undefined method `issues_path'

所以还要回  routes.rb 添加

{% highlight ruby %}
get 'issues' => 'issues#index', :as => 'issues'
{% endhighlight %}

这样就可以正确显示 form 了，打开浏览器，inspect element 查看源码，目前注意的就是两个东西 `method` 和 `action` 因为他俩决定了表单要提交到哪里。
浏览其中提交一下，报错 `No route matches [POST] "/issues"` 所以就知道 routes.rb 中应该怎么写了。

{% highlight ruby %}
post 'issues' => 'issues#create'
{% endhighlight %}

这样，就要在 issues_controller.rb 中添加

{% highlight ruby %}
def create
  render plain: params[:issue].inspect
end
{% endhighlight %}


### Strong Parameters

最终 create action 要写成这样：

{% highlight ruby %}
def create
  Issue.create(params[:issue])
  redirect_to :root
end
{% endhighlight %}

但是真正提交一下，却 error 了：

    ActiveModel::ForbiddenAttributesError

这个又是 Rails 为了防止坏人通过表单提交攻击网站，而采用的自我保护机制。你想啊，如果不加说明坏蛋们就可以在 params[:issue] 中人为植入其他的参数，比如 `admin: true` 这样就可以给他自己管理员权限了，所以必须要你自己指明哪些字段是允许直接用 params 里的参数来修改的。使用的方式就是 <https://github.com/rails/strong_parameters> 。

要做的修改非常简单，就是到 issue_controller.rb 添加

{% highlight ruby %}
private
  def issue_params
    params.require(:issue).permit(:title, :content)
  end
{% endhighlight %}

然后

{% highlight diff %}
- Issue.create(params[:issue])
+ Issue.create(issue_params)
{% endhighlight %}

这样再来提交，操作成功了。


