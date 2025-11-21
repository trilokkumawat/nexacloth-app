import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/card/product_card.dart';
import 'package:nexacloth/components/fontsize.dart';
import 'package:nexacloth/components/gaps.dart';
import 'package:nexacloth/components/header/back_header_search.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController searchController = TextEditingController();
  String currentSearchText = '';

  @override
  void initState() {
    super.initState();
    // Display text should update when controller changes.
    searchController.addListener(_handleSearchTextChanged);
  }

  void _handleSearchTextChanged() {
    setState(() {
      currentSearchText = searchController.text;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_handleSearchTextChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BackHeaderSearch(
                controller: searchController,
                isBackVisible: false,
                suffixIcon: Icons.close_rounded,
                isSuffixiconVisible: currentSearchText.length > 0,
                onSuffixTap: () {
                  searchController.clear();
                },
                onChanged: (value) {
                  /* This makes sure clearing with suffix works instantly */
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentSearchText.length > 0)
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Result for ',
                                  style: AppTextStyle.custom(
                                    fontSize: CustomFontSize.bodyMedium,
                                    fontWeight: FontWeight.w600,
                                    color: CustomAppColor.subtext,
                                  ),
                                ),
                                TextSpan(
                                  text: '"$currentSearchText"',
                                  style: AppTextStyle.h6,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            '6 Results found',
                            style: AppTextStyle.custom(
                              fontSize: CustomFontSize.bodyMedium,
                              fontWeight: FontWeight.w600,
                              color: CustomAppColor.primary,
                            ),
                          ),
                        ],
                      ),
                    Gaps.h12,
                    GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) => ProductCard(
                        // isFavorite: product.favorite,
                        // isInCart: product.addtocart,
                        onTapviewproduct: () {},
                        onTapAddToCart: () async {},
                        onFavoriteTap: () async {},
                        // imageUrl: 'https://picsum.photos/200/300',
                        productName: 'Product Name',
                        price: '100',
                        width: 140,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
