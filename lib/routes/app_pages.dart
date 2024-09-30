import 'package:aldi_test/view/dashboard/dashboard.controller.dart';
import 'package:aldi_test/view/login/login.controller.dart';
import 'package:aldi_test/view/login/login.page.dart';
import 'package:aldi_test/view/navigation/navigation.controller.dart';
import 'package:aldi_test/view/navigation/navigation.page.dart';
import 'package:aldi_test/view/product/product.controller.dart';
import 'package:aldi_test/view/profile/profile.controller.dart';
import 'package:aldi_test/view/register/register.controller.dart';
import 'package:aldi_test/view/register/register.page.dart';
import 'package:aldi_test/view/sale/sale.controller.dart';
import 'package:aldi_test/view/splash_screen/splash_screen.page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splashScreen;

  static final pages = <GetPage>[
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => RegisterController())),
    ),
    GetPage(
      name: Routes.navigation,
      page: () => const NavigationPage(),
      bindings: [
        BindingsBuilder(() => Get.lazyPut(() => NavigationController())),
        BindingsBuilder(() => Get.lazyPut(() => DashboardController())),
        BindingsBuilder(() => Get.lazyPut(() => ProductController())),
        BindingsBuilder(() => Get.lazyPut(() => SaleController())),
        BindingsBuilder(() => Get.lazyPut(() => ProfileController())),
      ],
    ),
  ];
}
