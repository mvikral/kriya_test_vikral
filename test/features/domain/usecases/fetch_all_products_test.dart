import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';
import 'package:kriya_test_vikral/features/purchase/domain/usecases/fetch_all_products.dart';
import 'package:kriya_test_vikral/global/error/failures.dart';

import 'package:mockito/mockito.dart';

import '../../../helper/setup_purchase_repository.mocks.dart';

main() {
  late MockIPurchaseRepository mockIPurchaseRepository;
  late FetchAllProducts usecase;
  setUp(
    () => {
      mockIPurchaseRepository = MockIPurchaseRepository(),
      usecase = FetchAllProducts(mockIPurchaseRepository),
    },
  );
  group('fetch all products usecases', () {
    const testResponse = [Product(title: 'test1', quantity: 0)];
    test(
      'should return Products Entities when success',
      () async {
        when(mockIPurchaseRepository.fetchAllProducts()).thenAnswer(
          (_) async => const Right(testResponse),
        );

        final result = await usecase();

        expect(result, const Right(testResponse));
      },
    );

    test(
      'should return Failure when failed',
      () async {
        when(mockIPurchaseRepository.fetchAllProducts()).thenAnswer(
          (_) async => Left(ServerFailure()),
        );

        final result = await usecase();

        expect(result, Left(ServerFailure()));
      },
    );
  });
}
