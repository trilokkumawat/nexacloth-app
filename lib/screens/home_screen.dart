import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/card/product_card.dart';
import 'package:nexacloth/components/customtextfield.dart';
import 'package:nexacloth/components/fontsize.dart';
import 'package:nexacloth/components/gaps.dart';
import 'package:nexacloth/components/header/homeheader.dart';
import 'package:nexacloth/components/safe_set_state_mixin.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nexacloth/controllers/basecontroller.dart';
import 'package:nexacloth/controllers/home_controller.dart';
import 'package:nexacloth/core/user_info_service.dart';
import 'package:nexacloth/model/product_model.dart';
import 'package:nexacloth/screens/productui/categorywithproduct.dart';
import 'package:nexacloth/screens/productui/productdetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SafeSetStateMixin {
  late HomeController _controller;
  late Query<List<dynamic>> _categoryWithProductsFuture;
  final UserInfoService user = UserInfoService();

  @override
  void initState() {
    super.initState();
    _controller = createModel(context, () => HomeController());
    _categoryWithProductsFuture = _controller.getcachedProductsWithCategory();
  }

  Future<void> _refreshData() async {
    // Refetch the query to get fresh data
    await _categoryWithProductsFuture.refetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppColor.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomHomeHeader(
                    imageUrl: 'https://picsum.photos/200/300',
                    title: user.name ?? 'Guest',
                  ),
                  Gaps.h10,
                  CustomTextField(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    fillColor: CustomAppColor.greylight,
                  ),
                  Gaps.h20,
                  // Carousel Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        _controller.setCurrentIndex(index);
                      },
                    ),
                    items: _controller.carouselImages.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: CustomAppColor.greylight,
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: CustomAppColor.greylight,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _controller.carouselImages.asMap().entries.map((
                      entry,
                    ) {
                      bool isActive = _controller.currentIndex == entry.key;
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: isActive ? 22.0 : 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isActive
                              ? CustomAppColor.primary
                              : CustomAppColor.primary.withOpacity(0.15),
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 6,
                                    spreadRadius: 1.5,
                                    offset: Offset(0, 1),
                                  ),
                                ]
                              : [],
                          // 'blow' indicator effect: larger, more visible and with shadow when active
                        ),
                      );
                    }).toList(),
                  ),
                  Gaps.h12,

                  QueryBuilder<QueryStatus<List<dynamic>>>(
                    query: _categoryWithProductsFuture,
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // Group products by category with category_id
                      Map<String, Map<String, dynamic>> groupedCategories = {};

                      for (var item in state.data!) {
                        if (item is Map && item.isNotEmpty) {
                          final categoryName = item.keys.first.toString();
                          final productMap = item.values.first;

                          if (productMap is Map<String, dynamic>) {
                            try {
                              final product = ProductModel.fromMap(productMap);
                              final categoryId = product.categoryId ?? "";

                              if (groupedCategories.containsKey(categoryName)) {
                                groupedCategories[categoryName]!['products']
                                    .add(product);
                              } else {
                                groupedCategories[categoryName] = {
                                  'category_id': categoryId,
                                  'products': [product],
                                };
                              }
                            } catch (e) {
                              debugPrint('Error parsing product: $e');
                            }
                          }
                        }
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: groupedCategories.length,
                        itemBuilder: (context, index) {
                          final categoryName = groupedCategories.keys.elementAt(
                            index,
                          );
                          final categoryInfo = groupedCategories[categoryName]!;
                          final products =
                              categoryInfo['products'] as List<ProductModel>;
                          final categoryId =
                              categoryInfo['category_id'] as String? ?? "";

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(categoryName, style: AppTextStyle.h4),
                                    if (categoryId.isNotEmpty) ...[
                                      SizedBox(width: 12),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: CustomAppColor.primary
                                              .withOpacity(0.10),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        child: Text(
                                          categoryId,
                                          style: AppTextStyle.custom(
                                            fontSize: 11,
                                            color: CustomAppColor.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryProduct(
                                                  categoryId: categoryId,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'See All',
                                        style: AppTextStyle.custom(
                                          fontSize: CustomFontSize.bodyMedium,
                                          color: CustomAppColor.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.h8,
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.19,
                                  child: ListView.builder(
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    itemBuilder: (context, productIndex) {
                                      final product = products[productIndex];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right:
                                              productIndex < products.length - 1
                                              ? 12
                                              : 0,
                                        ),
                                        child: ProductCard(
                                          isAddVisible: false,
                                          onFavoriteTap: () {},
                                          onTapAddToCart: () {},
                                          onTapviewproduct: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails(
                                                      productId: product.id,
                                                    ),
                                              ),
                                            );
                                          },
                                          imageUrl: product.images ?? '',
                                          productName: product.name ?? '',
                                          price: product.price ?? '',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
