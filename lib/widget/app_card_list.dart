import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';

class AppCardList extends StatelessWidget {
  final bool isLast;
  final double padding;
  final Widget child;
  const AppCardList({
    super.key,
    required this.isLast,
    this.padding = 16,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: padding, bottom: padding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : AppTheme.borderColor,
          ),
        ),
      ),
      child: child,
    );
  }
}
