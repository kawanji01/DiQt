class EnvHandler {
  static bool isDev() {
    return const String.fromEnvironment("flavor") == 'dev';
  }

  static bool isProd() {
    return const String.fromEnvironment("flavor") == 'prod';
  }
}
