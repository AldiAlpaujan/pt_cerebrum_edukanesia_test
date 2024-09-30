// ignore_for_file: deprecated_member_use
import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String hintText;
  final bool withLeading;
  final TextEditingController? controller;
  final Function() onClose;
  final Function(String)? onChanged;
  final List<Widget>? actions;
  const AppBarSearch({
    super.key,
    this.actions,
    required this.title,
    this.withLeading = true,
    this.onChanged,
    this.controller,
    required this.hintText,
    required this.onClose,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  var searchMode = false.obs;

  onSearch() {
    searchMode.value = !searchMode.value;
    if (!searchMode.value) {
      widget.onClose();
    }
  }

  onLeadingTap() {
    if (searchMode.value) {
      searchMode.value = false;
      widget.onClose();
    } else {
      Get.back();
    }
  }

  onWillPop() async {
    if (searchMode.value) {
      searchMode.value = false;
      widget.onClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !searchMode.value,
        onPopInvoked: (_) => onWillPop(),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppTheme.borderColor),
            ),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: widget.withLeading ? null : const SizedBox(),
            leadingWidth: widget.withLeading ? null : 0,
            title: Padding(
              padding: EdgeInsets.only(
                left: widget.withLeading ? 0.0 : AppTheme.padding,
              ),
              child: searchMode.value ? formSearch() : Text(widget.title),
            ),
            titleTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            actions: [
              IconButton(
                onPressed: onSearch,
                icon: Icon(
                  searchMode.value ? Icons.close_rounded : Icons.search_rounded,
                ),
              ),
              ...widget.actions ?? []
            ],
          ),
        ),
      ),
    );
  }

  Widget formSearch() {
    return TextFormField(
      autofocus: true,
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintStyle: const TextStyle(fontSize: 14),
        hintText: widget.hintText,
      ),
    );
  }
}
