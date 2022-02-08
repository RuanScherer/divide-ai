import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final String value;

  DefaultTextFormField({
    Key? key,
    this.validator,
    this.onChanged,
    this.autofocus = true,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.labelText,
    this.hintText,
    this.prefix,
    required this.value,
  }) : super(key: key) {
    _controller.text = value;
    _controller.selection = TextSelection.collapsed(offset: value.length);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: validator,
      onChanged: onChanged,
      textAlign: TextAlign.center,
      autofocus: autofocus,
      cursorColor: Theme.of(context).primaryColor,
      style: const TextStyle(fontSize: 20),
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        prefix: prefix,
        contentPadding: const EdgeInsets.all(8),
        hintText: hintText,
        label: labelText != null ? Center(
          child: Text(labelText!),
        ) : null,
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
