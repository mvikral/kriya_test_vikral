import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kriya_test_vikral/features/purchase/application/usecase/payment.dart';
import 'package:kriya_test_vikral/features/purchase/application/usecase/subtract_item_from_cart.dart';
import '../usecase/add_item_to_cart.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/fetch_all_products.dart';
import '../../../../global/error/failures.dart';
part 'purchase_cubit.freezed.dart';

part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  final FetchAllProducts fetchAllProductsUsecase;
  PurchaseCubit({required FetchAllProducts fetchAllProducts})
      : fetchAllProductsUsecase = fetchAllProducts,
        super(PurchaseState.initial());

  Future<void> fetchAllProducts() async {
    emit(
      state.copyWith(
        status: LoadingStatus.loading,
      ),
    );
    var response = await fetchAllProductsUsecase();
    response.fold(
      (failed) {
        if (failed == NetworkFailure()) {
          emit(
            state.copyWith(
              status: LoadingStatus.networkFailure,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: LoadingStatus.serverFailure,
            ),
          );
        }
      },
      (success) {
        var products = success.map(
          (product) {
            return Product(title: product.title, quantity: product.quantity);
          },
        ).toList();
        emit(
          state.copyWith(
            status: LoadingStatus.loaded,
            products: products,
          ),
        );
      },
    );
  }

  Future<void> addProductToCart(Product product) async {
    var cart = state.cart;
    var prod = state.products;
    var updatedState =
        addItemToCart(cart: cart, products: prod, product: product);
    emit(
      state.copyWith(
        cart: Cart(
          products: updatedState.cart.products,
          total: updatedState.cart.total,
        ),
        products: updatedState.products,
      ),
    );
  }

  Future<void> substractProductFromCart(Product product) async {
    if (product.quantity != 0) {
      var cart = state.cart;
      var prod = state.products;
      final updatedState =
          subtrackItemFromCart(cart: cart, products: prod, product: product);
      emit(
        state.copyWith(
          cart: Cart(
            products: updatedState.cart.products,
            total: updatedState.cart.total,
          ),
          products: updatedState.products,
        ),
      );
    }
  }

  Future<void> finishPayment() async {
    var prod = state.products;
    final updatedState = payment(products: prod);
    emit(
      state.copyWith(
        cart: Cart(
          products: updatedState.cart.products,
          total: updatedState.cart.total,
        ),
        products: updatedState.products,
      ),
    );
  }
}
