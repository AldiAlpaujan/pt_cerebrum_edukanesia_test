import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppTheme {
  static const fontFamily = "Barlow";
  static const primaryColor = Color(0xFF6AB058);
  static const bgColor = Color(0xFFFFFFFF);
  static const shadowColor = Color(0x18000000);
  static const titleColor = Color(0xFF4F4F4F);
  static const bodyColor = Color(0xFF4F4F4F);
  static const capColor = Color(0xFFA2A2A2);
  static const borderColor = Color(0xFFEEF2F8);

  static const textFieldBorderColor = Color(0xFFD5D8E2);

  static const padding = 16.0;

  static const titleDialogStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const contentDialogStyle = TextStyle(fontSize: 14);

  static const contentPaddingDialog = EdgeInsets.fromLTRB(24, 12, 24, 8);

  static const localizationsDelegates = [
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static const supportedLocales = [
    Locale('en'),
    Locale('id'),
  ];

  static final colorScheme = ThemeData().colorScheme.copyWith(
        primary: primaryColor,
      );
  static final btnTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
    ),
  );
  static const floatBtnTheme = FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  );
  static const btnStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const appBarTheme = AppBarTheme(
    color: primaryColor,
    elevation: 4,
    titleSpacing: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  );

  static final _borderTextFieldInput = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: AppTheme.textFieldBorderColor,
      width: 1,
    ),
  );

  static final textFieldInputDecoration = InputDecoration(
    isDense: true,
    border: _borderTextFieldInput,
    enabledBorder: _borderTextFieldInput,
    focusedBorder: _borderTextFieldInput.copyWith(
      borderSide: const BorderSide(
        color: AppTheme.primaryColor,
        width: 1,
      ),
    ),
    focusedErrorBorder: _borderTextFieldInput.copyWith(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 16,
    ),
    hintStyle: const TextStyle(
      color: AppTheme.capColor,
      fontSize: 12,
    ),
  );
}
