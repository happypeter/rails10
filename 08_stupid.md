---
layout: default
title: 笨办法发消息
---

进入网站实际功能部分，思路一样，先用笨办法来做事情，再引入 rails 的巧妙机制。

###  大声吆喝

<!-- 做一个发布活动信息的站点。先考虑简单情况，发消息的人，就我自己。我可以去后台敲 console 命令去创建 issue 。但是也还是要
     创建数据库之前，先写死一个 issue 的 html，让后看到这样发布信息也不是办法。
 -->

我先粘贴几行 html 和 css 过来，让页面上显示，大字 “It's Party Time” 小字 "到时聚聚，聊聊程序"。右侧一个 “发布新活动” 按钮。这样就可以看出我下面要做一个什么功能了。

在 welcome.html.erb 中， `class="home-banner"` 的 div 之内粘贴

{% highlight html %}
<div class="banner-inner container clearfix">
  <h1>It's Party Time!</h1>
  <p class="subheading">到时聚聚，聊聊程序</p>
  <div class="home-banner-links">
    <%= link_to "发布新活动", "#", class: "banner-btn btn" %>
  </div>
</div>
{% endhighlight %}

对应的 css 放在 welcome.css 之中

{% highlight sass %}
.home-banner {
  margin-top: -80px;
  padding-top: 80px;
  .banner-inner {
    height: 600px;
    position: relative;
    h1 {
      font-family: "museo-sans-condensed";
      font-size: 88px;
      font-weight: 400;
      letter-spacing: -2px;
      border-radius: 5px;
      margin-top: 60px;
      line-height: 1.2;
      max-width: 50%;
      text-transform: capitalize;
      color: #fff;
      text-shadow: 0 1px 81px rgba(0,0,0,0.3);
    }
    .subheading {
      color: #fff;
      font-weight: 300;
      font-size: 1.3em;
      margin-top: 26px;
      background: rgba(0,0,0,0.5);
      display: block;
      width: 45%;
      padding: 5px 10px;
      line-height: 30px;
      text-align: center;
    }
  }
}

.home-banner-links {
  position: absolute;
  right: 160px;
  top: 194px;
  .banner-btn {
    padding: 15px 15px;
    font-size: 1.2em;
    font-weight: 300;
    font-family: "museo-sans-condensed";
    border-radius: 5px;
    color: #fff;
    background: rgba(0,0,0,0.1);
    margin-left: 8px;
    border: 1px solid transparent;
    &:hover {
      border: 1px solid rgba(0,0,0,0.2);
    }
  }
}
{% endhighlight %}

最终达成这样的效果

![](http://media.happycasts.net/pic/rails10/party_time.png)

给活动列表加个标题，在 welcome.html.erb 中

{% highlight html %}
<div class="issue-list-header">
  <div class="container clearfix">
    <h1 class="issue-list-heading">所有活动都在下面了...</h1>
  </div>
</div>
{% endhighlight %}

再到 welcome.css.scss

{% highlight scss %}
.issue-list-header {
  border-bottom: 1px solid #ddd;
  padding-bottom: 30px;
  padding-top: 30px;
  margin-top: 0;
  margin-bottom: 35px;
  background: #7EB6AD;
  color: #fff;
  .issue-list-heading {
    font-size: 2em;
    font-weight: normal;
  }
}
{% endhighlight %}

#### 写 html 来发布活动很麻烦
现在假设我是站长，也只有我自己来发布新活动，那我可以把新活动的信息直接写成 html。每次活动写成一个 partial 。

在 welcome.html.erb 中添加活动列表

{% highlight html %}
<div class="container clearfix">
  <div class="issue-list">
    <article class="issue clearfix">
      <div class="avatar">
        <a href="/happypeter">
          <img src=http://gravatar.com/avatar/a92785d8d68f1d1d83b008574f8b5dba.png?s=512&amp;d=retro alt="">
</a>      </div>
      <div class="body">
        <h5 class="title">
          <a href="#">Ruby 爱好者</a>
        </h5>
        <a class="read-more" href="#">read</a>
        <span class="meta-data">
          <a href="/happypeter">happypeter</a>
        </span>
      </div>
      <div class="issue-comment-count">
        <a href="/issues/8">
          4
        </a>
      </div>
    </article>
  </div>
</div>
{% endhighlight %}

welcome.css.scss 中对应的 sass

{% highlight sass %}

.issue-list {
  background: #fff;
  clear: both;
  padding: 0 2em;
  margin-bottom: 1em;
  border: 1px solid #ddd;
  article {
    border-bottom: 1px solid #e3e3e3;
    position: relative;
    margin-top: 0;
    padding: 1em 0;
    .body {
      margin-right: 2em;
      width: 70%;
      float: left;
      .read-more{
        background-color: #316A72;
        color: #fff;
        font-size: 13px;
        border-radius: 4px;
        letter-spacing: -0.3px;
        display: inline-block;
        line-height: 1.7;
        font-weight: 100;
        padding: 0 6px;
      }
      .meta-data {
        color: #999;
        font-size: 12px;
      }

      h5 {
        font-size: 22px;
        line-height: 35px;
        font-weight: normal;
        margin: 0 0 5px;
        a {
          color: #555;
          &:hover {
            color: black;
          }
        }
      }
    }
    .issue-comment-count {
      float: right;
      margin-top: 15px;
      a {
        font-size: 45px;
      }
    }
    .avatar {
      width: 75px;
      float: left;
      img {
        width: 65px;
        padding: 4px;
        border: 1px solid #ddd;
      }
    }
  }
}
{% endhighlight %}

### controller 里传输局

page_controller.rb 中添加

{% highlight diff %}
def welcome
+ @issues  = [ { title: "Ruby lovers", comments: "4" }, { title: "Rails and Laravel", comments: "5" } ]
end
{% endhighlight %}

到 welcome.html.erb 中

{% highlight diff %}
- <%= render partial: 'issue_list' %>
+ <%= render partial: 'issue_list', locals: { issues: @issues } %>
{% endhighlight %}

这样在 _issue_list.html.erb 中就可以这样来迭代了

{% highlight html %}
<div class="issue-list">
  <% issues.each do |i| %>
    <article class="issue clearfix">
      <div class="avatar">
        <a href="/happypeter">
          <img src=http://gravatar.com/avatar/a92785d8d68f1d1d83b008574f8b5dba.png?s=512&amp;d=retro alt="">
        </a>
      </div>
      <div class="body">
        <h5 class="title">
          <%= link_to i[:title], "#" %>
        </h5>
        <a class="read-more" href="#">read</a>
        <span class="meta-data">
          <a href="/happypeter">happypeter</a>
        </span>
      </div>
      <div class="issue-comment-count">
        <%= link_to i[:comments], "#" %>
      </div>
    </article>
  <% end %>
</div>
{% endhighlight %}


- 建立 issue 表
  - 首先要确保 config/database.yml 中指定了正确的数据库，必要的话要填写密码。
  - 虽然安装的是 mysql 数据库，但是要操作他不需要自己敲 sql 了，rails 有着自己的更为人性化的语句
- 有 model
- controller 中读取 model 数据，并且用实例变量传递到 view 之中去。
- 有 partial
