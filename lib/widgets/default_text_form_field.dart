import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;

  const DefaultTextFormField({
    Key? key,
    this.validator,
    this.onChanged,
    this.autofocus = true,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      textAlign: TextAlign.center,
      autofocus: autofocus,
      cursorColor: Theme.of(context).primaryColor,
      style: const TextStyle(fontSize: 20),
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
