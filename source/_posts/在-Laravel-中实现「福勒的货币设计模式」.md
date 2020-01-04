---
title: 在 Laravel 中实现「福勒的货币设计模式」
date: 2019-12-02 14:16:45
thumbnail: https://s2.ax1x.com/2019/12/03/QKGYSP.md.jpg
tags:
- 货币模式
- Laravel
- Money Pattern
category: Laravel
---

> “这个世界上有很大比例的计算机都在操纵金钱，因此，我一直感到困惑的是，金钱实际上并不是任何主流编程语言中的一流数据类型。 缺乏类型会导致问题，这是最明显的周边货币。 如果您所有的计算都是用一种货币完成的，那么这并不是一个大问题，但是一旦涉及多种货币，您就希望避免在不考虑货币差异的情况下将美元加到日元中。 更细微的问题是舍入。 货币计算通常四舍五入为最小的货币单位。 执行此操作时，由于舍入错误，很容易损失几美分（或您当地的等值货币）“ -- [马丁福勒的货币设计模式（Flower's money pattern）](https://www.martinfowler.com/eaaCatalog/money.html)

## 为什么要使用货币类

相比于使用 float 类来存储货币的传统做法，使用货币类（Money library）可以照顾到处理金钱的所有细微复杂之处，比如四舍五入、金额计算、汇率换算、货币格式化输出等

## 货币模式在 Laravel 中的使用

```php
<?php

namespace App\Http\Controllers;

use App\Support\Money;

class TestController extends Controller
{
    public function index()
    {
        // 从容器中新建一个价值为 1000 美元的货币类, 其单位为「分」
        $money = app(Money::class, [100000, 'USD']);

        // 格式化输出
        $money->value(); // 1000.00
        $money->format(); // $1,000.00

        // 货币运算
        $money2 = app(Money::class, [5000, 'USD']);
        $money->add($money2)->format(); // $1,050.00
        $money->divide(10)->format(); // $100.00

        // 根据实时汇率换算为人民币
        $money->convertTo('CNY')->format(); // CN¥7,028.70

        // 根据固定汇率换算
        $exchangeRate = [
            'USD' => [
                'EUR' => 0.7,
                'CNY' => 8.7654321,
            ],
        ];

        $money->fixedConvertTo('EUR', $exchangeRate)->format(); // €700.00
        $money->fixedConvertTo('CNY', $exchangeRate)->format(); // CN¥8,765.43

        // 从字符串解析货币
        Money::parse('$300')->format(); // $300.00
    }
}

```



## 在 Laravel 中实现货币模式

###  cknow/laravel-money

`moneyphp/money`是货币模式的主要实现，`cknow/laravel-money`在其之上做了 Laravel 框架的拓展

#### 安装

```bash
$ composer require cknow/laravel-money
```

#### 发布配置文件

```bash
$ php artisan vendor:publish --provider="Cknow\Money\MoneyServiceProvider"
```

内容如下：

```php
# config/money.php

<?php

return [
    /*
     |--------------------------------------------------------------------------
     | Laravel money
     |--------------------------------------------------------------------------
     */
    'locale' => config('app.locale', 'en_US'), // 默认地区
    'currency' => config('app.currency', 'USD'), // 默认币种
];
```

### florianv/laravel-swap

`florianv/swap` 支持请求多种三方 API 获取汇率，并写入缓存，最终完成货币的汇率换算。`florianv/laravel-swap` 是对 `florianv/swap` 在 Laravel 框架的封装

#### 安装

```bash
$ composer require florianv/laravel-swap
```

#### 发布配置文件

```bash
$ php artisan vendor:publish --provider="Swap\Laravel\SwapServiceProvider"
```

```php
# config/swap.php

<?php

......

return [

    // 使用哪种缓存驱动
    'cache'           => 'redis',
	
    // 缓存过期时间
    'options' => [
        'cache_ttl' => 12 * 60 * 60,
    ],


    // 汇率 API, 我使用的是 currency_converter, 需要在此处填入你自己的服务商秘钥
    'services'        => [
        'currency_converter' => [
            'access_key' => 'key',
            'enterprise' => false,
        ],
    ],
];

```

### Money Service Provider

`cknow/laravel-money` 和 `florianv/laravel-swap` 的使用方式有些繁琐。通过 Laravel 的服务容器可以简化许多操作。

```php
# app/Providers/MoneyServiceProvider.php

<?php

namespace App\Providers;

use Money\Currency;
use Money\Converter;
use App\Support\Money;
use Money\Exchange\SwapExchange;
use Money\Exchange\FixedExchange;
use Money\Currencies\ISOCurrencies;
use Money\Formatter\DecimalMoneyFormatter;
use Illuminate\Contracts\Foundation\Application;
use Cknow\Money\MoneyServiceProvider as CknowMoneyServiceProvider;

class MoneyServiceProvider extends CknowMoneyServiceProvider
{
    public function boot()
    {
        // 为货币类设置默认地区
        Money::setLocale(config('money.locale'));

        // 为货币类设置默认币种
        Money::setCurrency(config('money.currency'));
    }

    public function register()
    {
        /*
        |--------------------------------------------------------------------------
        | 绑定 ISO Currency
        |--------------------------------------------------------------------------
        |
        | ISO 标准货币币种列表
        |
        */

        $this->app->singleton(ISOCurrencies::class, static function (Application $app) {
            return new ISOCurrencies();
        });

        $this->app->alias(ISOCurrencies::class, 'iso_currencies');

        /*
        |--------------------------------------------------------------------------
        | 绑定 Currency
        |--------------------------------------------------------------------------
        |
        | 货币币种
        |
        */

        $this->app->bind(Currency::class, static function (Application $app, array $parameters = []) {
            $currencyCode = current($parameters);

            return new Currency($currencyCode ?: \Cknow\Money\Money::getCurrency());
        });

        $this->app->alias(Currency::class, 'currency');

        /*
        |--------------------------------------------------------------------------
        | 绑定 Fixed Exchange
        |--------------------------------------------------------------------------
        |
        | 固定汇率货币换算服务
        |
        */

        $this->app->bind(FixedExchange::class, static function (Application $app, array $exchangeRate = []) {
            return new FixedExchange($exchangeRate);
        });

        $this->app->alias(FixedExchange::class, 'fixed_exchange');

        /*
        |--------------------------------------------------------------------------
        | 绑定 Swap Exchange
        |--------------------------------------------------------------------------
        |
        | 动态汇率货币换算服务
        |
        */

        $this->app->singleton(SwapExchange::class, static function (Application $app) {
            return new SwapExchange($app->get('swap'));
        });

        $this->app->alias(SwapExchange::class, 'swap_exchange');

        /*
        |--------------------------------------------------------------------------
        | 绑定 Fixed Converter
        |--------------------------------------------------------------------------
        |
        | 固定汇率货币换算器
        |
        */

        $this->app->bind('fixed_converter', static function (Application $app, array $exchangeRate = []) {
            return new Converter($app->get('iso_currencies'), $app->make('fixed_exchange', $exchangeRate));
        });

        /*
        |--------------------------------------------------------------------------
        | 绑定 Swap Converter
        |--------------------------------------------------------------------------
        |
        | 动态汇率货币换算器
        |
        */

        $this->app->singleton('swap_converter', static function (Application $app) {
            return new Converter($app->get('iso_currencies'), $app->get('swap_exchange'));
        });

        /*
        |--------------------------------------------------------------------------
        | 绑定 Decimal Money Formatter
        |--------------------------------------------------------------------------
        |
        | 默认的货币打印格式 - 小数格式
        |
        */

        $this->app->singleton(DecimalMoneyFormatter::class, static function (Application $app) {
            return new DecimalMoneyFormatter(app('iso_currencies'));
        });

        $this->app->alias(DecimalMoneyFormatter::class, 'decimal_money_formatter');

        /*
        |--------------------------------------------------------------------------
        | 绑定 Money
        |--------------------------------------------------------------------------
        |
        | 货币类
        |
        */

        $this->app->bind(Money::class, static function (Application $app, array $parameters = []) {
            $amount = current($parameters);
            $currencyCode = next($parameters);

            $currency = $app->make(Currency::class, [$currencyCode]);

            return new Money($amount, $currency);
        });

        $this->app->alias(Money::class, 'money');
    }
}

```

### 封装自己的货币类

根据自己的情况实现一些方法，方便使用

```php
# app/Support/Money.php

<?php

namespace App\Support;

use Money\Currency;
use Cknow\Money\Money as BaseMoney;
use Money\Formatter\DecimalMoneyFormatter;

class Money extends BaseMoney
{
    /**
     * 根据动态汇率换算金额.
     *
     * @param  string  $currency 要换算的币种
     *
     * @return self
     */
    public function convertTo(string $currency): self
    {
        $money = app('swap_converter')->convert($this->money, app(Currency::class, [$currency]));

        return $this->rebuild($money);
    }

    /**
     * 根据固定汇率换算金额.
     *
     * @param  string  $currency 要换算的币种
     * @param  array  $exchangeRate 自定义的汇率
     *
     * @return self
     */
    public function fixedConvertTo(string $currency, array $exchangeRate): self
    {
        $money = app('fixed_converter', $exchangeRate)->convert($this->money, app(Currency::class, [$currency]));

        return $this->rebuild($money);
    }

    /**
     * 以小数形式输出金额.
     *
     * @return string
     */
    public function value(): string
    {
        return app(DecimalMoneyFormatter::class)->format($this->money);
    }

    /**
     * 将 \Money\Money 类转换为 \App\Support\Money 类.
     *
     * @param \Money\Money $money
     *
     * @return self
     */
    protected function rebuild($money): self
    {
        $currencyCode = $money->getCurrency()->getCode();

        $amount = $money->getAmount();

        return app(self::class, [$amount, $currencyCode]);
    }

    /**
     * 重写父类魔术方法, 在存入数据库等操作时自动转换为小数.
     *
     * @return string
     */
    public function __toString()
    {
        return $this->value();
    }
}

```

到目前为止，便可以实现文章一开始的货币操作、汇率换算、打印功能

## 在 Eloquent Model 中使用货币类

货币在数据库中一般以浮点数的形式存储，使用 Eloquent Model 的 `cast` 特性，可以在把数据取出来时就把浮点数形式的货币转换为货币类

### vkovic/laravel-custom-casts

`vkovic/laravel-custom-casts` 可以将 Eloquent Model 的属性（数据库的字段）自动转换成自定义的类

#### 安装

```bash
$ composer require vkovic/laravel-custom-casts
```

#### 新建 Money Cast

```php
#app/Models/Casts/MoneyCast.php

<?php

namespace App\Models\Casts;

use App\Support\Money;
use Vkovic\LaravelCustomCasts\CustomCastBase;

class MoneyCast extends CustomCastBase
{
    /**
     * 属性存入数据库时转换为浮点数.
     *
     * @param  Money $money
     *
     * @return string
     */
    public function setAttribute($money)
    {
        if (! $money instanceof Money) {
            return $money;
        }

        return $money->divide(100)->value();
    }

    /**
     * 取出属性时转换为 Money 类.
     *
     * @param $money
     *
     * @return Money
     */
    public function castAttribute($money): Money
    {
        $money = bcmul($money, 100, 4);

        return app(Money::class, [$money]); // 在我的项目中默认币种为 USD, 所以这里省略了第二个参数
    }
}

```

在 `moneyphp/money` 中货币的基本单位为「分」，但我的项目中货币的基本单位为「元」，所以我在取出 / 存入货币时分别乘以 / 除以了 100。

#### 在模型中引入

```php
# app/Models/Order.php

<?php

namespace App\Models;

use App\Models\Casts\MoneyCast;
use Illuminate\Database\Eloquent\Model;
use Vkovic\LaravelCustomCasts\HasCustomCasts;

class Order extends Model
{
    use HasCustomCasts;

    public $casts  = [
        'order_total' => MoneyCast::class // 将订单总金额自动转为货币类
    ];
}

```

#### 使用

```php
<?php

namespace App\Http\Controllers;

use App\Support\Money;

class TestController extends Controller
{
    public function index()
    {
        $order = Order::query()->first();  // 该订单的金额在数据库中为 67.84

        dump($order->order_total); // 该字段已自动从浮点数转为了货币类
        
        dump($order->order_total->format());
    }
}

# 结果

App\Support\Money {#1677 ▼
  #money: Money\Money {#1753 ▼
    -amount: "6784"
    -currency: Money\Currency {#1682 ▼
      -code: "USD"
    }
  }
  #attributes: []
}

"$67.84"
```

## 其他

拓展包 [moneyphp/money](https://packagist.org/packages/moneyphp/money) 还提供了许多其他有用的方法，可以看下它的[官方文档](http://moneyphp.org/en/stable/)

我在使用这个拓展包时根据项目的情况做了一些封装处理，如有不足或更好的实现欢迎指出