import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/fontsize.dart';

class OrderSummary extends StatelessWidget {
  final int itemCount;
  final String subtotal;
  final String discount;
  final String deliveryCharge;
  final String total;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;

  const OrderSummary({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.discount,
    required this.deliveryCharge,
    required this.total,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.all(4.0),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomAppColor.greylight,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Text(
              'Order Summary',
              style: AppTextStyle.custom(
                fontSize: CustomFontSize.h4,
                fontWeight: FontWeight.w600,
                color: CustomAppColor.text,
              ),
            ),
            Padding(
              padding: contentPadding,
              child: Column(
                spacing: 5,
                children: [
                  _buildSummaryRow('Item', '$itemCount'),
                  _buildSummaryRow('Subtotal', subtotal),
                  _buildSummaryRow('Discount', discount),
                  _buildSummaryRow('Delivery Charge', deliveryCharge),
                ],
              ),
            ),
            Divider(
              color: CustomAppColor.grey.withOpacity(0.5),
              thickness: 1,
            ),
            Padding(
              padding: contentPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: AppTextStyle.custom(
                      fontSize: CustomFontSize.bodyLarge,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    total,
                    style: AppTextStyle.custom(
                      fontSize: CustomFontSize.bodyLarge,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.custom(
            fontSize: CustomFontSize.bodySmall,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.custom(
            fontSize: CustomFontSize.bodySmall,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

