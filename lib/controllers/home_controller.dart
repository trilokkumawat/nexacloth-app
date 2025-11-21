import 'package:flutter/material.dart';
import 'package:nexacloth/controllers/basecontroller.dart';
import 'package:nexacloth/core/supabase/supabase_curdoperation.dart';
import 'package:nexacloth/model/product_model.dart';
import 'package:nexacloth/screens/home_screen.dart';

class HomeController extends FlutterFlowModel<HomeScreen> {
  final List<String> _carouselImages = const [
    'https://picsum.photos/800/400?random=1',
    'https://picsum.photos/800/400?random=2',
    'https://picsum.photos/800/400?random=3',
    'https://picsum.photos/800/400?random=4',
    'https://picsum.photos/800/400?random=5',
  ];
  List<String> get carouselImages => _carouselImages;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<List<ProductModel>> getProducts() async {
    try {
      final products = await SupabaseCRUD.select(
        'product',
        queryBuilder: (query) => query.limit(10),
      );

      return products.map((product) => ProductModel.fromMap(product)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getproductwithcategory() async {
    try {
      final categories = await SupabaseCRUD.selectAll('category');
      final products = await SupabaseCRUD.selectAll('product');

      List<dynamic> categoryandproduct = [];
      for (var category in categories) {
        var categoryId = category['id']?.toString();
        for (var product in products) {
          var productCategoryId = product['category_id']?.toString();
          print(productCategoryId);
          if (productCategoryId.toString() == categoryId.toString()) {
            categoryandproduct.add({category['category']: product});
          }
        }
      }

      return categoryandproduct;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
