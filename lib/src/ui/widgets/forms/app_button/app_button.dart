import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRadius = 12,
    this.bgColor,
    this.textColor,
    this.icon,
    this.width,
    this.height = 50,
    this.fontSize = 16,
  });

  final VoidCallback onPressed;
  final String text;
  final double borderRadius;
  final Color? bgColor;
  final Color? textColor;
  final Widget? icon;
  final double? width;
  final double height;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      color:
                          textColor ?? Theme.of(context).colorScheme.onPrimary,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                  fontSize: fontSize,
                ),
              ),
      ),
    );
  }
}
