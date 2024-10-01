import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/widget/app_back_button.dart';
import 'package:flutter/material.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final String title;
  final List<Widget>? actions;
  const AppCustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: showLeading ? const AppBackButton() : const SizedBox(),
        leadingWidth: showLeading ? null : 0,
        title: Padding(
          padding: EdgeInsets.only(left: !showLeading ? AppTheme.padding : 0),
          child: Text(title),
        ),
        actions: actions,
        titleTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
