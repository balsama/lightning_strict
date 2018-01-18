<?php

class PackageBuilder {

  protected $lock;

  public function __construct($lock) {
    $this->lock = $lock;
  }

  public static function fromLockfile($path) {
    return new static(json_decode(file_get_contents($path), TRUE));
  }

  protected function defaultMetadata() {
    return [
      'name' => 'balsama/lightning_strict',
      'type' => 'metapackage',
      'description' => 'Locked Composer dependencies for Lightning Drupal distribution releases.',
      'license' => 'GPL-2.0+',
    ];
  }

  public function buildPackage() {
    $composer = $this->defaultMetadata();

    // Lightning composer.lock files are generated with php 7.0, so certain
    // dependencies (such as doctrine/common) will also need it.
    $composer['require']['php'] = '>=7.0';

    foreach ($this->lock['packages'] as $package) {
      $composer['require'][$package['name']] = $this->packageToVersion($package);
    }

    // I don't really see any use for the dev dependencies right now, but we
    // might as well include them since they don't affect the normal use case
    // and might come in handy someday.
    foreach ($this->lock['packages-dev'] as $package) {
      $composer['require-dev'][$package['name']] = $this->packageToVersion($package);
    }

    return $composer;
  }

  public function packageToVersion(array $package) {
    if (substr($package['version'], 0, 4) == 'dev-') {
      return $package['version'] . '#' . $package['source']['reference'];
    }
    return $package['version'];
  }

}
