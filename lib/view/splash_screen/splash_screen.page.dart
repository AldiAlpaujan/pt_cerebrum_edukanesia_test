import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:aldi_test/services/shared/shared_pref.dart';
import 'package:aldi_test/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  initialize() async {
    await SharedPref.loadUser();
    Get.toNamed(user == null ? Routes.login : Routes.navigation);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AppLoading()));
  }
}
