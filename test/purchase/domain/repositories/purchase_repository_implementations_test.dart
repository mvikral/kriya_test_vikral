import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriya_test_vikral/features/purchase/data/model/product_model.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';
import 'package:kriya_test_vikral/features/purchase/domain/repositories/purchase_repository_implementations.dart';
import 'package:kriya_test_vikral/global/error/exeptions.dart';
import 'package:kriya_test_vikral/global/error/failures.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/setup_mockito_generate_mocks.mocks.dart';

main() {
  late MockPurchaseRemoteData service;
  late MockNetworkInfo mockNetworkInfo;
  late PurchaseRepository repository;

  setUp(
    () {
      service = MockPurchaseRemoteData();
      mockNetworkInfo = MockNetworkInfo();
      repository = PurchaseRepository(
        service: service,
        networkInfo: mockNetworkInfo,
      );
    },
  );
  void deviceIsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void deviceIsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group(
    'fetch all products',
    () {
      const testProduct = [
        ProductModel(title: 'delectus aut autem', quantity: 0),
        ProductModel(title: 'quis ut nam facilis et officia qui', quantity: 0),
      ];
      const List<Product> product = testProduct;

      deviceIsOnline(
        () {
          test(
            'should return remote data when the device had internet connection',
            () async {
              //arrange

              when(service.fetchAllProducts())
                  .thenAnswer((_) async => testProduct);
              //act
              final result = await repository.fetchAllProducts();
              //assert
              expect(result, equals(const Right(product)));
            },
          );
          test(
            'should return server Failure when the call to api is failed',
            () async {
              //arrange
              when(service.fetchAllProducts()).thenThrow(ServerExeption());
              //act
              final result = await repository.fetchAllProducts();
              //assert
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      deviceIsOffline(
        () {
          test(
            'should return network Failure when the call to api is failed',
            () async {
              //arrange
              when(service.fetchAllProducts()).thenThrow(NetworkExeption());
              //act
              final result = await repository.fetchAllProducts();
              //assert
              expect(result, equals(Left(NetworkFailure())));
            },
          );
        },
      );
    },
  );
}
