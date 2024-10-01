import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFixBtmButton extends StatefulWidget {
  final String? label;
  final bool isActive;
  final Function()? onPressed;
  final ButtonStyle? style;
  final Widget? child;
  const AppFixBtmButton({
    super.key,
    this.onPressed,
    this.label,
    this.isActive = true,
    this.style,
    this.child,
  });

  @override
  State<AppFixBtmButton> createState() => _AppFixBtmButtonState();
}

class _AppFixBtmButtonState extends State<AppFixBtmButton>
    with WidgetsBindingObserver {
  final isKeyboardVisible = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    final newValue = bottomInset != 0.0;
    if (newValue != isKeyboardVisible.value) {
      isKeyboardVisible.value = newValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (isKeyboardVisible.value) return const SizedBox();
        return Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: AppTheme.shadowColor,
                offset: Offset(-1, 0),
              )
            ],
          ),
          child: Stack(
            children: [
              widget.child ??
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: widget.isActive ? widget.onPressed : null,
                      style: widget.style,
                      child: Text(
                        widget.label ?? "",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
