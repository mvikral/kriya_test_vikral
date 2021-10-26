import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kriya_test_vikral/features/purchase/application/cubit/purchase_cubit.dart';
import 'package:kriya_test_vikral/features/purchase/data/model/product_model.dart';
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

  group(
    'cubit',
    () {
      const testProduct = [
        ProductModel(title: 'delectus aut autem', quantity: 0),
        ProductModel(title: 'quis ut nam facilis et officia qui', quantity: 0),
      ];
      test(
        'should initial state when started',
        () {
          expect(cubit.state, PurchaseState.initial());
        },
      );
      group(
        'fetch all products',
        () {
          blocTest<PurchaseCubit, PurchaseState>(
            'emits status loading and loaded when fetch is success',
            build: () => cubit,
            act: (c) {
              when(usecase.call()).thenAnswer(
                  (realInvocation) async => const Right(testProduct));
              return cubit.fetchAllProducts();
            },
            expect: () {
              return [
                cubit.state.copyWith(status: LoadingStatus.loading),
                cubit.state.copyWith(status: LoadingStatus.loaded),
              ];
            },
          );
        },
      );
    },
  );
}
