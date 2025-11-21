import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double width;
  final double minWidth;
  final double maxWidth;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    this.elevation = 2.0,
    this.width = 180.0,
    this.minWidth = 100.0,
    this.maxWidth = 300.0,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late double _borderRadius;
  late double _width;

  @override
  void initState() {
    super.initState();
    _borderRadius = widget.borderRadius;
    _width = widget.width;
  }

  void _incrementRadius() {
    setState(() {
      _borderRadius += 4;
    });
  }

  void _decrementRadius() {
    setState(() {
      if (_borderRadius > 0) {
        _borderRadius -= 4;
      }
    });
  }

  void _incrementWidth() {
    setState(() {
      if (_width + 10 <= widget.maxWidth) {
        _width += 10;
      }
    });
  }

  void _decrementWidth() {
    setState(() {
      if (_width - 10 >= widget.minWidth) {
        _width -= 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: widget.color ?? Theme.of(context).primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        onTap: widget.onPressed,
        child: Container(
          width: widget.width == double.infinity ? double.infinity : _width,
          padding: widget.padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor ?? Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
