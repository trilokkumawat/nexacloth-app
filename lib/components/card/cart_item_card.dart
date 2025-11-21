import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/fontsize.dart';
import 'package:nexacloth/components/gaps.dart';
import 'package:nexacloth/components/quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String? description;
  final String price;
  final int quantity;
  final VoidCallback? onDelete;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final double imageWidth;
  final double imageHeight;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    this.description,
    required this.price,
    required this.quantity,
    this.onDelete,
    this.onDecrease,
    this.onIncrease,
    this.imageWidth = 126,
    this.imageHeight = 100,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.all(6.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: CustomAppColor.greylight,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.network(
              imageUrl,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
          ),
          Gaps.w8,
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: AppTextStyle.custom(
                    fontSize: CustomFontSize.bodyMedium,
                    fontWeight: FontWeight.w600,
                    color: CustomAppColor.text,
                  ),
                ),
                if (description != null)
                  Text(
                    description!,
                    style: AppTextStyle.subtextMedium,
                  ),
                Text(
                  price,
                  style: AppTextStyle.custom(
                    fontSize: CustomFontSize.bodyMedium,
                    fontWeight: FontWeight.w600,
                    color: CustomAppColor.primary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete),
                color: CustomAppColor.error,
              ),
              QuantitySelector(
                quantity: quantity,
                onDecrease: onDecrease,
                onIncrease: onIncrease,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

