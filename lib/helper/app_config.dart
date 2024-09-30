import 'package:aldi_test/enum/app_type.dart';

class AppConfig {
  static const applicationType = ApplicationType.development;

  static dynamic valueByConfig({dynamic devMode, dynamic prodMode}) {
    if (applicationType.isDevelopment) {
      return devMode;
    } else {
      return prodMode;
    }
  }
}
