import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/widget/app_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

waitingDialog({String? message}) {
  return Get.dialog(
    AppLoadingDialog(message: message),
    barrierDismissible: false,
  );
}

Future<bool?> info({
  required String message,
  Function? onOk,
}) {
  return showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Informasi', style: AppTheme.titleDialogStyle),
      content: Text(message, style: AppTheme.contentDialogStyle),
      contentPadding: AppTheme.contentPaddingDialog,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Get.back(result: true);
            }
          },
          child: const Text('OK'),
        )
      ],
    ),
  );
}

createDialog({
  required String title,
  required String message,
  List<Widget>? actions,
}) {
  return Get.dialog(
    AlertDialog(
      title: Text(title, style: AppTheme.titleDialogStyle),
      contentPadding: AppTheme.contentPaddingDialog,
      content: Text(message, style: AppTheme.contentDialogStyle),
      actions: actions,
    ),
    barrierDismissible: false,
  );
}

error({required String message, Function? onOk}) {
  return Get.dialog(
    AlertDialog(
      title: const Text('Ada Kesalahan', style: AppTheme.titleDialogStyle),
      contentPadding: AppTheme.contentPaddingDialog,
      content: Text(message, style: AppTheme.contentDialogStyle),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Get.back();
            }
          },
          child: const Text('OK'),
        )
      ],
    ),
    barrierDismissible: false,
  );
}

Future<bool?> confirm({
  String? title,
  required String message,
  Function? onCancel,
  Function? onOk,
}) {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(
        title ?? 'Konfirmasi',
        style: AppTheme.titleDialogStyle,
      ),
      content: Text(message, style: AppTheme.contentDialogStyle),
      contentPadding: AppTheme.contentPaddingDialog,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            } else {
              Get.back(result: false);
            }
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Get.back(result: true);
            }
          },
          child: const Text('OK'),
        )
      ],
    ),
    barrierDismissible: false,
  );
}
