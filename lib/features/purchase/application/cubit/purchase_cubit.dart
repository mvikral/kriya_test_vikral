import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
        emit(
          state.copyWith(
            status: LoadingStatus.loaded,
            products: success,
          ),
        );
      },
    );
  }

  Future<void> addProductToCart(Product product) async {
    var cart = state.cart.products;
    if (cart.contains(product)) {
      int index = cart.indexOf(product);
      cart[index] = Product(
        title: cart[index].title,
        quantity: cart[index].quantity + 1,
      );

      emit(
        state.copyWith(
          cart: Cart(
            products: cart,
            total: state.cart.total + 1,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          cart: Cart(
            products: [product],
            total: state.cart.total + 1,
          ),
        ),
      );
    }
  }

  Future<void> substractProductFromCart(Product product) async {
    var cart = state.cart.products;
    int index = cart.indexOf(product);
    if (cart[index].quantity == 1) {
      cart.remove(cart[index]);
      emit(
        state.copyWith(
          cart: Cart(
            products: cart,
            total: state.cart.total - 1,
          ),
        ),
      );
    } else {
      cart[index] = Product(
        title: cart[index].title,
        quantity: cart[index].quantity - 1,
      );
      emit(
        state.copyWith(
          cart: Cart(
            products: cart,
            total: state.cart.total - 1,
          ),
        ),
      );
    }
  }
}
