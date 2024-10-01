import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:aldi_test/services/shared/shared_pref.dart';
import 'package:aldi_test/services/sql/sql_helper.dart';
import 'package:aldi_test/services/sql/sql_service.dart';
import 'package:aldi_test/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final userDefault = {
    "username": "Mang Kendil",
    "email": "kendil@example.com",
    "phone": "08912312312",
    "pw": "12345",
  };
  final productDefault = [
    {
      'name': "Americano",
      'price': 20000,
      'category': "Coffee",
      'description': "Kopi mantap",
      'availability': 1,
    },
    {
      'name': "Teh Anget",
      'price': 20000,
      'category': "Tea",
      'description': "Teh Mantap",
      'availability': 1,
    },
    {
      'name': "Singkong Keju",
      'price': 20000,
      'category': "Makanan",
      'description': "Singkong Mantap",
      'availability': 1,
    },
    {
      'name': "Pisang Keju",
      'price': 20000,
      'category': "Makanan",
      'description': "Pisang Mantap",
      'availability': 1,
    },
  ];

  initializationData() async {
    await SqlService.dbTransaction((trx) async {
      final userId = await trx.insert(SqlHelper.tbUser, userDefault);
      for (var item in productDefault) {
        await trx.insert(SqlHelper.tbProduct, {
          ...item,
          "user_id": userId,
        });
      }
    });
    await SharedPref.setFirstTime();
  }

  initialize() async {
    await SharedPref.loadUser();
    final isFirstTime = await SharedPref.loadFirsTimeUser();
    if (isFirstTime) await initializationData();
    Get.offAllNamed(user == null ? Routes.login : Routes.navigation);
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
