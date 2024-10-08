import 'package:aldi_test/routes/app_pages.dart';
import 'package:aldi_test/services/sql/sql_service.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Aldi Test",
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppTheme.localizationsDelegates,
      supportedLocales: AppTheme.supportedLocales,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
        fontFamily: AppTheme.fontFamily,
        colorScheme: AppTheme.colorScheme,
        primaryColor: AppTheme.primaryColor,
        elevatedButtonTheme: AppTheme.btnTheme,
        scaffoldBackgroundColor: AppTheme.bgColor,
        floatingActionButtonTheme: AppTheme.floatBtnTheme,
        appBarTheme: AppTheme.appBarTheme,
      ),
    );
  }
}
