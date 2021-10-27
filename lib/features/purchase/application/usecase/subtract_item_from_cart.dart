import 'purchase_state_model.dart';
import 'update_product_quantity.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';

PurchaseStateModel subtrackItemFromCart({
  required Cart cart,
  required List<Product> products,
  required Product product,
}) {
  List<Product> updatedCart = [];
  for (var item in cart.products) {
    updatedCart.add(item);
  }
  List<Product> updatedProduct = UpdateProductsQuantity().call(
    products: products,
    product: product,
    type: UpdateType.substrack,
  );

  if (product.quantity == 1) {
    int index = updatedCart.indexOf(product);
    updatedCart.remove(updatedCart[index]);
    return PurchaseStateModel(
      cart: Cart(products: updatedCart, total: cart.total - 1),
      products: updatedProduct,
    );
  } else {
    int index = updatedCart.indexOf(product);
    updatedCart[index] = Product(
      title: updatedCart[index].title,
      quantity: updatedCart[index].quantity - 1,
    );
    return PurchaseStateModel(
      cart: Cart(products: updatedCart, total: cart.total - 1),
      products: updatedProduct,
    );
  }
}
