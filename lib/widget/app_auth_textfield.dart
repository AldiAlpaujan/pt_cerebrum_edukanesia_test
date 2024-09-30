import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppAuthTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const AppAuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
  });

  @override
  State<AppAuthTextField> createState() => _AppAuthTextFieldState();
}

class _AppAuthTextFieldState extends State<AppAuthTextField> {
  final focusNode = FocusNode();
  final isFocused = false.obs;
  final obscureText = false.obs;

  @override
  void initState() {
    obscureText.value = widget.obscureText;
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              color:
                  isFocused.value ? AppTheme.primaryColor : AppTheme.titleColor,
            ),
          ),
        ),
        Obx(
          () => TextFormField(
            focusNode: focusNode,
            obscureText: obscureText.value,
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            validator: widget.validator,
            decoration: InputDecoration(
              isDense: true,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0.4),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0.4),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppTheme.primaryColor, width: 0.6),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE9E9E9)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFB1B1B1),
                fontSize: 14,
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () => obscureText.value = !obscureText.value,
                      icon: Icon(
                        obscureText.value
                            ? MdiIcons.eyeOffOutline
                            : MdiIcons.eyeOutline,
                        color: const Color(0xFFBDBDBD),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
