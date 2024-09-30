import 'package:aldi_test/view/navigation/navigation.controller.dart';
import 'package:aldi_test/view/navigation/widget/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends GetView<NavigationController> {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.page,
        bottomNavigationBar: AppBottomNav(
          menu: controller.pages,
          currentIndex: controller.current.value,
          onChanged: controller.onNavChanged,
        ),
      ),
    );
  }
}
