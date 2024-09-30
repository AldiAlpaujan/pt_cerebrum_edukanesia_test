import 'package:aldi_test/helper/assets.dart';
import 'package:aldi_test/helper/global_style.dart';
import 'package:aldi_test/helper/validator.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/register/register.controller.dart';
import 'package:aldi_test/widget/app_auth_textfield.dart';
import 'package:aldi_test/widget/app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

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
                      registerIllustration,
                      height: getHeight(context) * 0.36,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Daftar Akun",
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
                        "Silahkan isi form dibawah ini",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.bodyColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: AppAuthTextField(
                      label: "Username",
                      hintText: "Masukan username",
                      controller: controller.nameC,
                      validator: (v) => emptyValidator("Username", v!),
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
                      label: "No. Telepon",
                      hintText: "Masukan no telepon",
                      controller: controller.phoneC,
                      validator: (v) => emptyValidator("No. Telepon", v!),
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
                      onTap: controller.register,
                      child: const Text("Register", style: AppTheme.btnStyle),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Sudah punya akun?",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.bodyColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Login!",
                            recognizer: TapGestureRecognizer()
                              ..onTap = Get.back,
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
