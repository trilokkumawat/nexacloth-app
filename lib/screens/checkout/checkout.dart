import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/btn.dart';
import 'package:nexacloth/components/gaps.dart';
import 'package:nexacloth/components/icon_button_circle.dart';
import 'package:nexacloth/components/header/back_header.dart';
import 'package:nexacloth/components/order_summary.dart';
import 'package:nexacloth/components/payment_method_card.dart';
import 'package:nexacloth/screens/order/order.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            BackHeader(title: 'Checkout', isFavoriteVisible: false),
            Gaps.h10,
            Row(
              spacing: 10,
              children: [
                IconButtonCircle(
                  icon: Icons.location_on,
                  iconColor: CustomAppColor.primary,
                  onTap: () {},
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text(
                      '325 15th Eighth Avenue, NewYork',
                      style: AppTextStyle.h6,
                    ),
                    Text(
                      'Saepe eaque fugiat ea voluptatum veniam.',
                      style: AppTextStyle.subtextSmall,
                    ),
                  ],
                ),
              ],
            ),
            Gaps.h10,
            Row(
              spacing: 10,
              children: [
                IconButtonCircle(
                  icon: Icons.watch_later,
                  iconColor: CustomAppColor.primary,
                  onTap: () {},
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('6:00 pm, Wednesday 20', style: AppTextStyle.h6),
                  ],
                ),
              ],
            ),
            Spacer(),
            OrderSummary(
              itemCount: 1,
              subtotal: '\$423',
              discount: '\$4',
              deliveryCharge: '\$2',
              total: '\$424',
            ),
            Gaps.h10,
            Text('Payment Method', style: AppTextStyle.h6),
            Gaps.h10,
            PaymentMethodCard(
              paymentIcon: Icons.paypal,
              paymentName: 'Paypal',
              onSelectionChanged: (isSelected) {
                // Handle selection change if needed
              },
            ),
            Gaps.h10,
            PaymentMethodCard(
              paymentIcon: Icons.credit_card,
              paymentName: 'Credit Card',
              onSelectionChanged: (isSelected) {
                // Handle selection change if needed
              },
            ),
            Gaps.h10,
            PaymentMethodCard(
              paymentIcon: Icons.money,
              paymentName: 'Cash on Delivery',
              onSelectionChanged: (isSelected) {
                // Handle selection change if needed
              },
            ),
            Gaps.h10,
            PaymentMethodCard(
              paymenticonVisible: false,
              paymentName: 'Cash on Delivery',
              onSelectionChanged: (isSelected) {
                // Handle selection change if needed
              },
            ),
            Gaps.h10,
            CustomButton(
              text: 'Check Out',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderScreen()),
                );
              },
              width: double.infinity,
              borderRadius: 20,
            ),
            Gaps.h20,
          ],
        ),
      ),
    );
  }
}
