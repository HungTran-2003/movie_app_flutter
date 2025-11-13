import 'package:flutter/material.dart';
import 'package:movie_app/common/app_text_styles.dart';

class AppDialogs {
  BuildContext context;

  AppDialogs({required this.context});

  Future<void> showSimpleDialog({
    required String title,
    required String content,
    String textConfirm = "OK",
    String? textCancel,
    barrierDismissible = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: AppTextStyle.whitePoppinsS18SemiBold),
          content: Text(content, style: AppTextStyle.whitePoppinsS12Regular),
          actions: [
            if (textCancel != null)
              TextButton(
                onPressed: onCancel,
                child: Text(
                  textCancel,
                  style: AppTextStyle.whitePoppinsS12Regular,
                ),
              ),
            TextButton(
              onPressed: onConfirm,
              child: Text(
                textConfirm,
                style: AppTextStyle.whitePoppinsS12Regular,
              ),
            ),
          ],
        );
      },
    );
  }
}
