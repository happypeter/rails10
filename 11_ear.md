---
layout: default
title: 网站的耳朵
---

当代的网站不仅能够向访问者展示新型，也能去倾听访问者的声音。这个主要是通过 form 实现的。

### form

首页的 “创建新活动” 的按钮，链接改为

{% highlight erb %}
<%= link_to "发布新活动", "/issue/new", class: "banner-btn btn" %>
{% endhighlight %}

route.rb 中添加

{% highlight ruby %}
get '/issues/new' => "issues#new"
{% endhighlight %}




现在运行

    rails g controller issues new

到生成的 issues_controller.rb 中

{% highlight diff %}
def new
+ @issue = Issue.new
end
{% endhighlight %}

然后创建 app/view/issues/new.html.erb

{% highlight erb %}
<div class="container">
  <%= form_for @issue do |f| %>
    <%= f.label :title %>
    <%= f.text_field :title %>
    <%= f.submit %>
  <% end %>
</div>
{% endhighlight %}

这样，刷新页面会报错

    undefined method `issues_path'

所以还要回  route.rb 添加

{% highlight ruby %}
 post 'issues' => 'issues#create', :as => 'issues'
{% endhighlight %}

maybe I shall go directly to `resources :issue` and show people `rake routes`

- 可以先用 html 写 form 然后指向 route.rb 中得相应设置，如果只是创建，这样挺简单
- 但是如果要同时进行 CRUD，那 rails 的 restful resource，确实是方便紧凑啊
- resources http://guides.rubyonrails.org/routing.html 2.2
- route 太多了，而且大部分都没有用过，可以先把 issue#show 和 issue#destroy 做成
  - show 和 destroy 都用不到 form_for
  - 也可以展示 /issues/:id params[:id] 这个重要概念

def create
  render plain: params[:article].inspect
end


def create
  @issue = Issue.new(params[:issue])
  if save
    redirect_to root_url
  else
    render :new # 注意这里是不执行 new action 的语句的，所以前面一定要有 @issue 在
