import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';

class PurchaseStateModel {
  final Cart cart;
  final List<Product> products;

  PurchaseStateModel({
    required this.cart,
    required this.products,
  });
}
