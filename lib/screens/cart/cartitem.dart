import 'package:flutter/material.dart';
import 'package:nexacloth/components/btn.dart';
import 'package:nexacloth/components/card/cart_item_card.dart';
import 'package:nexacloth/components/gaps.dart';
import 'package:nexacloth/components/header/back_header.dart';
import 'package:nexacloth/components/order_summary.dart';
import 'package:nexacloth/components/toast_message.dart';
import 'package:nexacloth/screens/checkout/checkout.dart';

class CardItemScreen extends StatefulWidget {
  final bool isHeaderVisible;
  const CardItemScreen({super.key, this.isHeaderVisible = true});

  @override
  State<CardItemScreen> createState() => _CardItemScreenState();
}

class _CardItemScreenState extends State<CardItemScreen> {
  int quantity = 1;
  Widget _buildBody() {
    final bodyContent = Stack(
      children: [
        Column(
          children: [
            Gaps.h10,
            CartItemCard(
              imageUrl: 'https://picsum.photos/200/300',
              productName: 'Product Name',
              description: 'Rolex Watch',
              price: '\$100',
              quantity: quantity,
              onDelete: () {},
              onDecrease: () {
                quantity > 1
                    ? setState(() {
                        quantity--;
                      })
                    : null;
              },
              onIncrease: () {
                quantity < 10
                    ? setState(() {
                        quantity++;
                      })
                    : ToastMessage.show(context, 'Maximum quantity reached');
              },
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              OrderSummary(
                itemCount: 1,
                subtotal: '\$423',
                discount: '\$4',
                deliveryCharge: '\$2',
                total: '\$424',
              ),
              Gaps.h10,
              CustomButton(
                text: 'Check Out',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckOutScreen()),
                  );
                },
                width: double.infinity,
                borderRadius: 20,
              ),
              Gaps.h20,
            ],
          ),
        ),
      ],
    );

    return widget.isHeaderVisible ? bodyContent : SafeArea(child: bodyContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isHeaderVisible
          ? BackHeader(
              title: 'Cart',
              isFavoriteVisible: true,
              actionIcon: Icons.menu,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildBody(),
      ),
    );
  }
}
