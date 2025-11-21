import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/btn.dart';
import 'package:nexacloth/components/fontsize.dart';
import 'package:nexacloth/components/gaps.dart';
import 'package:nexacloth/components/header/back_header.dart';
import 'package:nexacloth/components/safe_set_state_mixin.dart';
import 'package:nexacloth/controllers/basecontroller.dart';
import 'package:nexacloth/controllers/productcontroller.dart';
import 'package:nexacloth/model/product_model.dart';
import 'package:nexacloth/screens/cart/cartitem.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final String initialSize;
  final ValueChanged<String>? onSizeChanged;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.initialSize,
    this.onSizeChanged,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  late String selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.initialSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Size", style: AppTextStyle.h6),
        Row(
          spacing: 8,
          children: widget.sizes
              .map(
                (size) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                    widget.onSizeChanged?.call(size);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CustomAppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedSize == size
                            ? CustomAppColor.primary
                            : CustomAppColor.greylight,
                      ),
                    ),
                    child: Text(size, style: AppTextStyle.subtextMedium),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class ProductDetails extends StatefulWidget {
  final int productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SafeSetStateMixin {
  late ProductController _controller;
  List<String> sizes = ["S", "M", "L", "XL", "XXL"];

  late String selectedSize;
  late Future<List<ProductModel>> _productFuture;

  @override
  void initState() {
    super.initState();
    _controller = createModel(context, () => ProductController());
    selectedSize = "${sizes.first}";
    _productFuture = _controller.getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppColor.white,
      body: FutureBuilder<List<ProductModel>>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Column(
              children: [
                BackHeader(isFavoriteVisible: true),
                Center(child: Text('No product found')),
              ],
            );
          }
          final product = snapshot.data!.first;
          return Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 400,
                        child: Image.network(
                          product.images ?? "",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 0,
                        right: 0,
                        child: BackHeader(isFavoriteVisible: true),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name != null
                                  ? product.name!.length > 20
                                        ? "${product.name!.substring(0, 20)}..."
                                        : product.name!
                                  : "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.h4,
                            ),
                            Text(
                              "\$${product.price ?? ""}",
                              style: AppTextStyle.custom(
                                fontSize: CustomFontSize.h4,
                                fontWeight: FontWeight.w600,
                                color: CustomAppColor.primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: CustomAppColor.yellow,
                              size: 30,
                            ),
                            Text(
                              "4.5",
                              style: AppTextStyle.custom(
                                fontSize: CustomFontSize.bodyMedium,
                                fontWeight: FontWeight.bold,
                                color: CustomAppColor.primary,
                              ),
                            ),
                            Text(
                              "(100 reviews)",
                              style: AppTextStyle.subtextMedium,
                            ),
                          ],
                        ),
                        Gaps.h10,
                        Text("Description", style: AppTextStyle.h6),
                        Text(
                          product.description != null
                              ? product.description!.length > 300
                                    ? "${product.description!.substring(0, 300)}..."
                                    : product.description!
                              : "",
                          style: AppTextStyle.custom(
                            fontSize: CustomFontSize.bodyMedium,
                            fontWeight: FontWeight.w400,
                            color: CustomAppColor.grey,
                            justify: TextAlign.justify,
                          ),
                        ),
                        Gaps.h10,

                        SizeSelector(
                          sizes: sizes,
                          initialSize: selectedSize,
                          onSizeChanged: (size) {
                            selectedSize = size;
                          },
                        ),
                      ],
                    ),
                  ),

                  // FutureBuilder(
                  //   future: ,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Center(child: CircularProgressIndicator());
                  //     }
                  //     if (snapshot.hasError) {
                  //       return Center(child: Text('Error: ${snapshot.error}'));
                  //     }
                  //     if (!snapshot.hasData) {
                  //       return Center(child: Text('No product found'));
                  //     }
                  //     return Text('Product Details');
                  //   },
                  // ),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Buy Now',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardItemScreen(),
                              ),
                            );
                          },
                          width: double.infinity,
                          borderRadius: 50,
                        ),
                      ),
                      Gaps.w16,
                      Container(
                        width: 80,
                        decoration: BoxDecoration(
                          color: CustomAppColor.greylight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.card_travel),
                          color: CustomAppColor.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
