import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStateColor.resolveWith(
          (states) => (color ?? AppTheme.primaryColor).withOpacity(.1),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color ?? AppTheme.primaryColor,
        ),
      ),
    );
  }
}
