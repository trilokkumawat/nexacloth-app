class ProductModel {
  final int id;
  final DateTime createdAt;
  final String? categoryId;
  final String? productVariantId;
  final String? name;
  final String? description;
  final String? price;
  final String? brand;
  final String? discountPrice;
  final String? stockQuantity;
  final String? material; // referencing public.material type as String
  final String? gender; // referencing public.gender type as String
  final String? fit; // referencing public.fittype type as String
  final String? careInstructions;
  final String? images;
  final String? multiImage;
  final bool favorite;
  final bool addtocart;

  ProductModel({
    required this.id,
    required this.createdAt,
    this.categoryId,
    this.productVariantId,
    this.name,
    this.description,
    this.price,
    this.brand,
    this.discountPrice,
    this.stockQuantity,
    this.material,
    this.gender,
    this.fit,
    this.careInstructions,
    this.images,
    this.multiImage,
    this.favorite = false,
    this.addtocart = false,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] is int ? map['id'] : int.parse(map['id'].toString()),
      createdAt: DateTime.parse(map['created_at']),
      categoryId: map['category_id']?.toString(),
      productVariantId: map['product_variantid']?.toString(),
      name: map['name']?.toString(),
      description: map['description']?.toString(),
      price: map['price']?.toString(),
      brand: map['brand']?.toString(),
      discountPrice: map['discount_price']?.toString(),
      stockQuantity: map['stock_quantity']?.toString(),
      material: map['material']?.toString(),
      gender: map['gender']?.toString(),
      fit: map['fit']?.toString(),
      careInstructions: map['care_instructions']?.toString(),
      images: map['images']?.toString(),
      multiImage: map['multi_image']?.toString(),
      favorite: map['favorite'] == true || map['favorite'] == 1,
      addtocart: map['addtocart'] == true || map['addtocart'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'category_id': categoryId,
      'product_variantid': productVariantId,
      'name': name,
      'description': description,
      'price': price,
      'brand': brand,
      'discount_price': discountPrice,
      'stock_quantity': stockQuantity,
      'material': material,
      'gender': gender,
      'fit': fit,
      'care_instructions': careInstructions,
      'images': images,
      'multi_image': multiImage,
      'favorite': favorite,
      'addtocart': addtocart,
    };
  }

  ProductModel copyWith({
    int? id,
    DateTime? createdAt,
    String? categoryId,
    String? productVariantId,
    String? name,
    String? description,
    String? price,
    String? brand,
    String? discountPrice,
    String? stockQuantity,
    String? material,
    String? gender,
    String? fit,
    String? careInstructions,
    String? images,
    String? multiImage,
    bool? favorite,
    bool? addtocart,
  }) {
    return ProductModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      categoryId: categoryId ?? this.categoryId,
      productVariantId: productVariantId ?? this.productVariantId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      brand: brand ?? this.brand,
      discountPrice: discountPrice ?? this.discountPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      material: material ?? this.material,
      gender: gender ?? this.gender,
      fit: fit ?? this.fit,
      careInstructions: careInstructions ?? this.careInstructions,
      images: images ?? this.images,
      multiImage: multiImage ?? this.multiImage,
      favorite: favorite ?? this.favorite,
      addtocart: addtocart ?? this.addtocart,
    );
  }
}
