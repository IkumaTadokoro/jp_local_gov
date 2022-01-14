[![Gem Version](https://badge.fury.io/rb/jp_local_gov.svg)](https://badge.fury.io/rb/jp_local_gov)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/IkumaTadokoro/jp_local_gov/blob/main/LICENSE.txt)
![Gem](https://img.shields.io/gem/dt/jp_local_gov)

# JpLocalGov

Convert local government code based on JIS X 0402 to local government name in Japan.  
Reference(Japanese): [全国地方公共団体コード \- Wikipedia](https://ja.wikipedia.org/wiki/%E5%85%A8%E5%9B%BD%E5%9C%B0%E6%96%B9%E5%85%AC%E5%85%B1%E5%9B%A3%E4%BD%93%E3%82%B3%E3%83%BC%E3%83%89)

### Issues

If you find any bugs or concerns, or have suggestions for new features, please feel free to add them as an [GitHub Issue](https://github.com/IkumaTadokoro/jp_local_gov/issues/new/choose)!

There are issue templates for bug and feature. If neither, please use the blank template.

### Special Thanks

This gem is based on and inspired by [chocoby/jp_prefecture](https://github.com/chocoby/jp_prefecture).   
And I referenced [kufu/jpostcode-data](https://github.com/kufu/jpostcode-data) for the method of data acquisition.

Thanks!😁

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jp_local_gov'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jp_local_gov

## Usage

### Requirement

```ruby
require 'jp_local_gov'
```

### Search Local Government by Code

Provide local government code to search local government's data.  
Only a String can be used for 'code'.

```ruby
chiyodaku = JpLocalGov.find("131016")
# => #<JpLocalGov::LocalGov:0x00007fe706a8f148 @code="131016", @prefecture_code="13", @prefecture="東京都", @prefecture_kana="トウキョウト", @city="千代田区", @city_kana="チヨダク", @prefecture_capital=false>
chiyodaku.code
# => "131016"
chiyodaku.prefecture_code
# => "13"
chiyodaku.prefecture
# => "東京都"
chiyodaku.prefecture_kana
# => "トウキョウト"
chiyodaku.city
# => "千代田区"
chiyodaku.city_kana
# => "チヨダク"
chiyodaku.prefecture_capital
# => false
```

About prefecture capital: [List of capitals in Japan \- Wikipedia](https://en.wikipedia.org/wiki/List_of_capitals_in_Japan)

### Filtered Search

Use the `where` to enable AND searches with multiple conditions(Hash).  
This search function is an exact match search.

```ruby
misato = JpLocalGov.where(city: "美郷町")
# => [#<JpLocalGov::LocalGov:0x00007fb1c594cb08 @code="054348", @prefecture_code="05", @prefecture="秋田県", @prefecture_kana="アキタケン", @city="美郷町", @city_kana="ミサトチョウ", @prefecture_capital=false>, #<JpLocalGov::LocalGov:8 @code="324485", @prefecture_code="32", @prefecture="島根県", @prefecture_kana="シマネケン", @city="美郷町", @city_kana="ミサトチョウ", @prefecture_capital=false>, #<JpLocalGov::LocalGov:0x00007fb1c1a3ce40 @code="454311", @prefecture="宮崎県", @prefecture_kana="ミヤザキケン", @city="美郷町", @city_kana="ミサトチョウ", @prefecture_capital=false>]
misato.map { "#{_1.prefecture}:#{_1.city}" }
# => ["秋田県:美郷町", "島根県:美郷町", "宮崎県:美郷町"]

JpLocalGov.where(prefecture: "東京都", prefecture_capital: true)
# => [#<JpLocalGov::LocalGov:0x00007fb1c219e418 @code="131041", @prefecture_code="13", @prefecture="東京都", @prefecture_kana="トウキョウト", @city="新宿区", @city_kana="シンジュクク", @prefecture_capital=true>]

JpLocalGov.where(prefecture: "東京")
# => nil
# Exact match search. You should specified "東京都" instead of "東京".
```

The following attributes can be specified for the condition.

| Attributes         | Type          | Examples |
|--------------------|---------------|----------|
| code               | String        | "131016" |
| prefecture_code    | String        | "13"     |
| prefecture         | String        | "東京都"    |
| prefecture_kana    | String        | "トウキョウト" |
| city               | String        | "千代田区"   |
| city_kana          | String        | "チヨダク"   |
| prefecture_capital | true or false | false    |

### All data

You can get all local governments using `JpLocalGov.all`

```ruby
JpLocalGov.all
# =>  [#<JpLocalGov::LocalGov:0x00007fdf3a9c6758 @code="011002", @prefecture_code="01", @prefecture="北海道", @prefecture_kana="ホッカイドウ", @city="札幌市na="サッポロシ", @prefecture_capital=true>, #<JpLocalGov::LocalGov:0x00007fdf3a9c6730 @code="011011",...
```

### Usage on Rails (ActiveRecord)

Include JpLocalGov to Model which ActiveRecord::Base inherited.

```ruby
# app/models/insurance_fee.rb:
class InsuranceFee < ActiveRecord::Base
  # local_gov_code:String

  include JpLocalGov
  jp_local_gov :local_gov_code
end
```

By JpLocalGov included, `local_government` method will be generated:

```ruby
insurance_fee = InsuranceFee.new
insurance_fee.local_gov_code = "131016"
insurance_fee.local_government.city
# => "千代田区"
```

In Migration file, set `local_gov_code` column type to `string`.

```ruby
class AddLocalGovCodeToInsuranceFees < ActiveRecord::Migration
  def change
    add_column :insurance_fees, :local_gov_code, :string
  end
end
```

### Validation

You can use `JpLocalGov.valid_code?(local_gov_code)` in `validate` method.

```ruby
class InsuranceFee < ApplicationRecord
  include JpLocalGov
  jp_local_gov :local_gov_code

  validate :valid_code?

  def valid_code?
    unless JpLocalGov.valid_code?(local_gov_code)
      errors.add(:local_gov_code, "is not valid code")
    end
  end
end
```

This method inspect code by [check digits defined in JISX0402](https://www.soumu.go.jp/main_content/000137948.pdf).
(And also check code is String.)

### View Template

Use `collection_select` to generate selector in view:

```ruby
f.collection_select :local_gov_code, JpLocalGov.all, :code, :city # e.g. code: 131016, city: "千代田区"
```

## Development

### Steps

1. Fork it -> `git clone https://github.com/IkumaTadokoro/jp_local_gov/fork`
2. Run `bin/setup` to install dependencies
3. Create your feature branch
4. Implement feature and run `bin/test`, `bin/lint`, `bin/steep` to check your implementation
5. Push to the branch
6. Create a new Pull Request

### Commands

| Command            | Details                                                                                                  |
|--------------------|----------------------------------------------------------------------------------------------------------|
| `bin/console`      | An interactive prompt that will allow you to experiment                                                  |
| `bin/generate_rbs` | Create rbs file in `/sig` for new ruby files in `/lib`                                                   |
| `bin/test`         | Run `rspec` via Appraisal. <br>To specify the version, use `bin/test <version>`（e.g. `bin/test rails61`） |
| `bin/lint`         | Run Rubocop                                                                                              |
| `bin/steep`        | Run `steep stats` and `steep check`                                                                      |

### Running Test via JetBrains IDE (e.g. RubyMine)

This gem use 'Appraisal' to inspect several versions of Rails.

So you should run rspec by `bundle exec appraisal rspec` and you won't be able to run spec via IDE (only run via your
terminal).

If you use JetBrains IDE and you want to run spec via IDE, try to configure the following steps.

1. Open 「Edit Configurations...」
2. Open 「Edit Configuration templates...」
3. Select 「RSpec」
4. Check 「Use custom RSpec runner script:」 and fill the script with `[CLONE_DIR]/bin/spec_runner.rb`
5. Click「APPLY」, then you can run spec via IDE!!🎉

If you have already run spec via IDE before configuration, delete the existing configuration and try to configure the
above steps

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IkumaTadokoro/jp_local_gov. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/IkumaTadokoro/jp_local_gov/blob/main/CODE_OF_CONDUCT.md).

### Spell Checking

We are running [misspell](https://github.com/client9/misspell) which is mainly written in
[Golang](https://golang.org/) to check spelling with [GitHub Actions](../.github/workflows/spell-checking.yml). Correct
commonly misspelled English words quickly with `misspell`. `misspell` is different from most other spell checkers
because it doesn't use a custom dictionary. You can run `misspell` locally against all files with:

    $ find . -type f | xargs ./misspell -error

Notable `misspell` help options or flags are:

* `-i` string: ignore the following corrections, comma separated
* `-w`: Overwrite file with corrections (default is just to display)

We also run [codespell](https://github.com/codespell-project/codespell) with GitHub Actions to check spelling and
[codespell](https://pypi.org/project/codespell/) runs against a [small custom dictionary](../codespell.txt).
`codespell` is written in [Python](https://www.python.org/) and you can run it with:

    $ codespell --ignore-words=codespell.txt

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JpLocalGov project's codebases, issue trackers, chat rooms and mailing lists is expected to
follow the [code of conduct](https://github.com/IkumaTadokoro/jp_local_gov/blob/main/CODE_OF_CONDUCT.md).
