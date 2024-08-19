import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  final Color? color;
  final Color? borderColor;
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final Widget? suffixIcon;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.text,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color ?? Colors.lightBlue,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: child ??
                      Text(
                        text ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              ),
              if (suffixIcon != null) suffixIcon!
            ],
          ),
        ),
      ),
    );
  }
}
