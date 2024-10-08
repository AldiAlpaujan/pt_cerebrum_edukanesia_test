import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/widgets.dart';

class AppSquareInitial extends StatelessWidget {
  final String initial;
  final Color? bgColor;
  const AppSquareInitial({super.key, required this.initial, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor ?? AppTheme.primaryColor.withOpacity(.1),
      ),
      child: Text(
        initial,
        style: const TextStyle(
          fontSize: 16,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
