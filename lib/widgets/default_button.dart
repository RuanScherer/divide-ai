import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? overlayColor;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final String text;

  const DefaultButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    this.overlayColor,
    this.leading,
    this.trailing,
    this.textStyle,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? Colors.grey[200]!),
        overlayColor:
            MaterialStateProperty.all<Color>(overlayColor ?? Colors.grey[300]!),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (leading != null) ...[
              leading!
            ],
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: textStyle ?? const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (trailing != null) ...[
              trailing!
            ],
          ],
        ),
      ),
    );
  }
}
