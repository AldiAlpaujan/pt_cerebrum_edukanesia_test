import 'package:aldi_test/helper/assets.dart';
import 'package:aldi_test/helper/global_style.dart';
import 'package:aldi_test/helper/validator.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/login/login.controller.dart';
import 'package:aldi_test/widget/app_auth_textfield.dart';
import 'package:aldi_test/widget/app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.padding),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: SvgPicture.asset(
                      loginIllustration,
                      height: getHeight(context) * 0.36,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Selamat Datang Kembali",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppTheme.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Silahkan login dengan akun Anda",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.bodyColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: AppAuthTextField(
                      label: "Email",
                      hintText: "Masukan email",
                      controller: controller.emailC,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => emailValidator(v!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: AppAuthTextField(
                      label: "Password",
                      hintText: "Masukan password",
                      controller: controller.pwC,
                      obscureText: true,
                      validator: (v) => emptyValidator("Password", v!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: AppButton(
                      onTap: controller.login,
                      child: const Text("Login", style: AppTheme.btnStyle),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Belum punya akun?",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.bodyColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Daftar Sekarang!",
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.register,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
