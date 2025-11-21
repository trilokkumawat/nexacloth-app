import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final dynamic width;
  final dynamic height;
  final double fontSize;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    this.elevation = 2.0,
    this.width,
    this.height,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      color: color ?? Theme.of(context).primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
