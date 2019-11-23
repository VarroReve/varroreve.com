## 需求

[http://172.16.3.1:8091/task-view-575.html](http://172.16.3.1:8091/task-view-575.html)

## 大体思路

在新用户创建后，记录用户的 IP 地址，然后分发一个异步任务到队列，更新用户的 GEO 信息

项目中有多个地方都在创建用户，在每个创建用户的地方都加上记录 IP、更新 GEO 信息的代码很麻烦。使用 Laravel 框架提供的方法，可以在用户模型中统一处理，而不用修改其他的代码

```php
<?php

namespace App\Models\Shop;

class User extends BaseModel
{
    // 模型的初始化方法
    protected static function boot()
    {
        parent::boot();

        // 在「创建用户时」设置用户的「语言偏好」、「IP 地址」等属性
        static::creating(function (self $user) {
            $user->ip = Request::ip();
            $user->locale = App::getLocale();
        });

        // 在「创建用户后」分发异步任务到队列, 更新用户的国家信息
        static::created(function (self $user) {
            dispatch(new UpateUserGeo($user));
        });
    }
}
```



## 目前存在的问题

- API 和 Service 项目中都有创建用户的代码，需要把 Service 中的代码转移到 API，统一管理
- 站内方案中的前端代码在调用 Service 获取优惠券的接口时，有一定几率同时发起两次请求，接口会尝试创建两个一样的用户，但因为 `oo_user` 表有唯一索引，最终导致代码报错


## 具体实施方案

### 将 Service 项目中涉及到创建用户的代码转移到 API，目前发现有四处：

   ```php
   app/Models/Shop/User.php:225
   app/Http/Controllers/Api/Coupon/CouponApi.php:882
   app/Http/Controllers/Api/Coupon/CouponApi.php:1051
   app/Http/Controllers/Api/PopupEmailController.php:73
   ```

### 与前端配合，修复站内方案中发起重复请求的 BUG。目前发现的有问题的专题页：

   ```
   https://www.firmoo.com/promo-yxn.html
   https://www.firmoo.com/promo-yxb.html
   https://www.firmoo.com/promo-zm995.html
   https://www.firmoo.com/promo-new-customer.html
   https://www.firmoo.com/z/buy-one-get-one-free.html
   https://www.firmoo.com/blue-light-blocking-glasses.html
   https://www.firmoo.com/eyeglasses-p-4788.html?color=12967&is_package=4169
   ```

### 修改 `oo_user` 表结构，添加索引

`oo_user` 表里已经有 `countries_id` 字段了，在用户下单成功后，会将订单的 `countries_id` 更新到 `oo_user` 表中。

需要另外新加字段记录根据 IP 匹配到的国家 ID。

### 记录用户 IP 地址，匹配用户国家信息

可以按照上述方法，在用户模型中统一处理

### 用户分组新增 IP 归属地筛选

## 工时评估

- 转移 Service 项目代码、修复 BUG：1.5 天
- 记录用户 IP 地址，匹配用户国家信息：5 小时
- 用户分组新增 IP 归属地筛选：4 小时