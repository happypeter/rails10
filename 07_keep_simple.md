---
layout: default
title: Keep it Simple, Let it grow
---

介绍 sass coffeescript git 这些工具。经管 rails 是用来写带数据库的智能应用程序的，但是还是不着急碰数据库。这一集依旧是看看 Rails 能给前端代码的书写带来哪些好处。


### 重新安排 css 文件结构
继续开工。随着 html 页面结构的调整，layout 文件的引入，index.css 这个文件名已经变得不适合了。新建一个目录

    cd app/assets/stylesheets
    mkdir sections

里面专门放各个页面具体区块的 css。 把 index.css 移动进去，拆成 layout.css 和 welcome.css 。分别负责 application.html.erb 和 welcome.html.erb 页面的样式。再来新建

    mkdir shared

把 common.css 放进去。

### sass 的基本使用
有一种语言叫 [sass](http://sass-lang.com/) 。sass 可以让我用一种更为简单甜美的语法来写 css，然后只需要一个命令，sass 语句就能变成 css 语句。

    sass input.scss output.css

sass 甚至比 css 还有简单友好，所以即使你是 css 零基础，也不妨现在就把 sass 用起来。这个就类似于你是 javascript 零基础，也不妨碍你直接上手 jquery 。

如果把 app/assets/javascripts/ 下的文件后缀，改为 .js.coffee 就可以使用 coffeescript 了，不过这个倒是不着急用。

### git 很牛

但是不要跟 rails 一起学。Railstutorial 这本书中就是把如何用 git 辅助 rails 开发都很好的展示出来了。但是如果你现在 rails 和 git 都是 0 基础，那相信我，千万别把这两个东西放到一块来起步，因为他俩都是挺复杂了，复杂+复杂=举步维艰。
