---
title: resume
date: 2019-07-13 09:17:16
---
testing testing 123

[click this to download PDF](http://cdn.sakyavarro.cn/resume.pdf)


# Clean Code PHP

## Table of Contents

  1. [Introduction](#introduction)
  2. [Variables](#variables)
     * [Use meaningful and pronounceable variable names](#use-meaningful-and-pronounceable-variable-names)
     * [Use the same vocabulary for the same type of variable](#use-the-same-vocabulary-for-the-same-type-of-variable)
     * [Use searchable names (part 1)](#use-searchable-names-part-1)
     * [Use searchable names (part 2)](#use-searchable-names-part-2)
     * [Use explanatory variables](#use-explanatory-variables)
     * [Avoid nesting too deeply and return early (part 1)](#avoid-nesting-too-deeply-and-return-early-part-1)
     * [Avoid nesting too deeply and return early (part 2)](#avoid-nesting-too-deeply-and-return-early-part-2)
     * [Avoid Mental Mapping](#avoid-mental-mapping)
     * [Don't add unneeded context](#dont-add-unneeded-context)
     * [Use default arguments instead of short circuiting or conditionals](#use-default-arguments-instead-of-short-circuiting-or-conditionals)
  3. [Comparison](#comparison)
     * [Use identical comparison](#use-identical-comparison)
  4. [Functions](#functions)
     * [Function arguments (2 or fewer ideally)](#function-arguments-2-or-fewer-ideally)
     * [Functions should do one thing](#functions-should-do-one-thing)
     * [Function names should say what they do](#function-names-should-say-what-they-do)
     * [Functions should only be one level of abstraction](#functions-should-only-be-one-level-of-abstraction)
     * [Don't use flags as function parameters](#dont-use-flags-as-function-parameters)
     * [Avoid Side Effects](#avoid-side-effects)
     * [Don't write to global functions](#dont-write-to-global-functions)
     * [Don't use a Singleton pattern](#dont-use-a-singleton-pattern)
     * [Encapsulate conditionals](#encapsulate-conditionals)
     * [Avoid negative conditionals](#avoid-negative-conditionals)
     * [Avoid conditionals](#avoid-conditionals)
     * [Avoid type-checking (part 1)](#avoid-type-checking-part-1)
     * [Avoid type-checking (part 2)](#avoid-type-checking-part-2)
     * [Remove dead code](#remove-dead-code)
  5. [Objects and Data Structures](#objects-and-data-structures)
     * [Use object encapsulation](#use-object-encapsulation)
     * [Make objects have private/protected members](#make-objects-have-privateprotected-members)
  6. [Classes](#classes)
     * [Prefer composition over inheritance](#prefer-composition-over-inheritance)
     * [Avoid fluent interfaces](#avoid-fluent-interfaces)
     * [Prefer `final` classes](#prefer-final-classes)
  7. [SOLID](#solid)
     * [Single Responsibility Principle (SRP)](#single-responsibility-principle-srp)
     * [Open/Closed Principle (OCP)](#openclosed-principle-ocp)
     * [Liskov Substitution Principle (LSP)](#liskov-substitution-principle-lsp)
     * [Interface Segregation Principle (ISP)](#interface-segregation-principle-isp)
     * [Dependency Inversion Principle (DIP)](#dependency-inversion-principle-dip)
  8. [Don’t repeat yourself (DRY)](#dont-repeat-yourself-dry)
  9. [Translations](#translations)

## Introduction

Software engineering principles, from Robert C. Martin's book
[*Clean Code*](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882),
adapted for PHP. This is not a style guide. It's a guide to producing
readable, reusable, and refactorable software in PHP.

Not every principle herein has to be strictly followed, and even fewer will be universally 
agreed upon. These are guidelines and nothing more, but they are ones codified over many 
years of collective experience by the authors of *Clean Code*.

Inspired from [clean-code-javascript](https://github.com/ryanmcdermott/clean-code-javascript).

Although many developers still use PHP 5, most of the examples in this article only work with PHP 7.1+.

## Variables

### Use meaningful and pronounceable variable names

**Bad:**

```php
$ymdstr = $moment->format('y-m-d');
```

**Good:**

```php
$currentDate = $moment->format('y-m-d');
```

**[⬆ back to top](#table-of-contents)**

### Use the same vocabulary for the same type of variable

**Bad:**

```php
getUserInfo();
getUserData();
getUserRecord();
getUserProfile();
```

**Good:**

```php
getUser();
```

**[⬆ back to top](#table-of-contents)**

### Use searchable names (part 1)

We will read more code than we will ever write. It's important that the code we do write is 
readable and searchable. By *not* naming variables that end up being meaningful for 
understanding our program, we hurt our readers.
Make your names searchable.

**Bad:**

```php
// What the heck is 448 for?
$result = $serializer->serialize($data, 448);
```

**Good:**

```php
$json = $serializer->serialize($data, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
```

### Use searchable names (part 2)

**Bad:**

```php
class User
{
    // What the heck is 7 for?
    public $access = 7;
}

// What the heck is 4 for?
if ($user->access & 4) {
    // ...
}

// What's going on here?
$user->access ^= 2;
```

**Good:**

```php
class User
{
    const ACCESS_READ = 1;
    const ACCESS_CREATE = 2;
    const ACCESS_UPDATE = 4;
    const ACCESS_DELETE = 8;

    // User as default can read, create and update something
    public $access = self::ACCESS_READ | self::ACCESS_CREATE | self::ACCESS_UPDATE;
}

if ($user->access & User::ACCESS_UPDATE) {
    // do edit ...
}

// Deny access rights to create something
$user->access ^= User::ACCESS_CREATE;
```

**[⬆ back to top](#table-of-contents)**

### Use explanatory variables

**Bad:**

```php
$address = 'One Infinite Loop, Cupertino 95014';
$cityZipCodeRegex = '/^[^,]+,\s*(.+?)\s*(\d{5})$/';
preg_match($cityZipCodeRegex, $address, $matches);

saveCityZipCode($matches[1], $matches[2]);
```

**Not bad:**

It's better, but we are still heavily dependent on regex.

```php
$address = 'One Infinite Loop, Cupertino 95014';
$cityZipCodeRegex = '/^[^,]+,\s*(.+?)\s*(\d{5})$/';
preg_match($cityZipCodeRegex, $address, $matches);

[, $city, $zipCode] = $matches;
saveCityZipCode($city, $zipCode);
```

**Good:**

Decrease dependence on regex by naming subpatterns.

```php
$address = 'One Infinite Loop, Cupertino 95014';
$cityZipCodeRegex = '/^[^,]+,\s*(?<city>.+?)\s*(?<zipCode>\d{5})$/';
preg_match($cityZipCodeRegex, $address, $matches);

saveCityZipCode($matches['city'], $matches['zipCode']);
```

**[⬆ back to top](#table-of-contents)**

### Avoid nesting too deeply and return early (part 1)

Too many if-else statements can make your code hard to follow. Explicit is better
than implicit.

**Bad:**

```php
function isShopOpen($day): bool
{
    if ($day) {
        if (is_string($day)) {
            $day = strtolower($day);
            if ($day === 'friday') {
                return true;
            } elseif ($day === 'saturday') {
                return true;
            } elseif ($day === 'sunday') {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    } else {
        return false;
    }
}
```

**Good:**

```php
function isShopOpen(string $day): bool
{
    if (empty($day)) {
        return false;
    }

    $openingDays = [
        'friday', 'saturday', 'sunday'
    ];

    return in_array(strtolower($day), $openingDays, true);
}
```

**[⬆ back to top](#table-of-contents)**

### Avoid nesting too deeply and return early (part 2)

**Bad:**

```php
function fibonacci(int $n)
{
    if ($n < 50) {
        if ($n !== 0) {
            if ($n !== 1) {
                return fibonacci($n - 1) + fibonacci($n - 2);
            } else {
                return 1;
            }
        } else {
            return 0;
        }
    } else {
        return 'Not supported';
    }
}
```

**Good:**

```php
function fibonacci(int $n): int
{
    if ($n === 0 || $n === 1) {
        return $n;
    }

    if ($n >= 50) {
        throw new \Exception('Not supported');
    }

    return fibonacci($n - 1) + fibonacci($n - 2);
}
```

**[⬆ back to top](#table-of-contents)**

### Avoid Mental Mapping

Don’t force the reader of your code to translate what the variable means.
Explicit is better than implicit.

**Bad:**

```php
$l = ['Austin', 'New York', 'San Francisco'];

for ($i = 0; $i < count($l); $i++) {
    $li = $l[$i];
    doStuff();
    doSomeOtherStuff();
    // ...
    // ...
    // ...
    // Wait, what is `$li` for again?
    dispatch($li);
}
```

**Good:**

```php
$locations = ['Austin', 'New York', 'San Francisco'];

foreach ($locations as $location) {
    doStuff();
    doSomeOtherStuff();
    // ...
    // ...
    // ...
    dispatch($location);
}
```

**[⬆ back to top](#table-of-contents)**

### Don't add unneeded context

If your class/object name tells you something, don't repeat that in your
variable name.

**Bad:**

```php
class Car
{
    public $carMake;
    public $carModel;
    public $carColor;

    //...
}
```

**Good:**

```php
class Car
{
    public $make;
    public $model;
    public $color;

    //...
}
```

**[⬆ back to top](#table-of-contents)**

### Use default arguments instead of short circuiting or conditionals

**Not good:**

This is not good because `$breweryName` can be `NULL`.

```php
function createMicrobrewery($breweryName = 'Hipster Brew Co.'): void
{
    // ...
}
```

**Not bad:**

This opinion is more understandable than the previous version, but it better controls the value of the variable.

```php
function createMicrobrewery($name = null): void
{
    $breweryName = $name ?: 'Hipster Brew Co.';
    // ...
}
```

**Good:**

 You can use [type hinting](http://php.net/manual/en/functions.arguments.php#functions.arguments.type-declaration) and be sure that the `$breweryName` will not be `NULL`.

```php
function createMicrobrewery(string $breweryName = 'Hipster Brew Co.'): void
{
    // ...
}
```

**[⬆ back to top](#table-of-contents)**

## Comparison

### Use [identical comparison](http://php.net/manual/en/language.operators.comparison.php)

**Not good:**

The simple comparison will convert the string in an integer.

```php
$a = '42';
$b = 42;

if ($a != $b) {
   // The expression will always pass
}
```

The comparison `$a != $b` returns `FALSE` but in fact it's `TRUE`!
The string `42` is different than the integer `42`.

**Good:**

The identical comparison will compare type and value.

```php
$a = '42';
$b = 42;

if ($a !== $b) {
    // The expression is verified
}
```

The comparison `$a !== $b` returns `TRUE`.

**[⬆ back to top](#table-of-contents)**


## Functions

### Function arguments (2 or fewer ideally)

Limiting the amount of function parameters is incredibly important because it makes 
testing your function easier. Having more than three leads to a combinatorial explosion 
where you have to test tons of different cases with each separate argument.

Zero arguments is the ideal case. One or two arguments is ok, and three should be avoided. 
Anything more than that should be consolidated. Usually, if you have more than two 
arguments then your function is trying to do too much. In cases where it's not, most 
of the time a higher-level object will suffice as an argument.

**Bad:**

```php
function createMenu(string $title, string $body, string $buttonText, bool $cancellable): void
{
    // ...
}
```

**Good:**

```php
class MenuConfig
{
    public $title;
    public $body;
    public $buttonText;
    public $cancellable = false;
}

$config = new MenuConfig();
$config->title = 'Foo';
$config->body = 'Bar';
$config->buttonText = 'Baz';
$config->cancellable = true;

function createMenu(MenuConfig $config): void
{
    // ...
}
```

**[⬆ back to top](#table-of-contents)**

### Functions should do one thing

This is by far the most important rule in software engineering. When functions do more 
than one thing, they are harder to compose, test, and reason about. When you can isolate 
a function to just one action, they can be refactored easily and your code will read much 
cleaner. If you take nothing else away from this guide other than this, you'll be ahead 
of many developers.

**Bad:**
```php
function emailClients(array $clients): void
{
    foreach ($clients as $client) {
        $clientRecord = $db->find($client);
        if ($clientRecord->isActive()) {
            email($client);
        }
    }
}
```

**Good:**

```php
function emailClients(array $clients): void
{
    $activeClients = activeClients($clients);
    array_walk($activeClients, 'email');
}

function activeClients(array $clients): array
{
    return array_filter($clients, 'isClientActive');
}

function isClientActive(int $client): bool
{
    $clientRecord = $db->find($client);

    return $clientRecord->isActive();
}
```

**[⬆ back to top](#table-of-contents)**

### Function names should say what they do

**Bad:**

```php
class Email
{
    //...

    public function handle(): void
    {
        mail($this->to, $this->subject, $this->body);
    }
}

$message = new Email(...);
// What is this? A handle for the message? Are we writing to a file now?
$message->handle();
```

**Good:**

```php
class Email 
{
    //...

    public function send(): void
    {
        mail($this->to, $this->subject, $this->body);
    }
}

$message = new Email(...);
// Clear and obvious
$message->send();
```

**[⬆ back to top](#table-of-contents)**

### Functions should only be one level of abstraction

When you have more than one level of abstraction your function is usually
doing too much. Splitting up functions leads to reusability and easier
testing.

**Bad:**

```php
function parseBetterJSAlternative(string $code): void
{
    $regexes = [
        // ...
    ];

    $statements = explode(' ', $code);
    $tokens = [];
    foreach ($regexes as $regex) {
        foreach ($statements as $statement) {
            // ...
        }
    }

    $ast = [];
    foreach ($tokens as $token) {
        // lex...
    }

    foreach ($ast as $node) {
        // parse...
    }
}
```

**Bad too:**

We have carried out some of the functionality, but the `parseBetterJSAlternative()` function is still very complex and not testable.

```php
function tokenize(string $code): array
{
    $regexes = [
        // ...
    ];

    $statements = explode(' ', $code);
    $tokens = [];
    foreach ($regexes as $regex) {
        foreach ($statements as $statement) {
            $tokens[] = /* ... */;
        }
    }

    return $tokens;
}

function lexer(array $tokens): array
{
    $ast = [];
    foreach ($tokens as $token) {
        $ast[] = /* ... */;
    }

    return $ast;
}

function parseBetterJSAlternative(string $code): void
{
    $tokens = tokenize($code);
    $ast = lexer($tokens);
    foreach ($ast as $node) {
        // parse...
    }
}
```

**Good:**

The best solution is move out the dependencies of `parseBetterJSAlternative()` function.

```php
class Tokenizer
{
    public function tokenize(string $code): array
    {
        $regexes = [
            // ...
        ];

        $statements = explode(' ', $code);
        $tokens = [];
        foreach ($regexes as $regex) {
            foreach ($statements as $statement) {
                $tokens[] = /* ... */;
            }
        }

        return $tokens;
    }
}

class Lexer
{
    public function lexify(array $tokens): array
    {
        $ast = [];
        foreach ($tokens as $token) {
            $ast[] = /* ... */;
        }

        return $ast;
    }
}

class BetterJSAlternative
{
    private $tokenizer;
    private $lexer;

    public function __construct(Tokenizer $tokenizer, Lexer $lexer)
    {
        $this->tokenizer = $tokenizer;
        $this->lexer = $lexer;
    }

    public function parse(string $code): void
    {
        $tokens = $this->tokenizer->tokenize($code);
        $ast = $this->lexer->lexify($tokens);
        foreach ($ast as $node) {
            // parse...
        }
    }
}
```

**[⬆ back to top](#table-of-contents)**

### Don't use flags as function parameters

Flags tell your user that this function does more than one thing. Functions should 
do one thing. Split out your functions if they are following different code paths 
based on a boolean.

**Bad:**

```php
function createFile(string $name, bool $temp = false): void
{
    if ($temp) {
        touch('./temp/'.$name);
    } else {
        touch($name);
    }
}
```

**Good:**

```php
function createFile(string $name): void
{
    touch($name);
}

function createTempFile(string $name): void
{
    touch('./temp/'.$name);
}
```

**[⬆ back to top](#table-of-contents)**

### Avoid Side Effects

A function produces a side effect if it does anything other than take a value in and 
return another value or values. A side effect could be writing to a file, modifying 
some global variable, or accidentally wiring all your money to a stranger.

Now, you do need to have side effects in a program on occasion. Like the previous 
example, you might need to write to a file. What you want to do is to centralize where 
you are doing this. Don't have several functions and classes that write to a particular 
file. Have one service that does it. One and only one.

The main point is to avoid common pitfalls like sharing state between objects without
any structure, using mutable data types that can be written to by anything, and not 
centralizing where your side effects occur. If you can do this, you will be happier 
than the vast majority of other programmers.

**Bad:**

```php
// Global variable referenced by following function.
// If we had another function that used this name, now it'd be an array and it could break it.
$name = 'Ryan McDermott';

function splitIntoFirstAndLastName(): void
{
    global $name;

    $name = explode(' ', $name);
}

splitIntoFirstAndLastName();

var_dump($name); // ['Ryan', 'McDermott'];
```

**Good:**

```php
function splitIntoFirstAndLastName(string $name): array
{
    return explode(' ', $name);
}

$name = 'Ryan McDermott';
$newName = splitIntoFirstAndLastName($name);

var_dump($name); // 'Ryan McDermott';
var_dump($newName); // ['Ryan', 'McDermott'];
```

**[⬆ back to top](#table-of-contents)**

### Don't write to global functions

Polluting globals is a bad practice in many languages because you could clash with another 
library and the user of your API would be none-the-wiser until they get an exception in 
production. Let's think about an example: what if you wanted to have configuration array?
You could write global function like `config()`, but it could clash with another library 
that tried to do the same thing.

**Bad:**

```php
function config(): array
{
    return  [
        'foo' => 'bar',
    ]
}
```

**Good:**

```php
class Configuration
{
    private $configuration = [];

    public function __construct(array $configuration)
    {
        $this->configuration = $configuration;
    }

    public function get(string $key): ?string
    {
        return isset($this->configuration[$key]) ? $this->configuration[$key] : null;
    }
}
```

Load configuration and create instance of `Configuration` class 

```php
$configuration = new Configuration([
    'foo' => 'bar',
]);
```

And now you must use instance of `Configuration` in your application.

**[⬆ back to top](#table-of-contents)**

### Don't use a Singleton pattern

Singleton is an [anti-pattern](https://en.wikipedia.org/wiki/Singleton_pattern). Paraphrased from Brian Button:
 1. They are generally used as a **global instance**, why is that so bad? Because **you hide the dependencies** of your application in your code, instead of exposing them through the interfaces. Making something global to avoid passing it around is a [code smell](https://en.wikipedia.org/wiki/Code_smell).
 2. They violate the [single responsibility principle](#single-responsibility-principle-srp): by virtue of the fact that **they control their own creation and lifecycle**.
 3. They inherently cause code to be tightly [coupled](https://en.wikipedia.org/wiki/Coupling_%28computer_programming%29). This makes faking them out under **test rather difficult** in many cases.
 4. They carry state around for the lifetime of the application. Another hit to testing since **you can end up with a situation where tests need to be ordered** which is a big no for unit tests. Why? Because each unit test should be independent from the other.

There is also very good thoughts by [Misko Hevery](http://misko.hevery.com/about/) about the [root of problem](http://misko.hevery.com/2008/08/25/root-cause-of-singletons/).

**Bad:**

```php
class DBConnection
{
    private static $instance;

    private function __construct(string $dsn)
    {
        // ...
    }

    public static function getInstance(): DBConnection
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    // ...
}

$singleton = DBConnection::getInstance();
```

**Good:**

```php
class DBConnection
{
    public function __construct(string $dsn)
    {
        // ...
    }

     // ...
}
```

Create instance of `DBConnection` class and configure it with [DSN](http://php.net/manual/en/pdo.construct.php#refsect1-pdo.construct-parameters).

```php
$connection = new DBConnection($dsn);
```

And now you must use instance of `DBConnection` in your application.

**[⬆ back to top](#table-of-contents)**

### Encapsulate conditionals

**Bad:**

```php
if ($article->state === 'published') {
    // ...
}
```

**Good:**

```php
if ($article->isPublished()) {
    // ...
}
```

**[⬆ back to top](#table-of-contents)**

### Avoid negative conditionals

**Bad:**

```php
function isDOMNodeNotPresent(\DOMNode $node): bool
{
    // ...
}

if (!isDOMNodeNotPresent($node))
{
    // ...
}
```

**Good:**

```php
function isDOMNodePresent(\DOMNode $node): bool
{
    // ...
}

if (isDOMNodePresent($node)) {
    // ...
}
```

**[⬆ back to top](#table-of-contents)**

### Avoid conditionals

This seems like an impossible task. Upon first hearing this, most people say,
"how am I supposed to do anything without an `if` statement?" The answer is that
you can use polymorphism to achieve the same task in many cases. The second
question is usually, "well that's great but why would I want to do that?" The
answer is a previous clean code concept we learned: a function should only do
one thing. When you have classes and functions that have `if` statements, you
are telling your user that your function does more than one thing. Remember,
just do one thing.

**Bad:**

```php
class Airplane
{
    // ...

    public function getCruisingAltitude(): int
    {
        switch ($this->type) {
            case '777':
                return $this->getMaxAltitude() - $this->getPassengerCount();
            case 'Air Force One':
                return $this->getMaxAltitude();
            case 'Cessna':
                return $this->getMaxAltitude() - $this->getFuelExpenditure();
        }
    }
}
```

**Good:**

```php
interface Airplane
{
    // ...

    public function getCruisingAltitude(): int;
}

class Boeing777 implements Airplane
{
    // ...

    public function getCruisingAltitude(): int
    {
        return $this->getMaxAltitude() - $this->getPassengerCount();
    }
}

class AirForceOne implements Airplane
{
    // ...

    public function getCruisingAltitude(): int
    {
        return $this->getMaxAltitude();
    }
}

class Cessna implements Airplane
{
    // ...

    public function getCruisingAltitude(): int
    {
        return $this->getMaxAltitude() - $this->getFuelExpenditure();
    }
}
```

**[⬆ back to top](#table-of-contents)**

### Avoid type-checking (part 1)

PHP is untyped, which means your functions can take any type of argument.
Sometimes you are bitten by this freedom and it becomes tempting to do
type-checking in your functions. There are many ways to avoid having to do this.
The first thing to consider is consistent APIs.

**Bad:**

```php
function travelToTexas($vehicle): void
{
    if ($vehicle instanceof Bicycle) {
        $vehicle->pedalTo(new Location('texas'));
    } elseif ($vehicle instanceof Car) {
        $vehicle->driveTo(new Location('texas'));
    }
}
```

**Good:**

```php
function 