part of 'purchase_cubit.dart';

enum LoadingStatus { initial, loading, loaded, networkFailure, serverFailure }

@freezed
class PurchaseState with _$PurchaseState {
  const factory PurchaseState({
    required LoadingStatus status,
    required List<Product> products,
    required Cart cart,
  }) = _PurchaseState;

  factory PurchaseState.initial() => const PurchaseState(
        status: LoadingStatus.initial,
        products: [],
        cart: Cart(products: [], total: 0),
      );
  const PurchaseState._();
}
