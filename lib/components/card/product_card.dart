import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/fontsize.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String? productName;
  final String? price;
  final bool isFavorite;
  final double width;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTapviewproduct;
  final bool isAddVisible;
  final VoidCallback? onTapAddToCart;
  final bool isInCart;

  const ProductCard({
    Key? key,
    this.imageUrl,
    this.productName,
    this.price,
    this.isFavorite = false,
    this.width = 140,
    required this.onFavoriteTap,
    this.onTapviewproduct,
    this.isAddVisible = true,
    this.onTapAddToCart,
    this.isInCart = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapviewproduct,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with only top-rounded corners
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl ?? 'https://picsum.photos/200/300',
                    // fit: BoxFit.fill,
                    width: 126,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 100,
                      width: width,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Icon(Icons.error_outline, color: Colors.grey),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        width: width,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                  // Favorite icon in top-right
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: isFavorite ? CustomAppColor.red : Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info section with only bottom-rounded corners
            Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSize.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${price ?? ''}',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: CustomFontSize.bodySmall,
                        ),
                      ),
                      Spacer(),
                      if (isAddVisible)
                        GestureDetector(
                          onTap: onTapAddToCart,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: isInCart
                                  ? CustomAppColor.success
                                  : CustomAppColor.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              isInCart ? Icons.check : Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
