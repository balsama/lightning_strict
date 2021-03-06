# Lightning Strict 

This package will lock all of the dependencies defined by Lightning to the
specific versions that were used in testing each Lightning release.

## Usage

```
composer require acquia/lightning:VERSION balsama/lightning_strict:VERSION --no-update
composer update
```

`VERSION` is the specific version of Lightning you want to build. For example,
`2.2.4`, or `3.0.1`. It should be the same for both the `acquia/lightning` and
the `balsama/lightning_strict` packagesYou might need to run `composer update`
more than once for the composer-patches plugin to properly patch all
dependencies.

## Motivation
Lightning 2.2.0 required `drupal/core:~8.4.0` which translates roughly to:

> "Give me the most recent version of core lower than 8.5.0"

At the time of this writing, that would be `8.4.4`. But when Lightning 2.2.0 was
tagged on 4 October 2017, `8.4.0` was the most recent version of drupal/core. So
that tag was actually tested against 8.4.0. This is true for all dependencies of
Lightning - and any project that uses Composer to manage its dependencies.

When using Composer, it's usually best to let your dependencies manage their own
constraints. To allow the highest amount of flexibility and fewest conflicts,
Lightning is intentionally lenient (where it can be) when constraining
dependencies.

However, under certain circumstances, it might be necessary to build a specific
version of Lightning with dependencies exactly as they were when it was
released. For example, you might need an update path that was removed from
Lightning long ago, but building the version might be problematic because a
dependency is no longer available, or a patch no longer applies. In that case,
you can use this package to pin all of Lightning's dependencies (and their
dependencies recursively) to the specific versions included in Lightning's
composer.lock file when it was released.

## PHP Version
Lightning's dependencies are updated in an environment which runs php 7.0. Since
this package is directly based on historical Lightning composer.lock files, that
means that certain dependencies will need at least php 7.0 to run. We've added
a minimum PHP version to the generated composer.json files. Unfortunately, there
is no workaround if your environment uses PHP 5.6.

## Inspiration
This was inspired by and heavily borrows code from [webflo's](https://github.com/webflo)
awesome [drupal-core-strict project](https://github.com/webflo/drupal-core-strict).
Thank you.
