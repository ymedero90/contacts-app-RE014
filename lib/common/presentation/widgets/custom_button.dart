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
  final bool enable;

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
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: enable ? color ?? Colors.lightBlue : Colors.lightBlue.withOpacity(.4),
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              offset: Offset(0, 3),
              blurRadius: 5,
            )
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
