import 'package:flutter/material.dart';
import 'package:nexacloth/components/card/product_card.dart';
import 'package:nexacloth/components/header/back_header.dart';
import 'package:nexacloth/components/safe_set_state_mixin.dart';
import 'package:nexacloth/controllers/basecontroller.dart';
import 'package:nexacloth/controllers/productcontroller.dart';
import 'package:nexacloth/model/product_model.dart';
import 'package:nexacloth/screens/productui/productdetails.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryId;
  const CategoryProduct({super.key, required this.categoryId});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct>
    with SafeSetStateMixin {
  late ProductController _controller;
  List<ProductModel>? _products;

  @override
  void initState() {
    super.initState();
    _controller = createModel(context, () => ProductController());
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _controller.getProductByCategoryId(
      widget.categoryId,
    );
    safeSetState(() {
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = 140;

    return Scaffold(
      appBar: BackHeader(title: 'Product Details'),
      body: SafeArea(
        child: _products == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _products!.length,
                  itemBuilder: (context, index) {
                    final product = _products![index];
                    return ProductCard(
                      isFavorite: product.favorite,
                      isInCart: product.addtocart,
                      onTapviewproduct: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetails(productId: product.id),
                          ),
                        );
                      },
                      onTapAddToCart: () async {
                        final newCartState = await _controller
                            .toggleProductInCart(product.id.toString());
                        safeSetState(() {
                          if (_products != null) {
                            _products![index] = product.copyWith(
                              addtocart: newCartState,
                            );
                          }
                        });
                      },
                      onFavoriteTap: () async {
                        final newFavoriteState = !product.favorite;
                        await _controller.toggleFavoriteProduct(
                          product.id.toString(),
                          newFavoriteState,
                        );
                        await _loadProducts();
                      },

                      imageUrl: product.images ?? '',
                      productName: product.name ?? '',
                      price: product.price ?? '',
                      width: cardWidth,
                    );
                  },
                ),
              ),
      ),
    );
  }
}
