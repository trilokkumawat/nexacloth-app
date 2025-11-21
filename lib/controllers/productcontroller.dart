import 'package:flutter/material.dart';
import 'package:nexacloth/controllers/basecontroller.dart';
import 'package:nexacloth/core/supabase/supabase_curdoperation.dart';
import 'package:nexacloth/core/user_info_service.dart';
import 'package:nexacloth/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController extends FlutterFlowModel {
  void initState(BuildContext context) {}
  late String selectedSize;

  Future<List<ProductModel>> getProductById(int productId) async {
    try {
      final product = await SupabaseCRUD.selectWhere(
        'product',
        column: 'id',
        value: productId,
      );

      return product.map((p) => ProductModel.fromMap(p)).toList();
    } catch (e) {
      debugPrint('Error fetching product: $e');
      return [];
    }
  }

  void dispose() {}

  Future<bool> toggleProductInCart(String productId) async {
    try {
      final userId = UserInfoService().userId;
      if (userId == null || userId.isEmpty) {
        debugPrint('User not logged in, cannot add to cart');
        return false;
      }

      // Check if product is already in cart
      final cartItems = await SupabaseCRUD.selectWhere(
        'cart',
        column: 'user_id',
        value: userId,
      );

      final existingCartItem = cartItems.firstWhere(
        (item) => item['product_id']?.toString() == productId,
        orElse: () => {},
      );

      if (existingCartItem.isNotEmpty) {
        // Remove from cart
        await Supabase.instance.client
            .from('cart')
            .delete()
            .eq('user_id', userId)
            .eq('product_id', productId);
        debugPrint('Product $productId removed from cart');
        return false;
      } else {
        // Add to cart
        var param = {"user_id": userId, "product_id": productId, "qty": 1};
        await SupabaseCRUD.insert('cart', param);
        debugPrint('Product $productId added to cart');
        return true;
      }
    } catch (e) {
      debugPrint('Error toggling product in cart: $e');
      return false;
    }
  }

  // Keep old method name for backward compatibility
  Future<void> addProductToCart(String productId) async {
    await toggleProductInCart(productId);
  }

  Future<List<ProductModel>> getProductByCategoryId(String categoryId) async {
    try {
      // Get products by category
      final products = await SupabaseCRUD.selectWhere(
        'product',
        column: 'category_id',
        value: categoryId,
      );

      // Get current user ID (handle nullable)
      final userId = UserInfoService().userId;

      // Fetch user's favorite products if user is logged in
      Set<String> favoriteProductIds = {};
      if (userId != null && userId.isNotEmpty) {
        try {
          final favoriteProducts = await SupabaseCRUD.selectWhere(
            'user_favorite_product',
            column: 'user_id',
            value: userId,
          );
          favoriteProductIds = favoriteProducts
              .map((fav) => fav['product_id']?.toString())
              .where((id) => id != null)
              .cast<String>()
              .toSet();
        } catch (e) {
          debugPrint('Error fetching favorite products: $e');
        }
      }

      // Fetch user's cart products if user is logged in
      Set<String> cartProductIds = {};
      if (userId != null && userId.isNotEmpty) {
        try {
          final cartProducts = await SupabaseCRUD.selectWhere(
            'cart',
            column: 'user_id',
            value: userId,
          );
          cartProductIds = cartProducts
              .map((cart) => cart['product_id']?.toString())
              .where((id) => id != null)
              .cast<String>()
              .toSet();
        } catch (e) {
          debugPrint('Error fetching cart products: $e');
        }
      }

      // Map products and set favorite and cart fields
      return products.map((product) {
        final productId = product['id']?.toString() ?? '';
        final isFavorite = favoriteProductIds.contains(productId);
        final isInCart = cartProductIds.contains(productId);

        // Add favorite and cart fields to product map
        final productWithStatus = Map<String, dynamic>.from(product);
        productWithStatus['favorite'] = isFavorite;
        productWithStatus['addtocart'] = isInCart;

        return ProductModel.fromMap(productWithStatus);
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<void> toggleFavoriteProduct(String productId, bool isFavorite) async {
    try {
      final userId = UserInfoService().userId;
      if (userId == null || userId.isEmpty) {
        debugPrint('User not logged in, cannot toggle favorite');
        return;
      }

      if (isFavorite) {
        // Add to favorites
        var param = {"user_id": userId, "product_id": productId};
        await SupabaseCRUD.insert('user_favorite_product', param);
        debugPrint('Product $productId added to favorites');
      } else {
        // Remove from favorites - delete where both user_id and product_id match
        await Supabase.instance.client
            .from('user_favorite_product')
            .delete()
            .eq('user_id', userId)
            .eq('product_id', productId);
        debugPrint('Product $productId removed from favorites');
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  // Keep old method name for backward compatibility
  Future<void> addFavoriteProduct(String productId, bool isFavorite) async {
    await toggleFavoriteProduct(productId, isFavorite);
  }
}
