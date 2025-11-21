import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';

class IconButtonCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double borderRadius;

  const IconButtonCircle({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 50,
    this.backgroundColor,
    this.iconColor,
    this.borderRadius = 50,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? CustomAppColor.greylight,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
