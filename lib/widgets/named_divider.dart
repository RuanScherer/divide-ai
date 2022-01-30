import 'package:flutter/material.dart';

class NamedDivider extends StatelessWidget {
  final String text;

  const NamedDivider({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[500],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(text),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}
