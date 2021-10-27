import 'package:kriya_test_vikral/features/purchase/application/usecase/purchase_state_model.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/cart.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';

PurchaseStateModel payment({
  required List<Product> products,
}) {
  Cart cart = const Cart(products: [], total: 0);
  List<Product> resetedProducts = [];
  for (var item in products) {
    resetedProducts.add(Product(title: item.title, quantity: 0));
  }
  return PurchaseStateModel(
    cart: cart,
    products: resetedProducts,
  );
}
