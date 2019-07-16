---
title: 在 Laravel 中使用 Omnipay 接入 PayPal 支付 - 退款
date: 2019-07-11 20:44:16
tags:
- paypal
- omnipay
categories: pay
thumbnail: https://s2.ax1x.com/2019/07/14/Z5TZ6K.md.jpg
---
> Omnipay 的文档实在是太少了，需要看源码才能知道如何使用
<!-- more -->

## 安装

### 安装 omnipay/paypal
> composer require omnipay/paypal

### 安装 ignited/laravel-omnipay
> composer require ignited/laravel-omnipay

## 配置

> php artisan vendor:publish --provider="Ignited\LaravelOmnipay\LaravelOmnipayServiceProvider" --tag=config

```php
// config/laravel-omnipay.php

<?php

return [

    // The default gateway to use
    'default'  => 'paypal',

    // Add in each gateway here
    'gateways' => [
        'paypal' => [
            'driver'  => 'PayPal_Rest',
            'options' => [
                'clientId' => env('PAYPAL_REST_CLIENT_ID'),
                'secret'   => env('PAYPAL_REST_SECRET'),
                'testMode' => env('PAYMENT_SANDBOX', false), // Or false when you are ready for live transactions
            ],
        ],
    ],

];
```
## 使用

### 初始化

```php
$gateway = \Omnipay::gateway('paypal');
```

### 获取交易列表

```php
$start_time = new \DateTime('yesterday');
$end_time = new \DateTime('now');

$transaction = $gateway->listPurchase([
    'startTime' => $start_time,
    'endTime'   => $end_time,
]);

$response = $transaction->send();
$data = $response->getData();

echo "Gateway listPurchase response data == " . print_r($data, true) . "\n";
```

### 退款

```php
$transaction = $gateway->refund([
    'amount'   => '1.00',
    'currency' => 'USD',
]);

$transaction->setTransactionReference($sale_id);

$response = $transaction->send();

if ($response->isSuccessful()) {
    echo "Refund transaction was successful!\n";
    $data = $response->getData();
    echo "Gateway refund response data == " . print_r($data, true) . "\n";
}
```
