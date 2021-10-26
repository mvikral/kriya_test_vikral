import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kriya_test_vikral/features/purchase/application/cubit/purchase_cubit.dart';
import 'package:kriya_test_vikral/features/purchase/data/model/product_model.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/cart.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';
import 'package:kriya_test_vikral/global/error/failures.dart';
import 'package:mockito/mockito.dart';

import '../../helper/setup_mockito_generate_mocks.mocks.dart';

main() {
  late PurchaseCubit cubit;
  late MockFetchAllProducts usecase;

  setUp(
    () {
      usecase = MockFetchAllProducts();
      cubit = PurchaseCubit(fetchAllProducts: usecase);
    },
  );
  tearDown(() {
    cubit.close();
  });

  test(
    'should initial state when started',
    () {
      expect(cubit.state, PurchaseState.initial());
    },
  );

  group(
    'fetch all products',
    () {
      const testProduct = [
        ProductModel(title: 'delectus aut autem', quantity: 0),
        ProductModel(title: 'quis ut nam facilis et officia qui', quantity: 0),
      ];
      blocTest<PurchaseCubit, PurchaseState>(
        'emits status loading and then loaded and also update producst state with data from api when fetch is success',
        build: () => cubit,
        act: (c) {
          when(usecase.call())
              .thenAnswer((realInvocation) async => const Right(testProduct));
          return cubit.fetchAllProducts();
        },
        expect: () {
          return [
            cubit.state.copyWith(status: LoadingStatus.loading, products: []),
            cubit.state
                .copyWith(status: LoadingStatus.loaded, products: testProduct),
          ];
        },
      );

      blocTest<PurchaseCubit, PurchaseState>(
        'should emits status loading and then networkError when no internet connection',
        build: () => cubit,
        act: (c) {
          when(usecase.call())
              .thenAnswer((realInvocation) async => Left(NetworkFailure()));
          return cubit.fetchAllProducts();
        },
        expect: () {
          return [
            cubit.state.copyWith(status: LoadingStatus.loading),
            cubit.state.copyWith(status: LoadingStatus.networkFailure),
          ];
        },
      );

      blocTest<PurchaseCubit, PurchaseState>(
        'should emits status loading and then server error when return code unsuccess',
        build: () => cubit,
        act: (c) {
          when(usecase.call())
              .thenAnswer((realInvocation) async => Left(ServerFailure()));
          return cubit.fetchAllProducts();
        },
        expect: () {
          return [
            cubit.state.copyWith(status: LoadingStatus.loading),
            cubit.state.copyWith(status: LoadingStatus.serverFailure),
          ];
        },
      );
    },
  );

  group(
    'add products to cart',
    () {
      Product testProduct = const Product(
          title: 'quis ut nam facilis et officia qui', quantity: 1);
      Product testProductAdded = const Product(
          title: 'quis ut nam facilis et officia qui', quantity: 2);
      blocTest<PurchaseCubit, PurchaseState>(
        'should add product to cart and increase total when function get called',
        build: () => PurchaseCubit(fetchAllProducts: usecase),
        act: (cubit) => cubit.addProductToCart(testProduct),
        expect: () {
          return [
            cubit.state.copyWith(cart: Cart(products: [testProduct], total: 1)),
          ];
        },
      );

      blocTest<PurchaseCubit, PurchaseState>(
        'should add product quantyty increase total when same product is called',
        build: () => PurchaseCubit(fetchAllProducts: usecase),
        act: (cubit) => emitsInOrder([
          cubit.addProductToCart(testProduct),
          cubit.addProductToCart(testProduct),
        ]),
        expect: () {
          return [
            cubit.state
                .copyWith(cart: Cart(products: [testProductAdded], total: 1)),
            cubit.state
                .copyWith(cart: Cart(products: [testProductAdded], total: 2)),
          ];
        },
      );
    },
  );

  group(
    'subtract products from cart',
    () {
      Product testProduct = const Product(
          title: 'quis ut nam facilis et officia qui', quantity: 2);
      Product testSubtractedProduct = const Product(
          title: 'quis ut nam facilis et officia qui', quantity: 1);
      blocTest<PurchaseCubit, PurchaseState>(
        'should subtract quantity from product and decrease total when function get called',
        build: () => PurchaseCubit(fetchAllProducts: usecase),
        act: (cubit) {
          cubit.emit(
            cubit.state.copyWith(
              cart: Cart(
                products: [testProduct],
                total: 2,
              ),
            ),
          );
          return cubit.substractProductFromCart(testProduct);
        },
        expect: () {
          return [
            cubit.state.copyWith(
                cart: Cart(products: [testSubtractedProduct], total: 2)),
            cubit.state.copyWith(
                cart: Cart(products: [testSubtractedProduct], total: 1)),
          ];
        },
      );

      blocTest<PurchaseCubit, PurchaseState>(
        'should remove product from cart when quantity is 0',
        build: () => PurchaseCubit(fetchAllProducts: usecase),
        act: (cubit) {
          cubit.emit(
            cubit.state.copyWith(
              cart: Cart(
                products: [testSubtractedProduct],
                total: 1,
              ),
            ),
          );
          return cubit.substractProductFromCart(testSubtractedProduct);
        },
        expect: () {
          return [
            cubit.state.copyWith(cart: const Cart(products: [], total: 1)),
            cubit.state.copyWith(cart: const Cart(products: [], total: 0)),
          ];
        },
      );
    },
  );
}
