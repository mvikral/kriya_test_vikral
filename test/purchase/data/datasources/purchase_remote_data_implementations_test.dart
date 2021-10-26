import 'package:flutter_test/flutter_test.dart';
import 'package:kriya_test_vikral/features/purchase/data/datasources/purchase_remote_data_implementations.dart';
import 'package:kriya_test_vikral/features/purchase/data/model/product_model.dart';
import 'package:kriya_test_vikral/global/error/exeptions.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';
import '../../../helper/setup_mockito_generate_mocks.mocks.dart';

main() {
  late PurchaseRemoteData service;
  late MockClient mockClient;
  setUp(
    () {
      mockClient = MockClient();
      service = PurchaseRemoteData(client: mockClient);
    },
  );

  void setupMockClientSuccess200(String fixFileName) {
    when(mockClient.get(
      any,
    )).thenAnswer(
      (realInvocation) async => http.Response(
        fixture(fixFileName),
        200,
      ),
    );
  }

  void setupMockClientFailed() {
    when(mockClient.get(
      any,
    )).thenAnswer(
      (realInvocation) async => http.Response(
        'Something went Wrong',
        404,
      ),
    );
  }

  group(
    'fetch ALL Product',
    () {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
      const testProduct = [
        ProductModel(title: 'delectus aut autem', quantity: 0),
        ProductModel(title: 'quis ut nam facilis et officia qui', quantity: 0),
      ];
      test(
        'should call a get request into api url',
        () async {
          setupMockClientSuccess200('products.json');
          service.fetchAllProducts();
          verify(
            mockClient.get(
              url,
            ),
          );
        },
      );

      test(
        'should return product when the response code is 200',
        () async {
          setupMockClientSuccess200('products.json');
          final result = await service.fetchAllProducts();
          expect(result, equals(testProduct));
        },
      );

      test(
        'should throw a Server Exception when the response code is error code',
        () async {
          setupMockClientFailed();
          final call = service.fetchAllProducts;
          expect(
            () => call(),
            throwsA(
              const TypeMatcher<ServerExeption>(),
            ),
          );
        },
      );
    },
  );
}
