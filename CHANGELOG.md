# [1.0.0](https://github.com/IkumaTadokoro/jp_local_gov/compare/v0.3.1...v1.0.0) (2022-04-18)

[quitcost](https://github.com/IkumaTadokoro/quitcost) was released, which led to the development of this Gem!🎉

According to [semver.org](https://semver.org/#how-do-i-know-when-to-release-100), "If your software is being used in production, it should probably already be 1.0.0.", so we would like to release this Gem as v1.0.0 as well!

### ci

* remove steep stats ([c7b2cb8](https://github.com/IkumaTadokoro/jp_local_gov/commit/c7b2cb89ef3b8b3792a505aec6eb23ea0564401c)), closes [#84](https://github.com/IkumaTadokoro/jp_local_gov/issues/84)

### feat

* add library settings for steep ([57643af](https://github.com/IkumaTadokoro/jp_local_gov/commit/57643af258aef74e2b46eb3feca6c4b012241136))
* add rbs collection ([0c07ac0](https://github.com/IkumaTadokoro/jp_local_gov/commit/0c07ac04217bb3026af82a4de18f3bbd128aa60d))

### fix

* convert nilable argument into String ([971d9c6](https://github.com/IkumaTadokoro/jp_local_gov/commit/971d9c6446e67a38cdae0e1e4a431176464dc5ec))
* remove Gemfile.lock generated by Appraisal ([ddbe46d](https://github.com/IkumaTadokoro/jp_local_gov/commit/ddbe46d05c48d7a2380747193051ab329afbf67e))
* add empty line from data and rake task which creates data ([1c538de](https://github.com/IkumaTadokoro/jp_local_gov/pull/90/commits/1c538dea9933b4d3520b7f8aabbbdf7ffc9d4252) & [6803ba7](https://github.com/IkumaTadokoro/jp_local_gov/pull/92/commits/6803ba736575ce054042cee206f3c5ea636d7348))


# [0.3.1](https://github.com/IkumaTadokoro/jp_local_gov/compare/v0.3.0...v0.3.1) (2022-02-03)


### feat

* Specify ruby version in auto-update workflow ([572fc5e](https://github.com/IkumaTadokoro/jp_local_gov/commit/572fc5e3cd316f5d194dc8affdbf161acd3b864f)), closes [#77](https://github.com/IkumaTadokoro/jp_local_gov/issues/77) [#79](https://github.com/IkumaTadokoro/jp_local_gov/issues/79)

### fix

* Fix JpLocalGov.valid_code?'s condition ([5e1ccf4](https://github.com/IkumaTadokoro/jp_local_gov/commit/5e1ccf4415d5e2e5752d904334e07b550e0d6d5d)), closes [#85](https://github.com/IkumaTadokoro/jp_local_gov/issues/85)

# [0.3.0](https://github.com/IkumaTadokoro/jp_local_gov/compare/v0.2.1...v0.3.0) (2022-01-28)

### feat

* Loosen Ruby version requirement to 2.7.0 ([e3d5f6da](https://github.com/IkumaTadokoro/jp_local_gov/commit/e3d5f6dafcb6665444e81289fcb91ce7d4365a3a))
* Removing `.ruby-version` file lets other devs to use their preferred version of Ruby ([3b3bd483](https://github.com/IkumaTadokoro/jp_local_gov/commit/3b3bd483c167266338fe07d627d58de3d833b37d))

## [0.2.1](https://github.com/IkumaTadokoro/jp_local_gov/compare/v0.2.0...v0.2.1) (2022-01-14)

### docs

* Add how to use JpLocalGov::Random ([aab920b](https://github.com/IkumaTadokoro/jp_local_gov/commit/aab920bc1e460eb7105f4759fcca1f8a8e06b9f7)), closes [#66](https://github.com/IkumaTadokoro/jp_local_gov/issues/66)

### fix

* Fix dependency of JpLocalGov::Random ([6da699b](https://github.com/IkumaTadokoro/jp_local_gov/commit/6da699b9b49c53551e704f0d05cdd269a4566727)), closes [#70](https://github.com/IkumaTadokoro/jp_local_gov/issues/70)

## [0.2.0](https://github.com/IkumaTadokoro/jp_local_gov/compare/v0.1.0...v0.2.0) (2022-01-14)

### chore

* Add RSpec Runner for JetBrains IDE ([83d8c86](https://github.com/IkumaTadokoro/jp_local_gov/commit/83d8c8649f69506c9a08acf275960480316eb988))
* Make JpLocalGov::Data::Importer#prefecture_capital? to return true/false ([82daafd](https://github.com/IkumaTadokoro/jp_local_gov/commit/82daafd19b47e52ff2c1c341a243aef7e5dffae4))

### ci

* Add spell checking GitHub Actions Workflow ([fc23bd1](https://github.com/IkumaTadokoro/jp_local_gov/commit/fc23bd1a3c10cc49f8aaf4e869c0062b50255f03))

### docs

* 💅 ([61c6d66](https://github.com/IkumaTadokoro/jp_local_gov/commit/61c6d66a43b75339036656a1b110dec97156177e))
* Add how to use JpLocalGov.valid_code? ([2e14d71](https://github.com/IkumaTadokoro/jp_local_gov/commit/2e14d71c146d823e4bc3fa268da2e3a0c5f7ebe1))
* Add issue template ([9f416a3](https://github.com/IkumaTadokoro/jp_local_gov/commit/9f416a335247c3be5c52e450b914bd73c380092d)), closes [#47](https://github.com/IkumaTadokoro/jp_local_gov/issues/47)

### feat

* Add JpLocalGov::Random module ([bae16d7](https://github.com/IkumaTadokoro/jp_local_gov/commit/bae16d7b8ebeff1871b2b5586f0b916253c462e7)), closes [#65](https://github.com/IkumaTadokoro/jp_local_gov/issues/65)
* Add JpLocalGov.all_xxx ([f522686](https://github.com/IkumaTadokoro/jp_local_gov/commit/f52268612a5c41435e4a20f3759c9d7d70686a62)), closes [#54](https://github.com/IkumaTadokoro/jp_local_gov/issues/54)
* Make JpLocalGov.valid_code? public ([e46b4e7](https://github.com/IkumaTadokoro/jp_local_gov/commit/e46b4e79f3fd0098bd2b509123f866a92c01ee37)), closes [#55](https://github.com/IkumaTadokoro/jp_local_gov/issues/55)

### fix

* Fix a task(`jp_local_gov:data:update_all`) ([e21125c](https://github.com/IkumaTadokoro/jp_local_gov/commit/e21125cda74c62e7b45b528ee0f908cfbab6b039)), closes [#60](https://github.com/IkumaTadokoro/jp_local_gov/issues/60)

### style

* Add rubocop-rake and rubocop-rspec ([eb5f7d2](https://github.com/IkumaTadokoro/jp_local_gov/commit/eb5f7d22066a65d41d112e60dc8fc7c9b8b71c47))
* omit parentheses for internal DSL(RSpec) ([3c23ec5](https://github.com/IkumaTadokoro/jp_local_gov/commit/3c23ec5a19460e2c8ed496b61536ebd800cfeb03))
* Remove Metrics rule for spec ([e362565](https://github.com/IkumaTadokoro/jp_local_gov/commit/e3625658376a6b0fd8ac5cea97b0d857cd6f6e7b))

## 0.1.0 (2021-11-28)

- Initial release
