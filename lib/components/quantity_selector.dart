import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/fontsize.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final double buttonSize;
  final double borderRadius;

  const QuantitySelector({
    super.key,
    required this.quantity,
    this.onDecrease,
    this.onIncrease,
    this.buttonSize = 25,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: CustomAppColor.primary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onDecrease,
            icon: Icon(Icons.remove),
            color: CustomAppColor.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '$quantity',
            style: AppTextStyle.custom(
              fontSize: CustomFontSize.bodyMedium,
              fontWeight: FontWeight.w600,
              color: CustomAppColor.text,
            ),
          ),
        ),
        Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: CustomAppColor.primary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onIncrease,
            icon: Icon(Icons.add),
            color: CustomAppColor.white,
          ),
        ),
      ],
    );
  }
}
