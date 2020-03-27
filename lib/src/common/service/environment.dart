class Environment {
  static bool isProduction() {
    return bool.fromEnvironment('dart.vm.product');
  }
}
