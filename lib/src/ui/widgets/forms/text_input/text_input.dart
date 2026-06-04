import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInput extends StatefulWidget {
  TextInput({
    super.key,
    required this.labelText,
    this.controler,
    this.iconData,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.enabled,
    this.obscureText,
    this.text,
    this.validator,
  });

  final TextEditingController? controler;
  final String labelText;
  final IconData? iconData;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool? enabled;
  final bool? obscureText;
  final String? text;
  String? Function(String?)? validator;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: widget.controler,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          icon: widget.iconData != null ? Icon(widget.iconData) : null,
        ),
        obscureText: widget.isPassword,
        enabled: widget.enabled,
        initialValue: widget.text,
        validator: widget.validator,
      ),
    );
  }
}


