---
layout: default
title: 创建 rails 项目
---


```
rails new rails10 -d mysql
```

{% highlight diff %}
@@ -26,7 +26,7 @@ rbenv rehash
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 111111'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 111111'

-sudo apt-get install -y  mysql-server
+sudo apt-get install -y  mysql-server mysql-client  libmysqlclient-dev

 # js runtime
 sudo apt-get install -y nodejs
{% endhighlight %}
