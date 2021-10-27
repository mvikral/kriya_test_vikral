import 'purchase_state_model.dart';
import 'update_product_quantity.dart';
import '../../domain/entities/cart.dart';

import '../../domain/entities/product.dart';

PurchaseStateModel addItemToCart({
  required Cart cart,
  required List<Product> products,
  required Product product,
}) {
  List<Product> updatedCart = [];
  List<Product> updatedProduct = UpdateProductsQuantity().call(
    products: products,
    product: product,
    type: UpdateType.add,
  );

  for (var item in cart.products) {
    updatedCart.add(item);
  }

  if (updatedCart.contains(product)) {
    int index = updatedCart.indexOf(product);
    updatedCart[index] = Product(
      title: updatedCart[index].title,
      quantity: updatedCart[index].quantity + 1,
    );
  } else {
    updatedCart.add(
      Product(
        title: product.title,
        quantity: product.quantity + 1,
      ),
    );
  }
  return PurchaseStateModel(
    cart: Cart(products: updatedCart, total: cart.total + 1),
    products: updatedProduct,
  );
}
