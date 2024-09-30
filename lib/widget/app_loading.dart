import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final double marginLoadingBtm;
  final double fontSize;
  final double strokeWidth;
  final bool hideText;
  final Color? color;
  const AppLoading({
    super.key,
    this.size = 32,
    this.marginLoadingBtm = 16,
    this.fontSize = 14,
    this.strokeWidth = 4.0,
    this.color,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: size,
            width: size,
            margin: EdgeInsets.only(bottom: marginLoadingBtm),
            child: CircularProgressIndicator(
              color: color ?? AppTheme.primaryColor,
              strokeWidth: strokeWidth,
            ),
          ),
        ),
        if (!hideText)
          Text("Tunggu Sebentar...", style: TextStyle(fontSize: fontSize)),
      ],
    );
  }
}
