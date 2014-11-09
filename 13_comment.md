---
layout: default
title: 添加评论
---

现在来给大家添加评论功能。关注的核心点是如果创建两种资源之间的一对多关系。

### 创建 model 和 form


先来创建 model 和 migration 文件

    rails g model comment content:text username:string email:string issue_id:integer

为了体现归属关系，也就是一个 issue 对应多个 comment 的关系。要在 issue 中添加一个新的字段 `issue_id` 这个在后面会有妙用。

到 views/issues/show.html.erb 中添加

{% highlight erb %}
<%= render partial: 'shared/comment_box', locals: {issue: @issue} %>
{% endhighlight %}

创建 views/shared/_comment_box.html.erb，这次使用 form_tag <http://guides.rubyonrails.org/form_helpers.html> 比 form_for 更加直白简单。

{% highlight erb %}
<article class="reply clearfix">
  <div class="avatar">
    <%= link_to "#" do %>
      <%= image_tag "default_avatar.png", class: "image-circle" %>
    <% end %>
  </div>
  <div class="body">
  <%= form_tag("/issues/#{issue.id}/comments", method: :post) do  %>
    <%= label_tag :username, "用户名" %>
    <%= text_field_tag(:username) %>
    <%= label_tag :email, "邮箱" %>
    <%= text_field_tag(:email) %>
    <%= text_area_tag(:content) %>
    <%= submit_tag '提交评论', class: 'btn btn-primary btn-submit' %>
  <% end %>
  </div>
</article>
{% endhighlight %}

到 route.rb 添加

{% highlight ruby %}
# comments
post '/issues/:issue_id/comments' => "comments#create"
{% endhighlight %}

接下来就是创建 app/controllers/comments_controller.rb

    rails g controller comments

create 方法的具体内容是：

{% highlight ruby %}
def create
  c = Comment.new
  c.username = params[:username]
  c.email = params[:email]
  c.content = params[:content]
  c.issue_id = params[:issue_id]
  c.save
  issue = Issue.find(params[:issue_id])
  redirect_to issue
end
{% endhighlight %}

打开 Sequel Pro 可以看到改存的内容就都存好了。

### 显示 comment

到 views/issues/show.html.erb 中添加

{% highlight erb %}
<%= render partial: 'shared/comment_list', locals: {comments: @comments} %>
{% endhighlight %}

所以要来创建 shared/_comment_list.html.erb

{% highlight erb %}
  <% comments.each do |c| %>
    <div class="reply clearfix">
       <div class="avatar">
         <%= link_to '#' do %>
           <%= image_tag 'default_avatar.png', class: 'image-circle' %>
         <% end %>
       </div>
       <div class="body">
         <div class="heading">
            <h5 class="name"><%= link_to c.username, "#" %></h5>
            <span class="datetime">
              <%= time_ago_in_words c.created_at %> ago
            </span>
         </div>
         <%= c.content %>
       </div>
    </div>
  <% end %>
{% endhighlight %}

现在不太好办的一个事就是如何得到这个 issue 下的所有 comment 。这时候我多么多么希望在 issues_controller.rb 的 show 方法中，我可以使用这样的语句啊

{% highlight diff %}
def show
   @issue = Issue.find(params[:id])
   @comments = @issue.comments
end
{% endhighlight %}

其实要实现这样的效果也不难，就是要在 issue 和 comment 之间确立一对多关系，具体操作是这样。

### 建立一对多的关系

第一步，确保 comments 表里面有 `issue_id` 这个字段，注意，名字一个字都不能错，因为要用它和 `issues` 表去产生映射关系。

第二步，到 issue.rb 文件中添加

{% highlight ruby %}
has_many :comments
{% endhighlight %}

最后一步，到 comment.rb 中，添加

{% highlight ruby %}
belongs_to :issue
{% endhighlight %}

好了，就是这三步。现在到 rails console 中来创建一个隶属于（或者说 belongs to）id=1 的这个 issue 的一个 comment

    Comment.create(issue_id: 1, username: 'happypeter', email: 'happypeter1983@gmail.com', content: 'Hello peter here')

明显，这里是通过指明这个 comment 的 issue_id 来确定这个隶属关系的。 重启一个 rails console，执行

    i = Issue.find(1)
    i.comments

就可以看到刚才创建的那个 comment 了。

这样，到页面中刷新一下，就可以看到所有评论了。下面稍微把代码改的好一点。

到 comment_controller.rb 的 create 方法中

{% highlight diff %}
- issue = Issue.find(params[:issue_id])
- redirect_to issue
+ redirect_to c.issue
{% endhighlight %}

感谢一对多关系，咱们有了 `issue.comments` 和 `comment.issue` 这些方便的用法。

这样在来到首页，这里的评论数也是假的。到 views/page/_issue_list.html.erb 中

{% highlight erb %}
- <%= link_to '5', "#" %>
+ <%= link_to i.comments.count, i %>
{% endhighlight %}

更改评论头像。issue#show 页面的每个评论都是一个头像也不好看。其实如果发评论的人使用 <http://en.gravatar.com/> 的服务，是可以通过他给咱们的 email 来取得他的邮箱的。

到 comment.rb 文件

{% highlight ruby %}
def user_avatar
  gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
  "http://gravatar.com/avatar/#{gravatar_id}.png?s=512&d=retro"
end
{% endhighlight %}

这样到 views/shared/_comment_list.html.erb 中，

{% highlight diff %}
- <%= image_tag 'default_avatar.png', class: 'image-circle' %>
+ <%= image_tag c.user_avatar, class: 'image-circle' %>
{% endhighlight %}

这样就可以真确显示头像了。

