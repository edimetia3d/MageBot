# 简介
本工具可以让你的法师为公会成员提供水/面包/传送门

# 教程

## 插件 
* Weakauras: https://www.curseforge.com/wow/addons/weakauras-2
* LibCopyPaste-1.0: https://www.curseforge.com/wow/addons/libcopypaste
* tradeDispenser-classic: https://github.com/Pretzellent/tradeDispenser-classic

## 宏
* 创建名为 `Update_WF_Macro` 的宏, 其内容为

```
/run local d='/cast 造食术'; if GetItemCount(8076) > 200 then d='' end;EditMacro("Make_Food","Make_Food", nil,d)
/run local d='/cast 造水术'; if GetItemCount(8079) > 200 then d='' end;EditMacro("Make_Water","Make_Water", nil,d)
```

* 创建名为 `Make_Food` 的空宏
* 创建名为 `Make_Water` 的空宏

## 导入WA字串
```
!nF1tVnoru8VlrcPerBvDtx2dR6HUPPBlQnjKXDJqiS9e7XodRTNW4XDBQalXbUWfocIlCeXNaUX3ML)8TG3Bg7eNuNDZUScHsvJ9mV3mV)(73lowo2oKmhYrhy9OdEKdjXHeG)bRgjfV0HC2WjdCitfYaM8Pu)xeifZDipnMF)9uzqHNTqeR4Ws0C1mHC4CfxKMb6RCilgggMXuodoe2o1h2EKGNcB0R)a7(JRo2EIyHe0yGfk5GJ0)VR()hJlckaMczo1NHVsO(v3bjtrLkZLfYt5zZmpdpAwfEwj5rrmzM5cSxUa(yaBAEyO9I5mhYf9VA053CfSV(vAUKEeCbZzXXxgu6qz5tz3Ysveql(Doe3ENsSDj2No2E1MJKm9MKr9VcoUuAcRuD92WnXOXQzoKC0kjZJPlaRrHVVY0ugJ3xeNNKUY1HOhtMsJFo4qqmacwhd6LXUINaN1uWSJ5rPRcWq8rFGygaSVXSOvzNybvNNb1D9JPzzO(G)6JlMKdz1QqOz3nxnJFpBZfHLNwwKupRAPZQw6SQLoREiuSPWQcEcvX03Spn24KMQcCnZt9dIGec5lZPswH355XXfEtMXb1isTdzsGblGqn3hkBZNxPkbTXbyEua1jKurkQKqrv6OhevI1rUbpcDDDu(imQNcbUu15qLg4dKXNE2L3qajyXHLvW2dhvDhvf5hRvmKhzcVkH)TvzjlRUh2fYEqR1F97F7R(UFfI64lDMUO30P5NjcFoualHkfO6KQOMYCDhZ54QghK0BC)(dWgtEWeEaucHMTXiUmvBdOAs)RyPr4UD)iWbVRwtiQP5SgFM2Ad41AxL0aEEgebo8WQmdA91AZibqxbUORPjjJHNrwvpJo8chucLNU7sVSXD3K3urUSBwKRI5ywD4n2xD5G(W5jGguDE36OgHLc4zytNn7o4L)8x(M1bQQxsP0I0qMeVdhY5s(9fEFsonatAawOTUJ91u2RbZ8ZZuIe86VzEaw9tYl)gmwbg19nPxYPW7nI3rceUaSsgnc7DQJ4vhh8nG(zcRgR5nGTzeYDgpaJk8ewWQSLdXAj0wVzuvH31Lw22GexhuTYacZt1oAHxBTs7LKf5IzG9YyPqj(EhCWbDk(4cpZNybayu4LbThUr584GtcPXzSNSsIqHSWJFI1EpJPgKN8muORzjtHWr7ofEbIvIUXHMOLYfHUpbuwR5yrMc7ZcfT5DEYdvLh2UMAfENCcyCAdhUl1mw6dvP6tnFqjZzpz7sovYOVOH9H7z1IR9YQN4H1VPcpkiMx7QGSXGB9h)0p8QV)3ATvt(Y0BbG3BGQT2LoxdwJKPYLqECdNzn7QsMQKgSzzve0W37ItTDVM8m3jxCjuZmEzbOPKTSylpT8HYcYAmTRrT2inFd8T6gTBz2MfVwa16d236qdpvdtV0iz8xagkpCHd5Q(NBVgLXthABp8AdlaqFbnbs3lGKqmAI1zo2zIG6q7g(KGKJ7k97EA3hJab3XQ4j0q6BoaWlbMJjskqwoz5tBYjunKWBXCb48eyMrZGVLHeAMDPgo)24cQXUSBsVIDzNKh)aG27aXs9G)Amk)9p(Z7WOVnqQuVg4HSqVpynQOmiAcKsG3PBWMujvzSzeqa8PVRdyVofttnXnXI04aYnpS(dqmmM7)wsf9EU3bGIfErqFtjy3Eac5hS)Nv81F1N)HTWxqGY93hrZse3YWVPXjfEAgGAaVTBJiMdGvB3Y4oT60PofH7DviUEBhoDt(T1Wtr092zqOpn6a0Gx6Nw7zvDxT8BTnCDOwnkwmLg3UvYcx)Kax4SATmA15HAmhUkv7xJaVZSaBBQHx7p(ATrkQXe0WKlVDq)BFuVDb)VjmwePEe0rUyf8FdtPUZSaBczBycYpCYe2JV(8(570mPBYn0aV1d4t(pLB4)j)YdqRBHq2XhHrnN)5d
```

# 安装AHK并启动
* AHK: https://www.autohotkey.com/
* 配置你的tradeDispenser
* 打开 `AFK.ahk`,然后在战网界面(或游戏内)按快捷键启动
  * 按 `Ctrl + T` 启动 
  * 按 `Ctrl + U` 启动