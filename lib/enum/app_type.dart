enum ApplicationType {
  development,
  production;

  bool get isDevelopment => this == ApplicationType.development;
  bool get isProduction => this == ApplicationType.production;
}
