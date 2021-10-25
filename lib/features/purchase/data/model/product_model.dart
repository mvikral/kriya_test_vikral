import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String title,
    required int quantity,
  }) : super(
          title: title,
          quantity: quantity,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      quantity: 0,
    );
  }
}
