# JpLocalGov

## Description

Convert local government code to local government name in Japan.

Based on JIS X 0402.

```
Chiyodaku: "131016"
Osakashi: "271004"
```

Reference(Japanese): [全国地方公共団体コード \- Wikipedia](https://ja.wikipedia.org/wiki/%E5%85%A8%E5%9B%BD%E5%9C%B0%E6%96%B9%E5%85%AC%E5%85%B1%E5%9B%A3%E4%BD%93%E3%82%B3%E3%83%BC%E3%83%89)

Also available as a Rails plugin

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
# => [#<JpLocalGov::LocalGov:0x00007fb1c594cb08 @code="054348", @prefecture_code="05", @prefecture="秋田県", @prefecture_kana="アキタケン", @city="美郷町", @city_kana="ミサトチョウ", @prefecture_capital=false>, #<JpLocalGov::LocalGov:8 @code="324485", @prefecture_code="32", @prefecture="島根県", @prefecture_kana="シマネケン", @city="美郷町", @city_kana="ミサトチョウ", @prefecture_capital=false>, #<JpLocalGov::LocalGov:0x00007fb1c1a3ce40 @code="454311", @prefectuefecture="宮崎県", @prefecture_kana="ミヤザキケン", @city="美郷町", @city_kana="ミサトチョウ", @prefecture_capital=false>]
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

### Usage on Rails (ActiveRecord)

Include JpLocalGov to Model which ActiveRecord::Base inherited.

```ruby
# app/models/insurrance_fees.rb:
class Place < ActiveRecord::Base
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
class AddLocalGovCodeToinsuranceFees < ActiveRecord::Migration
  def change
    add_column :insurance_fees, :local_gov_code, :string
  end
end
```

## Development

1. Fork it -> `git clone https://github.com/IkumaTadokoro/jp_local_gov/fork`
2. Run `bin/setup` to install dependencies
3. Create your feature branch
4. Implement feature and add commit to your branch
    - You can run `bin/console` for an interactive prompt that will allow you to experiment.
    - You can run `bin/generate_rbs` to create rbs file in `/sig` for new ruby files in `/lib`.
5. Run the following command to check your implementation
    - `bin/test`: run `rspec` via Appraisal. If you want to specified version then `bin/test <version>`（e.g. `bin/test rails61`）.
    - `bin/lint`: run Rubocop
    - `bin/steep`: run `steep stats` and `steep check`
6. Push to the branch
7. Create a new Pull Request

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jp_local_gov. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/jp_local_gov/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JpLocalGov project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jp_local_gov/blob/main/CODE_OF_CONDUCT.md).

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
