import '../../domain/entities/product.dart';

enum UpdateType { add, substrack }

class UpdateProductsQuantity {
  List<Product> call({
    required List<Product> products,
    required Product product,
    required UpdateType type,
  }) {
    int productIndex = products.indexOf(product);
    products[productIndex] = Product(
      title: product.title,
      quantity: type == UpdateType.add
          ? products[productIndex].quantity + 1
          : products[productIndex].quantity - 1,
    );
    return products;
  }
}
