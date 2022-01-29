import 'package:divide_ai/globals/globals.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showDefaultSnackbar({
    Widget? content,
    String? text,
  }) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF00E4A7),
        content: _buildDefaultSnackbarContent(
          content: content,
          text: text,
        ),
      ),
    );
  }

  static Widget _buildDefaultSnackbarContent({Widget? content, String? text}) {
    if (content != null) {
      return content;
    } else if (text != null) {
      return Text(text);
    } else {
      return const Text('');
    }
  }

  static void dismissCurrentSnackbar() {
    snackbarKey.currentState?.hideCurrentSnackBar();
  }
}
