import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  const CustomCard({
    Key? key,
    required this.child,
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.color,
    this.boxShadow,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: card,
        ),
      );
    }
    return card;
  }
}
