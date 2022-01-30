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
          vertical: 8,
          horizontal: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (leading != null) ...[
              leading!
            ],
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: textStyle ?? const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
