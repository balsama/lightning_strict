# Lightning Strict 

This package will lock all of the dependencies defined by Lightning to the
specific versions that were used in testing each Lightning release.

## Usage

```
composer require balsama/lightning_strict:VERSION --no-update
composer update
```

## Motivation
Lightning 2.2.0 required `drupal/core:~8.4.0` which translates roughly to

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

## Inspiration
This was inspired by and largely copies most of its code from [webflo's](https://github.com/webflo)
awesome [drupal-core-strict project](https://github.com/webflo/drupal-core-strict).
Thank you.
